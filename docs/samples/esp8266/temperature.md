---
layout: docwithnav
title: 使用 ESP8266 和 DHT22 传感器通过 MQTT 上传温度
description: GridLinks IoT 平台示例，使用 ESP8266 和 DHT22 传感器通过 MQTT 上传温度数据。

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序执行 [DHT22 传感器](https://www.adafruit.com/product/385) 产生的温度和湿度值收集，并在实时网络仪表板上进一步可视化。
收集的数据通过 MQTT 推送到 GridLinks 服务器进行存储和可视化。
此应用程序的目的是演示 GridLinks [数据收集 API](/docs/user-guide/telemetry/) 和 [可视化功能](/docs/user-guide/visualization/)。

DHT22 传感器连接到 [ESP8266](https://en.wikipedia.org/wiki/ESP8266)。
ESP8266 提供完整且自包含的 Wi-Fi 网络解决方案。
ESP8266 通过使用 [PubSubClient](https://github.com/knolleary/pubsubclient) 库将数据推送到 GridLinks 服务器，该库适用于 Arduino 的 MQTT 协议。
数据使用内置的可自定义仪表板进行可视化。
在 ESP8266 上运行的应用程序使用 Arduino SDK 编写，该 SDK 非常简单且易于理解。

下面的视频演示了本教程的最终结果。

<br>
<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/S8JNPYsdT_M" frameborder="0" allowfullscreen></iframe>
    </div>
</div>
<br>
<br>

完成此示例/教程后，您将在以下仪表板上看到传感器数据。

![image](/images/samples/esp8266/temperature/dashboard.gif)

{% include templates/prerequisites.md %}

## 硬件和引脚列表

 - [ESP8266 模块](https://www.aliexpress.com/item/2PCS-ESP8266-Serial-Esp-01-WIFI-Wireless-Transceiver-Module-Send-Receive-LWIP-AP-STA/32302638695.html?spm=2114.03010208.3.163.FPBlcc&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_427_10073_10103_10102_10096_10052_10050_10051,searchweb201603_3&btsid=1494d8a7-6202-4a69-a0e7-877ffa333243)

  ![image](/images/samples/arduino/temperature/esp8266-pinout.png)

 - [DHT22 传感器](https://www.aliexpress.com/item/1pcs-DHT22-digital-temperature-and-humidity-sensor-Temperature-and-humidity-module-AM2302-replace-SHT11-SHT15/32316036161.html?spm=2114.03010208.3.49.aZvfaG&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_426_10073_10103_10102_10096_10052_10050_10051,searchweb201603_6&btsid=28d9ee9a-283a-4e97-af7b-a7e530490916)

  ![image](/images/samples/arduino/temperature/dht22-pinout.png)

 - USB 转 TTL
    
    - [带 DTR 和 RTS](https://www.aliexpress.com/item/Free-shipping-1pcs-FT232RL-FTDI-USB-3-3V-5-5V-to-TTL-Serial-Adapter-Module-for/32256920717.html?spm=2114.03010208.3.11.qSXSby&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_427_10073_10103_10102_10096_10052_10050_10051,searchweb201603_3&btsid=54ef4b72-5ab0-4ce6-aa89-74726d95c099)
    
    ![image](/images/samples/esp8266/temperature/usb-ttl-ft232rl-pinout.png)

    - 或 [不带 DTR 和 RTS](https://www.aliexpress.com/item/1pcs-lot-PL2303-USB-To-RS232-TTL-Converter-Adapter-Module-with-Dust-proof-Cover-PL2303HX/32642301991.html?spm=2114.03010208.3.50.WdAM18&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_427_10073_10103_10102_10096_10052_10050_10051,searchweb201603_3&btsid=9ac20e48-da8c-4a0f-8f33-d40c241fe5a3)
    
    ![image](/images/samples/esp8266/temperature/usb-ttl-pl2303hx.png)

 - 电阻器（4.7K 至 10K 之间）
  
 - 面包板
  
 - 2 根母对母跳线
 
 - 10 根母对公跳线
 
 - 3 根公对公跳线  
 
 - 3.3V 电源（例如 2 节 AA 电池）
 
## 接线方案

### 编程/刷写方案

ESP8266 引脚 | USB-TTL 引脚
----------- | -----------
ESP8266 VCC | USB-TTL VCC +3.3V
ESP8266 CH_PD | USB-TTL VCC +3.3V
ESP8266 GND (-) | USB-TTL GND
ESP8266 GPIO 0 | USB-TTL GND
ESP8266 RX | USB-TTL TX
ESP8266 TX | USB-TTL RX

DHT-22 引脚 | ESP8266 引脚
----------- | -----------
DHT-22 数据 | ESP8266 GPIO 2

DHT-22 引脚 | USB-TTL 引脚
----------- | -----------
DHT-22 VCC | USB-TTL VCC +3.3V
DHT-22 GND (-) | USB-TTL GND

最后，在 DHT 传感器的 1 号和 2 号引脚之间放置一个电阻器（4.7K 至 10K 之间）。

下图总结了此项目在编程/调试模式下的连接：

![image](/images/samples/esp8266/temperature/schema-flash.png)

### 最终方案（电池供电）

ESP8266 引脚 | 3.3V 电源
----------- | -----------
ESP8266 VCC | VCC+
ESP8266 CH_PD | VCC+
ESP8266 GND (-) | VCC-

DHT-22 引脚 | ESP8266 引脚
----------- | -----------
DHT-22 数据 | ESP8266 GPIO 2

DHT-22 引脚 | 3.3V 电源
----------- | -----------
DHT-22 VCC | VCC+
DHT-22 GND (-) | VCC-

最终图片：

![image](/images/samples/esp8266/temperature/schema.png)
 
{% include templates/thingsboard-configuration.md %}

### 配置您的设备

此步骤包含将您的设备连接到 GridLinks 所需的说明。

在浏览器中打开 GridLinks Web UI (http://localhost:8080) 并以租户管理员身份登录

 - 登录名：tenant@gridlinks.com
 - 密码：tenant
 
转到“设备”部分。单击“+”按钮并创建一个名为“ESP8266 Demo Device”的设备。

![image](/images/samples/esp8266/temperature/device.png)

创建设备后，打开其详细信息并单击“管理凭据”。
从“访问令牌”字段复制自动生成的访问令牌。请保存此设备令牌。它将在以后称为 **$ACCESS_TOKEN**。

![image](/images/samples/esp8266/temperature/credentials.png)


在设备详细信息中单击“复制设备 ID”以将您的设备 ID 复制到剪贴板。
将您的设备 ID 粘贴到某个地方，此值将在后续步骤中使用。

### 配置您的仪表板

使用此 [**链接**](/docs/samples/esp8266/resources/esp8266_dht_temp_dashboard_v2.json) 下载仪表板文件。
使用导入/导出 [**说明**](/docs/user-guide/ui/dashboards/#dashboard-importexport) 将仪表板导入到您的 ThingsBoard 实例。

## 编程 ESP8266

### 步骤 1. ESP8266 和 Arduino IDE 设置。

为了开始对 ESP8266 设备进行编程，您需要安装 Arduino IDE 和所有相关软件。

下载并安装 [Arduino IDE](https://www.arduino.cc/en/Main/Software)。

启动 Arduino IDE 后，从“文件”菜单中打开首选项。

![image](/images/samples/esp8266/temperature/arduino-preferences.png)

将以下 URL 粘贴到“其他板管理器 URL”中：http://arduino.esp8266.com/stable/package_esp8266com_index.json

通过单击“确定”按钮关闭屏幕。

现在，我们可以使用板管理器添加板 ESP8266。

在工具菜单中，单击菜单选项“板”：“*最有可能的 Arduino UNO*”。
您将在那里找到第一个选项“板管理器”。

在搜索栏中输入 3 个字母 ESP。找到并单击“*esp8266 by ESP8266 Community*”。
单击“安装”并等待一分钟下载电路板。

![image](/images/samples/esp8266/temperature/arduino-board-manager.png)

**请注意**，本教程使用“*esp8266 by ESP8266 Community*”版本 2.3.0 进行了测试。

在菜单工具“板”中“*最有可能的 Arduino UNO*”添加了三个新板。

选择“通用 ESP8266 模块”。

根据 [编程/刷写方案](#programmingflashing-schema) 准备您的硬件。
将 USB-TTL 适配器连接到 PC。

在菜单工具中，选择 USB-TTL 适配器的相应端口。
打开串行监视器（按 CTRL-Shift-M 或从菜单工具中）。
将键模拟设置为“Both NL & CR”，并将速度设置为 115200 波特。这可以在终端屏幕的底部设置。

### 步骤 2. 安装 Arduino 库。

打开 Arduino IDE 并转到 **草图 -> 包含库 -> 管理库**。
查找并安装以下库：

- [PubSubClient by Nick O'Leary](http://pubsubclient.knolleary.net/)。
- [Adafruit Unified Sensor by Adafruit](https://github.com/adafruit/Adafruit_Sensor)
- [DHT sensor library by Adafruit](https://github.com/adafruit/DHT-sensor-library)
- [Arduino ThingsBoard SDK by ThingsBoard](https://github.com/thingsboard/ThingsBoard-Arduino-MQTT-SDK)
- [ArduinoJSON by bblanchon](https://github.com/bblanchon/ArduinoJson)
- [Arduino Http Client](https://github.com/arduino-libraries/ArduinoHttpClient)

**请注意**，本教程使用以下版本的库进行了测试：

- PubSubClient 2.6
- Adafruit Unified Sensor 1.0.2
- DHT sensor library 1.3.0
- Arduino ThingsBoard SDK 0.4
- ArduinoJSON 6.10.1
- Arduino Http Client 0.4.0

### 步骤 3. 准备并上传草图。

下载并打开 **esp8266-dht-mqtt.ino** 草图。

**注意** 您需要在草图中编辑以下常量和变量：

- WIFI_AP - 您的接入点的名称
- WIFI_PASSWORD - 接入点密码
- TOKEN - ThingsBoard 配置步骤中的 **$ACCESS_TOKEN**。
- thingsboardServer - 在您的 wifi 网络中可访问的 ThingsBoard HOST/IP 地址。如果您使用的是 [实时演示](https://demo.thingsboard.io/) 服务器，请指定“demo.thingsboard.io”。

{% capture tabspec %}arduino-sketch
esp8266-dht-mqtt,esp8266-dht-mqtt.ino,c,resources/esp8266-dht-mqtt.ino,/docs/samples/esp8266/resources/esp8266-dht-mqtt.ino{% endcapture %}
{% include tabs.html %}

将 USB-TTL 适配器连接到 PC，并在 Arduino IDE 中选择相应的端口。使用“上传”按钮编译并上传草图到设备。

上传并启动应用程序后，它将尝试使用 mqtt 客户端连接到 GridLinks 节点，并每秒上传一次“温度”和“湿度”时序数据。

## 自主运行

上传草图后，您可以移除所有用于上传的电线，包括 USB-TTL 适配器，并根据 [最终接线方案](#final-schema-battery-powered) 将 ESP8266 和 DHT 传感器直接连接到电源。

## 故障排除

为了执行故障排除，您应该根据 [编程/刷写方案](#programmingflashing-schema) 组装您的硬件。
然后将 USB-TTL 适配器连接到 PC，并在 Arduino IDE 中选择 USB-TTL 适配器的端口。最后，打开“串行监视器”以查看串行输出产生的调试信息。

## 数据可视化

最后，打开 GridLinks Web UI。您可以通过以租户管理员身份登录来访问此仪表板。使用：

 - 登录名：tenant@gridlinks.com
 - 密码：tenant
 
在本地安装 GridLinks 的情况下。
  
转到 **“设备”** 部分并找到 **“ESP8266 Demo Device”**，打开设备详细信息并切换到 **“最新遥测”** 选项卡。
如果一切配置正确，您应该能够在表中看到“*温度*”和“*湿度*”的最新值。

![image](/images/samples/esp8266/temperature/attributes.png)

之后，打开 **“仪表板”** 部分，然后找到并打开 **“ESP8266 DHT22：温度和湿度演示仪表板”**。
结果，您将看到两个数字仪表和两个时序图，显示温度和湿度水平（类似于介绍中的仪表板图像）。

## 亦可参阅

浏览其他 [示例](/docs/samples) 或探索与 ThingsBoard 主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。

{% include templates/feedback.md %}
 
{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}