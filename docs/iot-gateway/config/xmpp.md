---
layout: docwithnav-gw
title: XMPP 连接器配置
description: GridLinks IoT 网关的 XMPP 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks IoT 网关的 MQTT 连接器配置。
使用 [常规配置](/docs/iot-gateway/configuration/) 启用此连接器。
此连接器的目的是使用 XMPP 协议从 IoT 设备收集数据。

我们将在下面描述连接器配置文件。

## 连接器配置：xmpp.json
连接器配置是一个 JSON 文件，其中包含有关如何连接到设备、如何处理数据以及其他服务功能的信息。让我们使用下面的示例来回顾配置文件的格式。

<b>XMPP 连接器配置文件示例。</b>

{% capture xmppConf %}
{
  "server": {
    "jid": "gateway@localhost",
    "password": "password",
    "host": "localhost",
    "port": 5222,
    "use_ssl": false,
    "disable_starttls": false,
    "force_starttls": true,
    "timeout": 10000,
    "plugins": [
      "xep_0030",
      "xep_0323",
      "xep_0325"
    ]
  },
  "devices": [
    {
      "jid": "device@localhost/TMP_1101",
      "deviceNameExpression": "${serialNumber}",
      "deviceTypeExpression": "default",
      "attributes": [
        {
          "key": "temperature",
          "value": "${temp}"
        }
      ],
      "timeseries": [
        {
          "key": "humidity",
          "value": "${hum}"
        },
        {
          "key": "combination",
          "value": "${temp}:${hum}"
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
{% include code-toggle.liquid code=xmppConf params="conf|.copy-code.expandable-20" %}

### “服务器”部分

此配置部分用于配置网关 XMPP 设备和与 XMPP 服务器的连接。

| **参数**     | **默认值**                    | **说明**                                                                                     |
|:-|:-|-
| jid             | **gateway@localhost**                  | XMPP 用户帐户的 JID。                                                                   |
| password        | **password**                           | XMPP 用户帐户的密码。                                                                   |
| host            |  **localhost**                         | XMPP 服务器的主机。                                                                            |
| port            | **5222**                               | XMPP 服务器的端口。                                                                            |
| use_ssl         | **false**                              | 指示是否应使用较旧的 SSL 连接方法。                                                        |
| disableStarttls | **false**                              | 禁用连接的 TLS。                                                                            |
| forceStarttls   | **true**                               | 指示如果服务器未宣传对 STARTTLS 的支持，则应中止协商。                                |
| timeout         | **10000**                              |  |
| plugins         | **["xep_0030","xep_0323","xep_0325"]** | 客户端将注册的插件列表。 |
|---

配置部分将如下所示：
```json
{
  "server": {
    "jid": "gateway@localhost",
    "password": "password",
    "host": "localhost",
    "port": 5222,
    "use_ssl": false,
    "disable_starttls": false,
    "force_starttls": true,
    "timeout": 10000,
    "plugins": [
      "xep_0030",
      "xep_0323",
      "xep_0325"
    ]
  }
}
```

### “设备”部分

此配置部分包含一个可以连接到连接器并发送数据的设备数组。这意味着连接器拒绝所有设备连接，其 JID 不包含在此数组中。

#### 设备子部分

此对象配置部分包括有关如何处理传入数据的信息。

| **参数**        | **默认值**             | **说明**                                                                                                                       |
|:-|:-|-
| jid                  | **device@localhost/TMP_1101** | XMPP 用户帐户的 JID。                                                                                                     |
| deviceNameExpression | **${serialNumber}**           | JSON 路径表达式，用于查找设备名称。                                                                                    |
| deviceTypeExpression | **${sensorType}**             | JSON 路径表达式，用于查找设备类型。                                                                                    |
| attributes           |                               | 此子部分包含传入请求的参数，这些参数将被解释为设备的属性。                                                               |
| ... key              | **temperature**               | GridLinks 中的属性名称。                                                                                                    |
| ... value            | **${temp}**                   | 简单 JSON 表达式，用于在传入消息中查找值，以作为 key 参数的值发送到 GridLinks 实例。                                |
| timeseries           |                               | 此子部分包含传入消息的参数，这些参数将被解释为设备的遥测。                                                               |
| ... key              | **humidity**                  | GridLinks 中的遥测名称。                                                                                                    |
| ... value            | **${hum}**                    | 简单 JSON 表达式，用于在传入消息中查找值，以作为 key 参数的值发送到 GridLinks 实例。                                |
|---

示例：
```json
{
  "jid": "device@localhost/TMP_1101",
  "deviceNameExpression": "${serialNumber}",
  "deviceTypeExpression": "default",
  "attributes": [
    {
      "key": "temperature",
      "value": "${temp}"
    }
  ],
  "timeseries": [
    {
      "key": "humidity",
      "value": "${hum}"
    },
    {
      "key": "combination",
      "value": "${temp}:${hum}"
    }
  ]
}
```

#### 属性更新子部分

此配置部分是可选的。GridLinks 允许配置设备属性并从设备应用程序中获取其中一些属性。您可以将其视为设备的远程配置。您的设备能够从 GridLinks 请求共享属性。有关更多详细信息，请参阅用户指南。

“attributeUpdates”配置允许配置将发送到 XMPP 设备的相应属性数据格式。

| **参数**           | **默认值**                               | **说明**                                                                   |
|:-|:-|-
| attributeOnThingsBoard  | **sharedName**                                  | 共享属性名称。                                                            |
| valueExpression         | **{\"${attributeKey}\":\"${attributeValue}\"}** | 用于创建将发送到设备的消息数据的 JSON 路径表达式。 |
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

ThingsBoard 允许将 RPC 命令直接或通过网关发送到连接到 GridLinks 的设备。

此部分中提供的配置用于将 RPC 请求从 GridLinks 发送到设备。

| **参数**           | **默认值**    | **说明**                                                                   |
|:-|:-|-
| methodRPC               | **rpcMethod1**       | RPC 方法名称。                                                                  |
| withResponse            | **true**             | 布尔值，表示是否向 ThingsBoard 发送响应。                                            |
| valueExpression         | **${params}**        | 用于创建将发送到设备的消息数据的 JSON 路径表达式。 |
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

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。