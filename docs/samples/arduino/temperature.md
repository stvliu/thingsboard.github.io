---
layout: docwithnav
title: 使用 Arduino UNO、ESP8266 和 DHT22 传感器通过 MQTT 上传温度
description: GridLinks IoT 平台示例，使用 Arduino UNO、ESP8266 和 DHT22 传感器通过 MQTT 上传温度数据。

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序收集由 [DHT22 传感器](https://www.adafruit.com/product/385)产生的温度和湿度值，并在实时网络仪表板上进一步显示。
收集的数据通过 MQTT 推送到 GridLinks 服务器以进行存储和显示。此应用程序的目的是演示 GridLinks [数据收集 API](/docs/user-guide/telemetry/)和 [可视化功能](/docs/user-guide/visualization/)。

DHT22 传感器连接到 [Arduino UNO](https://en.wikipedia.org/wiki/Arduino)。
Arduino UNO 使用 [ESP8266](https://en.wikipedia.org/wiki/ESP8266)连接到 WiFi 网络。
Arduino UNO 通过使用 [PubSubClient](https://github.com/knolleary/pubsubclient)库（适用于 Arduino）通过 MQTT 协议将数据推送到 GridLinks 服务器。
数据使用内置的可自定义仪表板进行可视化。运行在 Arduino UNO 上的应用程序使用 Arduino SDK 编写，该 SDK 非常简单且易于理解。

完成此示例/教程后，您将在以下仪表板上看到传感器数据。

![image](/images/samples/arduino/temperature/dashboard.png)

{% include templates/prerequisites.md %}

## 硬件和引脚列表

 - Arduino UNO

  ![image](/images/samples/arduino/temperature/arduino-uno-pinout.png)

 - [ESP8266 模块](https://www.aliexpress.com/item/Free-shipping-50pcs-lot-ESP8266-serial-WIFI-wireless-module-wireless-transceiver/32257568124.html?spm=2114.03010208.3.126.6Ir2oN&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_426_10073_10103_10102_10096_10052_10050_10051,searchweb201603_6&btsid=5ad90a6c-2282-48ee-a450-5ab29e2e5d84)

  ![image](/images/samples/arduino/temperature/esp8266-pinout.png)

 - [DHT22 传感器](https://www.aliexpress.com/item/1pcs-DHT22-digital-temperature-and-humidity-sensor-Temperature-and-humidity-module-AM2302-replace-SHT11-SHT15/32316036161.html?spm=2114.03010208.3.49.aZvfaG&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_426_10073_10103_10102_10096_10052_10050_10051,searchweb201603_6&btsid=28d9ee9a-283a-4e97-af7b-a7e530490916)

  ![image](/images/samples/arduino/temperature/dht22-pinout.png)

 - 电阻器（4.7K 到 10K 之间）

 - 面包板

 - 2 根母对母跳线

 - 11 根母对公跳线

 - 3 根公对公跳线

## ESP8266 固件

在当前教程中，[WiFiEsp Arduino 库](https://github.com/bportaluri/WiFiEsp)用于将 Arduino 板连接到互联网。
此库支持 ESP SDK 版本 1.1.1 及以上（AT 版本 0.25 及以上）。
请确保您的 ESP8266 具有兼容的固件。您可以下载并刷新 [AT25-SDK112 固件](http://www.espruino.com/files/ESP8266_AT25-SDK112-512k.bin)，该固件已在此教程中过测试。

请注意，ESP8266 的串行波特率应通过以下 AT 命令设置为 9600：

```bash
AT+UART_DEF=9600,8,1,0,0
```

## 接线方案

Arduino UNO 引脚 | ESP8266 引脚
-----------|-----------
Arduino UNO 3.3V | ESP8266 VCC
Arduino UNO 3.3V | ESP8266 CH_PD
Arduino UNO GND | ESP8266 GND (-)
Arduino UNO D2 | ESP8266 RX
Arduino UNO D3 | ESP8266 TX

Arduino UNO 引脚 | DHT-22 引脚
-----------|-----------
Arduino UNO 5V | DHT-22 VCC
Arduino UNO GND | DHT-22 GND (-)
Arduino UNO D4 | DHT-22 数据

最后，在 DHT 传感器的 1 号和 2 号引脚之间放置一个电阻器（4.7K 到 10K 之间）。

下图总结了此项目的连接：

![image](/images/samples/arduino/temperature/schema.png)

{% include templates/thingsboard-configuration.md %}

### 配置您的设备

此步骤包含将您的设备连接到 GridLinks 所需的说明。

在浏览器中打开 GridLinks Web UI (http://localhost:8080) 并以租户管理员身份登录

 - 登录名：tenant@gridlinks.com
 - 密码：tenant

转到“设备”部分。单击“+”按钮并创建一个名为“Arduino UNO 演示设备”的设备。

![image](/images/samples/arduino/temperature/device.png)

创建设备后，打开其详细信息并单击“管理凭据”。

从“访问令牌”字段复制自动生成的访问令牌。请保存此设备令牌。它将在后面称为 **$ACCESS_TOKEN**。

![image](/images/samples/arduino/temperature/credentials.png)

### 配置您的仪表板

使用此 [**链接**](/docs/samples/arduino/resources/arduino_dht_temp_dashboard_v2.json)下载仪表板文件。
使用导入/导出 [**说明**](/docs/user-guide/ui/dashboards/#dashboard-importexport)将仪表板导入您的 ThingsBoard 实例。

## 编程 Arduino UNO 设备

如果您已经熟悉使用 Arduino IDE 对 Arduino UNO 进行编程的基础知识，则可以跳过以下步骤并继续执行步骤 2。

### 步骤 1. Arduino UNO 和 Arduino IDE 设置。
为了开始对 Arduino UNO 设备进行编程，您需要安装 Arduino IDE 和所有相关软件。

下载并安装 [Arduino IDE](https://www.arduino.cc/en/Main/Software)。

要了解如何将 Uno 板连接到计算机并上传您的第一个草图，请按照此 [指南](https://www.arduino.cc/en/Guide/ArduinoUno)进行操作。

### 步骤 2. 安装 Arduino 库。

打开 Arduino IDE 并转到 **草图 -> 包含库 -> 管理库**。
查找并安装以下库：

- [Nick O'Leary 的 PubSubClient](http://pubsubclient.knolleary.net/)
- [bportaluri 的 WiFiEsp](https://github.com/bportaluri/WiFiEsp)
- [Adafruit 的 Adafruit 统一传感器](https://github.com/adafruit/Adafruit_Sensor)
- [Adafruit 的 DHT 传感器库](https://github.com/adafruit/DHT-sensor-library)
- [GridLinks 的 Arduino ThingsBoard SDK](https://github.com/thingsboard/ThingsBoard-Arduino-MQTT-SDK)
- [bblanchon 的 ArduinoJSON](https://github.com/bblanchon/ArduinoJson)
- [Arduino Http 客户端](https://github.com/arduino-libraries/ArduinoHttpClient)

**请注意**，本教程使用以下版本的库进行了测试：

- PubSubClient 2.6
- WiFiEsp 2.1.2
- Adafruit 统一传感器 1.0.2
- DHT 传感器库 1.3.0
- Arduino ThingsBoard SDK 0.4
- ArduinoJSON 6.10.1
- Arduino Http 客户端 0.4.0

### 步骤 3. 准备并上传草图。

下载并打开 **arduino-dht-esp8266-mqtt.ino** 草图。

**注意** 您需要在草图中编辑以下常量和变量：

- WIFI_AP - 您的接入点的名称
- WIFI_PASSWORD - 接入点密码
- TOKEN - ThingsBoard 配置步骤中的 **$ACCESS_TOKEN**。
- thingsboardServer - 可从您的 wifi 网络内访问的 ThingsBoard HOST/IP 地址。如果您使用的是 [实时演示](https://demo.thingsboard.io/)服务器，请指定“demo.thingsboard.io”。

{% capture tabspec %}arduino-sketch
arduino-dht-esp8266-mqtt,arduino-dht-esp8266-mqtt.ino,c,resources/arduino-dht-esp8266-mqtt.ino,/docs/samples/arduino/resources/arduino-dht-esp8266-mqtt.ino{% endcapture %}
{% include tabs.html %}

通过 USB 电缆连接您的 Arduino UNO 设备并在 Arduino IDE 中选择“Arduino/Genuino Uno”端口。使用“上传”按钮编译并上传草图到设备。

应用程序上传并启动后，它将尝试使用 mqtt 客户端连接到 GridLinks 节点，并每秒上传一次“温度”和“湿度”时序数据。

## 故障排除

当应用程序正在运行时，您可以在 Arduino IDE 中选择“Arduino/Genuino Uno”端口并打开“串行监视器”以查看串行输出产生的调试信息。

## 数据可视化

最后，打开 GridLinks Web UI。您可以通过以租户管理员身份登录来访问此仪表板。使用

 - 登录名：tenant@gridlinks.com
 - 密码：tenant

在本地 GridLinks 安装的情况下。

转到 **“设备”** 部分并找到 **“Arduino UNO 演示设备”**，打开设备详细信息并切换到 **“最新遥测”** 选项卡。
如果所有配置正确，您应该能够在表中看到 *“温度”* 和 *“湿度”* 的最新值。

![image](/images/samples/arduino/temperature/attributes.png)

之后，打开 **“仪表板”** 部分，然后找到并打开 **“Arduino DHT22：温度和湿度演示仪表板”**。
结果，您将看到两个时序图和两个数字仪表，显示温度和湿度水平（类似于介绍中的仪表板图像）。

## 另请参阅

浏览其他 [示例](/docs/samples)或探索与 ThingsBoard 主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}