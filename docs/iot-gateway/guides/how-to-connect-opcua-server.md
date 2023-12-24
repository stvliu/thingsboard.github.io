---
layout: docwithnav
assignees:
- zbeacon
title: 如何连接 OPC-UA 服务器
description: 了解如何连接 OPC-UA 服务器

---

* TOC
{:toc}

## 设备信息

出于本指南的目的，我们将使用带有 OPC-UA 服务器的 Raspberry Pi。  
我们将使用 [OPC-UA 连接器](/docs/iot-gateway/config/opc-ua/) 来收集数据。  

目前可用的信息：  


| 参数             | 我们的值                         | **说明**                                                           |
|-|-|-|
| 服务器 URL         | **192.168.1.113:4840/server/**    | OPC-UA 服务器地址。                                                     |
| 设备节点路径      | **Device\d\*$**                   | 服务器上设备对象的路径的正则表达式。                                 |
| 设备名称路径      | **${server.deviceName}**          | 设备对象到变量的相对路径包含设备名称。                                |
|-|-|

我们希望将 **湿度**（相对路径为 **${humidity_value}** ）作为遥测数据写入 ThingsBoard，并将 **batteryLevel**（相对路径为 **${Battery.Level}** ）作为设备客户端属性。      



## 步骤 1. 配置 OPC-UA 连接器

为了配置连接器，我们必须创建 OPC-UA 设置文件并将配置放在那里。
您可以使用默认的 opcua.json 文件（在守护程序安装的情况下为 /etc/thingsboard-gateway/config 中的文件，或者在使用 python 包的情况下为包含 tb_gateway.json 文件的文件夹中的文件）。  
只需用我们的值替换一些参数即可。
例如：

```json
{
  "server": {
    "name": "OPC-UA Default Server",
    "url": "192.168.1.113:4840/server/",
    "scanPeriodInMillis": 10000,
    "timeoutInMillis": 5000,
    "security": "Basic128Rsa15",
    "identity": {
      "type": "anonymous"
    },
    "mapping": [
      {
        "deviceNodePattern": "Device\\d*$",
        "deviceNamePattern": "${server.deviceName}",
        "attributes": [
          {
            "key": "batteryLevel",
            "path": "${Battery.Level}"
          }
        ],
        "timeseries": [
          {
            "key": "Humidity",
            "path": "${humidity_value}"
          }
        ]
      }
    ]
  }
}
```
{: .copy-code}

  
关于 OPC-UA 配置文件的部分，您可以在 [此处](/docs/iot-gateway/config/opc-ua/) 阅读更多信息。  

让我们分析我们的设置：

1. 连接器的常规配置。在此部分中，我们定义了主要设置（例如连接器名称 — OPC-UA 默认服务器、URL — 192.168.1.113:4840/server/ 等）。您可以在 [此处](/docs/iot-gateway/config/opc-ua/#section-server) 阅读有关可用参数的更多信息。  
2. 常规设备配置。在此部分中，我们定义了 OPC-UA 设备的主要设置（例如 OPC-UA 服务器模式中的设备对象 - Device\\d*$、ThingsBoard 中的设备名称模式 — Device\\d*$ 等）。您可以在 [此处](/docs/iot-gateway/config/opc-ua/#section-mapping) 阅读有关可用参数的更多信息。  
3. 属性配置。在此部分中，我们定义了 ThingsBoard 中 batteryLevel 属性的设置。您可以在 [此处](/docs/iot-gateway/config/opc-ua/#subsection-attributes) 阅读有关可用参数的更多信息。  
4. 时序配置。在此部分中，我们设置了温度和湿度参数。您可以在 [此处](/docs/iot-gateway/config/opc-ua/#subsection-timeseries) 阅读有关可用参数的更多信息。  

将配置文件另存为 opcua.json，放在配置文件夹中（包含常规配置文件 - **tb_gateway.yaml** 的目录）。  

## 步骤 3. 打开连接器

要使用连接器，我们必须在主配置文件（**[tb_gateway.yaml](/docs/iot-gateway/configuration/#connectors-configuration)**）中将其打开

在“connectors”部分中，我们应该取消注释以下字符串：

```yaml
  -
    name: OPC-UA Connector
    type: opcua
    configuration: opcua.json
```

## 步骤 4. 运行网关
  
运行命令取决于安装类型。  
如果您已将网关安装为守护程序，请运行以下命令：  
```bash
sudo systemctl restart thingsboard-gateway
```  
{: .copy-code}

如果您已将网关安装为 python 模块（使用 [pip 包管理器](/docs/iot-gateway/install/pip-installation/) 或 [从源代码](/docs/iot-gateway/install/source-installation/)），请使用以下命令或脚本运行网关。  
**注意**：您必须在命令/脚本中放置正确的主配置文件路径（**tb_gateway.yaml**）。  

```bash
sudo python3 -c 'from thingsboard_gateway.gateway.tb_gateway_service import TBGatewayService; TBGatewayService("YOUR_PATH_HERE")'
```

或脚本：

```python
from thingsboard_gateway.gateway.tb_gateway_service import TBGatewayService 

config_file_path = "YOUR_PATH_HERE"

TBGatewayService(config_file_path)
```

## 步骤 5. 检查设备信息

检查 ThingsBoard 实例中的数据。  
    - 转到您的 ThingsBoard 实例并登录。  
    - 转到“设备”选项卡。“湿度传感器”将显示在那里。
<br>    
转到设备详细信息，**属性**选项卡，您可能会看到具有某个值的 **batteryLevel** 属性。  
<br>
    ![](/images/gateway/opcua-sensor-attributes.png)
<br><br>
转到设备详细信息，**最新遥测数据**选项卡，以查看您的遥测数据：**湿度**具有某个值。  
<br>
![](/images/gateway/opcua-sensor-telemetry.png)