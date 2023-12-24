---
layout: docwithnav
title: 超声波住宅智能燃气表 LoRaWAN “Smartico G-1.6” 遥测数据上传
description: GridLinks IoT 平台示例，使用智能燃气表 LoRaWAN “Smartico G-1.6” 通过 MQTT 上传燃气数据。
hidetoc: "true"
---

* TOC
{:toc}

# 超声波住宅智能燃气表 LoRaWAN “Smartico G-1.6” 遥测数据上传
## 简介
住宅燃气表“Smartico”生产的尺寸范围为 G-1.6、G-2.5、G-4、G-6，用于测量使用过的天然气和液化气的体积，并转换为 20 °C 温度下的标准参考值。该仪表采用紧凑型设计，没有移动的机械部件，允许在狭小空间内安装。仪表测量系统提供高精度的计量特性。该仪表提供可视控制和无线数据传输功能，通过使用 LoRaWAN 技术的免许可证频率范围。该图显示了一个包含已处理遥测结果的仪表板。

![image](/images/samples/smartico/gas-meter-lorawan/MainDashboard.png)

## 先决条件
LoRaWAN 技术用于将数据从燃气表 G-1.6 传输到 GridLinks 平台。这是一种无线通信技术，允许在长距离上交换少量数据。首先，您需要配置 LoRaWAN 服务器并确保数据从设备发送到服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。
在应用程序页面上完成服务器配置后，表中应出现一个包含设备类型的条目。

![image](/images/samples/smartico/gas-meter-lorawan/lora1.PNG)

例如，我们连接了一个序列号为 12676 的设备。通过正确配置 LoRaWAN 服务器，我们应该看到来自设备的数据流。从设备传输数据的频率取决于燃气表设置。

![image](/images/samples/smartico/gas-meter-lorawan/Lora2.PNG)

为了能够通过 MQTT 协议接收数据，您需要集成 [LoRaWAN 服务器和 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。
## 步骤 1. 创建上行数据转换器。
首先，您应该根据设备协议创建上行数据转换器。转换器将解码来自超声波住宅智能燃气表 LoRaWAN “Smartico G-1.6” 的传入遥测有效载荷数据，该数据包含在编码的 Base64 字符串中，转换为人类可读的、简化的 GridLinks 数据格式。导入包含上行数据转换器的 [uplink_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/uplink_gas_meter.json) 文件。

![image](/images/samples/smartico/gas-meter-lorawan/convert.PNG)

## 步骤 2. 集成配置。
要将超声波住宅智能燃气表 LoRaWAN “Smartico G-1.6” 集成到 GridLinks 平台，您应该创建一个新的集成，如图所示。

![image](/images/samples/smartico/gas-meter-lorawan/integration.PNG)

您还应该在下面根据 LoRaWAN 服务器配置添加主题过滤器（在本例中为 ```application/1/device/+/rx```）。在主机和端口字段中，输入安装 MQTT 代理的 IP 地址和用于与之配合工作的端口。
## 步骤 3. 验证从设备接收的数据。
连接燃气表以传输信息。如果集成没有错误执行，在传输第一个遥测数据后，一个名为“012676”的新设备将出现在设备组 → 全部中。您还可以分别验证转换前后的输入和输出数据，方法是转到数据转换器 → 上行燃气表 → 事件。

![image](/images/samples/smartico/gas-meter-lorawan/verify.PNG)

来自燃气表的数据输入如下所示：
```json
{
    "applicationID": "1",
    "applicationName": "Smartico_gas_meters",
    "deviceName": "12676",
    "devEUI": "02aaaa0200003184",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "bd949c88-fd1e-4c97-bbef-ad6412139d89",
        "name": "Kona_micro_lite",
        "rssi": -65,
        "loRaSNR": 6,
        "location": {
            "latitude": 48.44229794818326,
            "longitude": 35.014479160308845,
            "altitude": 144
        }
    }],
    "txInfo": {
        "frequency": 868300000,
        "dr": 0
    },
    "adr": true,
    "fCnt": 742,
    "fPort": 2,
    "data": "BAwMAQAxhAAAA1YK4w=="
}
```
有效载荷包含在“data”字段中并以 Base64 加密。解码后，输出数据将如下所示：
```json
{
    "deviceName": "12676",
    "deviceType": "Gas Meter",
    "attributes": {
        "integrationName": "Gas Meter"
    },
    "telemetry": {
        "gasMeter": 0.854,
        "temperature": 27.87,
 	"REAL_TIME": "26.08.2020 15:02:39",
        "SN": "12676",
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 0,
        "FLG_MAGNET_DETECT": 1,
        "FLG_TAMPER_DETECT": 1,
        "STS_VALVE": 0,
        "FLG_ERR_OVR": 0,
        "FLG_ERR_REVERSE": 0,
        "FLG_ERR_SENSOR": 0,
        "FLG_ERR_GAS": 1,
        "FLG_ERR_TIME": 1,
        "FLG_POWER_ON": 0,
        "FLG_LOCK": 0,
        "FLG_CFG_DONE": 0
    }
}
```
输入和输出数据仅用于示例目的，与本指南开头所示的仪表板无关。
在打开设备之前，您可以验证 [uplink_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/uplink_gas_meter.json) 文件中编程代码的功能。为此，请打开数据转换器中的上行燃气表的 **测试解码器功能**，并将本指南中的输入数据复制到 **有效载荷内容** 字段中。然后按 **测试** 按钮，在 **输出** 字段中应出现解码输出数据，如图所示（REAL_TIME 字段显示当前日期和时间）。

![image](/images/samples/smartico/gas-meter-lorawan/verify1.PNG)

## 步骤 4. 创建脉冲传感器资产。
为了能够在仪表板中显示数据，您应该首先创建一个资产并在关系中添加设备 012685，如图所示。

![image](/images/samples/smartico/gas-meter-lorawan/asset1.PNG)

![image](/images/samples/smartico/gas-meter-lorawan/asset2.PNG)

## 步骤 5. 规则链导入和配置。
除了仪表读数外，还可以监视设备的状态。例如，您可以获取有关电池电量不足、打开设备外壳、暴露于磁场等信息。此信息显示在警报小部件中。因此，您应该首先设置规则链。导入包含警报的 [alarms_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/alarms_gas_meter.json) 文件，并将规则链的配置保存在 GridLinks 中。

![image](/images/samples/smartico/gas-meter-lorawan/alarm1.PNG)

然后配置根规则链。您应该在根规则链中添加燃气表警报，如图所示。

![image](/images/samples/smartico/gas-meter-lorawan/alarm2.PNG)

## 步骤 6. 仪表板导入和配置。
要向用户显示数据，您需要创建一个可以从 [dashboard_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/dashboard_gas_meter.json) 文件导入的仪表板。

![image](/images/samples/smartico/gas-meter-lorawan/dashboard1.PNG)

导入仪表板时，需要创建一个别名，如图所示。

![image](/images/samples/smartico/gas-meter-lorawan/dashboard2.PNG)

如果一切操作正确，在仪表板组 → 全部中，您将看到本指南开头提供的新的仪表板 **超声波住宅智能燃气表 LoRaWAN "Smartico G-1.6"**。

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