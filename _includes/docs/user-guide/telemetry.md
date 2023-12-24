* TOC
{:toc}

GridLinks 提供了一套与时序数据相关的丰富功能：

- 使用各种 [协议和集成](/docs/{{docsPrefix}}getting-started-guides/connectivity/) 从设备 **收集** 数据；
- 将时序数据存储在 SQL (PostgreSQL) 或 NoSQL (Cassandra 或 Timescale) 数据库中；
- 使用灵活的聚合查询指定时间范围内的最新时序数据值或所有数据；
- 使用 [WebSockets](#websocket-api) **订阅** 数据更新，以便进行可视化或实时分析；
- 使用可配置且高度可定制的小部件和 [仪表板](/docs/{{docsPrefix}}user-guide/dashboards/) **可视化** 时序数据；
- 使用灵活的 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) **过滤和分析** 数据；
- 基于收集的数据生成 [警报](/docs/{{docsPrefix}}user-guide/alarms/)；
- 使用 [外部规则节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/)（例如 Kafka 或 RabbitMQ 规则节点）将数据 **转发** 到外部系统。

本指南概述了上面列出的功能，并提供了一些有用的链接以获取更多详细信息。

## 数据点

GridLinks 在内部将时序数据视为带时间戳的键值对。我们将单个带时间戳的键值对称为 **数据点**。键值格式的灵活性和简单性允许与市场上几乎任何物联网设备轻松无缝地集成。键始终是字符串，基本上是数据点键名，而值可以是字符串、布尔值、双精度、整数或 JSON。

