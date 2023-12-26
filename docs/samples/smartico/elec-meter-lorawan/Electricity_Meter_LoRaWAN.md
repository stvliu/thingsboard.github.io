---
layout: docwithnav
title: 三相智能电表“Smartico E307”遥测上传
description: 使用智能电表“Smartico E307”通过 MQTT 上传电力数据到 GridLinks IoT 平台的示例。
hidetoc: "true"
---

* TOC
{:toc}

# 三相智能电表“Smartico E307”遥测上传
## 简介
三相智能电表“Smartico E307”针对智能计量系统进行了优化。它有多种形状和变体。Smartico E307 是一款真正的智能电表，能够将数据存储在非易失性存储器中，并测量消耗和输送到电网的有功/无功能量。主要功能是准确测量环路电网参数，包括电压、电流、功率、频率和其他参数。仪表板包含两种状态——计数器读数和质量参数。下图显示了具有处理遥测结果的仪表板状态。

仪表板的计数器读数状态。

![image](/images/samples/smartico/elec-meter-lorawan/MainDash1.PNG)

仪表板的质量参数状态。

![image](/images/samples/smartico/elec-meter-lorawan/MainDash2.PNG)

## 前提条件
LoRaWAN 技术用于将数据从电表“Smartico E307”传输到 GridLinks 平台。这是一种无线通信技术，允许在长距离上交换少量数据。首先，您需要配置 LoRaWAN 服务器并确保数据从设备发送到服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。
完成应用程序页面上的服务器配置后，表中应出现具有设备类型的条目。

![image](/images/samples/smartico/elec-meter-lorawan/Lora1.PNG)

例如，我们连接了一个序列号为 0012778 的设备。通过正确配置 LoRaWAN 服务器，我们应该看到来自设备的数据流。从设备传输数据的频率取决于电表设置。

![image](/images/samples/smartico/elec-meter-lorawan/Lora2.PNG)

