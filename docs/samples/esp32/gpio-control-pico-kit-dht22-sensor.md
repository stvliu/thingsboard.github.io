---
layout: docwithnav
title: ESP32 Pico Kit GPIO 控制和 DHT22 传感器监控，使用 GridLinks Arduino SDK
description: GridLinks IoT 平台示例，用于 ESP32 Pico Kit GPIO 控制和温度/湿度监控，使用 GridLinks Arduino SDK
hidetoc: "true"
---

* TOC
{:toc}

## 简介

{% include templates/what-is-thingsboard.md %}

[ESP32](https://www.espressif.com/en/products/hardware/esp32/overview) 是一系列低成本、低功耗的片上系统微控制器，集成了自包含的 Wi-Fi 和双模蓝牙。ESP32 是 ESP8266 芯片的继任者。

此示例应用程序允许您使用 GridLinks Web UI 控制 ESP32 设备的 GPIO，并显示来自 DHT22 传感器的湿度/温度数据。我们将观察连接到引脚的 LED 来控制 GPIO。此应用程序的目的是演示 GridLinks [RPC 功能](/docs/user-guide/rpc/) 和 GridLinks [遥测](/docs/user-guide/telemetry/)。

在 ESP32 上运行的应用程序使用 GridLinks Arduino SDK 编写，该 SDK 非常简单易懂。

当前 GPIO 状态和 GPIO 控制小部件可视化使用内置的可自定义仪表板。

完成此示例/教程后，您将在以下仪表板上看到传感器数据。

 ![image](/images/samples/esp32/gpio-temperature/dashboard.png)

## 硬件清单

 - [ESP32 Pico Kit 板](https://www.espressif.com/en/products/hardware/development-boards)。

  ![image](https://docs.espressif.com/projects/esp-idf/en/latest/_images/esp32-pico-kit-v4.1-layout.jpg)

 - [DHT22 传感器](https://www.aliexpress.com/item/1pcs-DHT22-digital-temperature-and-humidity-sensor-Temperature-and-humidity-module-AM2302-replace-SHT11-SHT15/32316036161.html)

  ![image](/images/samples/arduino/temperature/dht22-pinout.png)

 - 6 个 LED
 - 6 个电阻，范围在 68Ω 到 100Ω 之间
 - 面包板
 - Micro-USB 电缆

## 接线

### DHT22 连接

引脚 | 连接到
-----------|-----------
DHT22 VCC | Pico 5V
DHT22 DATA | Pico 33

### LED 连接

引脚 | 连接到
-----------|-----------
LED1 正极 | Pico 32 通过电阻 (68Ω - 100Ω)
LED2 正极 | Pico 26 通过电阻 (68Ω - 100Ω)
LED3 正极 | Pico 25 通过电阻 (68Ω - 100Ω)
LED4 正极 | Pico 19 通过电阻 (68Ω - 100Ω)
LED5 正极 | Pico 22 通过电阻 (68Ω - 100Ω)
LED6 正极 | Pico 21 通过电阻 (68Ω - 100Ω)
所有 LED 负极 | Pico 接地

### 连接图

下图总结了此项目的连接：

![image](/images/samples/esp32/gpio-temperature/wiring.png)

## 设备配置

此步骤包含将设备连接到 GridLinks 所需的说明。

在浏览器中打开 GridLinks Web UI (http://localhost:8080) 并以租户管理员身份登录。
如果您在 TB 安装期间加载了演示数据，则可以使用以下凭据：

 - 登录名：tenant@gridlinks.com
 - 密码：tenant

转到“设备”部分。单击“+”按钮并创建一个名为“ESP32 Pico Device”的设备。将“设备类型”设置为“default”。

![image](/images/samples/esp32/gpio-temperature/device.png)

创建设备后，打开其详细信息并单击“管理凭据”。

从“访问令牌”字段复制自动生成的访问令牌。请保存此设备令牌。它将在以后称为 **$ACCESS_TOKEN**。

![image](/images/samples/esp32/gpio-temperature/credentials.png)

## 配置仪表板

使用此 [**链接**](/docs/samples/esp32/resources/esp32-dht22-temp-and-gpio-dashboard.json) 下载仪表板文件。
使用导入/导出 [**说明**](/docs/user-guide/ui/dashboards/#dashboard-importexport) 将仪表板导入 GridLinks 实例。

## 创建 ESP32 固件

对 ESP32 Pico Kit 进行编程的最简单方法是使用 Arduino IDE。以下部分描述了该方法。

### ESP32 和 Arduino IDE 设置

首先，您需要安装 Arduino IDE 和所有相关软件。

下载并安装 [Arduino IDE](https://www.arduino.cc/en/Main/Software)。

在构建任何程序并将其刷新到 ESP32 之前，必须将 Pico 板支持添加到 Arduino IDE。为此，请按如下所述安装 ESP32 软件包：

1. 打开 Arduino IDE。

1. 打开 **文件 -> 首选项** 菜单，并添加一个板管理器 URL

   ```
   https://dl.espressif.com/dl/package_esp32_index.json,http://arduino.esp8266.com/stable/package_esp8266com_index.json
   ```

   输入 **其他板管理器 URL** 字段，如下所示：

   ![image](/images/samples/esp32/gpio-temperature/add-esp32-url.png)

1. 选择 **工具 -> 板... -> 板管理器** 菜单。

1. 在搜索字段中输入 **ESP32**。单击 **安装**

   ![image](/images/samples/esp32/gpio-temperature/install-esp32-arduino.png)

### 安装 Arduino ThingsBoard SDK

为了简化应用程序开发，请从标准 Arduino 库存储库安装 GridLinks Arduino SDK 及其依赖项：

1. 进入 **草图 -> 包含库...** 子菜单。选择 **管理库**。

1. 查找并安装 **ThingsBoard Arduino SDK**、**Nick O'Leary 的 PubSubClient** 和 **ArduinoHttpClient** 库。

   ![image](/images/samples/esp32/gpio-temperature/install-thingsboard-arduino.png)
   ![image](/images/samples/esp32/gpio-temperature/install-pubsubclient-arduino.png)
   ![image](/images/samples/esp32/gpio-temperature/install-arduinohttpclient-arduino.png)

1. 安装 **ArduinoJSON** 库 **v6.9.1** 或更高版本。 <span style="color:red">避免安装 ArduinoJson 库的测试版</span>。

   ![image](/images/samples/esp32/gpio-temperature/do-not-use-beta-version-arduinojson.png)

从现在开始，您可以在 Arduino IDE 中直接使用 GridLinks SDK。

### 安装 ESP32 DHT22 驱动程序

连接到 ESP32 的 DHT22 传感器需要一个特殊的驱动程序。要安装它，请按以下步骤操作：

1. 单击“草图”菜单。打开“包含库...”子菜单。选择“管理库”。

1. 在搜索字段中键入“ESP DHT22”。

1. 单击“ESPx 的 DHT22 传感器库”上的安装，如下所示：

   ![image](/images/samples/esp32/gpio-temperature/install-esp32-dht22-arduino.png)

### 将 ESP32 Pico 连接到 PC

ESP32 Pico Kit 不需要复杂的连接。只需将 micro-USB 电缆插入 PC 和 Pico，这应该足够了。

### 准备并上传草图

下载并打开 **esp32-dht-gpio.ino** 草图。

**注意** 您需要在草图中编辑以下常量和变量：

- `WIFI_AP` - 您的接入点名称
- `WIFI_PASSWORD` - 接入点密码
- `TOKEN` - GridLinks 配置步骤中的 **$ACCESS_TOKEN**。
- `THINGSBOARD_SERVER` - ThingsBoard HOST/IP 地址，可在您的 wifi 网络中访问。如果您使用 [实时演示](https://gridlinks.codingas.com/) 服务器，请指定 `demo.docs.codingas.com`。

{% capture tabspec %}arduino-sketch
esp32-dht-gpio,esp32-dht-gpio.ino,c,resources/esp32-dht-gpio.ino,/docs/samples/esp32/resources/esp32-dht-gpio.ino{% endcapture %}
{% include tabs.html %}

## 故障排除

为了执行故障排除，您必须检查 ESP32 Pico 日志。为此，只需在 Arduino IDE 中打开 **串行监视器**。

## 数据可视化和 GPIO 控制

最后，打开 GridLinks Web UI。您可以通过以租户管理员身份登录来访问此仪表板。

在本地安装的情况下（如果在 TB 安装期间添加了演示数据）：

 - 登录名：tenant@gridlinks.com
 - 密码：tenant

在实时演示服务器的情况下：

 - 登录名：您的实时演示用户名（电子邮件）
 - 密码：您的实时演示密码

有关如何获取帐户的更多详细信息，请参阅 **[实时演示](/docs/user-guide/live-demo/)** 页面。

转到 **“设备”** 部分并找到 **“ESP32 Pico Device”**，打开设备详细信息并切换到 **“最新遥测”** 选项卡。
如果所有配置正确，您应该能够在表中看到 *“温度”* 和 *“湿度”* 的最新值。

![image](/images/samples/esp32/gpio-temperature/telemetry.png)

之后，打开 **“仪表板”** 部分，然后找到并打开 **“ESP32 Pico 仪表板”**。
结果，您将看到一个时序图表，显示温度和湿度水平（类似于介绍中的仪表板图像）。

您还应该观察设备的 GPIO 控制。它由两个小部件组成：一个用于控制 LED 闪烁速度（以毫秒为单位），另一个用于打开和关闭各个 LED。

您可以使用控制面板切换 GPIO 的状态。结果，您将在设备上看到 LED 状态发生变化。要控制 LED 闪烁速度，只需转动旋钮并观察速度变化。

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 GridLinks 主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}