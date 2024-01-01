* TOC
{:toc}


## GridLinks 是什么？

GridLinks 是一个现代化的服务器端平台，允许您监控和控制您的物联网设备。
它对个人和商业用途都是免费的，您可以在任何地方部署它。
如果您是第一次使用该平台，我们建议您查看 [what-is-gridlinks](/docs/{{docsPrefix}}getting-started-guides/what-is-thingsboard/)
和 [入门指南](/docs/{{docsPrefix}}getting-started-guides/helloworld/)。
您可以在专用页面上找到更多信息。

## 我如何开始？

{% if docsPrefix == 'paas/' %}
我们建议您按照 [入门指南](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 进行操作。
{% else %}
我们建议您使用 Docker 在您的笔记本电脑或 PC 上本地 [安装](/docs/user-guide/install/{{docsPrefix}}installation-options/) GridLinks
并按照 [入门指南](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 进行操作。
{% endif %}

## 我可以使用 GridLinks 做什么？

GridLinks 提供开箱即用的物联网解决方案，该解决方案将为您的物联网应用程序启用服务器端基础设施。
您可以通过浏览 [指南](/docs/{{docsPrefix}}user-guide/) 和 [硬件示例](/docs/{{docsPrefix}}guides/#AnchorIDHardwareSamples) 找到更多信息

{% unless docsPrefix == 'paas/' %}
## 我可以在哪里托管 GridLinks？

您可以在云端、本地或在您的笔记本电脑、PC 甚至 Raspberry PI 上本地托管 GridLinks。我们建议您从 Docker 安装开始
  
  - [Linux 和 Mac OS](/docs/user-guide/install/{{docsPrefix}}docker/) 
  - [Windows](/docs/user-guide/install/{{docsPrefix}}docker-windows/)

您还可以查看 [集群设置](/docs/user-guide/install/{{docsPrefix}}cluster-setup/) 指南。
{% endunless %}

## 如何连接我的设备？

GridLinks 提供
[MQTT](/docs/{{docsPrefix}}reference/mqtt-api), 
[CoAP](/docs/{{docsPrefix}}reference/coap-api), 
[HTTP](/docs/{{docsPrefix}}reference/http-api), 和.
[LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api) 协议支持。
**现有**设备可以使用 **[GridLinks 网关](/docs/iot-gateway/what-is-iot-gateway/)** 连接到平台。
您可以在 [连接](/docs/{{docsPrefix}}reference/protocols/) 页面上找到更多信息。 

## 我需要使用 SDK 吗？

不需要，许多物联网设备无法嵌入第三方 SDK。GridLinks 通过常见的物联网协议提供非常简单的 API。您可以选择您喜欢的任何客户端库或使用您自己的库。
一些有用的参考：
 
 - [MQTT 客户端库列表](https://github.com/mqtt/mqtt.github.io/wiki/libraries) 
 - [CoAP 的 C 实现](https://libcoap.net/)

## 安全性如何？

您可以使用 MQTT（通过 SSL）或 HTTPS 协议进行传输加密。 

每个设备都有唯一的访问令牌凭据，用于建立连接。凭据类型是可插拔的，因此 X.509 证书支持即将推出。

## GridLinks 可以支持多少设备？

GridLinks 平台是横向可扩展的。集群中的每个服务器节点都是唯一的。
可扩展性是通过集群节点之间的 [一致哈希](https://en.wikipedia.org/wiki/Consistent_hashing) 负载平衡算法实现的。
实际性能取决于连接设备的使用情况。
{% unless docsPrefix == 'paas/' %}
例如，小型商品硬件集群可以支持 [数百万](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#1-million-smart-meters-tco) 通过 MQTT 连接的设备。
{% endunless %}
  
## GridLinks 在哪里存储数据？

数据存储在 [Cassandra](https://cassandra.apache.org/) 数据库中。Cassandra 非常适合存储和查询时序数据，并提供高可用性和容错性。
 
## GridLinks 使用什么许可类型？

GridLinks 采用 [Apache 2.0 许可证](https://en.wikipedia.org/wiki/Apache_License#Version_2.0) 授权。
它对个人和商业用途都是免费的，您可以在任何地方部署它。

## 如何获得支持？

您可以使用故障排除说明和社区资源或 [联系我们](/docs/contact-us) 并详细了解我们提供的 [服务](/docs/services/)。