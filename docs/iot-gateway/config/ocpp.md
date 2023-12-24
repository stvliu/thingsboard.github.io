---
layout: docwithnav-gw
title: OCPP 连接器配置
description: GridLinks IoT 网关的 OCPP 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks IoT 网关的 MQTT 连接器配置。
使用 [常规配置](/docs/iot-gateway/configuration/) 启用此连接器。
此连接器的目的是使用 OCPP 协议在充电点和中央系统之间进行通信。

我们将在下面描述连接器配置文件。

## 连接器配置：ocpp.json
连接器配置是一个 JSON 文件，其中包含有关如何连接到充电点、如何处理数据以及其他服务功能的信息。让我们使用下面的示例来回顾配置文件的格式。


<b>OCPP 连接器配置文件示例。</b>

{% capture ocppConf %}
{
  "centralSystem": {
    "name": "Central System",
    "host": "127.0.0.1",
    "port": 9000,
    "connection": {
      "type": "insecure"
    },
    "security": [
      {
        "type": "token",
        "tokens": [
          "Bearer ACCESS_TOKEN"
        ]
      },
      {
        "type": "basic",
        "credentials": [
          {
            "username": "admin",
            "password": "admin"
          }
        ]
      }
    ]
  },
  "chargePoints": [
    {
      "idRegexpPattern": "bidon/hello/CP_1",
      "deviceNameExpression": "${Vendor} ${Model}",
      "deviceTypeExpression": "default",
      "attributes": [
        {
          "messageTypeFilter": "MeterValues,",
          "key": "temp1",
          "value": "${meter_value[:].sampled_value[:].value}"
        },
        {
          "messageTypeFilter": "MeterValues,",
          "key": "vendorId",
          "value": "${connector_id}"
        }
      ],
      "timeseries": [
        {
          "messageTypeFilter": "DataTransfer,",
          "key": "temp",
          "value": "${data.temp}"
        }
      ],
      "attributeUpdates": [
        {
          "attributeOnThingsBoard": "shared",
          "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
        }
      ],
      "serverSideRpc": [
        {
          "methodRPC": "rpc1",
          "withResponse": true,
          "valueExpression": "${params}"
        }
      ]
    }
  ]
}
{% endcapture %}
{% include code-toggle.liquid code=ocppConf params="conf|.copy-code.expandable-20" %}

### “centralSystem” 部分

此配置部分用于将网关配置为中央系统。

| **参数**     | **默认值**      | **说明**                                     |
|:-|:-|-
| name              | **Central System**     | 中央系统名称。 |
| host              | **127.0.0.1**          | 中央系统主机名或 IP 地址。 |
| port              | **9000**               | 中央系统端口。 |
|---

#### 连接子部分

此配置子部分用于配置中央系统和充电点之间的连接类型。
您可以选择以下连接类型：

{% capture ocppconnectorconnectiontogglespec %}
不安全<small>无安全</small>%,%insecure%,%templates/iot-gateway/ocpp-connector-insecure-connection-config.md%br%
TLS<small>推荐</small>%,%tls%,%templates/iot-gateway/ocpp-connector-tls-connection-config.md{% endcapture %}
{% include content-toggle.html content-toggle-id="ocppConnectorConnectionConfig" toggle-spec=ocppconnectorconnectiontogglespec %} 

#### 安全子部分

安全子部分提供中央系统中充电点授权的配置。
您可以选择以下安全类型：

{% capture ocppconnectorsecuritytogglespec %}
匿名<small>无安全</small>%,%anonymous%,%templates/iot-gateway/ocpp-connector-anonymous-security-config.md%br%
基本<small>推荐</small>%,%basic%,%templates/iot-gateway/ocpp-connector-basic-security-config.md%br%
令牌<small>推荐</small>%,%token%,%templates/iot-gateway/ocpp-connector-token-security-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ocppConnectorSecurityConfig" toggle-spec=ocppconnectorsecuritytogglespec %}

**注意** 您可以组合 _basic_ 和 _token_ 安全类型。配置文件中的安全子部分将如下所示：

```json
    "security": [
      {
        "type": "token",
        "tokens": [
          "Bearer ACCESS_TOKEN"
        ]
      },
      {
        "type": "basic",
        "credentials": [
          {
            "username": "admin",
            "password": "admin"
          }
        ]
      }
    ]
```

### “chargePoints” 部分

此子部分包含充电点的常规设置和处理数据的子部分。

