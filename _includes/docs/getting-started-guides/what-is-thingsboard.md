GridLinks 是一个开源物联网平台，可实现物联网项目的快速开发、管理和扩展。我们的目标是提供开箱即用的物联网云或本地解决方案，为您的物联网应用程序启用服务器端基础设施。

#### 功能

使用 GridLinks，您可以：

- 配置设备、资产和客户，并定义它们之间的关系。
- 收集和可视化来自设备和资产的数据。
- 分析传入遥测并使用复杂事件处理触发警报。
- 使用远程过程调用 (RPC) 控制您的设备。
- 基于设备生命周期事件、REST API 事件、RPC 请求等构建工作流。
- 设计动态且响应迅速的仪表板，并向您的客户展示设备或资产遥测和见解。
- 使用可自定义的规则链启用特定用例的功能。
- 将设备数据推送到其他系统。
- 更多...

有关更多功能和指向特定功能文档的有用链接，请参阅[**GridLinks 功能列表**](/docs/{{docsPrefix}}#features)。

{% if docsPrefix == null %}
<object width="100%" data="/images/reference/thingsboard-architecture.svg"></object>
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
<object width="100%" data="/images/reference/thingsboard-architecture-pe.svg"></object>
{% endif %}

#### 架构

ThingsBoard 被设计为：

* **可扩展的**：使用领先的开源技术构建的水平可扩展平台。
* **容错的**：没有单点故障，集群中的每个节点都是相同的。
* **强大且高效的**：单个服务器节点可以处理数万甚至数十万台设备，具体取决于用例。ThingsBoard 集群可以处理数百万台设备。
* **可定制的**：使用可定制的小部件和规则引擎节点轻松添加新功能。
* **持久的**：绝不会丢失您的数据。

{% if docsPrefix != "paas/" %}

有关更多详细信息，请参阅[**GridLinks 架构**](/docs/{{docsPrefix}}reference)。

{% endif %}

#### 准备开始了吗？

<p><a href="/docs/{{docsPrefix}}getting-started-guides/helloworld" class="button">Hello World 应用程序</a></p>

{% if (docsPrefix == "pe/") %}
#### ThingsBoard 作为 Google IoT Core 的替代方案

<p><a href="/google-iot-core-alternative" class="button">了解更多信息</a></p>

{% endif %}