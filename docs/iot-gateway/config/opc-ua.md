---
layout: docwithnav-gw
assignees:
- ashvayka
title: OPC-UA 连接器配置
description: GridLinks物联网网关的 OPC-UA 协议支持

---

* TOC
{:toc}

{% capture difference %}
**从网关版本 3.1 开始，我们添加了一个基于 AsyncIO 库的新 OPC-UA 连接器。
请注意，该连接器处于早期测试阶段，因此可能存在错误。
此外，目前不建议在生产模式下使用它。
要启用它，请使用连接器类型 “opcua_asyncio”。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

本指南将帮助您熟悉 GridLinks物联网网关的 OPC-UA 连接器配置。
使用 [通用配置](/docs/iot-gateway/configuration/) 来启用此扩展。
我们将在下面描述连接器配置文件。

<b>OPC-UA 连接器配置文件示例。</b>

{% capture opcuaConf %}

{
  "server": {
    "name": "OPC-UA 默认服务器",
    "url": "localhost:4840/freeopcua/server/",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 5000,
    "disableSubscriptions":false,
    "subCheckPeriodInMillis": 100,
    "showMap": false,
    "security": "Basic128Rsa15",
    "identity": {
      "type": "anonymous"
    },
    "mapping": [
      {
        "deviceNodePattern": "Root\\.Objects\\.Device1",
        "deviceNamePattern": "Device ${Root\\.Objects\\.Device1\\.serialNumber}",
        "attributes": [
          {
            "key": "CertificateNumber",
            "path": "${ns=2;i=5}"
          }
        ],
        "timeseries": [
          {
            "key": "temperature °C",
            "path": "${Root\\.Objects\\.Device1\\.TemperatureAndHumiditySensor\\.Temperature}"
          },
          {
            "key": "batteryLevel",
            "path": "${Battery\\.batteryLevel}"
          }
        ],
        "rpc_methods": [
          {
            "method": "multiply",
            "arguments": [2, 4]
          }
        ],
        "attributes_updates": [
          {
            "attributeOnGridLinks": "deviceName",
            "attributeOnDevice": "Root\\.Objects\\.Device1\\.serialNumber"
          }
        ]
      }
    ]
  }
}

{% endcapture %}
{% include code-toggle.liquid code=opcuaConf params="conf|.copy-code.expandable-20" %}

## “server” 部分

此部分中的配置用于连接到 OPC-UA 服务器。

