---
layout: docwithnav
title: 泄漏检测器 LoRaWAN “Smartico L2-LR” 遥测数据上传
description: GridLinks IoT 平台示例，用于通过泄漏检测器 LoRaWAN “Smartico L2-LR” 使用 MQTT 上传泄漏数据。
hidetoc: "true"
---

* TOC
{:toc}

# 泄漏检测器 LoRaWAN “Smartico L2-LR” 遥测数据上传
## 简介
泄漏检测器 LoRaWAN “Smartico L2-LR” 设备用于工业、公用事业和自动化领域的各种应用，用于通过 LoRaWAN 网络进行远程数据收集、泄漏检测和数据传输。该设备使用无源泄漏传感器实现两个区域控制，从而提供高能效解决方案。防水外壳中的传感器设计允许外部使用。下图显示了一个包含已处理遥测结果的仪表板。

![image](/images/samples/smartico/leaks-detector-lorawan/mainDash.PNG)

## 先决条件
LoRaWAN 技术用于将数据从泄漏检测器 L2-LR 传输到 GridLinks 平台。这是一种无线通信技术，允许在长距离上交换少量数据。首先，您需要配置 LoRaWAN 服务器并确保数据从设备发送到服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。
在应用程序页面上完成服务器配置后，表中应出现具有设备类型的条目。

![image](/images/samples/smartico/leaks-detector-lorawan/Lora1.PNG)

例如，我们连接了一个序列号为 13123 的设备。通过正确配置 LoRaWAN 服务器，我们应该在“设备数据”页面上看到来自设备的数据流。从设备传输数据的频率取决于泄漏检测器的设置。

![image](/images/samples/smartico/leaks-detector-lorawan/Lora2.PNG)

为了能够通过 MQTT 协议接收数据，您需要集成 [LoRaWAN 服务器和 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。
## 步骤 1. 创建上行数据转换器。
首先，您应该根据设备协议创建上行数据转换器。转换器将解码来自泄漏检测器 LoRaWAN “Smartico L2-LR” 的传入遥测有效载荷数据，该数据包含编码的 Base64 字符串，以转换为人类可读的、简化的 GridLinks 数据格式。导入包含上行数据转换器的 [uplink_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/uplink_leaks_detector.json) 文件。

![image](/images/samples/smartico/leaks-detector-lorawan/uplink.PNG)

## 步骤 2. 集成配置。
要将泄漏检测器 LoRaWAN “Smartico L2-LR” 集成到 GridLinks 平台，您应该创建一个新的集成，如图所示。

![image](/images/samples/smartico/leaks-detector-lorawan/Integration.PNG)

您还应该在下面根据 LoRaWAN 服务器配置添加主题过滤器（在本例中为 ```application/7/device/+/rx```）。在主机和端口字段中，输入安装 MQTT 代理的 IP 地址和用于与其配合工作的端口。
## 步骤 3. 验证从设备接收的数据。
连接泄漏检测器 L2-LR 以传输信息。如果集成没有错误执行，在传输第一个遥测后，一个名为“13123”的新设备将出现在设备组 → 全部中。您还可以分别验证转换前后的输入和输出数据，方法是转到数据转换器 → 上行泄漏检测器 → 事件。

![image](/images/samples/smartico/leaks-detector-lorawan/verifying.PNG)

来自泄漏检测器的输入数据如下所示：
```json
{
    "applicationID": "7",
    "applicationName": "Smartico_leak_sensor",
    "deviceName": "13123",
    "devEUI": "02aaaa0100003343",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "4e9ed6ae-b658-4e11-b686-1ecae882c807",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -68,
        "loRaSNR": 4.8,
        "location": {
            "latitude": 48.44229794818326,
            "longitude": 35.014479160308845,
            "altitude": 144
        }
    }],
    "txInfo": {
        "frequency": 868500000,
        "dr": 0
    },
    "adr": true,
    "fCnt": 2220,
    "fPort": 7,
    "data": "YgAtAAAAAAAAAAA="
}
```
有效载荷包含在“data”字段中并以 Base64 加密。解码后，输出数据将如下所示：
```json
{
    "deviceName": "13123",
    "deviceType": "Leak Sensor",
    "attributes": {
        "integrationName": "Leaks Detector"
    },
    "telemetry": {
        "NAME_DEV": "Leaks Detector LoRaWAN 'Smartico L2-LR'",
        "SN": "13123",
        "REAL_TIME": "27.08.2020 10:46:25",
        "FRAUD_1": "Not discovered",
        "FRAUD_2": "Not discovered",
        "FRAUD_1D": 1,
        "FRAUD_2D": 1,
        "FLG_ERR_PULSE_1": 0,
        "FLG_ERR_PULSE_2": 0,
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 1,
        "FLG_MAGNET_DETECT": 0,
        "FLG_TAMPER_DETECT": 0,
        "FLG_POWER_ON": 0,
        "FLG_POWER_BAT": 1,
        "FLG_ERR_TIME": 1,
        "FLG_CFG_DONE": 0
    }
}
```
输入和输出数据仅用于示例目的，与本指南开头所示的仪表板无关。
在打开设备之前，您可以验证 [uplink_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/uplink_leaks_detector.json) 文件中编程代码的功能。为此，请打开数据转换器中的上行泄漏检测器测试解码器功能，并将本指南中的输入数据复制到 **有效载荷内容** 字段中。然后按 **测试** 按钮，在 **输出** 字段中应出现解码输出数据，如图所示（REAL_TIME 字段显示当前日期和时间）。

![image](/images/samples/smartico/leaks-detector-lorawan/verifying2.PNG)

## 步骤 4. 创建泄漏检测器资产。
为了能够在仪表板中显示数据，您应该首先创建一个资产并在关系中添加设备 13123，如图所示。

![image](/images/samples/smartico/leaks-detector-lorawan/addAsset.PNG)

![image](/images/samples/smartico/leaks-detector-lorawan/addRelation.PNG)

## 步骤 5. 规则链导入和配置。
除了仪表读数外，还可以监视设备的状态。例如，您可以获取有关电池电量不足、打开设备外壳、暴露于磁场等信息。此信息显示在警报小部件中。因此，您应该首先设置规则链。导入包含警报的 [alarms_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/alarms_leaks_detector.json) 文件，并将规则链的配置保存在 GridLinks 中。

![image](/images/samples/smartico/leaks-detector-lorawan/alarm1.PNG)

然后配置根规则链。您应该在根规则链中添加泄漏检测器警报，如图所示。

![image](/images/samples/smartico/leaks-detector-lorawan/alarm2.PNG)

## 步骤 6. 仪表板导入和配置。
要向用户显示数据，您需要创建一个可以从 [dashboard_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/dashboard_leaks_detector.json) 文件导入的仪表板。

![image](/images/samples/smartico/leaks-detector-lorawan/dashboard.PNG)

导入仪表板时，需要创建一个别名，如图所示。

![image](/images/samples/smartico/leaks-detector-lorawan/alias.PNG)

如果一切操作正确，在仪表板组 → 全部中，您将看到本指南开头提供的新的仪表板 **泄漏检测器 LoRaWAN Smartico “L2-LR”**。

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 GridLinks 主要功能相关的指南：

- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}