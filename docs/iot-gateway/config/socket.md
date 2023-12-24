---
layout: docwithnav-gw
title: Socket 连接器配置
description: GridLinks IoT 网关的 Socket API 支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks IoT 网关的 Socket 连接器配置。
使用 [通用配置指南](/docs/iot-gateway/configuration/) 启用此连接器。此连接器的目的是使用 TCP 或 UDP 连接类型连接到您的服务器。

当您在设施或公司网络中拥有本地服务器，并且您希望将数据从服务器推送到 GridLinks 时，此连接器非常有用。

我们将在下面描述连接器配置文件。

## 连接器配置：socket.json

连接器配置是一个 JSON 文件，其中包含有关如何连接到外部服务器、如何处理数据以及其他服务功能的信息。让我们使用下面的示例来回顾配置文件的格式。

<b>Socket 连接器配置文件示例。</b>

{% capture socketConf %}
{
  "name": "TCP 连接器示例",
  "type": "TCP",
  "address": "127.0.0.1",
  "port": 50000,
  "bufferSize": 1024,
  "devices": [
    {
      "address": "127.0.0.1:50001",
      "deviceName": "设备示例",
      "deviceType": "default",
      "encoding": "utf-8",
      "telemetry": [
        {
          "key": "temp",
          "byteFrom": 0,
          "byteTo": -1
        },
        {
          "key": "hum",
          "byteFrom": 0,
          "byteTo": 2
        }
      ],
      "attributes": [
        {
          "key": "name",
          "byteFrom": 0,
          "byteTo": -1
        },
        {
          "key": "num",
          "byteFrom": 2,
          "byteTo": 4
        }
      ],
      "attributeRequests": [
        {
          "type": "shared",
          "requestExpression": "${[0:3]==atr}",
          "attributeNameExpression": "[3:]"
        }
      ],
      "attributeUpdates": [
        {
          "encoding": "utf-16",
          "attributeOnThingsBoard": "sharedName"
        }
      ],
      "serverSideRpc": [
        {
          "methodRPC": "rpcMethod1",
          "withResponse": true,
          "methodProcessing": "write",
          "encoding": "utf-8"
        }
      ]
    }
  ]
}
{% endcapture %}
{% include code-toggle.liquid code=socketConf params="conf|.copy-code.expandable-20" %}

### 常规部分

| **参数**     | **默认值**                     | **说明**                                          |
|:-|:-|-
| name              | **TCP 连接器示例**             | 连接器名称                                           |
| type              | **TCP**                               | 套接字类型，可以是 TCP 或 UDP                      |
| address           | **127.0.0.1**                         | 连接器绑定地址                                  |
| port              | **50000**                             | 连接器绑定端口                                     |
| bufferSize        | **1024**                              | 接收到的数据块缓冲区的大小                       |
|---

配置部分将如下所示：

```json
{
  "name": "TCP 连接器示例",
  "type": "TCP",
  "address": "127.0.0.1",
  "port": 50000,
  "bufferSize": 1024,
  ...
}
```

### 常规部分

此配置部分包含一个对象数组，其中包含可以连接到连接器并发送数据的客户端。这意味着连接器拒绝所有未包含在此数组中的连接。

#### 设备子部分

此对象配置部分包括有关如何处理传入数据的信息。

| **参数**     | **默认值**                     | **说明**                                                                                                      |
|:-|:-|-
| address           | **127.0.0.1:50001**                   | 将连接到连接器的客户端的地址和端口。                                                                                  |
| deviceName        | **设备示例**                    | GridLinks 中的设备名称。                                                                                              |
| deviceType        | **default**                           | GridLinks 的设备类型，默认情况下此参数不存在，但您可以添加它。                                |
| encoding          | **utf-8**                             | 将字符串数据写入存储时使用的编码。                                                                                   |
| telemetry         |                                       | 此子部分包含传入消息的参数，这些参数将被解释为设备的遥测数据。                                  |
| ... key           | **temp**                              | GridLinks 中的遥测数据名称。                                                                                              |
| ... byteFrom      | **0**                                 | 用于从特定索引截取接收到的数据。                                                                                         |
| ... byteTo        | **-1**                                | 用于将接收到的数据截取到特定索引。                                                                                           |
| attributes        |                                       | 此子部分包含传入请求的参数，这些参数将被解释为设备的属性。                                                |
| ... key           | **hum**                               | GridLinks 中的属性名称。                                                                                              |
| ... byteFrom      | **2**                                 | 用于从特定索引截取接收到的数据。                                                                                         |
| ... byteTo        | **4**                                 | 用于将接收到的数据截取到特定索引。                                                                                           |
|---

