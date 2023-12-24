如果您对某些规则引擎队列使用 `RETRY_ALL, RETRY_FAILED, RETRY_TIMED_OUT` 或 `RETRY_FAILED_AND_TIMED_OUT` 策略，则某些失败的节点可能会阻止此队列中消息的整个处理过程。

以下是可以查找问题原因的方法：

- 分析 [规则引擎统计信息仪表板](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics)。您可以在此处找出某些消息是否失败或超时。此外，您还可以在仪表板的底部找到规则引擎内异常的描述，其中包含有问题的规则节点的名称。

- 找出哪个规则节点失败后，您可以 [启用 DEBUG](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#debugging) 并查看哪些消息导致规则节点失败，然后查看详细的错误描述。

**提示：**通过创建单独的队列，将不稳定的测试案例与其他规则引擎分开。在这种情况下，故障只会影响此单独队列的处理，而不会影响整个系统。您可以使用 [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/#queue-name) 功能为设备自动配置此逻辑。

**提示：**处理连接到某些外部服务（REST API 调用、Kafka、MQTT 等）的所有规则节点的<b>故障</b>事件。这样，您可以保证在外部系统发生故障时，规则引擎处理不会停止。您可以将失败的消息存储在数据库中，发送一些通知或只是<b>记录</b>消息。