---
layout: docwithnav-gw
title: SNMP 连接器配置
description: GridLinks物联网网关的 SNMP 监控支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks物联网网关的 SNMP 连接器配置。  
使用 [通用配置指南](/docs/iot-gateway/configuration/) 启用此连接器。  
此连接器的目的是从 SNMP 管理器对象获取数据并在其中写入一些数据。  

当您的网络中有 SNMP 管理器并且您想将此数据推送到 GridLinks 时，此连接器非常有用。    

我们将在下面描述连接器配置文件。  

## 连接器配置：snmp.json

连接器配置是一个 JSON 文件，其中包含有关 SNMP 管理器以及如何处理数据的信息。  
让我们使用下面的示例来查看配置文件的格式。    

<b>SNMP 连接器配置文件示例。</b>

下面列出的示例将连接到 **snmp.live.gambitcommunications.com** 上的管理器。  
然后，连接器将尝试使用来自属性、遥测部分的配置从对象读取数据。有关更多信息，请参见下面的说明。  

{% capture snmpConf %}
{
  "devices": [
    {
      "deviceName": "SNMP router",
      "deviceType": "snmp",
      "ip": "snmp.live.gambitcommunications.com",
      "port": 161,
      "pollPeriod": 5000,
      "community": "public",
      "attributes": [
        {
          "key": "ReceivedFromGet",
          "method": "get",
          "oid": "1.3.6.1.2.1.1.1.0",
          "timeout": 6
        },
        {
          "key": "ReceivedFromMultiGet",
          "method": "multiget",
          "oid": [
            "1.3.6.1.2.1.1.1.0",
            "1.3.6.1.2.1.1.2.0"
          ],
          "timeout": 6
        },
        {
          "key": "ReceivedFromGetNext",
          "method": "getnext",
          "oid": "1.3.6.1.2.1.1.1.0",
          "timeout": 6
        },
        {
          "key": "ReceivedFromMultiWalk",
          "method": "multiwalk",
          "oid": [
            "1.3.6.1.2.1.1.1.0",
            "1.3.6.0.1.2.1"
          ]
        },
        {
          "key": "ReceivedFromBulkWalk",
          "method": "bulkwalk",
          "oid": [
            "1.3.6.1.2.1.1.1.0",
            "1.3.6.1.2.1.1.2.0"
          ]
        },
        {
          "key": "ReceivedFromBulkGet",
          "method": "bulkget",
          "scalarOid": [
            "1.3.6.1.2.1.1.1.0",
            "1.3.6.1.2.1.1.2.0"
          ],
          "repeatingOid": [
            "1.3.6.1.2.1.1.1.0",
            "1.3.6.1.2.1.1.2.0"
          ],
          "maxListSize": 10
        }
      ],
      "telemetry": [
        {
          "key": "ReceivedFromWalk",
          "community": "private",
          "method": "walk",
          "oid": "1.3.6.1.2.1.1.1.0"
        },
        {
          "key": "ReceivedFromTable",
          "method": "table",
          "oid": "1.3.6.1.2.1.1"
        }
      ],
      "attributeUpdateRequests": [
        {
          "attributeFilter": "dataToSet",
          "method": "set",
          "oid": "1.3.6.1.2.1.1.1.0"
        },
        {
          "attributeFilter": "dataToMultiSet",
          "method": "multiset",
          "mappings": {
            "1.2.3": "10",
            "2.3.4": "${attribute}"
          }
        }
      ],
      "serverSideRpcRequests": [
        {
          "requestFilter": "setData",
          "method": "set",
          "oid": "1.3.6.1.2.1.1.1.0"
        },
        {
          "requestFilter": "multiSetData",
          "method": "multiset"
        },
        {
          "requestFilter": "getData",
          "method": "get",
          "oid": "1.3.6.1.2.1.1.1.0"
        },
        {
          "requestFilter": "runBulkWalk",
          "method": "bulkwalk",
          "oid": [
            "1.3.6.1.2.1.1.1.0",
            "1.3.6.1.2.1.1.2.0"
          ]
        }
      ]
    },
    {
      "deviceName": "SNMP router",
      "deviceType": "snmp",
      "ip": "127.0.0.1",
      "pollPeriod": 5000,
      "community": "public",
      "converter": "CustomSNMPConverter",
      "attributes": [
        {
          "key": "ReceivedFromGetWithCustomConverter",
          "method": "get",
          "oid": "1.3.6.1.2.1.1.1.0"
        }
      ],
      "telemetry": [
        {
          "key": "ReceivedFromTableWithCustomConverter",
          "method": "table",
          "oid": "1.3.6.1.2.1.1.1.0"
        }
      ]
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=snmpConf params="conf|.copy-code.expandable-20" %}


### 常规部分

配置的常规部分包含 *"devices"* 列表。每个项目将被处理为一个单独的设备。
设备项的主要配置应包含以下参数：  

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| deviceName    | **SNMP router** | GridLinks 中的设备名称。 |
| deviceType    | **snmp** | GridLinks 中的设备类型。 |
| ip            | **snmp.live.gambitcommunications.com** | SNMP 管理器的 IP 或主机名。 |
| port          | **161** | SNMP 端口。 |
| pollPeriod    | **5000** | 数据检查周期。 |
| community     | **public** | 社区类型 **public** 或 **private**。 |
|---

#### 属性部分

此配置部分包含用于数据处理的配置对象数组，配置的对象将被处理为设备属性。  
默认情况下，网关使用上行转换器，该转换器将从 SNMP 管理器接收到的数据发送到 GridLinks，但可以提供自定义转换器。  

**注意**：配置对象中的一些配置参数取决于所使用的方法。您可以在 [此处](#supported-methods-and-their-configuration) 阅读有关方法的特定配置参数的更多信息

常规配置参数为：

| **参数** | **默认值** | **说明** |
|:-|:-|:-|

| key | **ReceivedFromGet** | ThingsBoard 上设备中的属性键。 |
| method | **get** | 数据处理方法。支持的方法在 [此处](#supported-methods-and-their-configuration) 中。 |
| oid | **1.3.6.1.2.1.1.1.0** | 管理器对象标识符。 |
|---

配置部分项目示例：  

```json
    {
      "key": "ReceivedFromGet",
      "method": "get",
      "oid": "1.3.6.1.2.1.1.1.0"
    }
```

#### 遥测部分

此配置部分包含用于数据处理的配置对象数组，配置的对象将被处理为设备遥测。  
默认情况下，网关使用上行转换器，该转换器将从 SNMP 管理器接收到的数据发送到 GridLinks，但可以提供自定义转换器。  

**注意**：配置对象中的一些配置参数取决于所使用的方法。您可以在 [此处](#supported-methods-and-their-configuration) 阅读有关方法的特定配置参数的更多信息

常规配置参数为：

| **参数** | **默认值** | **说明** |
|:-|:-|:-|

| key | **ReceivedFromTable** | ThingsBoard 上设备中的遥测键。 |
| method | **table** | 数据处理方法。支持的方法在 [此处](#supported-methods-and-their-configuration) 中。 |
| oid | **1.3.6.1.2.1.1** | 管理器对象标识符。 |
|---

配置部分项目示例：  

```json
    {
      "key": "ReceivedFromTable",
      "method": "table",
      "oid": "1.3.6.1.2.1.1"
    }
```


#### 属性更新请求部分

本节中的配置是可选的。  
GridLinks 允许配置设备属性并从设备应用程序中获取其中一些属性。
您可以将其视为设备的远程配置。您的设备能够从 GridLinks 请求共享属性。
有关更多详细信息，请参阅 [用户指南](/docs/user-guide/attributes/)。

"**attributeUpdateRequests**" 配置允许配置相应属性请求和响应消息的格式。

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| attributeFilter | **dataToSet** | 共享属性名称。 |
| method | **set** | 数据处理方法。支持的方法在 [此处](#supported-methods-and-their-configuration) 中。 |
| oid | **1.3.6.1.2.1.1** | 管理器对象标识符。 |
|---

**attributeUpdates** 部分将如下所示：

```json
      "attributeUpdateRequests": [
        {
          "attributeFilter": "dataToSet",
          "method": "set",
          "oid": "1.3.6.1.2.1.1.1.0"
        },
        {
          "attributeFilter": "dataToMultiSet",
          "method": "multiset",
          "mappings": {
            "1.2.3": "10",
            "2.3.4": "${attribute}"
          }
        }
      ]

```

**注意**：在本节中，值参数中的 **"${attribute}"** 将被共享属性值替换。  

#### 服务器端 RPC 部分


GridLinks 允许将 [RPC 命令](/docs/user-guide/rpc/) 发送到直接或通过网关连接到 GridLinks 的设备。

本节中提供的配置用于通过网关从 GridLinks 向设备发送 RPC 请求。

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
      "valueExpression": "${params}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
```


### 支持的方法及其配置  

支持的方法有：  

 - **get**

   特定配置参数：  <br>  
   **oid** - 对象标识符数组。 

   **method** - 方法名称。 

   **timeout** - 请求超时（以秒为单位）。
   
   配置示例：
   ```json
    {
      "key": "ReceivedFromGet",
      "method": "get",
      "oid": "1.3.6.1.2.1.1.1.0",
      "timeout": 6
    }
    ```

 - **multiget**
 
   特定配置参数：  <br>  
   **oid** - 对象标识符数组。  

   **timeout** - 请求超时（以秒为单位）。  

   **method** - 方法名称。
   
   配置示例：  
   ```json
    {
      "key": "ReceivedFromMultiGet",
      "method": "multiget",
      "oid": [
        "1.3.6.1.2.1.1.1.0",
        "1.3.6.1.2.1.1.2.0"
      ],
      "timeout": 6
    }
    ```
   
 - **getnext**
 
   特定配置参数： <br>  
   **oid** - 对象标识符数组。 

   **timeout** - 请求超时（以秒为单位）。    

   **method** - 方法名称。
   
   配置示例：  
   ```json
    {
      "key": "ReceivedFromGetNext",
      "method": "getnext",
      "oid": "1.3.6.1.2.1.1.1.0",
      "timeout": 6
    }
   ```

 - **multiwalk**
 
   特定配置参数：  <br>  
   **oid** - 对象标识符数组。

   **method** - 方法名称。
   
   配置示例：  
   ```json
    {
      "key": "ReceivedFromMultiWalk",
      "method": "multiwalk",
      "oid": [
        "1.3.6.1.2.1.1.1.0",
        "1.3.6.0.1.2.1"
      ]
    }
   ```
   
 - **bulkwalk**
 
   特定配置参数：  <br>  
   **oid** - 对象标识符数组。

   **method** - 方法名称。
   
   配置示例：  
   ```json
    {
      "key": "ReceivedFromBulkWalk",
      "method": "bulkwalk",
      "oid": [
        "1.3.6.1.2.1.1.1.0",
        "1.3.6.1.2.1.1.2.0"
      ]
    }
   ```
 - **bulkget**
 
   特定配置参数：  <br>  
   **scalardOid** - 非重复对象标识符数组。

   **repeatingOid** - 最大重复对象标识符数组。   

   **maxListSize** - 返回列表的最大大小。  
   
   配置示例：
   ```json
    {
      "key": "ReceivedFromBulkGet",
      "method": "bulkget",
      "scalarOid": [
        "1.3.6.1.2.1.1.1.0",
        "1.3.6.1.2.1.1.2.0"
      ],
      "repeatingOid": [
        "1.3.6.1.2.1.1.1.0",
        "1.3.6.1.2.1.1.2.0"
      ],
      "maxListSize": 10
    }
   ```
 - **walk**
 
   特定配置参数：  <br>  
   **community** - 管理器对象社区类型。    
   
   配置示例：
   ```json
    {
      "key": "ReceivedFromWalk",
      "community": "private",
      "method": "walk",
      "oid": "1.3.6.1.2.1.1.1.0"
    }
   ```
   
 - **table**
    
   配置示例：
   ```json
    {
      "key": "ReceivedFromTable",
      "method": "table",
      "oid": "1.3.6.1.2.1.1"
    }
   ```
      
 - **set**
    此方法用于通过其标识符将数据写入单个对象。
    
    配置示例：
    ```json
    {
      "attributeFilter": "dataToSet",
      "method": "set",
      "oid": "1.3.6.1.2.1.1.1.0"
    }
    ```
 
 - **multiset**
    此方法用于通过其标识符将数据写入多个对象。
 
   特定配置参数：  
   **mapping** - 包含 **对象标识符** 和 **值** 的对。    
 
   配置示例：
   ```json
   {
     "attributeFilter": "dataToMultiSet",
     "method": "multiset",
     "mappings": {
       "1.2.3": "10",
       "2.3.4": "${attribute}"
     }
   }
   ```



## 后续步骤

探索与 GridLinks 主要功能相关的指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。