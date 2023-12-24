ThingsBoard 支持以下协议进行设备连接：

- **[MQTT](/docs/{{docsPrefix}}reference/mqtt-api)**
{% if docsPrefix != "edge/" and docsPrefix != "pe/edge/" %}
- **[MQTT Sparkplug](/docs/{{docsPrefix}}reference/mqtt-sparkplug-api)**
{% endif %}
- **[CoAP](/docs/{{docsPrefix}}reference/coap-api)**
- **[HTTP](/docs/{{docsPrefix}}reference/http-api)**
- **[LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api)**
- **[SNMP](/docs/{{docsPrefix}}reference/snmp-api)**

有关更多详细信息，请参阅特定于协议的文档。更多协议即将推出。

**注意** 您还可以使用以下方式将**现有**设备连接到平台：

- **[ThingsBoard 网关](/docs/iot-gateway/what-is-iot-gateway/)**
或使用 **[网关 MQTT API](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)** 设计您自己的网关。