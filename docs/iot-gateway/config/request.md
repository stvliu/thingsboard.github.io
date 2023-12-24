---
layout: docwithnav-gw
title: 请求连接器配置
description: ThingsBoard IoT 网关的 HTTP 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard IoT 网关的请求连接器配置。  
使用 [通用配置指南](/docs/iot-gateway/configuration/) 启用此连接器。  
此连接器的目的是连接到外部 HTTP(S) API 端点并从中获取数据。  
连接器还能够根据 GridLinks 的更新/命令将数据推送到外部 HTTP(S) API。    

当您的设备中有一些 HTTP(S) API 端点或外部资源中有一些数据，并且您想将这些数据推送到 GridLinks 时，此连接器非常有用。    

我们将在下面描述连接器配置文件。  

## 连接器配置: request.json

连接器配置是一个 JSON 文件，其中包含有关如何连接到外部 API 端点、读取数据时要使用哪些 URL 以及如何处理数据的信息。  
让我们使用下面的示例来查看配置文件的格式。    

<b>请求连接器配置文件示例。</b>

下面列出的示例将连接到具有 5000 端口的本地主机上的服务器。  
连接器将使用用户名和密码的基本 HTTP 授权。  
然后，连接器将使用映射部分中的 URL 从端点列表中读取数据。有关更多信息，请参见下面的说明。  

