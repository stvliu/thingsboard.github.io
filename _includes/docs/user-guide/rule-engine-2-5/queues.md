* TOC
{:toc}

#### 简介

ThingsBoard 平台使用队列来保证消息处理、处理偶尔的峰值，并在极端负载下保持系统正常运行。
您可以查看架构以找到有关队列的更多信息(/docs/{{docsPrefix}}reference/#message-queues-are-awesome)。
ThingsBoard 支持著名的消息代理/队列提供商（Kafka、RabbitMQ、AWS SQS、Azure Service Bus、Google Pub/Sub）。
在以后的版本中，我们将添加新的实现。
随着平台的 3.4 版本，引入了配置 UI 以简化设置和管理过程并改善用户体验。
简而言之，规则引擎在启动时订阅队列并轮询新消息。
始终有 **Main** 主题（队列），用作新消息的默认入口点。
可以使用 **Checkpoint** 节点将消息放入其他主题。
后者自动确认目标主题中的相应消息。

#### 队列配置

只有 **系统管理员** 用户才能配置队列。
配置后，新更改将立即应用。
队列有两个配置配置文件：**通用队列配置**和**隔离租户的队列配置**。
要详细了解隔离租户，请阅读[租户配置文件](/docs/{{docsPrefix}}user-guide/tenant-profiles/#processing-in-isolated-thingsboard-rule-engine-queues)文档。

##### 通用队列配置

开箱即用，所有消息（如遥测、连接或生命周期事件等）都会推送到 **Main** 或选择为默认值的另一个主题。
当隔离处理被禁用（默认）时，ThingsBoard 将所有租户的消息放入一个公共主题。优点：这种方法更具成本效益；无需管理额外的虚拟机或容器。缺点：所有租户共享一个规则引擎服务。

要创建新队列，请按照以下步骤操作：
- 以系统管理员身份登录；
- 导航到 **设置** 页面中的 **队列** 选项卡；
- 单击“加号”按钮以创建新队列。

{% if docsPrefix == null %}
![image](/images/user-guide/queues/add-queue-1-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/queues/add-queue-1-pe.png)
{% endif %}

- 输入队列名称。选择策略类型并配置重试处理设置和轮询设置。单击添加。

{% if docsPrefix == null %}
![image](/images/user-guide/queues/add-queue-2-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/queues/add-queue-2-pe.png)
{% endif %}

您已创建自定义队列。

{% if docsPrefix == null %}
![image](/images/user-guide/queues/add-queue-3-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/queues/add-queue-3-pe.png)
{% endif %}

{% capture difference %}
**注意**：
<br>
可以调整 **Main** 队列设置，但主题本身不能重命名或删除。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### 隔离租户的队列配置

为了您的方便，此配置与隔离租户[文档](/docs/{{docsPrefix}}user-guide/tenant-profiles/#queue-configuration-for-isolated-tenants)放在一起。

#### 队列设置

队列的定义由以下参数和模块组成：

* **名称** - 用于统计和日志记录；
* [提交设置](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#submit-settings) - 定义将消息提交给规则引擎的逻辑和顺序；
* [重试处理设置](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#retries-processing-settings) - 定义消息确认的逻辑；
* [轮询设置](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#polling-settings) - 批量和立即处理的队列设置。

##### 提交设置

规则引擎服务不断轮询特定主题的消息，一旦消费者返回消息列表，它就会创建 TbMsgPackProcessingContext 对象。队列提交策略控制如何将 TbMsgPackProcessingContext 中的消息传递给规则链。
有 5 种可用策略：

* **按发起者顺序** - 消息对特定实体（消息的发起者）逐个提交。例如，在对设备 A 的上一条消息确认之前，不会提交设备 A 的新消息。
* **按租户顺序** - 消息在租户（消息发起者的所有者）内按顺序提交。例如，在对租户 A 的上一条消息确认之前，租户 A 的新消息不会离开队列。
* **顺序** - 消息一个接一个地提交。在确认上一条消息之前不会提交新消息。这使得处理非常缓慢。
* **突发** - 所有消息按到达顺序提交给规则链。
* **批处理** - 使用 **分组参数“批处理大小”**将消息分组到批处理中。在确认上一批之前不会提交新批处理。

请参阅此[指南](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/queues-for-synchronization/)作为提交策略用例的示例。

##### 重试处理设置

处理策略控制如何重新处理失败或超时的消息。有 5 种可用策略：

* **重试失败和超时** - 重试处理包中的所有失败和超时消息。
* **跳过所有故障** - 简单地忽略所有故障。将导致丢失失败的消息。
例如，如果数据库宕机，消息将不会被持久化，但仍将被标记为“已确认”并从队列中删除。
此策略主要为向后兼容以前的版本和开发/演示环境而创建。
已提交给规则链以进行处理的超时消息不会被取消。
这意味着规则引擎仍将尝试处理它们，尽管超时。
* **跳过所有故障和超时** - 简单地忽略所有故障和超时。将导致丢失失败和超时消息。
例如，如果数据库宕机，消息将不会被持久化，但仍将被标记为“已确认”并从队列中删除。
已提交给规则链以进行处理的超时消息将被取消。
规则节点不会启动已取消消息的处理。但是，在消息被取消之前开始处理消息的规则节点不会中断。
* **重试所有** - 重试处理包中的所有消息。假设处理包包含 100 条消息。
如果 100 条消息中有 1 条失败，策略仍将重新处理（重新提交给规则引擎）100 条消息。
每次策略将消息重新提交给规则引擎时，这些消息都是原始消息的二进制副本。
在重新提交之前，将取消上次提交的所有消息。
规则节点不会启动已取消消息的处理。但是，在消息被取消之前开始处理消息的规则节点不会中断。
* **重试失败** - 重试处理包中的所有失败消息。假设处理包包含 100 条消息。
如果 100 条消息中有 1 条失败，策略将仅重新处理（重新提交给规则引擎）1 条消息。不会重新处理超时消息。
每次策略将消息重新提交给规则引擎时，这些消息都是原始消息的二进制副本。
在重新提交之前，将取消上次提交的所有消息。
规则节点不会启动已取消消息的处理。但是，在消息被取消之前开始处理消息的规则节点不会中断。
* **重试超时** - 重试处理包中的所有超时消息。假设处理包包含 100 条消息。
如果 100 条消息中有 1 条超时，策略将仅重新处理（重新提交给规则引擎）1 条消息。不会重新处理失败的消息。
每次策略将消息重新提交给规则引擎时，这些消息都是原始消息的二进制副本。
在重新提交之前，将取消上次提交的所有消息。
规则节点不会启动已取消消息的处理。但是，在消息被取消之前开始处理消息的规则节点不会中断。

所有重试处理策略都支持重要的配置参数：

* **重试次数** - 迭代次数，0 表示无限；
* **跳过重试的失败消息百分比** - 如果失败或超时少于 X 百分比的消息，则跳过重试；
* **重试间隔** - 在重试之前在消费者线程中等待的时间（以秒为单位）；
* **其他重试间隔** - 第二次及后续重试尝试的等待时间（以秒为单位）。

请参阅此[指南](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/queues-for-message-reprocessing/)作为处理策略用例的示例。

##### 轮询设置

批量处理：
* **轮询间隔** - 如果没有新消息到达，则轮询消息之间的持续时间（以毫秒为单位）。
* **分区** - 与此队列关联的分区数。用于扩展可以并行处理的消息数。

立即处理：
* **为每个消费者发送消息轮询** - 队列由分区组成。如果取消选中该复选框，则所有分区都有一个消费者。如果选中，每个分区将有单独的消费者。
* **处理间隔** - 消费者返回的特定消息包的处理间隔（以毫秒为单位）。

##### 自定义属性

您可以为队列（主题）创建指定自定义属性。它们特定于队列提供程序，
例如 Kafka 的 `retention.ms:604800000;retention.bytes:1048576000`，
或 AWS SQS 的 `MaximumMessageSize:262144;MessageRetentionPeriod:604800` 等。

请注意，这些属性仅在首次创建队列时应用。

#### 默认队列

配置了三个默认队列：Main、HighPriority 和 SequentialByOriginator。
它们根据提交和处理策略而有所不同。
基本上，规则引擎处理来自 **Main** 主题的消息，并可以选择使用“Checkpoint”规则节点将它们放入其他主题。
默认情况下，Main 主题简单地忽略失败的消息。这是为了向后兼容以前的版本。
但是，您可以自行承担风险重新配置此设置。
请注意，如果由于规则节点脚本中出现某些故障而导致一条消息未被处理，则可能会阻止处理下一条消息。
我们设计了特定的[仪表板](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics)来监控规则引擎的处理和故障。

**HighPriority** 主题可用于传递警报或其他关键处理步骤。
HighPriority 主题中的消息在发生故障时会不断重新处理，直到消息处理成功。
如果您遇到 SMTP 服务器或外部系统中断，这将非常有用。规则引擎将重试发送消息，直到它被处理。

**SequentialByOriginator** 主题很重要，如果您想确保消息按正确顺序处理。
来自同一实体的消息将按它们在队列中到达的顺序进行处理。
在确认同一实体 ID 的上一条消息之前，规则引擎不会将新消息提交给规则链。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}