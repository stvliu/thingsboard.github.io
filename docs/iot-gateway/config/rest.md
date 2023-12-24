---
layout: docwithnav-gw
title: REST 连接器配置
description: GridLinks IoT 网关的 REST API 端点支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks IoT 网关的 REST 连接器配置。  
使用 [通用配置指南](/docs/iot-gateway/configuration/) 启用此连接器。  
此连接器的目的是创建 API 端点并从接收到的请求中获取数据。  
连接器还能够根据 GridLinks 的更新/命令将数据推送到外部 HTTP(S) API。    

当您的设备中有一些 HTTP(S) API 端点或外部资源中有一些数据，并且您想将这些数据推送到 GridLinks 时，此连接器非常有用。    

我们将在下面描述连接器配置文件。  

## 连接器配置：rest.json

连接器配置是一个 JSON 文件，其中包含有关如何创建 API 端点以及如何处理数据的信息。  
让我们使用下面的示例来查看配置文件的格式。    

<b>REST 连接器配置文件示例。</b>

下面列出的示例将使用 5000 端口在本地主机上创建一个服务器。  
连接器将使用用户名和密码使用基本的 HTTP 授权。  
然后，连接器将使用映射部分中的端点从端点列表创建端点。有关更多信息，请参见下面的说明。  

{% capture restConf %}
{
  "host": "127.0.0.1",
  "port": "5000",
  "SSL": false,
  "security": {
    "cert": "~/ssl/cert.pem",
    "key": "~/ssl/key.pem"
  },
  "mapping":[
    {
      "endpoint": "/test_device",
      "HTTPMethods": [
        "POST"
      ],
      "security":
      {
        "type": "basic",
        "username": "user",
        "password": "passwd"
      },
      "converter": {
        "type": "json",
        "deviceNameExpression": "Device ${name}",
        "deviceTypeExpression": "default",
        "attributes": [
          {
            "type": "string",
            "key": "model",
            "value": "${sensorModel}"
          }
        ],
        "timeseries": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}",
            "converter": "CustomConverter"
          }
        ]
      }
    },
    {
      "endpoint": "/test",
      "HTTPMethods": [
        "GET",
        "POST"
      ],
      "security":
      {
        "type": "anonymous"
      },
      "converter": {
        "type": "custom",
        "class": "CustomConverter",
        "deviceNameExpression": "Device 2",
        "deviceTypeExpression": "default",
        "attributes": [
          {
            "type": "string",
            "key": "model",
            "value": "Model2"
          }
        ],
        "timeseries": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          }
        ]
      }
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=restConf params="conf|.copy-code.expandable-20" %}


### 常规部分
{% capture restconnectorsecuritytogglespec %}
使用 SSL<small>推荐</small>%,%accessToken%,%templates/iot-gateway/rest-connector-ssl-security-config.md%br%
不使用 SSL<small>无安全</small>%,%anonymous%,%templates/iot-gateway/rest-connector-no-ssl-security-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="restConnectorCredentialsConfig" toggle-spec=restconnectorsecuritytogglespec %}  

### 映射部分

此配置部分包含网关将创建的端点的对象数组。  
此部分还包含有关处理传入消息（转换器）的设置。  
在收到请求后，将分析请求中的消息以提取设备名称、类型和数据（属性和/或时序值）。  
默认情况下，网关使用 Json 转换器，但可以提供自定义转换器。

**注意**：您可以在数组中指定多个映射对象。

| **参数** | **默认值** | **说明** |
|:--------------|:-|-------------------------------------------------------------
| endpoint      | **/test_device**                      | 端点的 URL 地址。 |
| HTTPMethods   | **GET**                               | 允许端点使用的 HTTP 方法（**GET**、**POST** 等）。 |
| ---           

#### 安全部分

此部分提供针对每个端点在网关上进行客户端授权的配置。
 
{% capture restconnectorsecuritytogglespec %}
基本<small>推荐</small>%,%username%,%templates/iot-gateway/rest-connector-basic-security-config.md%br%
匿名<small>无安全</small>%,%anonymous%,%templates/iot-gateway/rest-connector-anonymous-security-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="restConnectorCredentialsConfig" toggle-spec=restconnectorsecuritytogglespec %}


#### 转换器子部分

此子部分包含有关处理传入消息的配置。  

请求转换器的类型：  
1. json -- 默认转换器  
2. custom -- 自定义转换器（您可以自己编写，它将用于转换传入数据。）  

