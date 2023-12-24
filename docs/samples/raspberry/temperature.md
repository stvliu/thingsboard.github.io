---
layout: docwithnav
title: 使用树莓派和 DHT22 传感器通过 MQTT 上传温度
description: 使用树莓派和 DHT22 传感器通过 MQTT 上传温度数据的物联网平台示例。

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序执行由 [DHT22 传感器](https://www.adafruit.com/product/385)产生的温度和湿度值收集，并在实时网络仪表板上进一步显示。
收集的数据通过 MQTT 推送到物联网平台服务器进行存储和显示。此应用程序的目的是演示物联网平台的 [数据收集 API](/docs/user-guide/telemetry/)和 [可视化功能](/docs/user-guide/visualization/)。

DHT22 传感器连接到 [树莓派](https://en.wikipedia.org/wiki/Raspberry_Pi)。
树莓派提供完整且自包含的 Wi-Fi 网络解决方案。
树莓派通过使用 [paho mqtt](https://eclipse.org/paho/clients/python/)python 库通过 MQTT 协议将数据推送到物联网平台服务器。
数据使用内置的可自定义仪表板进行可视化。
在树莓派上运行的应用程序是用 Python 编写的，非常简单易懂。

下面的视频演示了本教程的最终结果。

<br>
<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/-26bxb90tt0" frameborder="0" allowfullscreen></iframe>
    </div>
</div>
<br>
<br>

完成此示例/教程后，您将在以下仪表板上看到传感器数据。

![image](/images/samples/esp8266/temperature/dashboard.gif)

{% include templates/prerequisites.md %}

## 硬件和引脚列表

 - [树莓派 3](https://www.aliexpress.com/item/Raspberry-Pi-Model-B-Featuring-the-ARM1176JZF-S-Running-at-700MHz-with-512MB-of-RAM-version/2008093537.html?spm=2114.01010208.3.186.mgDFUO&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10000009_10084_10083_10080_10082_10081_10060_10062_10056_503_10055_10054_10059_10099_10078_501_10079_426_10103_10073_10102_10096_10052_10053_10108_10050_10107_10051_10106,searchweb201603_3,afswitch_3&btsid=2b2a0772-e248-4fa1-a79c-941b5c410deb)

  ![image](/images/samples/raspberry/RaspberryPi3.jpg)

 - [DHT22 传感器](https://www.aliexpress.com/item/1pcs-DHT22-digital-temperature-and-humidity-sensor-Temperature-and-humidity-module-AM2302-replace-SHT11-SHT15/32316036161.html?spm=2114.03010208.3.49.aZvfaG&ws_ab_test=searchweb0_0,searchweb201602_2_10065_10068_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10054_10059_10099_10078_10079_10093_426_10073_10103_10102_10096_10052_10050_10051,searchweb201603_6&btsid=28d9ee9a-283a-4e97-af7b-a7e530490916)

  ![image](/images/samples/arduino/temperature/dht22-pinout.png)

 - 电阻器（4.7K 到 10K 之间）
  
 - 面包板
  
 - 2 根母对母跳线
 
 - 10 根母对公跳线
 
 - 3 根公对公跳线  
 
## 接线方案

DHT-22 引脚 | 树莓派引脚
-----------|-----------
DHT-22 数据 | 树莓派 GPIO 4
DHT-22 VCC | 树莓派 3.3V
DHT-22 GND (-) | 树莓派 GND

最后，在 DHT 传感器的引脚 1 和 2 之间放置一个电阻器（4.7K 到 10K 之间）。

下图总结了此项目的连接：

![image](/images/samples/raspberry/temperature/schema.png)
 
{% include templates/thingsboard-configuration.md %}

### 配置设备

此步骤包含将设备连接到物联网平台所需的说明。

在浏览器中打开物联网平台 Web UI (http://localhost:8080) 并以租户管理员身份登录

 - 登录名：tenant@gridlinks.com
 - 密码：tenant
 
转到“设备”部分。单击“+”按钮并创建一个名为“DHT22 演示设备”的设备。

![image](/images/samples/raspberry/temperature/device.png)

创建设备后，打开其详细信息并单击“管理凭据”。
从“访问令牌”字段复制自动生成的访问令牌。请保存此设备令牌。它将在以后称为 **$ACCESS_TOKEN**。

![image](/images/samples/raspberry/temperature/credentials.png)


在设备详细信息中单击“复制设备 ID”以将设备 ID 复制到剪贴板。
将设备 ID 粘贴到某个地方，此值将在后续步骤中使用。

### 配置仪表板

使用此 [**链接**](/docs/samples/raspberry/resources/dht22_temp_dashboard_v2.json)下载仪表板文件。
使用导入/导出 [**说明**](/docs/user-guide/ui/dashboards/#dashboard-importexport)将仪表板导入到物联网平台实例。

## 编程树莓派

### 安装 MQTT 库

以下命令将安装 MQTT Python 库：

```bash
sudo pip install paho-mqtt
```

### 安装 Adafruit DHT 库

安装 python-dev 包：

```bash
sudo apt-get install python-dev
```

下载并安装 Adafruit DHT 库：

```bash
git clone https://github.com/adafruit/Adafruit_Python_DHT.git
cd Adafruit_Python_DHT
sudo python setup.py install
```

### 应用程序源代码

我们的应用程序由一个记录良好的 Python 脚本组成。
您需要修改 **THINGSBOARD_HOST** 常量以匹配您的物联网平台服务器安装 IP 地址或主机名。
如果您使用的是 [实时演示](https://gridlinks.codingas.com/)服务器，请使用“demo.thingsboard.io”。

**ACCESS_TOKEN** 常量值对应于示例 DHT22 演示设备。
如果您使用的是 [实时演示](https://gridlinks.codingas.com/)服务器 - [获取访问令牌](/docs/user-guide/ui/devices/#manage-device-credentials)以获取预先配置的“DHT22 演示设备”。

{% capture tabspec %}python-script
mqtt-dht22,mqtt-dht22.py,python,resources/mqtt-dht22.py,/docs/samples/raspberry/resources/mqtt-dht22.py{% endcapture %}
{% include tabs.html %}

### 运行应用程序

此简单命令将启动应用程序：

```bash
python mqtt-dht22.py
```

## 数据可视化

最后，打开物联网平台 Web UI。您可以通过以租户管理员身份登录来访问此仪表板。

如果是本地安装：
 
 - 登录名：tenant@gridlinks.com
 - 密码：tenant

如果是实时演示服务器：
 
 - 登录名：您的实时演示用户名（电子邮件）
 - 密码：您的实时演示密码
 
有关如何获取帐户的更多详细信息，请参阅 **[实时演示](/docs/user-guide/live-demo/)** 页面。
  
转到 **“设备”** 部分并找到 **“DHT22 演示设备”**，打开设备详细信息并切换到 **“最新遥测”** 选项卡。
如果所有配置正确，您应该能够在表中看到 *“温度”* 和 *“湿度”* 的最新值。

![image](/images/samples/raspberry/temperature/attributes.png)

之后，打开 **“仪表板”** 部分，然后找到并打开 **“DHT22：温度和湿度演示仪表板”**。
结果，您将看到两个数字仪表和两个时序图表，显示温度和湿度水平（类似于简介中的仪表板图像）。

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与物联网平台主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}
 
{% include socials.html %}


## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}