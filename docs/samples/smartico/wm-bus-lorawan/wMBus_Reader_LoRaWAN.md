---
layout: docwithnav
title: 水表 wM-Bus Reader LoRaWAN "Smartico WM-LR" 遥测数据上传
description: ThingsBoard IoT 平台示例，用于通过 wM-Bus Reader LoRaWAN "Smartico WM-LR" 使用 MQTT 上传水表数据。
hidetoc: "true"
---

* TOC
{:toc}

# 水表 wM-Bus Reader LoRaWAN "Smartico WM-LR" 遥测数据上传
## 简介
设备 wM-Bus Reader LoRaWAN “Smartico WM-LR” 用于工业、公用事业和自动化领域的各种应用，通过 wM-Bus 协议和 LoRaWAN 网络数据传输，从燃气、水、电和热量表远程收集数据。此外，该设备还具有一个输入，可作为标准连接到 Kamstrup 表的数字接口。此输入还可用于计数脉冲。传感器采用防水外壳设计，允许外部使用。传感器的紧凑尺寸允许安装在狭小空间内，特殊适配器可将传感器可靠地安装到管道或平坦表面，而无需打开外壳。在此示例中，四个水表连接到设备。下图显示了一个包含已处理遥测结果的仪表板。

![image](/images/samples/smartico/wm-bus-lorawan/mainDashboard.PNG)

## 先决条件
LoRaWAN 技术用于将数据从 wM-Bus Reader WM-LR 传输到 ThingsBoard 平台。这是一种无线通信技术，允许在长距离上交换少量数据。首先，您需要配置 LoRaWAN 服务器并确保数据从设备发送到服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。
在应用程序页面上完成服务器配置后，表中应出现一个包含设备类型的条目。

![image](/images/samples/smartico/wm-bus-lorawan/Lora1.PNG)

例如，我们连接了一个序列号为 0000020 的设备。通过正确配置 LoRaWAN 服务器，我们应该可以看到来自设备的数据流。从设备传输数据的频率取决于 wM-Bus Reader 设置。

![image](/images/samples/smartico/wm-bus-lorawan/Lora2.PNG)