为了能够通过 MQTT 协议接收数据，您需要集成 [LoRaWAN 服务器和 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。
## 步骤 1. 创建上行数据转换器。
首先，您应该根据设备协议创建上行数据转换器。转换器将解码来自电表“Smartico E307”的传入遥测有效载荷数据，其中包含编码的 Base64 字符串，以转换为人类可读的、简化的 GridLinks 数据格式。导入 [uplink_elec_meter.json](/docs/samples/smartico/elec-meter-lorawan/resources/uplink_elec_meter.json) 文件，其中包含上行数据转换器。

![image](/images/samples/smartico/elec-meter-lorawan/uplink.PNG)

## 步骤 2. 集成配置。
要将电表“Smartico E307”集成到 GridLinks 平台，您应该创建一个新的集成，如图所示。

![image](/images/samples/smartico/elec-meter-lorawan/Integration.PNG)

您还应该在下面根据 LoRaWAN 服务器配置添加主题过滤器（在本例中为 ``` application/2/device/+/rx ```）。在主机和端口字段中，输入安装 MQTT 代理的 IP 地址和用于与其协同工作的端口。
## 步骤 3. 验证从设备接收的数据。
连接电表以传输信息。如果集成没有错误执行，则在传输第一个遥测后，一个名为“0012778”的新设备将出现在设备组 → 全部中。您还可以分别在转换前和转换后验证输入和输出数据，方法是转到数据转换器 → 上行电表 → 事件。

![image](/images/samples/smartico/elec-meter-lorawan/verifying.PNG)

来自电表的数据输入如下所示：
```json
{
    "applicationID": "2",
    "applicationName": "Smartico_electric_meters",
    "deviceName": "0012778",
    "devEUI": "02aaaa02000031ea",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "9d29d67f-8db2-4c7e-9fa8-b7f9bd5be9e6",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -80,
        "loRaSNR": 5.2,
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
    "fCnt": 2202,
    "fPort": 15,
    "data": "QF8gJWwgSK4giMogyIYhQHEhgcshwTwiw1BBwABNNw=="
}
```
有效载荷包含在“data”字段中并以 Base64 加密。解码后，输出数据将如下所示：
```json
{
    "deviceName": "0012778",
    "deviceType": "elecMeter",
    "attributes": {
        "integrationName": "Elec Meter"
    },
    "telemetry": {
        "REAL_TIME": "27.08.2020 09:51:49",
        "SN": "0012778",
        "deviceTypeTelemetry": "Smartico E307",
        "NAME_DEV": "Electricity Meter 'Smartico E307'",
        "VOLTAGE_A": 222.2,
        "VOLTAGE_B": 225,
        "VOLTAGE_C": 218.2,
        "CURRENT_A": 1.13,
        "CURRENT_B": 4.59,
        "CURRENT_C": 3.16,
        "FREQUENCY": 50,
        "POWER_FULL_SUMMARY": 197.67,
        "POWER_FULL_A": null,
        "POWER_FULL_B": null,
        "POWER_FULL_C": null,
        "POWER_ACTIVE_SUMMARY": null,
        "POWER_ACTIVE_A": null,
        "POWER_ACTIVE_B": null,
        "POWER_ACTIVE_C": null,
        "POWER_REACTIVE_SUMMARY": null,
        "POWER_REACTIVE_A": null,
        "POWER_REACTIVE_B": null,
        "POWER_REACTIVE_C": null,
        "VALUE": null,
        "ENERGY_ACTIVE_SUMMARY": null,
        "ENERGY_ACTIVE_T1": null,
        "ENERGY_ACTIVE_T2": null,
        "ENERGY_ACTIVE_T3": null,
        "ENERGY_ACTIVE_T4": null,
        "ENERGY_ACTIVE_T5": null,
        "ENERGY_ACTIVE_T6": null,
        "ENERGY_ACTIVE_T7": null,
        "ENERGY_ACTIVE_T8": null,
        "ENERGY_REACTIVE_SUMMARY": null,
        "ENERGY_REACTIVE_T1": null,
        "ENERGY_REACTIVE_T2": null,
        "ENERGY_REACTIVE_T3": null,
        "ENERGY_REACTIVE_T4": null,
        "ENERGY_REACTIVE_T5": null,
        "ENERGY_REACTIVE_T6": null,
        "ENERGY_REACTIVE_T7": null,
        "ENERGY_REACTIVE_T8": null
    }
}
```
输入和输出数据仅用于示例目的，与本指南开头所示的仪表板无关。
在打开设备之前，您可以验证 [uplink_elec_meter.json](/docs/samples/smartico/elec-meter-lorawan/resources/uplink_elec_meter.json) 文件中编程代码的功能。为此，请打开数据转换器中的上行电表 **测试解码器功能**，并将本指南中的输入数据复制到 **有效载荷内容** 字段中。按 **测试** 按钮，然后 **输出** 字段中应显示解码输出数据，如图所示（REAL_TIME 字段显示当前日期和时间）。

![image](/images/samples/smartico/elec-meter-lorawan/verifyingUplink.PNG)

## 步骤 4. 创建电表资产。
为了能够在仪表板中显示数据，您应该首先创建一个资产并在关系中添加设备 0012778，如图所示。

![image](/images/samples/smartico/elec-meter-lorawan/asset1.PNG)

![image](/images/samples/smartico/elec-meter-lorawan/asset2.PNG)

## 步骤 5. 仪表板导入和配置。
要向用户显示数据，您需要创建一个可以从 [dashboard_elec_meter.json](/docs/samples/smartico/elec-meter-lorawan/resources/dashboard_elec_meter.json) 文件导入的仪表板。

![image](/images/samples/smartico/elec-meter-lorawan/dash1.PNG)

导入仪表板时，需要创建一个别名，如图所示。

![image](/images/samples/smartico/elec-meter-lorawan/dash2.PNG)

如果一切正常，在仪表板组 → 全部中，您将看到本指南开头提供的新的仪表板 **三相智能电表“Smartico E307”**。

## 参见

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