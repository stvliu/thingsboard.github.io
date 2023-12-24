过滤器节点用于消息过滤和路由。您可以在下面找到可用节点的列表。

* TOC
{:toc}
  
## 资产配置文件开关

根据资产配置文件的名称路由传入的消息。资产配置文件名称区分大小写。自 **v3.4.4** 起可用。

**输出**

规则节点的输出连接对应于资产配置文件名称。例如：“冷冻室”、“建筑物”等。有关更多详细信息，请参阅规则节点 [连接](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection)。

**用法示例**

经验丰富的平台用户利用 [资产配置文件](/docs/{{docsPrefix}}user-guide/asset-profiles/) 并为每个资产配置文件配置特定的规则链。
这对于自动路由平台生成的消息非常有用：资产创建、删除、属性更新等。
但大多数消息都来自传感器数据。
假设我们在具有以下配置文件的房间资产中安装了温度传感器：“冷冻室”和“锅炉房”。我们还认为房间资产和类型为“包含”的温度设备之间存在关系。
下面的规则链将消息的始发者从设备更改为相关资产，并将传入的消息路由到“冷冻室”或“锅炉房”规则链。  

![image](/images/user-guide/rule-engine-2-0/nodes/asset-profile-switch-chain.png)

您可以 [下载](https://gist.github.com/ashvayka/f67f9415c625e8a2d12340e18248111f#file-asset-profile-switch-example-json) 并导入规则链。
请注意，“规则链”节点将指向您环境中不存在的规则链。

<br>

## 设备配置文件开关

根据设备配置文件的名称路由传入的消息。设备配置文件名称区分大小写。自 **v3.4.4** 起可用。

**输出**

规则节点的输出连接对应于设备配置文件名称。例如：“温度传感器”、“湿度传感器”等。有关更多详细信息，请参阅规则节点 [连接](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection)。

**用法示例**

经验丰富的平台用户利用 [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/) 并为每个设备配置文件配置特定的规则链。
在大多数情况下，这很有用，除非设备数据来自其他一些消息。
例如，您可以将 BLE 用于 MQTT 网关和 BLE 信标。网关有效负载通常包含信标的 MAC 和信标数据：

```json
{"mac": "7085C2F13DCD", "rssi": -25, "payload": "AABBCC"}
```

假设您有不同的信标配置文件 - 室内空气质量（“IAQ 传感器”）和泄漏传感器（“泄漏传感器”）。
下面的规则链将消息的始发者从网关更改为设备，并将消息转发到相应的规则链：

![image](/images/user-guide/rule-engine-2-0/nodes/device-profile-switch-chain.png)

您可以 [下载](https://gist.github.com/ashvayka/f67f9415c625e8a2d12340e18248111f#file-device-profile-switch-example-json) 并导入规则链。
请注意，“规则链”节点将指向您环境中不存在的规则链。

<br>

## 检查警报状态

检查 [警报](/docs/{{docsPrefix}}user-guide/alarms/) 状态以匹配指定状态之一。

**配置**

* 警报状态过滤器 - 包含警报状态列表。
可用状态：“已确认激活”、“未确认激活”、“已确认清除”、“未确认清除”。

![image](/images/user-guide/rule-engine-2-0/nodes/check-alarm-status-configuration.png)

**输出**

输出连接类型：“真”或“假”。

**示例**

下面的规则链将检查确认的警报仍然处于活动状态还是已经清除。

![image](/images/user-guide/rule-engine-2-0/nodes/check-alarm-status-chain.png)

您可以 [下载](https://gist.github.com/ashvayka/f67f9415c625e8a2d12340e18248111f#file-check-alarm-status-example-json) 并导入规则链。

<br>

## 检查字段是否存在 {#check-existence-fields-node}

检查消息和/或元数据中是否存在指定字段。
消息和元数据通常是 JSON 对象。
用户在配置中指定消息和/或元数据字段名称。
 

**配置**

* 消息字段名称 - 应存在于消息中的字段名称列表；
* 元数据字段名称 - 应存在于元数据中的字段名称列表；
* '检查所有指定字段是否存在' 复选框 - 检查所有（如果选中）或至少一个字段（如果未选中）的存在。

![image](/images/user-guide/rule-engine-2-0/nodes/check-fields-presence-configuration.png)

**输出**

输出连接类型：“真”或“假”。

**示例**

请参阅配置屏幕截图。

<br>

## 检查关系 {#check-relation-filter-node}

检查消息的始发者与其他实体之间的 [关系](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations) 的存在。
如果选中“检查与特定实体的关系”，则必须指定相关实体。否则，规则节点将检查与匹配方向和关系类型条件的任何实体的关系的存在。

**配置**

* '检查与特定实体的关系' 复选框启用特定实体的配置，用于检查关系。
* 方向 - 配置关系的方向。它是“从”或“到”。该值对应于从特定/任何实体到始发者的关系的方向。
   见示例。
* 关系类型 - 任意关系类型。默认关系类型是“包含”和“管理”，但您可以创建任何类型的关系。

![image](/images/user-guide/rule-engine-2-0/nodes/check-relation-configuration.png)

**输出**

输出连接类型：“真”或“假”。

**示例**

假设您在办公室和仓库内都有温度传感器。
在数据处理期间，您可能想知道传感器位于办公室还是仓库中。
要实现这一点，您应该从办公室资产向位于办公室的传感器设备提供“OfficeToDevice”关系。
请参阅配置屏幕截图以了解如何针对此特定情况配置规则节点。

<br>

## 实体类型 {#originator-type-filter-node}

按消息始发者实体的类型过滤传入的消息。
检查传入消息始发者的实体类型是否与过滤器中指定的值之一匹配。

**配置**

* 始发者类型过滤器 - 实体类型列表：设备、资产、用户等。

![image](/images/user-guide/rule-engine-2-0/nodes/entity-type-configuration.png)

**输出**

输出连接类型：“真”或“假”。

**示例**

请参阅配置屏幕截图。

<br>

## 实体类型开关 {#originator-type-switch-node}

按消息始发者实体的类型切换传入的消息。

**输出**

规则节点的输出连接对应于消息始发者的实体类型。例如：“设备”、“资产”、“用户”等。

**示例**

假设您在一个规则链中处理来自不同实体的消息。
您可能希望根据实体类型拆分消息流。
见下文：

![image](/images/user-guide/rule-engine-2-0/nodes/entity-type-switch-chain.png)

<br>

## 消息类型 {#message-type-filter-node}

根据一个或多个 [预定义](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types) 或自定义消息类型过滤传入的消息。
检查传入消息的消息类型是否与过滤器中指定的值之一匹配。

**配置**

* 消息类型过滤器 - [预定义](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types) 消息类型列表。
   还支持自定义消息类型。

![image](/images/user-guide/rule-engine-2-0/nodes/message-type-configuration.png)

**输出**

输出连接类型：“真”或“假”。

**示例**

请参阅配置屏幕截图。

<br>

## 消息类型开关 {#message-type-switch-node}

按消息类型值路由传入的消息。
如果传入消息具有已知 [消息类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types)，
那么它将被发送到相应的链，否则，消息将被发送到 **其他** 链。

如果您使用自定义消息类型，则可以通过 **消息类型开关节点** 的 **其他** 链将这些消息路由到配置了所需路由逻辑的 [**消息类型**](#message-type)。

**输出**

规则节点的输出连接对应于消息的类型。例如：“设备”、“资产”、“用户”等。

**示例**

假设您在一个规则链中处理具有不同类型的消息。
您可能希望根据消息类型拆分消息流。
见下文：

![image](/images/user-guide/rule-engine-2-0/nodes/message-type-switch-chain.png)

<br>

## 脚本 {#script-filter-node}

使用传入消息评估布尔函数。该函数可以使用 [TBEL](/docs/{{docsPrefix}}user-guide/tbel/)(推荐) 或纯 JavaScript 编写。
脚本函数应返回布尔值并接受三个参数。

**配置**

TBEL/JavaScript 函数接收 3 个输入参数：

- `msg` - 是消息有效负载，通常是 JSON 对象或数组。
- `metadata` - 是消息元数据。表示为键值对映射。键和值都是字符串。
- `msgType` - 是消息类型，字符串。

![image](/images/user-guide/rule-engine-2-0/nodes/script-filter-node-configuration.png)

**输出**

输出连接类型：“真”或“假”。

**示例**
 
可以通过 `msg` 变量访问消息有效负载。例如 `msg.temperature < 10;` <br> 
可以通过 `metadata` 变量访问消息元数据。例如 `metadata.deviceType === 'DHT11';` <br> 
可以通过 `msgType` 变量访问消息类型。例如 `msgType === 'POST_TELEMETRY_REQUEST'` <br> 

完整脚本示例：

```javascript
if(msgType === 'POST_TELEMETRY_REQUEST') {
    if(metadata.deviceType === 'vehicle') {
        return msg.humidity > 50;
    } else if(metadata.deviceType === 'controller') {
        return msg.temperature > 20 && msg.humidity > 60;
    }
}

return false;
```
{: .copy-code}

可以使用 [测试脚本函数](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#test-script-functions) 验证 TBEL/JavaScript 条件。

您可以在以下教程中看到使用此节点的真实示例：

- [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/)
- [回复 RPC 调用](/docs/user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial/#add-filter-script-node)

<br>

## 开关 {#switch-node}

将传入消息路由到一个或多个输出连接。
节点执行配置的 [TBEL](/docs/{{docsPrefix}}user-guide/tbel/)(推荐) 或 JavaScript 函数，该函数返回字符串数组（连接名称）。

**配置**

TBEL/JavaScript 函数接收 3 个输入参数：

- `msg` - 是消息有效负载，通常是 JSON 对象或数组。
- `metadata` - 是消息元数据。表示为键值对映射。键和值都是字符串。
- `msgType` - 是消息类型，字符串。

脚本应返回 **_下一个关系名称的数组_**，消息应被路由到该数组。
如果返回的数组为空 - 消息将不会被路由到任何节点并被丢弃。

![image](/images/user-guide/rule-engine-2-0/nodes/filter-switch-configuration.png)

**输出**

规则节点的输出连接对应于脚本执行的结果。例如：“低温遥测”、“正常温度遥测”、“空闲状态”等。
有关更多详细信息，请参阅规则节点 [连接](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection)。

**示例**

可以通过 `msg` 变量访问消息有效负载。例如 `msg.temperature < 10;` <br> 
可以通过 `metadata` 变量访问消息元数据。例如 `metadata.customerName === 'John';` <br> 
可以通过 `msgType` 变量访问消息类型。例如 `msgType === 'POST_TELEMETRY_REQUEST'` <br> 

完整脚本示例：

```javascript
if (msgType === 'POST_TELEMETRY_REQUEST') {
    if (msg.temperature < 18) {
        return ['Low Temperature Telemetry'];
    } else {
        return ['Normal Temperature Telemetry'];
    }
} else if (msgType === 'POST_ATTRIBUTES_REQUEST') {
    if (msg.currentState === 'IDLE') {
        return ['Idle State', 'Update State Attribute'];
    } else if (msg.currentState === 'RUNNING') {
        return ['Running State', 'Update State Attribute'];
    } else {
        return ['Unknown State'];
    }
}
return [];
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/nodes/filter-switch.png)

可以使用 [测试脚本函数](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#test-script-functions) 验证 TBEL/JavaScript 条件。

<br>

## GPS 地理围栏过滤器 {#gps-geofencing-filter-node}

按基于 GPS 的地理围栏过滤传入的消息。
从传入消息中提取纬度和经度参数，并根据配置的周长对其进行检查。

**配置**

 * 纬度键名 - 包含位置纬度的消息字段的名称；
 * 经度键名 - 包含位置经度的消息字段的名称；
 * 周长类型 - 多边形或圆形；
 * 从消息元数据获取周长 - 从消息元数据加载周长的复选框；
   如果您的周长特定于设备/资产并且您将其存储为设备/资产属性，请启用；
 * 周长键名 - 存储周长信息的消息元数据的键名；
 * 对于多边形周长类型：  
    * 多边形定义 - 包含以下格式的坐标数组的字符串：[[lat1, lon1],[lat2, lon2],[lat3, lon3], ... , [latN, lonN]]
 * 对于圆形周长类型：      
    * 中心纬度 - 圆形周长中心的纬度；
    * 中心经度 - 圆形周长中心的经度；
    * 范围 - 圆形周长范围的值，双精度浮点值；
    * 范围单位 - 其中之一：米、公里、英尺、英里、海里；
    
如果启用了“从消息元数据获取周长”，并且“周长键名”未配置，则规则节点将使用默认元数据键名。
多边形周长类型的默认元数据键名是“perimeter”。圆形周长的默认元数据键名是：“centerLatitude”、“centerLongitude”、“range”、“rangeUnit”。

圆形周长定义的结构（例如存储在服务器端属性中）：

```json
{"latitude":  48.198618758582384, "longitude": 24.65322245153503, "radius":  100.0, "radiusUnit": "METER" }
```

可用半径单位：METER、KILOMETER、FOOT、MILE、NAUTICAL_MILE；
    
**输出**

输出连接类型：“真”或“假”。
当出现以下情况时，将使用“失败”连接：a) 传入消息在数据或元数据中没有配置的纬度或经度键，或 b) 缺少周长定义；     

**示例**

*静态圆形周长*

假设您想检查设备的位置是否在乌克兰独立纪念碑周围 100 米范围内，该纪念碑位于基辅市中心。
纪念碑的坐标如下：纬度 = 50.4515652，经度 = 0.5236963。规则节点的配置非常简单：

![image](/images/user-guide/rule-engine-2-0/nodes/filter-gps-geofencing-circle-static-configuration.png)

*静态多边形周长*

假设一个简单的牲畜位置监控案例。让我们配置规则节点以监控绵羊是否在区域周长内：

我们将使用农场字段的静态多边形坐标：

```json
[[48.19736726399899, 24.652353415807884], [48.19800374220741, 24.65060461551745], [48.19918370897885, 24.65317953619048], [48.19849718616351, 24.65420950445969]]
```  

如果您在消息中提交以下坐标，则可以测试规则节点是否返回“真”：

```json
{ latitude: 48.198618758582384, longitude: 24.65322245153503 }
```

![image](/images/user-guide/rule-engine-2-0/nodes/filter-gps-geofencing-perimeter-static-configuration.png)

*动态圆形/多边形周长*

让我们回顾一个更复杂的牲畜位置监控案例，您可能在不同的农场中饲养绵羊。
假设我们创建了两个农场：农场 A 和农场 B。每个牲畜追踪器设备都与农场 A 或农场 B 资产相关。

![image](/images/user-guide/rule-engine-2-0/nodes/gps-geofencing-filter-farm-relation.png)

我们将配置名为“perimeter”的服务器端属性，其 JSON 值为：“[[48.19736726399899, 24.652353415807884], [48.19800374220741, 24.65060461551745], [48.19918370897885, 24.65317953619048], [48.19849718616351, 24.65420950445969]]”;

![image](/images/user-guide/rule-engine-2-0/nodes/gps-geofencing-filter-farm-attribute.png)

下面的规则链将从相关资产（农场 A）中获取属性并在地理围栏节点中使用它：

![image](/images/user-guide/rule-engine-2-0/nodes/gps-geofencing-filter-dynamic-example.png)

规则节点配置非常简单。请注意，周长键名没有任何前缀：

![image](/images/user-guide/rule-engine-2-0/nodes/gps-geofencing-filter-dynamic-configuration.png)

您可以 [下载](https://gist.github.com/ashvayka/f67f9415c625e8a2d12340e18248111f#file-gps-geofencing-filter-example) 并导入规则链。
请注意，“规则链”节点将指向“绵羊追踪器生成器”节点中不存在的设备。
您需要配置设备和资产才能复制示例。