{% capture difference %}
<br>
**连接器不会传递转换器中的 None 值**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture restconvertertypespec %}
json<small>如果请求中将收到 json，则推荐</small>%,%json%,%templates/iot-gateway/rest-converter-json-config.md%br%
custom<small>如果请求中将收到字节或其他任何内容，则推荐</small>%,%custom%,%templates/iot-gateway/rest-converter-custom-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="restConverterTypeConfig" toggle-spec=restconvertertypespec %}

{% capture difference %}
<br>
**如果您使用的是 GET 请求，还可以从 URL 中解析查询参数。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### 响应

REST 连接器中的响应可以有 3 种配置变体：
1. 默认响应（无需额外配置，仅返回 HTTP 状态代码）；
2. 硬编码响应正文，对于此选项，您必须指定一个新部分和 2 个新的可选参数，如下面的示例所示：

    | **参数** | **默认值** | **说明** |
    |:-|:-|-
    | response                      |                                                       | 将在每次对服务器的请求中返回的响应 |
    | ... successResponse           | **OK**                                                | 仅当响应状态为 200 时 |
    | ... unsuccessfulResponse      | **Error**                                             | 仅当响应状态不同于 200 时 |
    |---

3. **高级** ThingsBoard 将返回的远程响应。
   1. 要配置该变体，您必须在配置文件中指定一个新部分，如下面的示例所示：

       | **参数** | **默认值** | **说明** |
       |:-|:-|-
       | response                      |                                                       | 开/关返回响应的布尔值 |
       | ... responseExpected          | **true**                                              | 请求的超时时间。 |
       | ... timeout                   | **120**                                               | 仅当响应状态不同于 200 时 |
       | ... responseAttribute         | **result**                                            | 将返回响应的共享属性名称 |
       |---

   2. 在 GridLinks 中配置规则链：
      ![image](/images/gateway/custom-response-rule-chain-config.png)
      最后，您必须配置规则节点：
      1. 黄色规则节点
          ![image](/images/gateway/custom-response-yellow-rule-node.png)
      2. 蓝色规则节点
          ![image](/images/gateway/custom-response-blue-rule-node.png)

### 属性请求部分
此部分中的配置是可选的。

为了向 GridLinks 服务器节点请求客户端或共享设备属性，网关允许发送属性请求。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| endpoint                      | **/sharedAttributes**                                 | 端点的 URL 地址。 |
| type                          | **shared**                                            | 请求的属性类型可以是“shared”或“client”。 |
| HTTPMethods                   | **[”POST”]**                                          | 允许的方法 |
| security                      |                                                       | 请求的安全： |
| ... type                      | **basic**                                             | 向服务器请求的安全类型（**basic** 或 **anonymous**）。 |
| ... username                  | **user**                                              | 基本安全类型的用户名。 |
| ... password                  | **passwd**                                            | 基本安全类型的密码。 |
| timeout                       | **10.0**                                              | 请求的超时时间。 |
| deviceNameExpression          | **${deviceName}**                                     | 用于查找设备名称的 JSON 路径表达式。 |
| attributeNameExpression       | **${attribute}**                                      | 用于查找属性名称的 JSON 路径表达式。 |
|---

**attributeRequests** 部分将如下所示：
```json
"attributeRequests": [
  {
    "endpoint": "/sharedAttributes",
    "type": "shared",
    "HTTPMethods": [
      "POST"
    ],
    "security": {
      "type": "anonymous"
    },
    "timeout": 10.0,
    "deviceNameExpression": "${deviceName}",
    "attributeNameExpression": "${attribute}"
  }
]
```

此外，您还可以一次请求多个属性。只需向 attributeNameExpression 参数添加一个 JSON 路径即可。例如，我们希望在一个请求中请求两个共享属性，我们的配置将如下所示：
```json
"attributeRequests": [
  {
    "endpoint": "/sharedAttributes",
    "type": "shared",
    "HTTPMethods": [
      "POST"
    ],
    "security": {
      "type": "anonymous"
    },
    "timeout": 10.0,
    "deviceNameExpression": "${deviceName}",
    "attributeNameExpression": "${pduAttribute}, ${versionAttribute}"
  }
]
```

### 属性更新部分

此部分中的配置是可选的。  
ThingsBoard 允许配置设备属性并从设备应用程序中获取其中一些属性。
您可以将其视为设备的远程配置。您的设备能够从 ThingsBoard 请求共享属性。
有关更多详细信息，请参阅 [用户指南](/docs/user-guide/attributes/)。