示例：
```json
{
  "address": "127.0.0.1:50001",
  "deviceName": "设备示例",
  "deviceType": "default",
  "encoding": "utf-8",
  "telemetry": [
    {
      "key": "temp",
      "byteFrom": 0,
      "byteTo": -1
    },
    {
      "key": "hum",
      "byteFrom": 0,
      "byteTo": 2
    }
  ],
  "attributes": [
    {
      "key": "name",
      "byteFrom": 0,
      "byteTo": -1
    },
    {
      "key": "num",
      "byteFrom": 2,
      "byteTo": 4
    }
  ]
}
```

#### 属性请求子部分

为了向 GridLinks 服务器节点请求客户端或共享设备属性，网关允许发送属性请求。

| **参数**           | **默认值**                     | **说明**                                                                                                      |
|:-|:-|-
| type                    | **shared**                            | 请求的属性类型可以是“shared”或“client”。                                                                     |
| requestExpression       | **${[0:3]==atr}**                     | 用于判断设备的请求是否为“属性请求”的表达式。                                                                 |
| attributeNameExpression | **[3:]**                              | 用于从接收到的数据中获取请求的属性名称的表达式。                                                               |
|---

此子部分的配置如下所示：

```json
"attributeRequests": [
  {
    "type": "shared",
    "requestExpression": "${[0:3]==atr}",
    "attributeNameExpression": "[3:]"
  }
]
```

此外，您还可以一次请求多个属性。只需向 attributeNameExpression 参数添加一个 JSON 路径即可。例如，我们希望在一个请求中请求两个共享属性，我们的配置将如下所示：

```json
"attributeRequests": [
  {
    "type": "shared",
    "requestExpression": "${[0:3]==atr}",
    "attributeNameExpression": "[4:19][20:]"
  }
]
```

这意味着我们必须发送以下消息来请求两个共享属性：
`atr sharedAttribute sharedAttribite1`

#### 属性更新子部分

此配置部分是可选的。GridLinks 允许配置设备属性并从设备应用程序中获取其中一些属性。您可以将其视为设备的远程配置。您的设备能够从 GridLinks 请求共享属性。有关更多详细信息，请参阅用户指南。

“attributeRequests”配置允许配置将发送到服务器的相应属性数据格式。

| **参数**           | **默认值**                     | **说明**                                             |
|:-|:-|-
| encoding                | **utf-16**                            | 将接收到的字符串数据写入存储时使用的编码。 |
| attributeOnThingsBoard  | **sharedName**                        | 共享属性名称                                       |
|---

配置文件中的此子部分如下所示：

```json
"attributeUpdates": [
  {
    "encoding": "utf-16",
    "attributeOnThingsBoard": "sharedName"
  }
]
```

#### 服务器端 RPC 子部分

ThingsBoard 允许直接或通过网关连接到 GridLinks 的设备发送 RPC 命令。

此部分中提供的配置用于从 GridLinks 向设备发送 RPC 请求。

| **参数**           | **默认值**                     | **说明**                                                       |
|:-|:-|-
| methodRPC               | **rpcMethod1**                        | RPC 方法名称。                                                      |
| withResponse            | **true**                              | 布尔值，表示是否向 ThingsBoard 发送或不发送响应。 |
| methodProcessing        | **write**                             | 操作类型。                                                    |
| encoding                | **utf-8**                             | 将接收到的字符串数据写入存储时使用的编码。           |
|---

配置文件中的此子部分如下所示：

```json
"serverSideRpc": [
  {
    "methodRPC": "rpcMethod1",
    "withResponse": true,
    "methodProcessing": "write",
    "encoding": "utf-8"
  }
]
```

此外，每个遥测数据和属性参数都内置了 SET RPC 方法，因此您无需手动配置它。要使用它们，请确保设置所有必需的参数（在 Socket Connector 的情况下，这些参数如下：**withResponse**、**methodProcessing**、**encoding**）。
请参阅[指南](/docs/iot-gateway/guides/how-to-use-get-set-rpc-methods)。

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。