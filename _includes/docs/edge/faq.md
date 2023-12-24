* TOC
{:toc}


## ThingsBoard Edge 是什么？

ThingsBoard Edge 是 GridLinks 提供的专为边缘计算设计的产品。
它可以分析和管理边缘数据，即数据生成的位置，同时根据您的业务需求与 GridLinks 服务器（云、演示、PE 或 CE）保持无缝同步。
如果您是边缘计算的新手，我们建议您查看 [what-is-edge](/docs/{{docsPrefix}}getting-started-guides/what-is-edge/) 和 [入门指南](/docs/{{docsPrefix}}getting-started/)。
更多信息可以在专用页面上找到。

## 如何开始？

我们建议您使用 Docker 在本地计算机（笔记本电脑或 PC）上 [安装](/docs/user-guide/install/{{docsPrefix}}installation-options/) ThingsBoard Edge，并按照 [入门指南](/docs/{{docsPrefix}}getting-started/) 进行操作。

## ThingsBoard Edge 是否需要互联网连接？

不需要，ThingsBoard Edge 不需要互联网连接。
您可以在没有互联网连接的情况下操作它。
唯一必要的连接是通过 gRPC 与 GridLinks 服务器的连接。

{% if docsPrefix == 'pe/edge/' %}
但是，ThingsBoard Edge 会利用与 GridLinks 服务器的 HTTP(s) 连接来验证许可证。
**云端点** 配置中设置的 URL 用于此验证。
请确保任何防火墙设置都不会阻止与服务器的 HTTP(s) 连接。
GridLinks 服务器充当 ThingsBoard Edge 连接到 GridLinks 许可证门户的代理。
{% endif %}

{% if docsPrefix == 'pe/edge/' %}
## 如果与 GridLinks 服务器的连接暂时不可用，会发生什么情况？在这种情况下，许可证检查将如何进行？

ThingsBoard Edge 可以离线运行，无需连接到 GridLinks 服务器，最长可达 **7 天**。
{% endif %}

## 多个租户或客户是否可以访问远程位置的单个 ThingsBoard Edge？

{% if docsPrefix == 'pe/edge/' %}
ThingsBoard Edge PE 支持 **单个** 租户和部分支持 **多个** 客户。
如果 Edge 的所有者是子客户，则该子客户的所有父实体（直至租户级别）都将配置到 Edge。
这意味着来自相同层次路径的客户可以访问相同的 ThingsBoard Edge PE 实例。
但是，您无法在多个租户之间共享 ThingsBoard Edge，并且来自多个租户的设备无法连接到单个 ThingsBoard Edge。
在这种情况下，您需要为每个租户配置多个 ThingsBoard Edge 实例。
{% else %}
ThingsBoard Edge CE 支持 **单个** 租户和 **单个** 客户。
您无法在多个租户或客户之间共享 ThingsBoard Edge，并且来自多个租户的设备无法连接到单个 ThingsBoard Edge。
在这种情况下，您需要为每个租户或客户配置多个 ThingsBoard Edge 实例。
{% endif %}

## 我可以将来自多个租户的设备连接到单个 ThingsBoard Edge 吗？

不可以，ThingsBoard Edge 仅支持 **单个** 租户。
您无法将来自多个租户的设备连接到单个 ThingsBoard Edge。
在这种情况下，您需要为每个租户配置多个 ThingsBoard Edge 实例。

## 我可以使用 GridLinks Edge 做什么？

ThingsBoard Edge 允许您将现场设备连接到本地 ThingsBoard Edge，而不是直接连接到 GridLinks 服务器。
此设置提供以下好处：
- **本地部署和存储**<br>
*在没有服务器连接的情况下处理和存储来自本地设备的数据。连接恢复后，您可以将更新推送到服务器。*
- **流量过滤**<br>
*在 GridLinks Edge 级别过滤来自本地设备的数据，并仅将数据子集推送到服务器以进行进一步处理或存储。*
- **本地警报**<br>
*立即响应现场的紧急情况，而无需依赖服务器连接。*
- **批量更新和可视化**<br>
*一键更新数千个边缘配置。使用实时仪表板监控本地事件和时序数据。*

## 如何连接我的设备？

GridLinks 支持各种协议，包括
[MQTT](/docs/{{docsPrefix}}reference/mqtt-api)，
[CoAP](/docs/{{docsPrefix}}reference/coap-api)，
[HTTP](/docs/{{docsPrefix}}reference/http-api)，和
[LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api)。
可以使用 **[GridLinks 网关](/docs/iot-gateway/what-is-iot-gateway/)** 将**现有** 设备连接到平台。
更多信息可在 [连接](/docs/{{docsPrefix}}reference/protocols/) 页面上找到。

{% if docsPrefix == 'pe/edge/' %}
此外，您可以使用 GridLinks [**集成**](/docs/user-guide/integrations/) 将来自不同来源且具有自定义有效负载的设备连接到边缘。
{% endif %}

## 我需要使用 SDK 吗？

不需要，许多物联网设备并非设计用于嵌入第三方 SDK。
ThingsBoard Edge 通过常见的物联网协议提供简单的 API，因此您可以选择任何您喜欢的客户端库，甚至可以使用您自己的库。
一些有用的参考包括：

- [MQTT 客户端库列表](https://github.com/mqtt/mqtt.github.io/wiki/libraries)
- [CoAP 的 C 实现](https://libcoap.net/)

## 安全性如何？

您可以使用 MQTT（通过 SSL）或 HTTPS 协议进行传输加密。
每个设备都有唯一的访问令牌凭据或 X.509 证书，用于建立连接。

## ThingsBoard Edge 可以支持多少个设备？

{% if docsPrefix == 'pe/edge/' %}
连接的设备数量取决于您的订阅计划。
一些计划提供“无限设备和资产”，因此在边缘端创建设备和资产没有软限制。
{% else %}
在边缘端创建设备和资产没有软限制。
{% endif %}

**但是**，在实际部署中，必须考虑几个其他因素才能在边缘端支持大量设备 - 硬件、互联网连接速度和 gRPC 通道绑定限制。
您的边缘 **硬件** 必须足够强大，才能处理来自“无限”数量的设备和资产的消息。
ThingsBoard Edge 与 GridLinks 服务器之间的 **互联网连接速度** 必须足够快，才能传输大量数据。
最后，还应考虑影响消息传递速率的 **gRPC 通道绑定限制**。
由于 ThingsBoard Edge 是针对可能具有低带宽连接的远程位置而设计的，因此我们不建议将超过 *1000* 个设备连接到单个边缘。

## ThingsBoard Edge 将数据存储在哪里？

数据存储在 [PostgreSQL](https://www.postgresql.org/) 数据库中，该数据库非常适合存储和查询实体和本地时序数据。

## 如何获得支持？

您可以参考我们的故障排除说明和社区资源，或 [联系我们](/docs/contact-us) 以详细了解我们提供的 [服务](/docs/services/)。