{% capture requestConf %}
{
  "host": "http://127.0.0.1:5000",
  "SSLVerify": true,
  "security": {
    "type": "basic",
    "username": "user",
    "password": "password"
  },
  "mapping": [
    {
      "url": "getdata",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 5,
      "converter": {
        "type": "json",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "attributes": [
          {
            "key": "serialNumber",
            "type": "string",
            "value": "${serial}"
          }
        ],
        "telemetry": [
          {
            "key": "Maintainer",
            "type": "string",
            "value": "${Developer}"
          }
        ]
      }
    },
    {
      "url": "get_info",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 100,
      "converter": {
        "type": "custom",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "extension": "CustomRequestUplinkConverter",
        "extension-config": [
          {
            "key": "Totaliser",
            "type": "float",
            "fromByte": 0,
            "toByte": 4,
            "byteorder": "big",
            "signed": true,
            "multiplier": 1
          },
          {
            "key": "Flow",
            "type": "int",
            "fromByte": 4,
            "toByte": 6,
            "byteorder": "big",
            "signed": true,
            "multiplier": 0.01
          }
        ]
      }
    }
  ],
  "attributeUpdates": [
      {
        "httpMethod": "POST",
        "httpHeaders": {
          "CONTENT-TYPE": "application/json"
        },
        "timeout": 0.5,
        "tries": 3,
        "allowRedirects": true,
        "deviceNameFilter": "SD.*",
        "attributeFilter": "send_data",
        "requestUrlExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
  ],
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "echo",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "responseTimeout": 1,
      "httpMethod": "GET",
      "valueExpression": "${params}",
      "timeout": 0.5,
      "tries": 3,
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "httpMethod": "POST",
      "valueExpression": "${params}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=requestConf params="conf|.copy-code.expandable-20" %}


### 常规部分

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| host | **http://127.0.0.1:5000** | 服务器的域名地址或 IP。 |
| SSLVerify | **true** | 如果可用，验证服务器上的 SSL 证书。 |
|---


### 安全部分

本部分提供了外部服务器上客户端授权的配置。

{% capture requestconnectorsecuritytogglespec %}
基本<small>推荐</small>%,%username%,%templates/iot-gateway/request-connector-basic-security-config.md%br%
匿名<small>无安全</small>%,%anonymous%,%templates/iot-gateway/request-connector-anonymous-security-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="requestConnectorCredentialsConfig" toggle-spec=requestconnectorsecuritytogglespec %}


### 映射部分

此配置部分包含一个对象数组，其中包含网关在连接到服务器后尝试读取的端点。  
此部分还包含有关处理传入消息（转换器）的设置。  
请求后，将分析来自该 URL 的每个响应以提取设备名称、类型和数据（属性和/或时序值）。  
默认情况下，网关使用 Json 转换器，但可以提供自定义转换器。请参阅源代码中的 [示例](https://github.com/thingsboard/thingsboard-gateway/blob/master/thingsboard_gateway/extensions/request/custom_request_uplink_converter.py)。  

**注意**：您可以在数组中指定多个映射对象。

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| url | **getdata** | 用于发送请求的 URL 地址。 |
| httpMethod | **GET** | 请求的 HTTP 方法（**GET**、**POST** 等）。 |
| httpHeaders | **{ "ACCEPT": "application/json" }** | 对象包含请求的其他 HTTP 头。 |
| allowRedirects | **true** | 允许请求重定向。 |
| timeout | **0.5** | 请求超时。 |
| scanPeriod | **5** | 重新扫描速率。 |
|---


#### 转换器子部分

此子部分包含有关处理传入消息的配置。  

请求转换器的类型：  
1. json -- 默认转换器  
2. custom -- 自定义转换器（您可以自己编写，它将用于转换响应中的传入数据。）  

{% capture requestconvertertypespec %}
json<small>如果响应中收到 json，则推荐</small>%,%json%,%templates/iot-gateway/request-converter-json-config.md%br%
custom<small>如果响应中收到字节或其他任何内容，则推荐</small>%,%custom%,%templates/iot-gateway/request-converter-custom-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="RequestConverterTypeConfig" toggle-spec=requestconvertertypespec %}


### 属性更新部分

本部分中的配置是可选的。  
ThingsBoard 允许配置设备属性并从设备应用程序中获取其中一些属性。
您可以将其视为设备的远程配置。您的设备能够从 ThingsBoard 请求共享属性。
有关更多详细信息，请参阅 [用户指南](/docs/user-guide/attributes/)。

“**attributeRequests**”配置允许配置相应属性请求和响应消息的格式。

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| httpMethod | **GET** | 请求的 HTTP 方法（**GET**、**POST** 等）。 |
| httpHeaders | **{ "CONTENT-TYPE": "application/json" }** | 对象包含请求的其他 HTTP 头。 |
| timeout | **0.5** | 请求超时。 |
| tries | **3** | 发送数据的次数 |
| allowRedirects | **true** | 允许请求重定向。 |
| deviceNameFilter | **SD.\*** | 正则表达式设备名称过滤器，用于确定要执行哪个函数。 |
| attributeFilter | **send_data** | 正则表达式属性名称过滤器，用于确定要执行哪个函数。 |
| requestUrlExpression | **sensor/${deviceName}/${attributeKey}** | JSON 路径表达式用于创建发送消息的 URL 地址。 |
| valueExpression | **{\\"${attributeKey}\\":\\"${attributeValue}\\"}** | JSON 路径表达式用于创建将发送到 URL 的消息数据。 |
|---

**attributeUpdates** 部分将如下所示：

```json

  "attributeUpdates": [
      {
        "httpMethod": "POST",
        "httpHeaders": {
          "CONTENT-TYPE": "application/json"
        },
        "timeout": 0.5,
        "tries": 3,
        "allowRedirects": true,
        "deviceNameFilter": "SD.*",
        "attributeFilter": "send_data",
        "requestUrlExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
  ]

```

### 服务器端 RPC 部分

ThingsBoard 允许将 [RPC 命令](/docs/user-guide/rpc/) 发送到直接或通过网关连接到 GridLinks 的设备。

本部分中提供的配置用于将 RPC 请求从 ThingsBoard 发送到设备。

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| deviceNameFilter | **SmartMeter.\*** | 正则表达式设备名称过滤器，用于确定要执行哪个函数。 |
| methodFilter | **echo** | 正则表达式方法名称过滤器，用于确定要执行哪个函数。 |
| requestUrlExpression | **sensor/${deviceName}/request/${methodName}/${requestId}** | JSON 路径表达式，用于创建发送 RPC 请求的 URL 地址。 |
| responseTimeout | **0.5** | 请求超时。 |
| httpMethod | **GET** | 请求的 HTTP 方法（**GET**、**POST** 等）。 |
| valueExpression | **${params}** | JSON 路径表达式，用于创建要发送到外部端点的数据。 |
| timeout | **0.5** | 请求超时。 |
| tries | **3** | 发送数据的次数 |
| httpHeaders | **{ "CONTENT-TYPE": "application/json" }** | 对象包含请求的其他 HTTP 头。 |
|---

{% capture rpc_variants %}
**有 2 种类型的 RPC 调用：**

1. 带有回复，在发送请求后，网关将等待响应并将其发送到 GridLinks。
2. 无回复，在发送请求后，网关不会等待响应。

下面提供了两种方法的示例。

{% endcapture %}
{% include templates/info-banner.md content=rpc_variants %}

```json
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "echo",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "responseTimeout": 1,
      "httpMethod": "GET",
      "valueExpression": "${params}",
      "timeout": 0.5,
      "tries": 3,
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "httpMethod": "POST",
      "valueExpression": "${params.hum}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
```

## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。