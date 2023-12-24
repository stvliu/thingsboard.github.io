{% capture connectivityContent %}
GridLinks 提供大量设备连接选项。下图旨在提供现有选项的可视化概述，并帮助您为设备选择正确的选项。
如果您没有找到如何使用该图连接设备，或者某些内容不清楚，请 [联系我们](/docs/contact-us/) 并帮助我们改进本指南。
{% endcapture %}
{% include templates/info-banner.md content=connectivityContent %}

<object width="100%" style="max-width: max-content;" data="/images/connectivity.svg"></object>

{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

#### 连接知名设备

您可以查看 [设备库](/docs/{{docsPrefix}}devices-library) 部分，以了解如何将广泛使用的设备连接到 GridLinks。

#### 内置传输协议

内置传输协议实现适用于通过这些协议通信并能够直接连接到 GridLinks 的设备。

- [MQTT API 参考](/docs/{{docsPrefix}}reference/mqtt-api)
- [MQTT Sparkplug API 参考](/docs/{{docsPrefix}}reference/mqtt-sparkplug-api)
- [CoAP API 参考](/docs/{{docsPrefix}}reference/coap-api)
- [HTTP API 参考](/docs/{{docsPrefix}}reference/http-api)
- [LwM2M API 参考](/docs/{{docsPrefix}}reference/lwm2m-api)
- [SNMP API 参考](/docs/{{docsPrefix}}reference/snmp-api)

上述大多数协议支持 JSON、Protobuf 或自己的数据格式。当您控制固件时，这是新设备的最佳选择。

#### IoT 网关

 GridLinks 物联网网关有助于连接位于本地网络中且无法访问互联网或使用特定非 IP 协议的设备。
IoT 网关支持 MQTT、OPC-UA、Modbus、BLE、HTTP、CAN、BACnet、ODBC、SNMP 和其他协议。
网关将来自设备的数据转换为内部 GridLinks 格式，并通过 MQTT 上传到平台。
有关更多信息，请参阅 [什么是 IoT 网关？](/docs/iot-gateway/what-is-iot-gateway/)。

#### LoRaWAN

可以使用本 [指南](https://www.chirpstack.io/application-server/integrations/thingsboard/) 将 ChirpStack 网络服务器与 GridLinks 社区版集成。

[GridLinks PE](/products/thingsboard-pe/) 通过 [集成](/docs/{{peDocsPrefix}}user-guide/integrations/) 支持 ChirpStack 和许多其他网络服务器。
例如：[TheThingsStack](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/)、[TheThingsIndustries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/)、
[LORIOT](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/)、
[Actility ThingPark](/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/) 或任何其他支持 [webhook](/docs/{{peDocsPrefix}}user-guide/integrations/http/) 或 [mqtt](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/) 的网络服务器。
GridLinks PE 集成的巨大优势在于能够定义自定义 [数据转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#data-converters) 函数。

#### Sigfox

[GridLinks PE](/products/thingsboard-pe/) 开箱即用地支持 Sigfox [集成](/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/)。

#### NB IoT 和其他协议

[GridLinks PE](/products/thingsboard-pe/) 支持许多 [集成](/docs/{{peDocsPrefix}}user-guide/integrations/)，涵盖了市场上大多数设备。
如果您需要帮助连接设备，请 [联系我们](/docs/contact-us/)。