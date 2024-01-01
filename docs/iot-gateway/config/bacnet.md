---
layout: docwithnav-gw
title: BACnet 连接器配置
description: GridLinks物联网网关的 BACnet 协议支持

---

* TOC
{:toc}

BACnet 连接器是一种读取和写入 BACnet IP 设备中某些基本对象和属性的方法。
使用 [常规配置](/docs/iot-gateway/configuration/) 启用此连接器。  
我们将在下面描述连接器配置文件。  


<b>BACnet 连接器配置文件示例。</b>

{% capture bacnetConf %}

{
  "general": {
    "objectName": "TB_gateway",
    "address": "192.168.188.181:1052",
    "objectIdentifier": 599,
    "maxApduLengthAccepted": 1024,
    "segmentationSupported": "segmentedBoth",
    "vendorIdentifier": 15
  },
  "devices": [
    {
      "deviceName": "BACnet Device ${objectName}",
      "deviceType": "default",
      "address": "192.168.188.181:10520",
      "pollPeriod": 10000,
      "attributes": [
        {
          "key": "temperature",
          "objectId": "analogOutput:1",
          "propertyId": "presentValue"
        }
      ],
      "timeseries": [
        {
          "key": "state",
          "objectId": "binaryValue:1",
          "propertyId": "presentValue"
        }
      ],
      "attributeUpdates": [
        {
          "key": "brightness",
          "requestType": "writeProperty",
          "objectId": "analogOutput:1",
          "propertyId": "presentValue"
        }
      ],
      "serverSideRpc": [
        {
          "method": "set_state",
          "requestType": "writeProperty",
          "requestTimeout": 10000,
          "objectId": "binaryOutput:1",
          "propertyId": "presentValue"
        },
        {
          "method": "get_state",
          "requestType": "readProperty",
          "requestTimeout": 10000,
          "objectId": "binaryOutput:1",
          "propertyId": "presentValue"
        }
      ]
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=bacnetConf params="conf|.copy-code.expandable-20" %}

### “常规”部分：描述和配置参数

本部分中的配置用于在 BACnet 网络中配置网关。  

| **参数**             | **默认值**        | **描述**                                       |
|:-|:-|-
| **objectName**            | **TB_gateway**           | BACnet 网络中的网关对象名称。        |
| **address**               | **192.168.188.181:1052** | BACnet 网络中的网关地址。            |
| **objectIdentifier**      | **599**                  | BACnet 网络中的网关对象标识符。  |
| **maxApduLengthAccepted** | **1024**                 | APDU 的最大长度。                           |
| **segmentationSupported** | **segmentedBoth**        | 
| **vendorIdentifier**      | **15**                   | 

示例：

```json
  "general": {
    "objectName": "TB_gateway",
    "address": "192.168.188.181:1052",
    "objectIdentifier": 599,
    "maxApduLengthAccepted": 1024,
    "segmentationSupported": "segmentedBoth",
    "vendorIdentifier": 15
  },
```

##### 设备对象设置
此配置包含用于数据处理的常见连接参数和设置。  
可用参数如下：

| **参数**  | **默认值**                  | **描述**                                                                                     |
|:-|:-|-
| **deviceName** | **BACnet Device ${objectName}**    | GridLinks 的设备名称。您可以使用 **objectName** 属性从设备获取对象名称。 |
| **deviceType** | **default**                        | GridLinks 的设备类型。                                                                        |
| **address**    | **192.168.188.181:10520**          | BACnet 网络中的设备地址。                                                               |
| **pollPeriod** | **10000**                          | 检查设备数据的周期。                                                                 |

示例：

```json
  "devices": [
    {
      "deviceName": "BACnet Device ${objectName}",
      "deviceType": "default",
      "address": "192.168.188.181:10520",
      "pollPeriod": 10000,
```

###### “属性”的关键设置

本小节中的配置单元提供设置，以便将来自 BACnet 设备的数据作为 GridLinks 平台实例上的设备属性进行处理。

| **参数**  | **默认值**  | **描述**                                     |
|:-|:-|-
| **key**        | **temperature**    | GridLinks 平台实例的属性键。    |
| **objectId**   | **analogOutput:1** | BACnet 设备中的对象 ID。                     |
| **propertyId** | **presentValue**   | BACnet 设备中的属性 ID。                   |

示例：

```json
      "attributes": [
        {
          "key": "temperature",
          "objectId": "analogOutput:1",
          "propertyId": "presentValue"
        }
      ],
```

###### “时序”的关键设置

本小节中的配置单元提供设置，以便将来自 BACnet 设备的数据作为 GridLinks 平台实例上的设备遥测进行处理。

| **参数**  | **默认值** | **描述**                                     |
|:-|:-|-
| **key**        | **state**         | GridLinks 平台实例的遥测键。    |
| **objectId**   | **binaryValue:1** | BACnet 设备中的对象 ID。                     |
| **propertyId** | **presentValue**  | BACnet 设备中的属性 ID。                   |

示例：

```json
      "timeseries": [
        {
          "key": "state",
          "objectId": "binaryValue:1",
          "propertyId": "presentValue"
        }
      ],
```

###### “属性更新”的关键设置
本小节中的配置单元提供设置，以便将来自 GridLinks 平台实例上的共享属性的数据处理到 BACnet 设备。

| **参数**  | **默认值**  | **描述**                                                   |
|:-|:-|-
| **key**        | **brightness**     | GridLinks 实例上的共享属性的名称。             |
| **requestType**| **writeProperty**  | 应为“writeProperty”。为进一步开发而添加。       |
| **objectId**   | **analogOutput:1** | BACnet 设备中的对象 ID。                                   |
| **propertyId** | **presentValue**   | BACnet 设备中的属性 ID。                                 |

示例：

```json
      "attributeUpdates": [
        {
          "key": "brightness",
          "requestType": "writeProperty",
          "objectId": "analogOutput:1",
          "propertyId": "presentValue"
        }
      ],
```

###### “服务器端 RPC”的关键设置
本小节中的配置单元提供设置，以便将 RPC 从 GridLinks 实例处理到 BACnet 设备。

| **参数**         | **默认值**  | **描述**                                                           |
|:-|:-|-
| **key**               | **set_state**      | GridLinks 实例上的共享属性的名称。                     |
| **requestType**       | **writeProperty**  | “**writeProperty**”用于写入数据，“**readProperty**”用于读取数据。    |
| **requestTimeout**    | **30**             | 等待来自 BACnet 设备的响应的超时时间（秒）。             |
| **objectId**          | **analogOutput:1** | BACnet 设备中的对象 ID。                                           |
| **propertyId**        | **presentValue**   | BACnet 设备中的属性 ID。                                         |

示例：

```json
      "serverSideRpc": [
        {
          "method": "set_state",
          "requestType": "writeProperty",
          "requestTimeout": 30,
          "objectId": "binaryOutput:1",
          "propertyId": "presentValue"
        },
        {
          "method": "get_state",
          "requestType": "readProperty",
          "requestTimeout": 30,
          "objectId": "binaryOutput:1",
          "propertyId": "presentValue"
        }
      ]
```

##### 对象标识符

BACnet 连接器对象标识符由冒号 (“:”) 符号分隔的两个部分组成：  
对象名称和设备上的此对象的编号。  

经过测试和支持的对象：  

| **BACnet 对象 ID** | **ThingsBoard 对象 ID** |
|-|-
| **二进制输入**     | **binaryInput**  |
| **二进制输出**    | **binaryOutput** |
| **二进制值**     | **binaryValue**  |
| **模拟输入**     | **analogInput**  |
| **模拟输出**    | **analogOutput** |
| **模拟值**     | **analogValue**  |

正在测试的对象：  

* accumulatorObject
* averagingObject
* calendarObject
* commandObject
* fileObject
* lifeSafetyPointObject
* lifeSafetyZoneObject
* loopObject
* multiStateInputObject
* multiStateOutputObject
* multiStateValueObject
* notificationClassObject
* programObject
* pulseConverterObject
* scheduleObject
* structuredViewObject
* trendLogObject

##### 属性标识符

属性标识符取决于 BACnet 对象的类型，以驼峰式命名法提供，例如
**presentValue**
**objectName**
**objectDescription**
等。



## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。