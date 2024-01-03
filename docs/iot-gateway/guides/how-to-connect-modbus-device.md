---
layout: docwithnav
assignees:
- zbeacon
title: 如何使用 GridLinks物联网网关将 Modbus 设备连接到 GridLinks
description: 了解如何使用 GridLinks物联网网关将 Modbus 设备连接到 GridLinks

---

* TOC
{:toc}

## 设备信息

为了本指南的目的，我们将使用带有 Modbus 服务器的 Raspberry Pi 来模拟 Modbus 设备。
我们将使用 [Modbus 连接器](/docs/iot-gateway/config/modbus/) 来收集数据。

目前可用的信息：


| 参数     | 我们的值            |
|-|-|
| 设备名称   | **TH_sensor**        |
| IP 地址    | **192.168.1.113**    |
| 端口          | **5020**             |
| 单元 ID       | **1**                |
| 轮询周期   | **5 秒**        | 
|-|-|

我们希望将 **温度**（寄存器地址为 0）和 **湿度**（寄存器地址为 1）作为遥测数据写入 ThingsBoard，并将 **batteryLevel**（寄存器地址为 2）作为设备客户端属性。      



## 步骤 1. 配置 Modbus 连接器

为了配置连接器，我们必须创建 MODBUS 设置文件并将配置放在那里。
您可以使用默认的 modbus.json 文件（在守护程序安装的情况下为 /etc/gridlinks-gateway/config 中的文件，或者在使用 python 包的情况下为包含 tb_gateway.json 文件的文件夹中的文件）。  
只需用我们的值替换一些参数即可。
例如：

```json
{
  "server": {
    "name": "Modbus Default Server",
    "type": "tcp",
    "host": "192.168.1.113",
    "port": 5020,
    "timeout": 35,
    "method": "socket",
    "devices": [
      {
        "unitId": 1,
        "deviceName": "TH_sensor",
        "attributesPollPeriod": 5000,
        "timeseriesPollPeriod": 5000,
        "sendDataOnlyOnChange": false,
        "attributes": [
          {
            "byteOrder": "BIG",
            "tag": "batteryLevel",
            "type": "long",
            "functionCode": 4,
            "registerCount": 1,
            "address": 2
          }
        ],
        "timeseries": [
          {
            "byteOrder": "BIG",
            "tag": "humidity",
            "type": "long",
            "functionCode": 4,
            "registerCount": 1,
            "address": 1
          },
          {
            "byteOrder": "BIG",
            "tag": "temperature",
            "type": "long",
            "functionCode": 4,
            "registerCount": 1,
            "address": 0
          }
        ]
      }
    ]
  }
}
```
{: .copy-code}

  
关于 Modbus 配置文件的各个部分，您可以在此处 [了解更多信息](/docs/iot-gateway/config/modbus/)。  

让我们分析一下我们的设置：

1. 连接器的通用配置。在此部分中，我们定义了主要设置（例如连接器名称 — Modbus 默认服务器、端口 — 5020 等）。您可以在此处阅读有关可用参数的更多信息。
2. 通用设备配置。在此部分中，我们定义了 Modbus 设备的主要设置（例如 GridLinks 中的设备名称 — TH_sensor、单元 ID — 1 等）。您可以在此处阅读有关可用参数的更多信息。
3. 时序配置。在此部分中，我们设置了温度和湿度参数。您可以在此处阅读有关可用参数的更多信息。
4. 属性配置。在此部分中，我们定义了 GridLinks 中 batteryLevel 属性的设置。您可以在此处阅读有关可用参数的更多信息。

将配置文件另存为 modbus.json，放在配置文件夹中（包含通用配置文件 **tb_gateway.yaml** 的目录）。  

## 步骤 3. 打开连接器

要使用连接器，我们必须在主配置文件（**[tb_gateway.yaml](/docs/iot-gateway/configuration/#connectors-configuration)**）中将其打开

在“connectors”部分中，我们应该取消注释以下字符串：

```yaml
  -
    name: Modbus Connector
    type: modbus
    configuration: modbus.json
```

## 步骤 4. 运行网关
  
运行命令取决于安装类型。  
如果您已将网关安装为守护程序，请运行以下命令：  
```bash
sudo systemctl restart gridlinks-gateway
```  
{: .copy-code}

如果您已将网关安装为 python 模块（使用 [pip 包管理器](/docs/iot-gateway/install/pip-installation/) 或 [从源代码](/docs/iot-gateway/install/source-installation/)），请使用以下命令或脚本运行网关。  
**注意**：您必须在命令/脚本中放置正确的主配置文件路径（**tb_gateway.yaml**）。  

```bash
sudo python3 -c 'from gridlinks_gateway.gateway.tb_gateway_service import TBGatewayService; TBGatewayService("YOUR_PATH_HERE")'
```

或脚本：

```python
from gridlinks_gateway.gateway.tb_gateway_service import TBGatewayService 

config_file_path = "YOUR_PATH_HERE"

TBGatewayService(config_file_path)
```

## 步骤 5. 检查设备信息

检查 GridLinks 实例中的数据。  
    - 转到您的 GridLinks 实例并登录。  
    - 转到“设备”选项卡。“TH_sensor”将在那里。
    <br>    
    ![](/images/gateway/gateway-modbus-device-added.png)
<br><br>
转到设备详细信息，**属性**选项卡，您可能会看到具有某个值的属性 **batteryLevel**。  
<br>
![](/images/gateway/modbus-device-client-attribute.png)
<br><br>
转到设备详细信息，**最新遥测数据**选项卡，以查看您的遥测数据：**温度**和**湿度**。  
<br>
![](/images/gateway/modbus-device-telemetry.png)