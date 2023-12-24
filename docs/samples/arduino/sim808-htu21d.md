---
layout: docwithnav
title: 使用 Arduino UNO、SIM808 Shield 和 HTU21D 传感器通过 HTTP 上传湿度和温度
description: 使用 Arduino UNO、SIM808 GSM shield 和 HTU21D 传感器通过 HTTP 上传湿度和温度数据的物联网平台示例。

---

* TOC
{:toc}

## 简介

{% include templates/what-is-thingsboard.md %}

此示例应用程序执行由 [HTU21D 传感器](https://www.sparkfun.com/products/13763)产生的湿度和温度值的收集，并在实时网络仪表板上进一步显示。
收集的数据通过 HTTP 推送到物联网平台服务器进行存储和显示。此应用程序的目的是演示物联网平台 [数据收集 API](/docs/user-guide/telemetry/)和 [可视化功能](/docs/user-guide/visualization/)。

HTU21D 传感器连接到 [Arduino UNO](https://en.wikipedia.org/wiki/Arduino)。
Arduino UNO 使用 [SIM808 GSM shield](https://www.elecrow.com/wiki/index.php?title=SIM808_GPRS/GSM%2BGPS_Shield_v1.1)连接到互联网。
Arduino UNO 通过使用 [Arduino 物联网平台 SDK](https://github.com/thingsboard/ThingsBoard-Arduino-MQTT-SDK)通过 HTTP 协议将数据推送到物联网平台服务器。
数据使用内置的可自定义仪表板进行可视化。在 Arduino UNO 上运行的应用程序使用 Arduino SDK 编写，非常简单易懂。

完成此示例/教程后，您将在以下仪表板上看到传感器数据。

![image](/images/samples/arduino/sim808-htu21d/dashboard.png)

{% include templates/prerequisites.md %}

## 硬件清单

- Arduino UNO

   ![image](/images/samples/arduino/sim808-htu21d/arduino-uno-pinout.png)

- [HTU21D 传感器](https://www.sparkfun.com/products/13763)

   ![image](/images/samples/arduino/sim808-htu21d/htu21d.jpg)

- [SIM808 GSM shield](https://www.elecrow.com/wiki/index.php?title=SIM808_GPRS/GSM%2BGPS_Shield_v1.1)

   ![image](/images/samples/arduino/sim808-htu21d/sim808_shield.jpg)

## 接线

### SIM808 shield 连接

只需将 SIM808 shield 连接到 Arduino 上方。

### HTU21D 连接

按照以下方式连接 HTU21D：

* VCC - Arduino 3.3V
* GND - Arduino GND
* SDA - Arduino A5
* SCL - Arduino A4

## 完成接线

仔细检查您的接线是否遵循以下示意图：

   ![image](/images/samples/arduino/sim808-htu21d/arduino-uno-sim808-htu21d.png)

完整的设置如下所示：

   ![image](/images/samples/arduino/sim808-htu21d/arduino-uno-sim808-htu21d-photo.png)

## 设备配置

此步骤包含将设备连接到物联网平台所需的说明。

在浏览器中打开物联网平台 Web UI (http://localhost:8080) 并以租户管理员身份登录。
如果您在安装物联网平台期间加载了演示数据，则可以使用以下凭据：

- 登录名：tenant@gridlinks.com
- 密码：tenant

转到“设备”部分。单击“+”按钮，并创建一个名为“Arduino UNO 演示设备”的设备。将“设备类型”设置为“default”。

![image](/images/samples/arduino/sim808-htu21d/device.png)

创建设备后，打开其详细信息并单击“管理凭据”。

从“访问令牌”字段复制自动生成的访问令牌。请保存此设备令牌。它将在后面称为 **$ACCESS_TOKEN**。

![image](/images/samples/arduino/sim808-htu21d/credentials.png)

## 配置您的仪表板

使用此 [**链接**](/docs/samples/arduino/resources/arduino_uno_with_sim808_shield_and_htu21d_sensor_dashboard.json)下载仪表板文件。
使用导入/导出 [**说明**](/docs/user-guide/ui/dashboards/#dashboard-importexport)将仪表板导入您的物联网平台实例。

## 创建 Arduino 固件

如果您已经熟悉使用 Arduino IDE 对 Arduino UNO 进行编程的基础知识，则可以跳过以下步骤并继续执行步骤 2。

### 步骤 1. Arduino UNO 和 Arduino IDE 设置。
为了开始对 Arduino UNO 设备进行编程，您需要安装 Arduino IDE 和所有相关软件。

下载并安装 [Arduino IDE](https://www.arduino.cc/en/Main/Software)。

要了解如何将 Uno 板连接到计算机并上传您的第一个草图，请按照此 [指南](https://www.arduino.cc/en/Guide/ArduinoUno)进行操作。

### 步骤 2. 安装 Arduino 物联网平台 SDK 和依赖项

为了简化应用程序开发，请从标准 Arduino 库存储库安装物联网平台 Arduino SDK 及其依赖项：

1. 进入 **草图 -> 包含库...** 子菜单。选择 **管理库**。

1. 查找并安装 **ThingsBoard Arduino SDK** 和 **Nick O'Leary 的 PubSubClient** 库。

   ![image](/images/samples/arduino/sim808-htu21d/install-tb-arduino.png)

1. 安装 **ArduinoJSON** 库 **v6.9.1** 或更高版本。 <span style="color:red">避免安装 ArduinoJson 库的测试版</span>。

   ![image](/images/samples/arduino/sim808-htu21d/do-not-use-beta-version-arduinojson.png)

1. 安装 **ArduinoHttpClient** 库。

   ![image](/images/samples/arduino/sim808-htu21d/install-http-arduino.png)

从现在开始，您可以直接从 Arduino IDE 使用物联网平台 SDK。

### 步骤 3. 安装 HTU21D 库

使用 SparkFun HTU21D 库，如下面的屏幕截图所示。

![image](/images/samples/arduino/sim808-htu21d/install-htu21d.png)

### 步骤 4. 安装 SIM808 驱动程序

SIM808 受 TinyGSM 驱动程序支持，可以按照以下说明进行安装。

![image](/images/samples/arduino/sim808-htu21d/install-tinygsm.png)

### 步骤 5. 准备并上传草图。

下载并打开 **arduino_htu21d_sim808_http.ino** 草图。

**注意** 您需要在草图中编辑以下常量和变量：

- `apn` - GPRS 接入点名称。咨询您的蜂窝网络提供商以获取更多信息。
- `user` - GPRS 接入点用户。咨询您的蜂窝网络提供商以获取更多信息。
- `pass` - GPRS 接入点密码。咨询您的蜂窝网络提供商以获取更多信息。
- `TOKEN` - 物联网平台配置步骤中的 **$ACCESS_TOKEN**。
- `THINGSBOARD_SERVER` - 可从您的 wifi 网络访问的物联网平台主机/IP 地址。如果您使用的是 [实时演示](https://gridlinks.codingas.com/)服务器，请指定“demo.thingsboard.io”。
- `THINGSBOARD_PORT` - 要连接的 HTTP 端口。如有必要，请更改它。

{% capture tabspec %}arduino-sketch
arduino_uno_sim808_htu21d_http,arduino_uno_sim808_htu21d_http.ino,c,resources/arduino_uno_sim808_htu21d_http.ino,/docs/samples/arduino/resources/arduino_uno_sim808_htu21d_http.ino{% endcapture %}
{% include tabs.html %}

通过 USB 电缆连接您的 Arduino UNO 设备，并在 Arduino IDE 中选择“Arduino/Genuino Uno”端口。使用“上传”按钮编译并上传草图到设备。

应用程序上传并启动后，它将尝试使用 HTTP 连接到物联网平台节点，并每秒上传一次“湿度”和“温度”时序数据。

## 故障排除

当应用程序正在运行时，您可以在 Arduino IDE 中选择“Arduino/Genuino Uno”端口，并打开“串行监视器”以查看串行输出产生的调试信息。

## 数据可视化

最后，打开物联网平台 Web UI。您可以使用租户管理员身份登录来访问此仪表板。使用

- 登录名：tenant@gridlinks.com
- 密码：tenant

在本地安装物联网平台的情况下。

转到 **“设备”** 部分并找到 **“Arduino UNO 演示设备”**，打开设备详细信息并切换到 **“最新遥测”** 选项卡。
如果所有配置正确，您应该能够在表中看到 *湿度* 和 *温度* 的最新值。

![image](/images/samples/arduino/sim808-htu21d/telemetry.png)

之后，打开 **“仪表板”** 部分，然后找到并打开 **“仪表板 Arduino Uno 与 SIM808 Shield 和 HTU21D 传感器”**。
因此，您将看到两个时序图和数字仪表，显示湿度和温度水平（类似于简介中的仪表板图像）。