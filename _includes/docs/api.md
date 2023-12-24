ThingsBoard API 由两部分组成：设备 API 和服务器端 API。

设备 API 按支持的通信协议分组：

* [**MQTT API**](/docs/{{docsPrefix}}reference/mqtt-api)
{% if docsPrefix != "edge/" and docsPrefix != "pe/edge/" %}
* [**MQTT Sparkplug API**](/docs/{{docsPrefix}}reference/mqtt-sparkplug-api)
{% endif %}
* [**CoAP API**](/docs/{{docsPrefix}}reference/coap-api)
* [**HTTP API**](/docs/{{docsPrefix}}reference/http-api)
* [**LWM2M API**](/docs/{{docsPrefix}}reference/lwm2m-api)
* [**SNMP API**](/docs/{{docsPrefix}}reference/snmp-api)

[**网关 MQTT API**](/docs/{{docsPrefix}}reference/gateway-mqtt-api) 允许您使用 **[ThingsBoard 网关](/docs/iot-gateway/what-is-iot-gateway/)** 将 **现有** 设备连接到平台，或实现您自己的网关。

{% if docsPrefix != "edge/" and docsPrefix != "pe/edge/" %}

服务器端 API 可用作 REST API：

* [**管理 REST API**](/docs/{{docsPrefix}}reference/rest-api) - 服务器端核心 API。
* [**属性查询 API**](/docs/{{docsPrefix}}user-guide/attributes/#data-query-api) - 由 [遥测服务](/docs/{{docsPrefix}}user-guide/attributes/) 提供的服务器端 API。
* [**时序查询 API**](/docs/{{docsPrefix}}user-guide/telemetry/#data-query-api) - 由 [遥测服务](/docs/{{docsPrefix}}user-guide/telemetry/) 提供的服务器端 API。
* [**RPC API**](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc-api) - 由 [RPC 服务](/docs/{{docsPrefix}}user-guide/rpc/) 提供的服务器端 API。
* [**REST 客户端**](/docs/{{docsPrefix}}reference/rest-client)
* [**Python REST 客户端**](/docs/{{docsPrefix}}reference/python-rest-client)
* [**Dart API 客户端**](/docs/{{docsPrefix}}reference/dart-client)

软件开发工具包：

* [**Python 客户端 SDK**](/docs/{{docsPrefix}}reference/python-client-sdk) - 用于将您的 Python 项目集成到客户端的软件开发工具包。

{% endif %}