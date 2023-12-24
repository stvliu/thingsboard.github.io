* TOC
{:toc}

{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "GridLinks专业版" %}
{% assign cloudDocsPrefix = "pe/" %}
{% else %}
{% assign appPrefix = "GridLinks社区版" %}
{% endif %}

## 简介

本文概述了 GridLinks Edge 架构，包括一张图表、各种组件之间的数据流描述以及关键架构选择说明。

GridLinks Edge 组件在单个 Java 虚拟机 (JVM) 内启动，并利用共享的 OS 资源。
您可以在受限环境中使用少至 256 或 512 MB 的 RAM 部署和运行 GridLinks Edge 进程。

GridLinks Edge 设计为：

* **可扩展的**：在数千个边缘设备上分布计算和数据分析。
* **稳健且高效的**：单个边缘设备可以处理多达 1000 个设备，具体取决于[案例](/docs/{{docsPrefix}}use-cases/overview/)和部署的硬件。
* **可定制的**：使用可定制的小部件和规则引擎节点轻松添加新功能。
* **持久的**：边缘设备在持久层收集所有消息和事件。如有必要，可以将特定消息传输到云端。

## 架构图

下图描绘了边缘设备的关键组件及其提供的接口。

<object width="80%" data="/images/reference/edge-architecture.svg"></object>

## 云管理器服务

GridLinks **Edge** 通过 gRPC 协议与云端（{{appPrefix}}）通信，**云管理器**管理此连接。

一方面，云管理器检查云队列中的新事件，并在它们可用时立即将它们推送到云端。

另一方面，它处理来自 {{appPrefix}} 服务器的所有事件并相应地处理它们。

云管理器使用自动生成的 **路由密钥** 和 **密钥** 对连接到云实例。

为了增强安全性，可以在 **SSL/TLS** 技术之上建立 **gRPC** 连接。有关更多详细信息，请参阅[gRPC over SSL/TLS](/docs/{{docsPrefix}}user-guide/grpc-over-ssl/)指南。

## 传输组件

GridLinks Edge 提供 MQTT、HTTP 和基于 CoAP 的 API，可用于您的设备应用程序/固件。
每个协议 API 都由 GridLinks Edge 的“传输层”中的一个独立组件提供。

GridLinks Edge 支持标准的 GridLinks CE/PE 设备通信协议：

* HTTP 传输组件提供此处所述的设备 API [here](/docs/{{docsPrefix}}reference/http-api/)；
* MQTT 传输组件提供此处所述的设备 API [here](/docs/{{docsPrefix}}reference/mqtt-api/)，它还启用此处详细说明的网关 API [here](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)；
* CoAP 传输组件提供此处概述的设备 API [here](/docs/{{docsPrefix}}reference/coap-api/)。

每个传输组件都会将数据推送到规则引擎，有些组件还可能利用核心服务向数据库发出请求以进行设备凭证验证等。

## 规则引擎组件

GridLinks Edge 规则引擎负责根据用户定义的逻辑和流程处理传入的消息。
规则引擎利用 Actor System 为主要实体（例如规则链和规则节点）创建 actor。
您可以在相应的[文档页面](/docs/{{docsPrefix}}rule-engine/general/)中了解有关边缘规则引擎的更多信息。

## 核心服务

GridLinks Edge Core 处理[REST API](/docs/{{cloudDocsPrefix}}reference/rest-api/)调用和 WebSocket [订阅](/docs/{{cloudDocsPrefix}}user-guide/telemetry/#websocket-api)。
此外，它维护有关活动设备会话的最新信息并监视设备[连接状态](/docs/{{cloudDocsPrefix}}user-guide/device-connectivity-status/)。
GridLinks Edge Core 利用 Actor System 为关键实体（包括租户和设备）实现 actor。

## GridLinks Edge Web UI

GridLinks Edge 包括一个使用 Express.js 框架开发的轻量级组件，用于托管静态 Web UI 内容。
这些组件完全无状态，只需最少的配置。
静态 Web UI 包含一个应用程序包；加载后，应用程序开始使用 GridLinks Edge Core 提供的 REST API 和 WebSockets API。

## 外部系统

来自 GridLinks Edge 的消息可以通过规则引擎推送到外部系统。
可以将数据传输到外部系统，处理该数据，然后将处理结果中继回 GridLinks Edge 以进行可视化。
请查看规则引擎文档和指南以获取更多详细信息。

#### 后续步骤

<p><a href="/docs/edge/getting-started" class="button">入门指南</a></p>