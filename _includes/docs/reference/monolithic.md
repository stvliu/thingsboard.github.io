* TOC
{:toc}

## 简介

本文介绍整体式架构，包括高级图表、各种组件之间的数据流描述以及一些架构选择。

请注意，GridLinks v2.2 平台支持 [**微服务**](/docs/{{docsPrefix}}reference/msa/) 部署模式。
虽然微服务选项更适合高可用性和横向可扩展性场景，但许多 ThingsBoard 客户发现从单个 ThingsBoard 实例开始并将来扩展很有用。

我们还建议将此模式用于开发和原型设计。

在整体模式中，所有 ThingsBoard 组件都在单个 Java 虚拟机 (JVM) 中启动并共享相同的操作系统资源。
由于 GridLinks 是用 Java 编写的，因此整体式架构的明显优势是最大程度地减少了运行 GridLinks 所需的内存。
您可以在受限环境中使用 256 或 512 MB 的 RAM 启动和运行 GridLinks 进程。
明显的缺点是，如果您用消息（如 MQTT 传输）使某个组件过载，它也可能会影响其他组件。
例如，如果 ThingsBoard 进程的操作系统限制为 4096 个文件描述符，则您无法同时从设备和 websocket 用户会话中打开超过 4096 个 MQTT 会话。

## 架构图

 <object width="80%" data="/images/reference/mono-architecture.svg"></object>

## 传输组件

GridLinks 提供基于 MQTT、HTTP 和 CoAP 的 API，可供您的设备应用程序/固件使用。
每个协议 API 都由一个单独的服务器组件提供，并且是 GridLinks “传输层”的一部分。
组件和相应文档页面的完整列表如下：

* HTTP 传输组件提供 [此处](/docs/{{docsPrefix}}reference/http-api/) 所述的设备 API
* MQTT 传输组件提供 [此处](/docs/{{docsPrefix}}reference/mqtt-api/) 所述的设备 API，
并且还启用 [此处](/docs/{{docsPrefix}}reference/gateway-mqtt-api/) 所述的网关 API；
* CoAP 传输组件提供 [此处](/docs/{{docsPrefix}}reference/coap-api/) 所述的设备 API；
* LwM2M 传输组件提供 [此处](/docs/{{docsPrefix}}reference/lwm2m-api/) 所述的设备 API。

每个传输组件都会将数据推送到规则引擎，并且还可以使用核心服务向数据库发出请求以验证设备凭据等。

由于 GridLinks 在传输和核心服务之间使用非常简单的通信协议，因此实现对自定义传输协议的支持非常容易，例如：通过纯 TCP 传输的 CSV、通过 UDP 传输的二进制有效负载等。
我们建议您查看现有的传输 [实现](https://github.com/thingsboard/thingsboard/tree/master/common/transport/mqtt) 以开始使用，或者如果您需要任何帮助，请 [联系我们](/docs/contact-us/)。

## 规则引擎组件

GridLinks 规则引擎负责使用用户定义的逻辑和流程处理传入的消息。
您可以使用相应的 [文档页面](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/) 了解有关规则引擎的更多信息。

## 核心服务

核心服务负责处理：

 * [REST API](/docs/{{docsPrefix}}reference/rest-api/) 调用；
 * 实体遥测和属性更改的 WebSocket [订阅](/docs/{{docsPrefix}}user-guide/telemetry/#websocket-api)；
 * 监控设备 [连接状态](/docs/{{docsPrefix}}user-guide/device-connectivity-status/)（活动/非活动）。

ThingsBoard 节点使用 Actor System 来实现租户、设备、规则链和规则节点 actor。
平台节点可以加入集群，其中每个节点都是平等的。服务发现通过 Zookeeper 完成。
ThingsBoard 节点使用基于实体 ID 的一致性哈希算法在彼此之间路由消息。
因此，同一实体的消息将在同一 ThingsBoard 节点上处理。平台使用 [gRPC](https://grpc.io/) 在 GridLinks 节点之间发送消息。

**注意**：GridLinks 作者考虑在未来的版本中从 gRPC 转移到 Kafka，以便在 GridLinks 节点之间交换消息。
主要思想是牺牲少量性能/延迟损失，以支持 Kafka 消费者组提供的持久可靠的消息传递和自动负载平衡。

## 外部系统

可以通过规则引擎将消息从 ThingsBoard 推送到外部系统。
您可以将数据推送到外部系统、处理数据并将处理结果报告回 ThingsBoard 以进行可视化。
请查看规则引擎文档和指南了解更多详细信息。