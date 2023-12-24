* TOC
{:toc}
## 为实体和属性管理分配自定义属性


GridLinks 提供了为实体分配自定义属性并管理这些属性的功能。
这些属性存储在数据库中，可用于数据可视化和数据处理。

属性被视为键值对。键值格式的灵活性和简单性允许与市场上几乎任何物联网设备轻松无缝地集成。
键始终是字符串，基本上是属性名称，而属性值可以是字符串、布尔值、双精度、整数或 JSON。
例如：

```json
{
 "firmwareVersion":"v2.3.1", 
 "booleanParameter":true, 
 "doubleParameter":42.0, 
 "longParameter":73, 
 "configuration": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
 }
}
```
{: .copy-code}

## 属性名称

作为平台用户，您可以定义任何属性名称。
但是，我们建议使用 [camelCase](https://en.wikipedia.org/wiki/Camel_case)。
这使得为数据处理和可视化编写自定义 JS 函数变得容易。

## 属性类型

有三种类型的属性。让我们通过示例来回顾它们：

### 服务器端属性

这种类型的属性几乎受任何平台实体支持：设备、资产、客户、租户、用户等。
服务器端属性是您可以通过管理 UI 或 REST API 配置的属性。
设备固件无法访问服务器端属性。

{:refdef: style="text-align: center;"}
![image](/images/user-guide/server-side-attributes.svg)
{: refdef}

假设您想构建一个建筑物监控解决方案并回顾几个示例：

1. *纬度*、*经度* 和 *地址* 是您可以分配给代表建筑物或其他房地产的资产的服务器端属性的良好示例。您可以在仪表板的地图小部件上使用此属性来可视化建筑物的位置。
2. *floorPlanImage* 可能包含指向图像的 URL。您可以在图像地图小部件上使用此属性来可视化平面图。
3. *maxTemperatureThreshold* 和 *temperatureAlarmEnabled* 可用于配置和启用/禁用特定设备或资产的警报。

#### 管理 UI

{% include images-gallery.html imageCollection="server-side-attrs-ui" showListImageTitles="true" %}


{% capture bulk_provisioning %}
[批量配置](/docs/{{docsPrefix}}user-guide/bulk-provisioning/) 功能允许您从 CSV 文件快速创建多个设备和资产及其属性。
{% endcapture %}
{% include templates/info-banner.md content=bulk_provisioning %}

#### REST API

使用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档获取 JWT 令牌的值。您将使用它来填充“X-Authorization”标头并验证您的 REST API 调用请求。

将 JSON 表示的属性的 POST 请求发送到以下 URL：

```text
https://$YOUR_GRIDLINKS_HOST/api/plugins/telemetry/$ENTITY_TYPE/$ENTITY_ID/SERVER_SCOPE
```

以下示例为具有 ID 'ad17c410-914c-11eb-af0c-d5862211a5f6' 的设备和 GridLinks云服务 服务器创建名为“newAttributeName”且值为“newAttributeValue”的属性：
```shell
curl -v 'https://thingsboard.cloud/api/plugins/telemetry/DEVICE/ad17c410-914c-11eb-af0c-d5862211a5f6/SERVER_SCOPE' \
-H 'x-authorization: Bearer $YOUR_JWT_TOKEN_HERE' \
-H 'content-type: application/json' \
--data-raw '{"newAttributeName":"newAttributeValue"}'
```
{: .copy-code}

类似地，您可以使用以下命令获取所有服务器端属性：

```shell
curl -v -X GET 'https://thingsboard.cloud/api/plugins/telemetry/DEVICE/ad17c410-914c-11eb-af0c-d5862211a5f6/values/attributes/SERVER_SCOPE' \
  -H 'x-authorization: Bearer $YOUR_JWT_TOKEN_HERE' \
  -H 'content-type: application/json' \
```
{: .copy-code}


输出将包括“键”、“值”和最后一次更新的时间戳：

```json
[
    {
        "lastUpdateTs": 1617633139380,
        "key": "newAttributeName",
        "value": "newAttributeValue"
    }
]
```
{: .copy-code}

作为 curl 的替代方案，您可以使用 [Java](/docs/{{docsPrefix}}reference/rest-client/) 或 [Python](/docs/{{docsPrefix}}reference/python-rest-client/) REST 客户端。

### 共享属性

这种类型的属性仅适用于设备。它类似于服务器端属性，但有一个重要的区别。
设备固件/应用程序可以请求共享属性的值或订阅属性的更新。
通过 MQTT 或其他双向通信协议通信的设备可以订阅属性更新并实时接收通知。
通过 HTTP 或其他请求-响应通信协议通信的设备可以定期请求共享属性的值。

{:refdef: style="text-align: center;"}
![image](/images/user-guide/shared-attributes.svg)
{: refdef}

共享属性最常见的案例是存储设备设置。
让我们假设相同的建筑物监控解决方案并回顾几个示例：

1. *targetFirmwareVersion* 属性可用于存储特定设备的固件版本。
2. *maxTemperature* 属性可用于在房间内温度过高时自动启用 HVAC。

用户可以通过 UI 更改属性。脚本或其他服务器端应用程序可以通过 REST API 更改属性值。

#### 管理 UI

{% include images-gallery.html imageCollection="shared-attrs-ui" %}

{% include templates/info-banner.md content=bulk_provisioning %}

#### REST API

使用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档获取 JWT 令牌的值。您将使用它来填充“X-Authorization”标头并验证您的 REST API 调用请求。

将 JSON 表示的属性的 POST 请求发送到以下 URL：

```text
https://$YOUR_GRIDLINKS_HOST/api/plugins/telemetry/$ENTITY_TYPE/$ENTITY_ID/SHARED_SCOPE
```

以下示例为具有 ID 'ad17c410-914c-11eb-af0c-d5862211a5f6' 的设备和 GridLinks云服务 服务器创建名为“newAttributeName”且值为“newAttributeValue”的属性：
```shell
curl -v 'https://thingsboard.cloud/api/plugins/telemetry/DEVICE/ad17c410-914c-11eb-af0c-d5862211a5f6/SHARED_SCOPE' \
-H 'x-authorization: Bearer $YOUR_JWT_TOKEN_HERE' \
-H 'content-type: application/json' \
--data-raw '{"newAttributeName":"newAttributeValue"}'
```
{: .copy-code}

类似地，您可以使用以下命令获取所有共享属性：

```shell
curl -v -X GET 'https://thingsboard.cloud/api/plugins/telemetry/DEVICE/ad17c410-914c-11eb-af0c-d5862211a5f6/values/attributes/SHARED_SCOPE' \
  -H 'x-authorization: Bearer $YOUR_JWT_TOKEN_HERE' \
  -H 'content-type: application/json' \
```
{: .copy-code}

输出将包括“键”、“值”和最后一次更新的时间戳：

```json
[
    {
        "lastUpdateTs": 1617633139380,
        "key": "newAttributeName",
        "value": "newAttributeValue"
    }
]
```
{: .copy-code}

作为 curl 的替代方案，您可以使用 [Java](/docs/{{docsPrefix}}reference/rest-client/) 或 [Python](/docs/{{docsPrefix}}reference/python-rest-client/) REST 客户端。

#### 设备固件或应用程序的 API：

- 从服务器请求*共享*属性：[MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/#request-attribute-values-from-the-server)、[CoAP API](/docs/{{docsPrefix}}reference/coap-api/#request-attribute-values-from-the-server)、[HTTP API](/docs/{{docsPrefix}}reference/http-api/#request-attribute-values-from-the-server)、[LwM2M API](/docs/{{docsPrefix}}reference/lwm2m-api/#attributes-api)；
- 订阅来自服务器的*共享*属性更新：[MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/#subscribe-to-attribute-updates-from-the-server)、[CoAP API](/docs/{{docsPrefix}}reference/coap-api/#subscribe-to-attribute-updates-from-the-server)、[HTTP API](/docs/{{docsPrefix}}reference/http-api/#subscribe-to-attribute-updates-from-the-server)、[LwM2M API](/docs/{{docsPrefix}}reference/lwm2m-api/#attributes-api)。

{% capture missed_updates %}
如果设备离线，它可能会错过重要的属性更新通知。<br>我们建议在应用程序启动时订阅属性更新，并在每次连接或重新连接后请求属性的最新值。

{% endcapture %}
{% include templates/info-banner.md content=missed_updates %}

### 客户端属性

这种类型的属性仅适用于设备。它用于向 ThingsBoard（服务器）报告来自设备（客户端）的各种半静态数据。
它类似于 [共享属性](/docs/{{docsPrefix}}user-guide/attributes/#shared-attributes)，但有一个重要的区别。
设备固件/应用程序可以将属性的值从设备发送到平台。

{:refdef: style="text-align: center;"}
![image](/images/user-guide/client-side-attributes.svg)
{: refdef}

客户端属性最常见的案例是报告设备状态。
让我们假设相同的建筑物监控解决方案并回顾几个示例：

1. *currentFirmwareVersion* 属性可用于向平台报告设备的已安装固件/应用程序版本。
2. *currentConfiguration* 属性可用于向平台报告当前固件/应用程序配置。
3. *currentState* 可用于通过网络持久化和恢复当前固件/应用程序状态，如果设备没有持久化存储。

用户和服务器端应用程序可以通过 UI/REST API 浏览客户端属性，但他们无法更改它们。
基本上，客户端属性的值对于 UI/REST API 来说是只读的。

#### 通过 REST API 获取客户端属性

使用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档获取 JWT 令牌的值。您将使用它来填充“X-Authorization”标头并验证您的 REST API 调用请求。

将 GET 请求发送到以下 URL：

```text
https://$YOUR_GRIDLINKS_HOST/api/plugins/telemetry/$ENTITY_TYPE/$ENTITY_ID/CLIENT_SCOPE
```
{: .copy-code}

以下示例获取具有 ID 'ad17c410-914c-11eb-af0c-d5862211a5f6' 的设备和 GridLinks云服务 服务器的所有属性：

```shell
curl -v -X GET 'https://thingsboard.cloud/api/plugins/telemetry/DEVICE/ad17c410-914c-11eb-af0c-d5862211a5f6/values/attributes/CLIENT_SCOPE' \
  -H 'x-authorization: Bearer $YOUR_JWT_TOKEN_HERE' \
  -H 'content-type: application/json' \
```
{: .copy-code}

输出将包括“键”、“值”和最后一次更新的时间戳：

```json
[
    {
        "lastUpdateTs": 1617633139380,
        "key": "newAttributeName",
        "value": "newAttributeValue"
    }
]
```
{: .copy-code}

作为 curl 的替代方案，您可以使用 [Java](/docs/{{docsPrefix}}reference/rest-client/) 或 [Python](/docs/{{docsPrefix}}reference/python-rest-client/) REST 客户端。

#### 设备固件或应用程序的 API：

- 将*客户端*属性发布到服务器：[MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/#publish-attribute-update-to-the-server)、[CoAP API](/docs/{{docsPrefix}}reference/coap-api/#publish-attribute-update-to-the-server)、[HTTP API](/docs/{{docsPrefix}}reference/http-api/#publish-attribute-update-to-the-server)；
- 从服务器请求*客户端*属性：[MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/#request-attribute-values-from-the-server)、[CoAP API](/docs/{{docsPrefix}}reference/coap-api/#request-attribute-values-from-the-server)、[HTTP API](/docs/{{docsPrefix}}reference/http-api/#request-attribute-values-from-the-server)。

## 属性持久性

ThingsBoard 将属性的最新值和上次修改时间存储在 SQL 数据库中。这允许在仪表板中使用 [实体过滤器](/docs/{{docsPrefix}}user-guide/dashboards/#entity-filters)。
用户发起的属性更改记录在 [审计日志](/docs/{{docsPrefix}}user-guide/audit-log/)中。

## 数据查询 API

遥测控制器提供以下 REST API 来获取实体数据：

![image](/images/user-guide/telemetry-service/rest-api.png)

{% capture api_note %}
**注意：**上面列出的 API 可通过 Swagger UI 获得。请查看一般 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档以了解更多详细信息。
API 向后兼容 TB v1.0+，这就是 API 调用 URL 包含“插件”的主要原因。
{% endcapture %}
{% include templates/info-banner.md content=api_note %}

## 数据可视化

我们假设您已经配置了设备属性。现在您可以在仪表板中使用它们。我们建议 [仪表板概述](/docs/{{docsPrefix}}user-guide/dashboards/) 来开始。
一旦您熟悉如何创建仪表板和配置数据源，
您就可以使用 [数字](/docs/{{docsPrefix}}user-guide/ui/widget-library/#digital-gauges) 和 [模拟](/docs/{{docsPrefix}}user-guide/ui/widget-library/#analog-gauges) 仪表来可视化
温度、速度、压力或其他数值。您还可以使用 [卡片](/docs/{{docsPrefix}}user-guide/ui/widget-library/#cards) 来使用卡片可视化多个属性，或 [实体表](/docs/{{docsPrefix}}user-guide/ui/entity-table-widget/)。

您还可以使用 [输入小部件](/docs/{{docsPrefix}}user-guide/ui/widget-library/#input-widgets) 允许仪表板用户在仪表板上更改属性的值。

## 规则引擎

[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 负责处理各种传入的数据和事件。
您可以在下面找到使用规则引擎中属性的最受欢迎的场景：

**根据属性值对逻辑表达式生成警报**

使用 [警报规则](/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules) 通过 UI 配置最常见的警报条件，
或使用 [过滤器节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/filter-nodes/) 通过自定义 JS 函数配置更具体的案例。

**在将传入的客户端属性存储在数据库中之前修改它们**

使用 [消息类型开关](/docs/{{docsPrefix}}/user-guide/rule-engine-2-0/filter-nodes/#message-type-switch-node) 规则节点过滤包含“发布属性”请求的消息。
然后，使用 [转换规则节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/transformation-nodes/) 修改特定消息。

**对服务器端属性的更改做出反应**

使用 [消息类型开关](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/filter-nodes/#message-type-switch-node) 规则节点过滤包含“属性已更新”通知的消息。
然后，使用 [操作](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/) 或 [外部](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/) 对传入事件做出反应。

**获取属性值以分析来自设备的传入遥测数据**

使用 [丰富](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/enrichment-nodes/) 规则节点使用设备、相关资产、客户或租户的属性丰富传入的遥测消息。
这是一种非常强大的技术，它允许根据存储在属性中的设置修改处理逻辑和参数。

{% unless docsPrefix == "paas/" %}

## 性能提升

启用属性缓存后，您可以获得更高的性能（请参阅 [配置属性](/docs/user-guide/install/{{docsPrefix}}config/#thingsboard-core-settings) 的 <b>cache.attributes.enabled</b> 属性）

启用属性缓存后，GridLinks 将仅从数据库加载特定属性一次，所有后续对属性的请求都将从更快的缓存连接加载。

**注意：**如果您使用 Redis 缓存，请确保将 <b>maxmemory-policy</b> 更改为 <b>allkeys-random</b> 以防止 Redis 填满所有可用内存。

{% endunless %}

## 旧视频教程

<div id="video">
  <div id="video_wrapper">
    <iframe src="https://www.youtube.com/embed/JCW_hShAp7I" frameborder="0" allowfullscreen=""></iframe>
  </div>
</div>