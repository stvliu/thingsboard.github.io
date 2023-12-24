---
layout: docwithnav-gw
title: FTP 连接器配置
description: ThingsBoard IoT 网关的 FTP 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard IoT 网关的 FTP 连接器配置。
使用 [常规配置](/docs/iot-gateway/configuration/) 启用此连接器。
此连接器的目的是连接到外部 FTP 服务器并从特定路径的文件中获取数据。
连接器还能够根据 GridLinks 的更新/命令将数据推送到 FTP 服务器文件。

当您的设备中有一些 FTP 服务器或外部资源中有一些数据，并且您想将这些数据推送到 GridLinks 时，此连接器非常有用。

我们将在下面描述连接器配置文件。

## 连接器配置：ftp.json

连接器配置是一个 JSON 文件，其中包含有关如何连接到外部 FTP 服务器、在读取数据时使用哪些路径以及如何处理数据的信息。
让我们使用下面的示例来查看配置文件的格式。

<b>FTP 连接器配置文件示例。</b>

下面列出的示例将连接到部署在 IP 为 0.0.0.0 的服务器上的本地网络中的 FTP 服务器。
连接器将使用用户名和密码的基本 FTP 身份验证。
然后，连接器将订阅映射部分中的路径列表。有关更多信息，请参见下面的说明。

{% capture ftpConf %}

{
  "host": "0.0.0.0",
  "port": 21,
  "TLSSupport": false,
  "security": {
    "type": "basic",
    "username": "admin",
    "password": "admin"
  },
  "paths": [
    {
      "devicePatternName": "asd",
      "devicePatternType": "Device",
      "delimiter": ",",
      "path": "fol/*_hello*.txt",
      "readMode": "FULL",
      "maxFileSize": 5,
      "pollPeriod": 5,
      "txtFileDataView": "SLICED",
      "withSortingFiles": true,
      "attributes": [
        {
          "key": "temp",
          "value": "[1:]"
        },
        {
          "key": "tmp",
          "value": "[0:1]"
        }
      ],
      "timeseries": [
        {
          "type": "int",
          "key": "[0:1]",
          "value": "[0:1]"
        },
        {
          "type": "int",
          "key": "temp",
          "value": "[1:]"
        }
      ]
    }
  ],
  "attributeUpdates": [
    {
      "path": "fol/hello.json",
      "deviceNameFilter": ".*",
      "writingMode": "WRITE",
      "valueExpression": "{'${attributeKey}':'${attributeValue}'}"
    }
  ],
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "read",
      "valueExpression": "${params}"
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "write",
      "valueExpression": "${params}"
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=ftpConf params="conf|.copy-code.expandable-20" %}

### 常规部分

| **参数** | **默认值** | **说明** |
|:-|:-|-
| host | **localhost** | 服务器的域名或 IP。 |
| port | **21** | 服务器的端口 |
| TLSSupport | **true** | 如果可用，请在服务器上验证或不验证 TLS 支持。 |
|---

#### 子部分“security”

子部分“security”提供了 FTP 服务器上客户端授权的配置。

{% capture mqttconnectorsecuritytogglespec %}
基本<small>推荐</small>%,%accessToken%,%templates/iot-gateway/ftp-connector-basic-security-config.md%br%
匿名<small>无安全</small>%,%anonymous%,%templates/iot-gateway/ftp-connector-anonymous-security-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="mqttConnectorCredentialsConfig" toggle-spec=mqttconnectorsecuritytogglespec %}  

### 部分“paths”

此配置部分包含一个对象数组，其中包含网关在连接到服务器后尝试读取的路径。
此部分还包含有关处理传入消息（转换器）的设置。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| path | **data/log.txt** | 用于读取数据的文件的路径。 |
|---

**注意** 确保您的文件扩展名是 FTP 连接器支持的扩展名之一（.txt、.json、.csv）

**path** 支持特殊符号“*”以允许订阅多个路径和文件。
让我们看看使用 **path** 参数的另一个示例：

| **示例名称** | **路径** | **注释** |
|:-|:-|:-|-
| 示例 1 | data/log.txt | 从一个文件（如果存在）读取数据 |
| 示例 2 | data/*/log.txt | 从包含 data 文件夹的所有文件夹中读取所有 log.txt 文件 |
| 示例 3 | data/\*/\*_log.txt | 从包含 data 文件夹的所有文件夹中读取名称包含 _log.txt 的所有文件 |
| 示例 3 | data/\*.\* | 从包含 data 文件夹的所有支持扩展名的文件中读取所有文件 |
|---

现在让我们回顾一下路径部分中的另一个必需参数。

| **参数** | **可用值** | **说明** |
|:-|:-|:-|-
| delimiter | , | 用于分割文件中的数据的符号 |
| readMode | FULL/PARTIAL | 如果参数等于 FULL，则文件将从头到尾读取。如果参数等于 PARTIAL，则文件将从上次读取时的行开始读取 |
| maxFileSize | 5 | 将要读取的最大文件大小（以 MB 为单位）（如果文件大小超过 5 MB，则将传递） |
| pollPeriod | 60 | 将读取路径中文件的时间段（以秒为单位） |
| txtFileDataView | TABLE/SLICED | txtFileDataView 参数仅用于 .txt 文件 |
| withSortingFiles | true/false | 找到的路径中的文件将如何追加到数组 |
| attributes | | 此子部分包含传入消息的参数，这些参数将被解释为设备的属性。 |
| timeseries | | 此子部分包含传入消息的参数，这些参数将被解释为设备的遥测数据。 |
|---

让我们看看如何为不同的文件扩展名配置此部分：