要能够通过 MQTT 协议接收数据，您需要集成 [LoRaWAN 服务器和 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。
## 步骤 1. 创建上行数据转换器。
首先，您应该根据设备协议创建上行数据转换器。转换器将解码来自 wM-Bus Reader LoRaWAN “Smartico WM-LR” 的传入遥测有效载荷数据，该数据包含编码的 Base64 字符串，转换为人类可读的、简化的 ThingsBoard 数据格式。导入包含上行数据转换器的 [uplink_wmbus_reader.json](/docs/samples/smartico/wm-bus-lorawan/resources/uplink_wmbus_reader.json) 文件。

![image](/images/samples/smartico/wm-bus-lorawan/converter.PNG)

## 步骤 2. 集成配置。
要将 wM-Bus Reader LoRaWAN “Smartico WM-LR” 集成到 ThingsBoard 平台，您应该创建一个新的集成，如图所示。

![image](/images/samples/smartico/wm-bus-lorawan/Integration.PNG)

您还应该在下面根据 LoRaWAN 服务器配置添加主题过滤器（在此示例中为 ```application/3/device/+/rx```）。在主机和端口字段中，输入安装 MQTT 代理的 IP 地址和用于与之配合工作的端口。
## 步骤 3. 验证从设备接收的数据。
连接 wM-Bus Reader WM-LR 以传输信息。如果集成没有错误，在传输第一个遥测数据后，一个名为“0000020”的新设备将出现在设备组 → 全部中。您还可以分别在数据转换器 → 上行 wM-Bus Reader → 事件中验证转换前后的输入和输出数据。

![image](/images/samples/smartico/wm-bus-lorawan/Verifying.PNG)

请注意，来自每个表的数据以单独的包形式出现。在这种情况下，仪表板上指示的时间对应于最后一个包的时间。变量 “existSerial” 必须包含连接到 wM-Bus Reader 的所有表的序列号。例如 ```var existSerial=['66413314','65656691','66413313', '66413315'];```。
来自 wM-Bus Reader 的输入数据如下所示：
```json
{
    "applicationID": "3",
    "applicationName": "Smartico_wmbus_readers",
    "deviceName": "0000020",
    "devEUI": "02aaaa0100000014",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "14b77859-1e6c-4668-8eb3-73900e49a33c",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -89,
        "loRaSNR": 7.5,
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
    "fCnt": 28,
    "fPort": 33,
    "data": "IAP1YwIAAAAATFo="
}
```
有效载荷包含在 “data” 字段中并以 Base64 加密。解码后，输出数据如下所示：
```json
{
    "deviceName": "0000020",
    "deviceType": "wM-Bus Reader",
    "attributes": {
        "integrationName": "wM-Bus Reader Integration"
    },
    "telemetry": {
        "REAL_TIME": "26.08.2020 16:38:14",
        "SERIAL1": "66413314",
        "SERIAL2": null,
        "SERIAL3": null,
        "SERIAL4": null,
        "WATER_WMBUS_VALUE1": 19.546,
        "WATER_WMBUS_VALUE2": null,
        "WATER_WMBUS_VALUE3": null,
        "WATER_WMBUS_VALUE4": null,
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 0,
        "FLG_MAGNET_DETECT": 0,
        "FLG_TAMPER_DETECT": 0,
        "FLG_POWER_ON": 0,
        "FLG_POWER_BAT": 1,
        "FLG_ERR_TIME": 0,
        "FLG_CFG_DONE": 0
    }
}
```
输入和输出数据仅用于示例目的，与本指南开头所示的仪表板无关。
在打开设备之前，您可以验证 [uplink_wmbus_reader.json](/docs/samples/smartico/wm-bus-lorawan/resources/uplink_wmbus_reader.json) 文件中编程代码的功能。为此，请打开数据转换器中的上行 wM-Bus Reader 的 **测试解码器函数**，并将本指南中的输入数据复制到 **有效载荷内容** 字段中。按 **测试** 按钮，然后 **输出** 字段中应显示解码输出数据，如图所示（REAL_TIME 字段显示当前日期和时间）。

![image](/images/samples/smartico/wm-bus-lorawan/verifying2.PNG)

## 步骤 4. 创建 wM-Bus Reader 资产。
要能够在仪表板上显示数据，您应该首先创建一个资产并在关系中添加设备 0000020，如图所示。

![image](/images/samples/smartico/wm-bus-lorawan/asset1.PNG)

![image](/images/samples/smartico/wm-bus-lorawan/asset2.PNG)

## 步骤 5. 规则链导入和配置。
除了仪表读数外，还可以监视设备的状态。例如，您可以获取有关电池电量不足、打开设备外壳、暴露于磁场等信息。此信息显示在警报小部件中。因此，您应该首先设置规则链。导入包含警报的 [alarms_wmbus_reader.json](/docs/samples/smartico/wm-bus-lorawan/resources/alarms_wmbus_reader.json) 文件，并将规则链的配置保存在 ThingsBoard 中。

![image](/images/samples/smartico/wm-bus-lorawan/alarms1.PNG)

然后配置根规则链。您应该在根规则链中添加 wMBus Reader 警报，如图所示。

![image](/images/samples/smartico/wm-bus-lorawan/alarms2.PNG)

## 步骤 6. 仪表板导入和配置。
要向用户显示数据，您需要创建一个可以从 [dashboard_wmbus_reader.json](/docs/samples/smartico/wm-bus-lorawan/resources/dashboard_wmbus_reader.json) 文件导入的仪表板。

![image](/images/samples/smartico/wm-bus-lorawan/dash1.PNG)

导入仪表板时，需要创建一个别名，如图所示。

![image](/images/samples/smartico/wm-bus-lorawan/dash2.PNG)

如果一切顺利，在仪表板组 → 全部中，您将看到本指南开头提供的新的仪表板 **水表 wM-Bus Reader LoRaWAN “Smartico WM-LR”**。

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 ThingsBoard 主要功能相关的指南：

- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}