---
layout: docwithnav
title: Gas Shutoff Valve LoRaWAN “Smartico V-LR” 遥测数据上传
description: GridLinks IoT 平台示例，使用 Gas Shutoff Valve LoRaWAN “Smartico V-LR” 通过 MQTT 上传阀门状态数据。
hidetoc: "true"
---

* TOC
{:toc}

# Gas Shutoff Valve LoRaWAN “Smartico V-LR” 遥测数据上传
## 简介
Gas Shutoff Valve LoRaWAN “Smartico V-LR” 设计用于远程关闭低压气体网络中的气体供应。截止阀采用自主电源。它具有特殊的阀门激活机制，可安全恢复气体供应。提供了安装保护密封件的位置，以防止未经授权访问电源并排除从连接气体管道拆卸阀门的可能性。下图显示了一个包含已处理遥测结果的仪表板。

![image](/images/samples/smartico/gas-valve-lorawan/MainDash.png)

## 先决条件
LoRaWAN 技术用于将数据从气阀 V-LR 传输到 GridLinks 平台。这是一种无线通信技术，允许在长距离上交换少量数据。首先，您需要配置 LoRaWAN 服务器并确保数据从设备发送到服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。
在应用程序页面上完成服务器配置后，表中应出现带有设备类型的条目。

![image](/images/samples/smartico/gas-valve-lorawan/Lora1.PNG)

例如，我们连接了一个序列号为 0000129 的设备。通过正确配置 LoRaWAN 服务器，我们应该在“设备数据”页面上看到来自设备的数据流。从设备传输数据的频率取决于气阀设置。

![image](/images/samples/smartico/gas-valve-lorawan/Lora2.PNG)

要能够通过 MQTT 协议接收数据，您需要集成 [LoRaWAN 服务器和 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。
## 步骤 1. 创建上行数据转换器。
首先，您应该根据设备协议创建上行数据转换器。转换器将解码来自 Gas Shutoff Valve LoRaWAN “Smartico V-LR” 的传入遥测有效载荷数据，其中包含编码的 Base64 字符串，以转换为人类可读的、简化的 ThingsBoard 数据格式。导入包含上行数据转换器的 [uplink_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/uplink_gas_valve.json) 文件。

![image](/images/samples/smartico/gas-valve-lorawan/converter.PNG)

## 步骤 2. 集成配置。
要将 Gas Shutoff Valve LoRaWAN “Smartico V-LR” 集成到 GridLinks 平台，您应该创建一个新的集成，如图所示。

![image](/images/samples/smartico/gas-valve-lorawan/integration.PNG)

您还应该在下面根据 LoRaWAN 服务器配置添加主题过滤器（在本例中为 ```application/6/device/+/rx```）。在主机和端口字段中，输入安装 MQTT 代理的 IP 地址和用于与其配合工作的端口。
## 步骤 3. 验证从设备接收的数据。
连接气阀 V-LR 以传输信息。如果集成没有错误执行，在传输第一个遥测后，设备组 → 全部中将出现一个名为“0000129”的新设备。您还可以分别在数据转换器 → 上行气阀 → 事件中验证转换前后的输入和输出数据。

![image](/images/samples/smartico/gas-valve-lorawan/Verifying.PNG)

来自气阀的输入数据如下所示：
```json
{
    "applicationID": "6",
    "applicationName": "Smartico_gaz_valves",
    "deviceName": "VALVE_0000129",
    "devEUI": "02aaaa0100000081",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "bebb9711-3fe0-4ddd-ad16-9815af9c0f42",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -72,
        "loRaSNR": 9.8,
        "location": {
            "latitude": 48.44229794818326,
            "longitude": 35.014479160308845,
            "altitude": 144
        }
    }],
    "txInfo": {
        "frequency": 868100000,
        "dr": 0
    },
    "adr": true,
    "fCnt": 12,
    "fPort": 2,
    "data": "BkABAACB"
}
```
有效载荷包含在“data”字段中并以 Base64 加密。解码后，输出数据如下所示：
```json
{
    "deviceName": "0000129",
    "deviceType": "Gas Valve",
    "attributes": {
        "integrationName": "Gas Valve"
    },
    "telemetry": {
        "NAME_DEV": "Gas Shutoff Valve LoRaWAN 'Smartico V-LR'",
        "REAL_TIME": "26.08.2020 10:25:20",
        "SERIAL": "0000129",
        "VALVE_MODEL": "Gas",
        "STS_VALVE": "Close",
        "STS_VALVE_CODE": 1,
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 0,
        "FLG_MAGNET_DETECT": 0,
        "FLG_TAMPER_DETECT": 0,
        "FLG_POWER_ON": 0,
        "FLG_POWER_BAT": 0,
        "FLG_ERR_TIME": 1,
        "FLG_CFG_DONE": 0
    }
}
```
输入和输出数据仅用于示例目的，与本指南开头所示的仪表板无关。
在打开设备之前，您可以验证 [uplink_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/uplink_gas_valve.json) 文件中编程代码的功能。为此，请打开数据转换器中的上行气阀的 **测试解码器功能**，并将本指南中的输入数据复制到 **有效载荷内容** 字段中。按 **测试** 按钮，然后 **输出** 字段中应出现解码输出数据，如图所示（REAL_TIME 字段显示当前日期和时间）。

![image](/images/samples/smartico/gas-valve-lorawan/VerifyingUplink.PNG)

## 步骤 4. 创建气阀资产。
要能够在仪表板中显示数据，您应该首先创建一个资产并在关系中添加设备 0000129，如图所示。

![image](/images/samples/smartico/gas-valve-lorawan/asset.PNG)

![image](/images/samples/smartico/gas-valve-lorawan/asset2.PNG)

## 步骤 5. 规则链导入和配置。
除了仪表读数外，还可以监视设备的状态。例如，您可以获取有关电池电量不足、打开设备外壳、暴露于磁场等信息。此信息显示在警报小部件中。因此，您应该首先设置规则链。导入包含警报的 [alarms_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/alarms_gas_valve.json) 文件，并将规则链的配置保存在 GridLinks 中。

![image](/images/samples/smartico/gas-valve-lorawan/alarm1.PNG)

然后配置根规则链。您应该在根规则链中添加气阀警报，如图所示。

![image](/images/samples/smartico/gas-valve-lorawan/alarm2.PNG)

## 步骤 6. 仪表板导入和配置。
要向用户显示数据，您需要创建一个可以从 [dashboard_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/dashboard_gas_valve.json) 文件导入的仪表板。

![image](/images/samples/smartico/gas-valve-lorawan/dashboard1.PNG)

导入仪表板时，需要创建一个别名，如图所示。

![image](/images/samples/smartico/gas-valve-lorawan/dashboard2.PNG)

如果一切操作正确，在仪表板组 → 全部中，您将看到本指南开头提供的新的仪表板 **Gas Shutoff Valve LoRaWAN “Smartico V-LR”**。

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