| **参数**                 | **默认值**                    | **说明**                                                                                                                                                        |
|:-|:-|-
| name                          | **OPC-UA 默认服务器**            | 连接到服务器的名称。                                                                                                                                           |
| host                          | **localhost:4840/freeopcua/server/** | OPC-UA 服务器的主机名或 IP 地址。                                                                                                                               |
| timeoutInMillis               | **5000**                             | 连接到 OPC-UA 服务器的超时时间（以秒为单位）。                                                                                                                    |
| scanPeriodInMillis            | **5000**                             | 重新扫描服务器的周期。                                                                                                                                           |
| disableSubscriptions          | **false**                            | 如果为 true - 网关将订阅感兴趣的节点并等待数据更新，如果为 false - 网关将每 **scanPeriodInMillis** 重新扫描 OPC-UA 服务器   |
| subCheckPeriodInMillis        | **100**                              | 检查 OPC-UA 服务器中的订阅的周期。                                                                                                                |
| showMap                       | **true**                             | 扫描时显示节点 **true** 或 **false**。                                                                                                                          |
| security                      | **Basic128Rsa15**                    | 安全策略（**Basic128Rsa15**、**Basic256**、**Basic256Sha256**）                                                                                                  |
|---

<br>
**我们来看一个示例。**
<br>
此示例使用 Prosys OPC UA 模拟服务器来演示如何配置 OPC-UA 连接器。
<br>

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-simulation-server-1.png)
{: refdef}


在 **“状态”** 主选项卡上，复制连接地址（UA TCP）。

要将 OPC UA 服务器连接到 GridLinks，请在 OPC-UA 连接器配置文件 (opcua.json) 中，将 “url” 值替换为复制的连接地址。

我们的 **server** 部分将如下所示：

```json
  "server": {
    "name": "OPC-UA 默认服务器",
    "url": "localhost:53530/OPCUA/SimulationServer",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 5000,
    "disableSubscriptions": false,
    "subCheckPeriodInMillis": 100,
    "showMap": false,
    "security": "Basic128Rsa15",
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-configuration-1.png)
{: refdef}

### “identity” 子部分
此子部分有几种类型可用：  
1. anonymous  
2. username  
3. cert.PEM  

{% capture identityopcuatogglespec %}
<b>anonymous</b><br> <small>(推荐用于本地网络中的所有服务器)</small>%,%anonymous%,%templates/iot-gateway/opcua-identity-anonymous-config.md%br%
<b>username</b><br> <small>(推荐作为基本级别的安全性)</small>%,%username%,%templates/iot-gateway/opcua-identity-username-config.md%br%
<b>cert.PEM</b><br> <small>(推荐作为更高级别的安全性)</small>%,%certpem%,%templates/iot-gateway/opcua-identity-certpem-config.md%br%{% endcapture %}

{% include content-toggle.html content-toggle-id="opcuaIdentityConfig" toggle-spec=identityopcuatogglespec %}

## “mapping” 部分
此配置部分包含网关在连接到 OPC-UA 服务器后将订阅的节点数组，以及有关处理来自这些节点的数据的设置。

| **参数**                 | **默认值**                    | **说明**                                                                       |
|:-|:-|-
| deviceNodePattern             | **Root\\.Objects\\.Device1**                     | 用于查找当前设备的节点的正则表达式。                   |
| deviceNamePattern             | **Device ${Root\\.Objects\\.Device1\\.serialNumber}**           | 具有设备名称的变量的路径，用于在某个变量中查找设备名称。              |
|---

配置的这一部分将如下所示：  

```json
        "deviceNodePattern": "Root\\.Objects\\.Device1",
        "deviceNamePattern": "Device ${Root\\.Objects\\.Device1\\.serialNumber}",
```

***您可以选择在此部分中添加 “converter” 参数以使用自定义转换器。***
<br>
<br><br>
**我们来看一个示例。**

将 **deviceNodePattern** 指定为我们的测试服务器上的内容。在此示例中，它是 **“Root\\.Objects\\.Simulation”**。

将 **deviceNamePattern** 指定为 **“Device OPC-UA”**。

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-simulation-server-2.png)
{: refdef}

<br>
在此示例中，**mapping** 部分将如下所示：

```json
        "deviceNodePattern": "Root\\.Objects\\.Simulation",
        "deviceNamePattern": "Device OPC-UA",
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-configuration-2.png)
{: refdef}

运行 ** GridLinks 物联网网关** 后，您将在 GridLinks 实例中看到新设备 **Device OPC-UA**。

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-1.png)
{: refdef}

### “attributes” 子部分
此子部分包含对象变量的配置，这些变量将被解释为设备的属性。

| **参数**   | **默认值**           | **说明**                                                                                      |
|:-|:-|-
| key             | **CertificateNumber**       | 将被解释为 GridLinks 平台实例的属性的标记。                           |
| path            | **${ns=2;i=5}**             | OPC-UA 对象中变量的名称，用于在某个变量中查找值。 ** \* **     |
|---

{% capture difference %}
<br>
**如果您未指定 “key” 参数，则将使用节点名称**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

** \* ** 您可以在此处放置一些要搜索的表达式，例如：
1. 完整节点路径 - **${Root\\.Objects\\.Device1\\.TemperatureAndHumiditySensor\\.CertificateNumber}**
2. 相对于设备对象的相对路径 - **${TemperatureAndHumiditySensor\\.CertificateNumber}** 
3. 要搜索的一些正则表达式 - **${Root\\.Objects\\.Device\\d\*\\.TemperatureAndHumiditySensor\\.CertificateNumber}**
4. 命名空间标识符和节点标识符 - **${ns=2;i=5}**

配置的这一部分将如下所示：  

```json
        "attributes": [
          {
            "key": "CertificateNumber",
            "path": "${ns=2;i=5}"
          }
        ],
```

<br>
**我们来看一个示例。**
<br>
在 “path” 行中设置从我们的测试服务器获取的 NodeId 值。
<br>

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-simulation-server-3.png)
{: refdef}

在此示例中，**attributes** 部分将如下所示：

```json
        "attributes": [
          {
            "key": "model",
            "path": "${ns=3;i=1008}"
          },
          {
            "key": "CertificateNumber",
            "path": "${ns=3;i=1007}"
          }
        ],
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-configuration-3.png)
{: refdef}

您必须在设备的 **属性** 部分中看到发送到 GridLinks 的属性：

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-2.png)
{: refdef}

### “timeseries” 子部分
此子部分包含对象变量的配置，这些变量将被解释为设备的遥测数据。

| **参数**   | **默认值**           | **说明**                                                                   |
|:-|:-|-
| key             | **temperature °C**                                                             | 将被解释为 GridLinks 平台实例的遥测数据的标记。        |
| path            | **${Root\\.Objects\\.Device1\\.TemperatureAndHumiditySensor\\.Temperature}**   | OPC-UA 对象中变量的名称，用于在某个变量中查找值。 ** \* ** |
|---

** \* ** 您可以在此处放置一些要搜索的表达式，例如：
1. 完整节点路径 - **${Root\\.Objects\\.Device1\\.TemperatureAndHumiditySensor\\.Temperature}**
2. 相对于设备对象的相对路径 - **${TemperatureAndHumiditySensor\\.Temperature}** 
3. 要搜索的一些正则表达式 - **${Root\\.Objects\\.Device\\d\*\\.TemperatureAndHumiditySensor\\.Temperature}**
4. 命名空间标识符和节点标识符 - **${ns=2;i=5}**

配置的这一部分将如下所示：  

```json
        "timeseries": [
          {
            "key": "temperature °C",
            "path": "${Root\\.Objects\\.Device1\\.TemperatureAndHumiditySensor\\.Temperature}"
          }
        ],
```

<br>
**我们来看一个示例。**

将 “path” 值替换为从我们的测试服务器获取的 “NodeId” 值、相对于设备对象的相对路径或显示名称标识符。
<br>

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-simulation-server-4.png)
{: refdef}

在此示例中，**timeseries** 部分将如下所示：

```json
        "timeseries": [
          {
            "key": "humidity",
            "path": "${Counter}"
          },
          {
            "key": "pressure",
            "path": "${Root\\.Objects\\.Simulation\\.Triangle}"
          },
          {
            "key": "temperature °C",
            "path": "${ns=3;i=1002}"
          }
        ],
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/opc-ua-configuration-4.png)
{: refdef}

您必须在设备的 **最新遥测数据** 部分中看到发送到 GridLinks 的遥测数据：

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-3.png)
{: refdef}

### “rpc_methods” 子部分
此子部分包含来自 GridLinks 平台实例的 RPC 请求的配置。

| **参数**         | **默认值**                 | **说明**                                                                                    |
|:-|:-|-
| method                | **multiply**                      | OPC-UA 服务器上的方法名称。                                                                   |
| arguments             | **[2,4]**                         | 方法的参数（如果此参数不存在，则参数将从 rpc 请求中获取）。  |
|---

配置的这一部分将如下所示：  

```json
        "rpc_methods": [
          {
            "method": "multiply",
            "arguments": [2, 4]
          }
        ]
```

{% capture methodFilterOptions %}
此外，每个遥测数据和属性参数都内置了 GET 和 SET RPC 方法，因此您无需手动配置它。请参阅 [指南](/docs/iot-gateway/guides/how-to-use-get-set-rpc-methods)。
{% endcapture %}
{% include templates/info-banner.md content=methodFilterOptions %}

### “attributes_updates” 子部分
此子部分包含来自 GridLinks 平台实例的属性更新请求的配置。

| **参数**             | **默认值**                                            | **说明**                                                                               |
|:-|:-|-
| attributeOnGridLinks    | **deviceName**                                               | 服务器端参数的名称。                                                                 |
| attributeOnDevice         | **Root\\.Objects\\.Device1\\.serialNumber**                     | 将使用属性更新请求中的值更改其自身值的可变变量的名称。    |
|---

配置的这一部分将如下所示：  

```json
        "attributes_updates": [
          {
            "attributeOnGridLinks": "deviceName",
            "attributeOnDevice": "Root\\.Objects\\.Device1\\.serialNumber"
          }
        ]
```

**我们来看一个示例。**

假设您想设置 **“deviceName”** 属性的值。目前，该属性没有任何值。

在 OPC-UA 连接器配置文件 (opcua.json) 中，将 **“attributeOnDevice”** 值更改为节点 “deviceName” 的完整路径。

在此示例中，它是 **“Root\\.Objects\\.Simulation\\.deviceName”**。

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-updates-2.png)
{: refdef}

我们的 **attributes_updates** 部分将如下所示：

```json
  "attributes_updates": [
    {
      "attributeOnGridLinks": "deviceName",
      "attributeOnDevice": "Root\\.Objects\\.Simulation\\.deviceName"
    }
  ]
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-updates-1.png)
{: refdef}

转到 **“共享属性”** 并为 GridLinks 实例中的设备创建一个新属性。

指定键名 - deviceName、值类型 - 字符串、字符串值 - Device OPC-UA。

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-updates-3.png)
{: refdef}

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-updates-4.png)
{: refdef}

现在转到 OPC UA 服务器并确保 deviceName 节点的值已更新。

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-attributes-updates-5.png)
{: refdef}

## 后续步骤

探索与 GridLinks 主要功能相关的指南：
 - [如何将 OPC-UA 服务器连接到网关](/docs/iot-gateway/guides/how-to-connect-opcua-server/)
 - [ GridLinks 物联网网关功能](/docs/iot-gateway/features/)
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。