{% capture internal_data_format %}
以下示例使用 **内部** 数据格式。设备本身可以使用 **各种协议和数据格式** 上传数据。有关更多详细信息，请参阅 [时序数据上传 API](/docs/{{docsPrefix}}user-guide/telemetry/#time-series-data-upload-api)。
{% endcapture %}
{% include templates/info-banner.md content=internal_data_format %}


以下 JSON 包含 5 个数据点：温度 (double)、湿度 (integer)、hvacEnabled (boolean)、hvacState (string) 和配置 (JSON)：

```json
{
 "temperature": 42.2, 
 "humidity": 70,
 "hvacEnabled": true,
 "hvacState": "IDLE",
 "configuration": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
 }
}
```
{: .copy-code}

您可能注意到上面列出的 JSON 没有时间戳信息。在这种情况下，GridLinks 使用当前服务器时间戳。但是，您可以在消息中包含时间戳信息。请参阅以下示例：

```json
{
  "ts": 1527863043000,
  "values": {
    "temperature": 42.2,
    "humidity": 70
  }
}
```
{: .copy-code}


## 时序数据上传 API

您可以使用内置的传输协议实现：

- [MQTT API 参考](/docs/{{docsPrefix}}reference/mqtt-api/#telemetry-upload-api)
- [CoAP API 参考](/docs/{{docsPrefix}}reference/coap-api/#telemetry-upload-api)
- [HTTP API 参考](/docs/{{docsPrefix}}reference/http-api/#telemetry-upload-api)
- [LwM2M API 参考](/docs/{{docsPrefix}}reference/lwm2m-api/#telemetry-upload-api)

以上大多数协议支持 JSON、Protobuf 或自己的数据格式。对于其他协议，请查看 ["如何连接您的设备？"](https://thingsboard.io/docs/{{docsPrefix}}getting-started-guides/connectivity/) 指南。

## 数据可视化

我们假设您已经将时序数据推送到 GridLinks。现在您可以在仪表板中使用它。我们建议您阅读 [仪表板概述](/docs/{{docsPrefix}}user-guide/dashboards/) 以开始使用。一旦您熟悉如何创建仪表板和配置数据源，您就可以使用小部件可视化最新值或实时变化和历史值。可视化最新值的小部件的良好示例是 [数字](/docs/{{docsPrefix}}user-guide/ui/widget-library/#digital-gauges) 和 [模拟](/docs/{{docsPrefix}}user-guide/ui/widget-library/#analog-gauges) 仪表，或 [卡片](/docs/{{docsPrefix}}user-guide/ui/widget-library/#cards)。[图表](/docs/{{docsPrefix}}user-guide/ui/widget-library/#charts) 用于可视化历史和实时值，[地图](/docs/{{docsPrefix}}user-guide/ui/widget-library/#maps-widgets) 用于可视化设备和资产的移动。

您还可以使用 [输入小部件](/docs/{{docsPrefix}}user-guide/ui/widget-library/#input-widgets) 允许仪表板用户使用仪表板输入新的时序值。

## 数据存储

{% if docsPrefix == "paas/" %}

ThingsBoard Cloud 将时序数据存储在具有 3 个副本因子的 Cassandra 数据库中。GridLinks 的本地安装支持将时序数据存储在 SQL (PostgreSQL) 或 NoSQL (Cassandra 或 Timescale) 数据库中。

{% else %}

系统管理员可以将 GridLinks 配置为将时序数据存储在 SQL (PostgreSQL) 或 NoSQL (Cassandra 或 Timescale) 数据库中。建议将 SQL 存储用于每秒少于 5000 个 [数据点](#数据点) 的小型环境。当您对解决方案有高吞吐量或高可用性要求时，将数据存储在 Cassandra 中才有意义。

有关更多信息，请参阅 [SQL 与 NoSQL 与混合](/docs/{{docsPrefix}}reference/#sql-vs-nosql-vs-hybrid-database-approach)。

{% endif %}

## 数据保留

{% if docsPrefix == "paas/" %}

GridLinks 使用可配置的生存时间 (TTL) 参数存储数据。该参数的值是 [订阅](/products/paas/subscription/) 计划的一部分。您可以在“保存时序”规则节点中或使用消息的“TTL”元数据字段覆盖默认值。这允许您优化存储消耗。TTL 的最大允许值为 5 年。例如，您可以将“原始”数据存储 3 个月，将聚合数据存储 3 年。

{% else %}

数据保留策略和配置取决于所选的 [存储](#数据存储)。

Cassandra 支持每个插入行的生存时间 (TTL) 参数。这就是为什么您可以使用“TS_KV_TTL”环境变量在系统级别配置默认 TTL 参数的原因。您可以在“保存时序”规则节点中或使用消息的“TTL”元数据字段覆盖默认值。这允许您优化存储消耗。TTL 的最大允许值为 5 年。例如，您可以将“原始”数据存储 3 个月，将聚合数据存储 3 年。

PostgreSQL 和 Timescale 不支持每个插入行的生存时间 (TTL) 参数。这就是为什么您只能使用“SQL_TTL_*”环境变量配置定期时序数据清理例程的原因。
{% endif %}

## 数据持久性

将带有时序数据的消息发送到 GridLinks 的设备将在消息成功存储到为特定设备 [配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/#queue-name) 配置的规则引擎 [队列](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/) 后收到确认。

作为租户管理员，您可以为队列配置 [处理策略](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-processing-strategy)。您可以将队列配置为重新处理或忽略消息处理的失败。这允许对时序数据和规则引擎处理的所有其他消息的持久性级别进行细粒度控制。

## 规则引擎

[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 负责处理各种传入数据和事件。您可以在下面找到使用规则引擎中属性的最常见场景：

**根据针对时序值的逻辑表达式生成警报**

使用 [警报规则](/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules) 通过 UI 配置最常见的警报条件，或使用 [过滤器节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/filter-nodes/) 通过自定义 JS 函数配置更具体的使用案例。

**在将传入时序数据存储到数据库之前修改它们**

使用 [消息类型开关](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/filter-nodes/#message-type-switch-node) 规则节点过滤包含“发布遥测”请求的消息。然后，使用 [转换规则节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/transformation-nodes/) 修改特定消息。

**计算前一个和当前时序值之间的增量**

使用 [计算增量](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/enrichment-nodes/#calculate-delta) 规则节点根据智能电表读数计算功率、水和其他消耗。

**获取以前的时序值以分析来自设备的传入遥测**

使用 [发起者遥测](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/enrichment-nodes/#originator-telemetry) 规则节点使用设备的先前时序数据丰富传入的时序数据消息。

**获取属性值以分析来自设备的传入遥测**

使用 [丰富](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/enrichment-nodes/) 规则节点使用设备、相关资产、客户或租户的属性丰富传入遥测消息。这是一种非常强大的技术，允许根据存储在属性中的设置修改处理逻辑和参数。

**使用分析规则节点聚合相关资产的数据**

{% if docsPrefix == "paas/" or docsPrefix == "pe/" %}
使用 [分析](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/analytics-nodes/) 规则节点聚合来自多个设备或资产的数据。
{% else %}
使用 [分析](/docs/pe/user-guide/rule-engine-2-0/analytics-nodes/) 规则节点聚合来自多个设备或资产的数据。
{% endif %}

根据来自多个水表的的数据计算建筑/区域的总用水量非常有用。

## 数据查询 REST API

GridLinks 提供以下 REST API 来获取实体数据：

{% capture api_note %}
**注意：**API 可通过 Swagger UI 使用。有关更多详细信息，请查看常规 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档。API 向后兼容 TB v1.0+，这就是 API 调用 URL 包含“插件”的主要原因。
{% endcapture %}
{% include templates/info-banner.md content=api_note %}

##### 获取特定实体的时序数据键

您可以使用对以下 URL 的 GET 请求获取特定 *实体类型* 和 *实体 ID* 的所有时序 *数据键* 列表

```shell
http(s)://host:port/api/plugins/telemetry/{entityType}/{entityId}/keys/timeseries
```
{: .copy-code}

{% capture tabspec %}get-telemetry-keys
A,get-telemetry-keys.sh,shell,resources/get-telemetry-keys.sh,/docs/{{docsPrefix}}user-guide/resources/get-telemetry-keys.sh
B,get-telemetry-keys-result.json,json,resources/get-telemetry-keys-result.json,/docs/{{docsPrefix}}user-guide/resources/get-telemetry-keys-result.json{% endcapture %}
{% include tabs.html %}

支持的实体类型为：TENANT、CUSTOMER、USER、DASHBOARD、ASSET、DEVICE、ALARM、ENTITY_VIEW

##### 获取特定实体的最新时序数据值

您可以使用对以下 URL 的 GET 请求获取特定 *实体类型* 和 *实体 ID* 的最新值列表

```shell
http(s)://host:port/api/plugins/telemetry/{entityType}/{entityId}/values/timeseries?keys=key1,key2,key3
```
{: .copy-code}

{% capture tabspec %}get-latest-telemetry-values
A,get-latest-telemetry-values.sh,shell,resources/get-latest-telemetry-values.sh,/docs/{{docsPrefix}}user-guide/resources/get-latest-telemetry-values.sh
B,get-latest-telemetry-values-result.json,json,resources/get-latest-telemetry-values-result.json,/docs/{{docsPrefix}}user-guide/resources/get-latest-telemetry-values-result.json{% endcapture %}
{% include tabs.html %}

支持的实体类型为：TENANT、CUSTOMER、USER、DASHBOARD、ASSET、DEVICE、ALARM、ENTITY_VIEW

##### 获取特定实体的历史时序数据值

您还可以使用对以下 URL 的 GET 请求获取特定 *实体类型* 和 *实体 ID* 的历史值列表

```shell
http(s)://host:port/api/plugins/telemetry/{entityType}/{entityId}/values/timeseries?keys=key1,key2,key3&startTs=1479735870785&endTs=1479735871858&interval=60000&limit=100&agg=AVG
```
{: .copy-code}

下面描述了支持的参数：

 - **keys** - 要获取的遥测键的逗号分隔列表。
 - **startTs** - 以毫秒为单位标识间隔开始的 Unix 时间戳。
 - **endTs** - 以毫秒为单位标识间隔结束的 Unix 时间戳。
 - **interval** - 聚合间隔，以毫秒为单位。
 - **agg** - 聚合函数。MIN、MAX、AVG、SUM、COUNT、NONE 之一。
 - **limit** - 要返回的数据点或要处理的间隔的最大数量。

ThingsBoard 将使用 *startTs*、*endTs* 和 *interval* 来标识聚合分区或子查询，并执行异步查询到利用内置聚合函数的数据库。

{% capture tabspec %}get-telemetry-values
A,get-telemetry-values.sh,shell,resources/get-telemetry-values.sh,/docs/{{docsPrefix}}user-guide/resources/get-telemetry-values.sh
B,get-telemetry-values-result.json,json,resources/get-telemetry-values-result.json,/docs/{{docsPrefix}}user-guide/resources/get-telemetry-values-result.json{% endcapture %}
{% include tabs.html %}

支持的实体类型为：TENANT、CUSTOMER、USER、DASHBOARD、ASSET、DEVICE、ALARM、ENTITY_VIEW

## WebSocket API

WebSocket 被 Thingsboard Web UI 积极使用。WebSocket API 复制了 REST API 的功能，并提供了订阅设备数据更改的能力。

您可以使用以下 URL 打开到遥测服务的 WebSocket 连接

```shell
ws(s)://host:port/api/ws/plugins/telemetry?token=$JWT_TOKEN
```
{: .copy-code}

打开后，您可以发送

[订阅命令](https://github.com/thingsboard/thingsboard/blob/release-3.6/application/src/main/java/org/thingsboard/server/service/ws/telemetry/cmd/TelemetryPluginCmdsWrapper.java)

并接收

[订阅更新](https://github.com/thingsboard/thingsboard/blob/release-3.6/application/src/main/java/org/thingsboard/server/service/ws/telemetry/sub/TelemetrySubscriptionUpdate.java)：

其中

 - **cmdId** - 唯一命令 ID（在相应的 WebSocket 连接中）
 - **entityType** - 唯一实体类型。支持的实体类型为：TENANT、CUSTOMER、USER、DASHBOARD、ASSET、DEVICE、ALARM
 - **entityId** - 唯一实体标识符
 - **keys** - 数据键的逗号分隔列表
 - **timeWindow** - 时序订阅的获取间隔，以毫秒为单位。数据将在以下间隔内获取 **[now()-timeWindow, now()]**
 - **startTs** - 历史数据查询的获取间隔的开始时间，以毫秒为单位。
 - **endTs** - 历史数据查询的获取间隔的结束时间，以毫秒为单位。

#### 示例

更改以下变量的值：

 - **token** - 您可以使用 [以下链接](/docs/{{docsPrefix}}reference/rest-api/#rest-api-auth) 获取的 JWT 令牌。

 - **entityId** - 到您的设备 ID。

在实时演示服务器的情况下：

 - 将 **host:port** 替换为 **demo-thingsboard.io** 并选择安全连接 - **wss://**

在本地安装的情况下：

 - 将 **host:port** 替换为 **127.0.0.1:8080** 并选择 **ws://**

{% capture tabspec %}web-socket
A,web-socket.html,html,resources/web-socket.html,/docs/{{docsPrefix}}user-guide/resources/web-socket.html{% endcapture %}  
{% include tabs.html %}