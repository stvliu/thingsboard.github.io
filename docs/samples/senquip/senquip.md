---
layout: docwithnav
title: 将 Senquip 遥测设备连接到 GridLinks
description: 配置 Senquip 遥测设备，使其能够将遥测数据发送到 GridLinks。

---

* TOC
{:toc}

## 简介
GridLinks 是一个用于物联网解决方案的服务管理、数据收集、处理和可视化平台。如果您是第一次使用该平台，我们建议您查看 [what-is-thingsboard](/docs/getting-started-guides/what-is-thingsboard/) 页面和 [getting-started](/docs/getting-started-guides/helloworld/) 指南。


Senquip 制造可编程遥测设备，例如 [ORB-C1](https://www.senquip.com)，该设备可连接到任何工业传感器或系统。Senquip 设备可以同时与第三方端点（通过 UDP、HTTP 和 MQTT）和 [Senquip Portal](https://portal.senquip.com) 保持连接。这允许从 [Senquip Portal](https://portal.senquip.com) 进行配置更改和固件更新，同时将测量数据发送到 GridLinks。

Senquip 设备可以连接到 MODBUS、CAN 总线、电流、电压、频率和许多其他类型的传感器。在此示例中，位置、温度和 CAN 总线数据将使用 MQTT 从 Senquip ORB-C1 发送到 GridLinks。

以下是使用此数据进行实际安装的图片。

![image](/images/samples/senquip/digger.jpg)

完成后，数据将显示在以下仪表板上。

![image](/images/samples/senquip/dash.jpg)

Senquip 网站上还提供类似的指南，作为 [应用说明](https://docs.senquip.com/app_notes/APN0015%20Rev%201.0%20-%20Connecting%20Senquip%20Devices%20to%20the%20ThingsBoard.pdf)。


## 硬件和引脚列表

ORB-C1-G
![image](/images/samples/senquip/orb-x1-open.jpg)


引脚编号 | 名称 | 端子块标记 | 应用
----------------|-------------------------------|----------------------------|---------------------------------------------------------------------------------------
1 | 正电压输入 | PWR+ | 正系统电源；永久性或间歇性，例如来自太阳能电池板
2 | 负电压输入（接地） | GND | 负系统电源或接地
3 | 源 1 | SRC1 | 可切换输出，带电流测量，用于为传感器供电，例如 4-20mA 设备
4 | 接地 | GND | 传感器连接的备用接地
5 | 源 2 | SRC2 | 可切换输出，带电流测量，用于为传感器供电，例如 4-20mA 设备
6 | 串行输入 | B / RX | RS485B 在 RS485 模式下，在 RS232 模式下接收
7 | 串行输出 | A / TX | RS485A 在 RS485 模式下，在 RS232 模式下发送
8 | 输入 1 | IN1 | 具有边缘检测功能的模拟或数字输入
9 | 输入 2 | IN2 | 模拟或数字输入
10 | 输出 | OUT1 | 开集极输出
11 | CAN 总线高 | CAN H | CAN 总线高连接
12 | CAN 总线低 | CAN L | CAN 总线高连接


## Senquip 设备配置

在本指南中，假定用户在 [Senquip Portal](https://portal.senquip.com) 上拥有一个帐户，并且他们已向该帐户添加了一个设备。还假定设备网络配置为通过 Wi-Fi 或蜂窝网络运行。下面步骤中描述的所有设备配置都将在 [Senquip Portal](https://portal.senquip.com) 上执行。

### 常规设备设置

* [步骤 1] 为 Senquip 设备起一个有意义的名称（设置/常规/名称 = “演示 Senquip 设备”）。
* [步骤 2] 将 Senquip 设备进行测量的间隔和传输间隔配置为 5 秒（设置/常规/基本间隔 = 5）。
* [步骤 3] 打开 GPS 外设并将其设置为在每个基本间隔进行测量（设置/内部/GPS/间隔 = 1）。
* [步骤 4] 打开 CAN 外设并将其设置为在每个基本间隔进行测量（设置/外部/CAN/间隔 = 1）。如果这是网络上唯一的 CAN 设备，请选择“Tx 启用”，以便 Senquip 设备确认 CAN 消息。
* [步骤 5] 按保存按钮保存配置。

常规设置现在应如下所示。

![image](/images/samples/senquip/general.jpg)

### 配置 ThingsBoard 端点

Senquip 设备可以同时发送到 Senquip Portal 和第二个端点。在此示例中，ThingsBoard 将被配置为第二个端点，使用 MQTT 作为传输。

* [步骤 1] 启用 MQTT 端点（设置/端点/MQTT = 启用）。
* [步骤 2] 设置代理地址（设置/端点/MQTT/代理地址 = “thingsboard.cloud:1883”）。
* [步骤 3] 设置客户端地址，我们将使用唯一的设备 ID “AYCAN24V1”（设置/端点/MQTT/客户端 ID = “AYCAN24V1”）。
* [步骤 4] 设置数据主题（设置/端点/MQTT/数据主题 = “v1/devices/me/telemetry”）。
* [步骤 5] 选择要在 GridLinks 上使用的用户名，我们选择了“Senquip”（设置/端点/MQTT/用户名 = “Senquip”）。
* [步骤 6] 选择与用户名关联的密码，我们选择了“SenquipPassword”，我们建议您选择更安全的内容（设置/端点/MQTT/密码 = “SenquipPassword”）。

端点设置现在应如下所示。

![image](/images/samples/senquip/mqtt.jpg)

## Thingsboard 配置

假定用户在 [ThingsBoard Cloud](https://thingsboard.cloud/) 上拥有一个帐户。下面步骤中描述的所有设备配置都将使用 [ThingsBoard Cloud](https://thingsboard.cloud/) 执行。

### 创建新设备

* [步骤 1] 选择要向其添加 Senquip 设备的设备组。打开组并使用“+”按钮添加新设备。
* [步骤 2] 为新设备起一个有意义的名称，我们使用与步骤 1.1 中选择的名称相同。
* [步骤 3] 为设备提供一个简短的标签，该标签将用于地图等小部件，我们选择了“SQ1”。
* [步骤 4] 选择 MQTT 作为传输类型。
* [步骤 5] 按“下一步：凭据”继续。

新设备设置现在应如下所示。

![image](/images/samples/senquip/add.jpg)

### 设置凭据

* [步骤 1] 选择“MQTT Basic”作为凭据类型。
* [步骤 2] 插入客户端 ID、用户名和密码，与步骤 2.3、2.5 和 2.6 中相同。
* [步骤 3] 按“添加”添加已配置的设备。

凭据现在应如下所示。

![image](/images/samples/senquip/credentials.jpg)

## 遥测数据

Senquip 设备以 [JSON](https://en.wikipedia.org/wiki/JSON) 格式发送数据，如下图所示。

![image](/images/samples/senquip/raw.jpg)


JSON 数据包中的每个测量值都有一个键和一个值。例如，GPS 纬度具有键“gps_lat”和值“-32.70245”。在此示例中，正在接收 5 条 CAN 消息，每条消息都有一个标识符和一个值，因此 JSON 数据包中的 CAN 数据嵌套有 5 个单独的 CAN 标识符和值。

通过选择我们刚刚添加到 GridLinks 的设备并按“最新遥测”，我们可以看到遥测到达 ThingsBoard。请注意 ThingsBoard 如何自动识别 JSON 数据包中的数据并将其转换为键和值表。还请注意，CAN 数据是如何作为 5 行 CAN 标识符和值插入的。

![image](/images/samples/senquip/telemetry.jpg)


## 在仪表板上查看数据

现在，我们将遥测数据添加到仪表板上的小部件。

* [步骤 1] 从最新遥测中选择一个键，然后按“在小部件上显示”。

![image](/images/samples/senquip/widget.jpg)

* [步骤 2] 从可用的那些中选择一组小部件。对于温度，我们将选择模拟仪表。
* [步骤 3] 按“添加到仪表板”并选择可用仪表板或创建一个新仪表板。我们将创建一个新仪表板并将其命名为“Senquip Demo”。

![image](/images/samples/senquip/add-widget.jpg)

* [步骤 4] 从遥测数据中选择其他键并将它们与小部件关联，每次将它们添加到仪表板。
* [步骤 5] 对于某些小部件（例如地图小部件），需要多个键值（gps_lat 和 gps_lon）。在高级设置下，小部件的纬度和经度可以与 gps_lat 和 gps_lon 键关联。
* [步骤 6] 可以通过更改颜色、大小、小部件的位置、文本字体等来自定义仪表板和小部件。

仪表板现在如下所示。

![image](/images/samples/senquip/dash.jpg)


## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}