| **参数**        | **默认值**      | **说明**                                                                                                                        |
|:-|:-|-
| idRegexpPattern      | **charge_points/CP_1** | 正则表达式，用于查找当前设备的充电点。                                                            |
| deviceNameExpression | **${Vendor} ${Model}** | 简单 JSON 表达式，用于查找传入消息中的设备名称（参数“Vendor + Model”将用作设备名称）。 |
| deviceTypeExpression | **${Model}**           | 简单 JSON 表达式，用于查找传入消息中的设备类型（参数“Model”将用作设备类型）。          |
| attributes           |                        | 用于处理设备属性的对象数组。                                                                                     |
| timeseries           |                        | 用于处理设备遥测的对象数组。                                                                                      |
| attributeUpdates     |                        | 用于处理来自 GridLinks 的 attributeUpdate 请求的对象数组。                                                             |
| serverSideRpc        |                        | 用于处理来自 GridLinks 的 RPC 请求的对象数组。                                                                         |
|---

配置的这一部分将如下所示：

```json
  "chargePoints": [
    {
      "idRegexpPattern": "charge_points/CP_1",
      "deviceNameExpression": "${Vendor} ${Model}",
      "deviceTypeExpression": "${Model}",
      "attributes": [
        ...
      ],
      "timeseries": [
        ...
      ],
      "attributeUpdates": [
        ...
      ],
      "serverSideRpc": [
        ...
      ]
    }
  ]
```

#### 子部分属性

此子部分包含要解释为设备属性的处理数据的常规设置。

| **参数**           | **默认值**                            | **说明**                                                                                                                       |
|:-|:-|-
| attributes              |                                              | 此子部分包含传入消息的参数，这些参数将解释为设备的属性。                          |
| ... messageTypeFilter   | **MeterValues,**                             | 以逗号分隔的允许的消息类型列表。                                                                                       |
| ... key                 | **temp**                                     | 要发送到 GridLinks 实例的属性名称。                                                                                   |
| ... value               | **${meter_value[:].sampled_value[:].value}** | 简单 JSON 表达式，用于查找传入消息中的值，并将其作为 key 参数的值发送到 GridLinks 实例。 |
|---

配置文件中的此子部分如下所示：

```json
      "attributes": [
        {
          "messageTypeFilter": "MeterValues,",
          "key": "temp",
          "value": "${meter_value[:].sampled_value[:].value}"
        },
        {
          "messageTypeFilter": "MeterValues,",
          "key": "vendorId",
          "value": "${connector_id}"
        }
      ]
```

#### 子部分时序

此子部分包含要解释为时序的处理数据的常规设置。

| **参数**           | **默认值**                            | **说明**                                                                                                                       |
|:-|:-|-
| timeseries              |                                              | 此子部分包含传入消息的参数，这些参数将解释为设备的遥测。                           |
| ... messageTypeFilter   | **MeterValues,**                             | 以逗号分隔的允许的消息类型列表。                                                                                       |
| ... key                 | **temp**                                     | 要发送到 GridLinks 实例的遥测名称。                                                                                   |
| ... value               | **${meter_value[:].sampled_value[:].value}** | 简单 JSON 表达式，用于查找传入消息中的值，并将其作为 key 参数的值发送到 GridLinks 实例。 |
|---

配置文件中的此子部分如下所示：

```json
      "timeseries": [
        {
          "messageTypeFilter": "DataTransfer,",
          "key": "temp",
          "value": "${data.temp}"
        }
      ]
```

#### 属性更新子部分

此配置部分是可选的。ThingsBoard 允许配置设备属性并从设备应用程序中获取其中一些属性。您可以将其视为设备的远程配置。您的设备能够从 ThingsBoard 请求共享属性。有关更多详细信息，请参阅用户指南。

“attributeUpdates”配置允许配置将发送到充电点的相应属性数据格式。

| **参数**           | **默认值**                               | **说明**                                                                         |
|:-|:-|-
| attributeOnThingsBoard  | **sharedName**                                  | 共享属性名称。                                                                  |
| valueExpression         | **{\"${attributeKey}\":\"${attributeValue}\"}** | 用于创建将发送到充电点消息数据的 JSON 路径表达式。 |
|---

配置文件中的此部分如下所示：
```json
"attributeUpdates": [
  {
    "attributeOnThingsBoard": "shared",
    "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
  }
]
```

#### 服务器端 RPC 子部分

ThingsBoard 允许将 RPC 命令发送到直接或通过网关连接到 GridLinks 的设备。

此部分中提供的配置用于将 RPC 请求从 ThingsBoard 发送到充电点。

| **参数**           | **默认值**    | **说明**                                                                         |
|:-|:-|-
| methodRPC               | **rpcMethod1**       | RPC 方法名称。                                                                        |
| withResponse            | **true**             | 布尔值，表示是否将响应发送回 ThingsBoard。                   |
| valueExpression         | **${params}**        | 用于创建将发送到充电点消息数据的 JSON 路径表达式。 |
|---

配置文件中的此子部分如下所示：

```json
"serverSideRpc": [
  {
    "methodRPC": "rpc1",
    "withResponse": true,
    "valueExpression": "${params}"
  }
]
```

## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。