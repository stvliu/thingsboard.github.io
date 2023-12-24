---
layout: docwithnav
assignees:
- zbeacon
title: 如何使用网关连接 BLE 温度和湿度传感器
description: 了解如何使用网关连接 BLE 温度和湿度传感器

---

* TOC
{:toc}

## 设备信息

在本指南中，我们将使用米家湿度和温度传感器。
我们将使用 [BLE 连接器](/docs/iot-gateway/config/ble/) 连接到设备并收集数据。

我们对该设备的目标：

1. 温度和湿度数据。
2. 获取设备名称。

目前，有关设备的唯一信息是其 MAC 地址和特征标识符：

MAC 地址 - 4C:65:A8:DF:85:C0

特征 ID：

00002A00-0000-1000-8000-00805F9B34FB - 标准设备名称特征的标识符 ([GATT 规范](https://www.bluetooth.com/specifications/gatt/services/))

226CAA55-6476-4566-7562-66734470666D - 自定义温度和湿度特征的标识符 ([如何从 BLE 设备获取特征列表标识符](#how-to-get-characteristics-identifiers-list-from-ble-device))

## 步骤 1. 所需库

在我们开始在网关中配置 BLE 连接器之前。
这些库取决于您的操作系统类型：


{% capture systemtogglespec %}
基于 Debian<br>%,%deb%,%templates/iot-gateway/ble-requirements-deb.md%br%
基于 Red Hat<br>%,%red-hat%,%templates/iot-gateway/ble-requirements-rpm.md{% endcapture %}

{% include content-toggle.html content-toggle-id="SystemLibraries" toggle-spec=systemtogglespec %}


## 步骤 2. 配置 BLE 连接器

我们需要创建 ble 设置文件并将配置放在其中。例如：

```json
{
    "name": "BLE Connector",
    "rescanIntervalSeconds": 100,
    "checkIntervalSeconds": 100,
    "scanTimeSeconds": 5,
    "passiveScanMode": true,
    "devices": [
        {
            "name": "Temperature and humidity sensor",
            "MACAddress": "4C:65:A8:DF:85:C0",
            "telemetry": [
                {
                    "key": "temperature",
                    "method": "notify",
                    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
                    "byteFrom": 2,
                    "byteTo": 6
                },
                {
                    "key": "humidity",
                    "method": "notify",
                    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
                    "byteFrom": 9,
                    "byteTo": 13
                }
            ],
            "attributes": [
                {
                    "key": "name",
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
                    "method": "read",
                    "byteFrom": 0,
                    "byteTo": -1
                }
            ],
            "attributeUpdates": [
                {
                    "attributeOnThingsBoard": "sharedName",
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB"
                }
            ],
            "serverSideRpc": [
                {
                    "methodRPC": "sharedName",
                    "withResponse": true,
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
                    "methodProcessing": "write"
                }
            ]
        }
    ]
}
```
{: .copy-code}


有关 BLE 配置文件的部分，您可以在此处 [了解更多](/docs/iot-gateway/config/ble/)。

在本指南中，我们将使用上面的配置。

让我们分析我们的设置：

1. 连接器的常规配置。在本节中，我们定义了常规连接器设置，例如连接器名称（“BLE 连接器”）、重新扫描间隔（100）等。您可以在此处 [阅读有关可用参数的更多信息](/docs/iot-gateway/config/ble/#main-section)。
2. 常规设备配置。在本节中，我们定义了常规设备设置，例如 ThingsBoard 中的设备名称（“温度和湿度传感器”）、MAC 地址（“4C:65:A8:DF:85:C0”）等。您可以在此处 [阅读有关可用参数的更多信息](/docs/iot-gateway/config/ble/#device-object-subsection)。
3. 遥测配置。在本节中，我们定义了温度和湿度参数的配置。您可以在此处 [阅读有关可用参数的更多信息](/docs/iot-gateway/config/ble/#subsection-telemetry)。
4. 属性配置。在本节中，我们定义了连接器将从特征（“00002A00-0000-1000-8000-00805F9B34FB”）中读取值，并将其作为 ThingsBoard 上的设备客户端属性（“名称”）写入。您可以在此处 [阅读有关可用参数的更多信息](/docs/iot-gateway/config/ble/#subsection-attributes)。
5. 属性更新配置。在本节中，我们配置了网关，以便在我们在 ThingsBoard 设备中更改共享属性（“sharedName”）时更改设备名称。您可以在此处 [阅读有关可用参数的更多信息](/docs/iot-gateway/config/ble/#subsection-attributeupdates)。
6. 服务器端 rpc 配置。在本节中，我们配置了网关，以便在从 ThingsBoard 调用 RPC 方法（“rpcMethod1”）时读取设备名称并返回该名称。您可以在此处 [阅读有关可用参数的更多信息](/docs/iot-gateway/config/ble/#subsection-serversiderpc)。

如果您有不同的设备，则应在配置 json 中提供您的设备特征标识符。

我们将配置文件另存为 **ble.json**，位于 config 文件夹中（包含常规配置文件 - **tb_gateway.yaml** 的目录）。

## 步骤 3. 打开连接器

要使用连接器，我们必须在主配置文件（**[tb_gateway.yaml](/docs/iot-gateway/configuration/#connectors-configuration)**）中将其打开

在“connectors”部分中，我们应该取消注释以下字符串：

```yaml
   -
     name: BLE Connector
     type: ble
     configuration: ble.json
```

## 步骤 4. 运行网关

要使用 BLE 连接器运行网关，我们将使用 root 权限。

运行命令取决于安装类型。

如果您已将网关安装为守护程序，请运行以下命令：

```bash
sudo systemctl restart thingsboard-gateway
```

{: .copy-code}

如果您已将网关安装为 Python 模块（使用 [pip 包管理器](/docs/iot-gateway/install/pip-installation/) 或 [从源代码](/docs/iot-gateway/install/source-installation/)），请使用以下命令或脚本运行网关。

**注意：** 您必须在命令/脚本中放置到主配置文件（**tb_gateway.yaml**）的正确路径。

```bash
sudo python3 -c 'from thingsboard_gateway.gateway.tb_gateway_service import TBGatewayService; TBGatewayService("YOUR_PATH_HERE")'
```

或脚本：

```python
from thingsboard_gateway.gateway.tb_gateway_service import TBGatewayService 

config_file_path = "YOUR_PATH_HERE"

TBGatewayService(config_file_path)
```

## 步骤 5. 检查 ThingsBoard 上的信息

检查您已在 [常规配置指南](/docs/iot-gateway/configuration/) 中配置的 ThingsBoard 实例中的数据。

- 前往您的 ThingsBoard 实例并登录。
- 转到“设备”选项卡。“温度和湿度传感器”应该在那里。
<br>
![](/images/gateway/temp-hum-sensor.png)
<br><br>
转到设备详细信息，**属性**选项卡，其中包含所有客户端属性，包括从我们的配置文件属性中请求的属性。

**通知：** 来自 GATT 规范的属性仅在网关启动后首次连接到设备时更新。
<br>
![](/images/gateway/attribute-on-ble-device.png)

## 步骤 6. 使用共享属性更改设备名称

我们尝试更改设备名称。
我们应该遵循以下几个步骤：
1. 在 ThingsBoard 上的设备中创建共享属性，为此，我们转到 **属性**选项卡，从属性列表中选择“共享属性”选项而不是“客户端属性”，按加号图标，将“sharedName”作为键和“New_name_”作为“字符串值”。
2. 使用 RPC 仪表板中的“rpcMethod1”检查设备名称或使用在安装网关的设备中使用默认功能扫描周围设备。

**通知：** 某些设备可以将它们的名称重置为默认名称。

![](/images/gateway/changed-name-ble-tb-gateway.png)



#### 如何从 BLE 设备获取特征标识符列表

要获取所有可用的设备特征，您可以使用以下 Python 脚本：

```python
from bluepy.btle import Peripheral

MAC = "PUT_DEVICE_MAC_ADDRESS_HERE"

peripheral = Peripheral(MAC)

for service in peripheral.getServices():
    for characteristic in service.getCharacteristics():
        print("Characteristic - id: %s\tname (if exists): %s\tavailable methods: %s" % (str(characteristic.uuid), str(characteristic), characteristic.propertiesToString()))
```

{: .copy-code}

**注意：要运行脚本 - 您应该安装 Bluepy 库并具有访问蓝牙模块的权限。**

运行脚本后，您将在控制台中收到如下输出：

```text
Characteristic - id: 00002a00-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Device Name>	available methods: READ WRITE 
Characteristic - id: 00002a01-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Appearance>	available methods: READ 
Characteristic - id: 00002a04-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Peripheral Preferred Connection Parameters>	available methods: READ 
Characteristic - id: 00002a05-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Service Changed>	available methods: INDICATE 
Characteristic - id: 226caa55-6476-4566-7562-66734470666d	name (if exists): Characteristic <226caa55-6476-4566-7562-66734470666d>	available methods: NOTIFY 
Characteristic - id: 226cbb55-6476-4566-7562-66734470666d	name (if exists): Characteristic <226cbb55-6476-4566-7562-66734470666d>	available methods: WRITE NOTIFY 
Characteristic - id: 00002a19-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Battery Level>	available methods: READ NOTIFY 
Characteristic - id: 00002a29-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Manufacturer Name String>	available methods: READ 
Characteristic - id: 00002a24-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Model Number String>	available methods: READ 
Characteristic - id: 00002a25-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Serial Number String>	available methods: READ 
Characteristic - id: 00002a27-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Hardware Revision String>	available methods: READ 
Characteristic - id: 00002a26-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <Firmware Revision String>	available methods: READ 
Characteristic - id: 00001532-1212-efde-1523-785feabcd123	name (if exists): Characteristic <00001532-1212-efde-1523-785feabcd123>	available methods: WRITE NO RESPONSE 
Characteristic - id: 00001531-1212-efde-1523-785feabcd123	name (if exists): Characteristic <00001531-1212-efde-1523-785feabcd123>	available methods: WRITE NOTIFY 
Characteristic - id: 00001534-1212-efde-1523-785feabcd123	name (if exists): Characteristic <00001534-1212-efde-1523-785feabcd123>	available methods: READ 
Characteristic - id: 00000001-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <0001>	available methods: WRITE NOTIFY 
Characteristic - id: 00000002-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <0002>	available methods: READ 
Characteristic - id: 00000004-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <0004>	available methods: READ 
Characteristic - id: 00000010-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <0010>	available methods: WRITE 
Characteristic - id: 00000013-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <0013>	available methods: READ WRITE 
Characteristic - id: 00000014-0000-1000-8000-00805f9b34fb	name (if exists): Characteristic <0014>	available methods: READ WRITE 
```

其中：

id - 特征标识符。

name (if exists) - 特征名称，如果它在 [GATT 规范](https://www.bluetooth.com/specifications/gatt/services/) 中有描述。

available methods - 特征支持的方法。

特征方法：

1. READ - 从特征中读取值。
2. WRITE - 将值写入特征。
3. NOTIFY - 订阅特征更新。

通常名称等于 id 的特征是自定义的。