1. 对于具有 TABLE 数据视图的 .txt 和 .csv 文件
    ```json
      "paths": [
        {
          "devicePatternName": "${temp}",
          "devicePatternType": "Device",
          "delimiter": ",",
          "path": "fol/*.*",
          "readMode": "FULL",
          "maxFileSize": 5,
          "pollPeriod": 60,
          "txtFileDataView": "TABLE",
          "withSortingFiles": true,
          "attributes": [
            {
              "type": "int",
              "key": "key",
              "value": "${temp}"
            }
          ],
          "timeseries": [
            {
              "type": "int",
              "key": "${hum}",
              "value": "${temp}"
            },
            {
              "type": "int",
              "key": "temp",
              "value": "${hum}"
            }
          ]
        }
      ]
    ```
    
    这意味着 FTP 转换器将查找下一个文件结构：
    ```txt
    temp,hum
    1,2
    23,34
    ```
2. 对于具有 SLICED 数据视图的 .txt 文件
    ```json
      "paths": [
        {
          "devicePatternName": "DeviceName",
          "devicePatternType": "[0:1]",
          "delimiter": ",",
          "path": "fol/table.txt",
          "readMode": "FULL",
          "maxFileSize": 5,
          "pollPeriod": 60,
          "txtFileDataView": "SLICED",
          "withSortingFiles": true,
          "attributes": [
            {
              "key": "temp",
              "value": "[1:]"
            },
            {
              "key": "tmp",
              "value": "[0:1]"
            }
          ],
          "timeseries": [
            {
              "type": "int",
              "key": "[0:1]",
              "value": "[0:1]"
            },
            {
              "type": "int",
              "key": "temp",
              "value": "[1:]"
            }
          ]
        }
      ]    
    ```

    这意味着 FTP 转换器将查找下一个文件结构：
    ```txt
    1,2
    23,34
    ```
3. 对于 .json 文件
    ```json
    "paths": [
        {
          "devicePatternName": "${temp}",
          "devicePatternType": "Device",
          "delimiter": ",",
          "path": "fol/*.json",
          "readMode": "FULL",
          "maxFileSize": 5,
          "pollPeriod": 60,
          "withSortingFiles": true,
          "attributes": [
            {
              "type": "int",
              "key": "key",
              "value": "${temp}"
            }
          ],
          "timeseries": [
            {
              "type": "int",
              "key": "key",
              "value": "${temp}"
            },
            {
              "type": "int",
              "key": "temp",
              "value": "${tmp}"
            }
          ]
        }
      ]
    ```
4. 组合属性、遥测和 serverSideRpc 部分，例如 .json 文件：
  ```json
  "paths": [
          {
            "devicePatternName": "${temp}",
            "devicePatternType": "Device",
            "delimiter": ",",
            "path": "fol/*.json",
            "readMode": "FULL",
            "maxFileSize": 5,
            "pollPeriod": 60,
            "withSortingFiles": true,
            "attributes": [],
            "timeseries": [
              {
                "type": "int",
                "key": "hum",
                "value": "${hum}"
              },
              {
                "type": "int",
                "key": "temp",
                "value": "${tmp}"
              },
              {
                "type": "string",
                "key": "combine",
                "value": "${tmp}::${hum}"
              }
            ]
          }
        ]
  ```

### 部分“attributeUpdates”

此配置部分是可选的。
ThingsBoard 允许配置设备属性并从设备应用程序中获取其中一些属性。您可以将其视为设备的远程配置。您的设备能够从 ThingsBoard 请求共享属性。有关更多详细信息，请参阅用户指南。

“attributeRequests”配置允许配置将写入特定文件的相应属性数据格式。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| path | **fol/${attributeKey}/${attributeValue}.txt** | 用于查找特定文件的 JSON 路径表达式 |
| deviceNameFilter | **.\*** | 正则表达式设备名称过滤器，用于确定要执行哪个函数。 |
| writingMode | **OVERRIDE/WRITE** | 如果 writingMode 等于 OVERRIDE，则找到的文件将被覆盖。如果 writingMode 等于 WRITE，则新数据将追加到找到的文件的末尾 |
| valueExpression | **,,,,${attributeKey},,,${attributeValue}** | 用于创建将发送到 FTP 服务器的消息数据的表达式。在这种情况下，',' 作为分隔符，您可以在其之前插入数据。 |
|---

配置文件中的此部分如下所示：

```json
  "attributeUpdates": [
    {
      "path": "fol/${attributeKey}/${attributeValue}.txt",
      "deviceNameFilter": ".*",
      "writingMode": "OVERRIDE",
      "valueExpression": ",,,,${attributeKey},,,${attributeValue}"
    }
  ]
```

### 服务器端 RPC 命令

ThingsBoard 允许直接或通过网关将 RPC 命令发送到连接到 GridLinks 的设备。

此部分中提供的配置用于将 RPC 请求从 ThingsBoard 发送到设备。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| deviceNameFilter | **.\*** | 正则表达式设备名称过滤器，用于确定要执行哪个函数。 |
| methodFilter | **read/write** | 打开文件模式 |
| valueExpression | **,,,,${attributeKey},,,${attributeValue}** | JSON 路径表达式，用于创建要发送到 FTP 服务器的数据，如果 methodFilter 等于 write。如果 methodFilter 等于 read，则将传递此字段。 |
|---

配置文件中的此部分如下所示：

```json
"serverSideRpc": [
  {
    "deviceNameFilter": ".*",
    "methodFilter": "read",
    "valueExpression": "${params}"
  },
  {
    "deviceNameFilter": ".*",
    "methodFilter": "write",
    "valueExpression": "${params}"
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