"**attributeRequests**" 配置允许配置相应属性请求和响应消息的格式。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| httpMethod                    | **POST**                                              | 请求的 HTTP 方法（**GET**、**POST** 等）。 |
| SSLVerify                     | **false**                                             | 如果可用，在服务器上验证或不验证 SSL 证书。 |
| httpHeaders                   | **{ "CONTENT-TYPE": "application/json" }**            | 包含请求的其他 HTTP 头的对象。 |
| security                      |                                                       | 请求的安全： |
|   type                        | **basic**                                             | 向服务器请求的安全类型（**basic** 或 **anonymous**）。 |
|   username                    | **user**                                              | 基本安全类型的用户名。 |
|   password                    | **passwd**                                            | 基本安全类型的密码。 |   
| timeout                       | **0.5**                                               | 请求的超时时间。 |
| tries                         | **3**                                                 | 发送数据尝试的次数 |
| allowRedirects                | **true**                                              | 允许请求重定向。 |
| deviceNameFilter              | **.\*REST$**                                          | 正则表达式设备名称过滤器，用于确定要执行哪个函数。 |
| attributeFilter               | **data**                                              | 正则表达式属性名称过滤器，用于确定要执行哪个函数。 |
| requestUrlExpression          | **sensor/${deviceName}/${attributeKey}**              | 用于创建要发送消息的 URL 地址的 JSON 路径表达式。 |
| valueExpression               | **{\\"${attributeKey}\\":\\"${attributeValue}\\"}**   | 用于创建将发送到 url 的消息数据的 JSON 路径表达式。 |
|---

**attributeUpdates** 部分将如下所示：

```json
  "attributeUpdates": [
      {
        "HTTPMethod": "POST",
        "SSLVerify": false,
        "httpHeaders": {
          "CONTENT-TYPE": "application/json"
        },
        "security": {
          "type": "basic",
          "username": "user",
          "password": "passwd"
        },
        "timeout": 0.5,
        "tries": 3,
        "allowRedirects": true,
        "deviceNameFilter": ".*REST$",
        "attributeFilter": "data",
        "requestUrlExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
  ],

```

### 服务器端 RPC 部分

ThingsBoard 允许将 [RPC 命令](/docs/user-guide/rpc/) 直接发送到连接到 GridLinks 或通过网关连接的设备。
 
此部分中提供的配置用于从 ThingsBoard 向设备发送 RPC 请求。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| deviceNameFilter              | **.\***                                                           | 正则表达式设备名称过滤器，用于确定要执行哪个函数。 |
| methodFilter                  | **echo**                                                          | 正则表达式方法名称过滤器，用于确定要执行哪个函数。 |
| requestUrlExpression          | **http://127.0.0.1:5001/${deviceName}**                           | 用于创建要发送 RPC 请求的 URL 地址的 JSON 路径表达式。 |
| responseTimeout               | **1**                                                             | 请求的超时时间。 |
| httpMethod                    | **GET**                                                           | 请求的 HTTP 方法（**GET**、**POST** 等）。 |
| valueExpression               | **${params}**                                                     | 用于创建要发送的数据的 JSON 路径表达式。 |
| timeout                       | **0.5**                                                           | 请求的超时时间。 |
| tries                         | **3**                                                             | 发送数据尝试的次数 |
| httpHeaders                   | **{ "CONTENT-TYPE": "application/json" }**                        | 包含请求的其他 HTTP 头的对象。 |
| security                      |                                                                   | 请求的安全： |
|   type                        | **anonymous**                                                     | 向服务器请求的安全类型（**basic** 或 **anonymous**）。 |
|---

{% capture rpc_variants %}
**有 2 种类型的 RPC 调用：**  
1. 带有回复，在发送请求后，网关将等待回复并将其发送到 GridLinks。
2. 无回复，在发送请求后，网关不会等待回复。

下面提供了两种方法的示例。

{% endcapture %}
{% include templates/info-banner.md content=rpc_variants %}

```json
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "echo",
      "requestUrlExpression": "http://127.0.0.1:5001/${deviceName}",
      "responseTimeout": 1,
      "HTTPMethod": "GET",
      "valueExpression": "${params}",
      "timeout": 0.5,
      "tries": 3,
      "httpHeaders": {
        "Content-Type": "application/json"
      },
      "security": {
        "type": "anonymous"
      }
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "HTTPMethod": "POST",
      "valueExpression": "${params.hum}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
```

此外，每个遥测和属性参数都内置了 GET 和 SET RPC 方法，因此您无需手动配置它。要使用它们，请确保您设置了所有必需的参数（对于 REST Connector，这些参数如下：**requestUrlExpression**、**responseTimeout**、**HTTPMethod**、**valueExpression**）。
请参阅 [指南](/docs/iot-gateway/guides/how-to-use-get-set-rpc-methods)。

## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。