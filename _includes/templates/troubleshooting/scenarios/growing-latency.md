有时您可能会遇到规则引擎内消息处理延迟不断增加的情况。以下是可以采取的步骤来找出问题的原因：
- 检查 [规则引擎统计信息仪表板](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics) 中是否存在超时。规则节点中的超时会减慢队列的处理速度，并可能导致延迟。

- 检查以下服务的 [CPU 使用情况](#cpumemory-usage)：
    - GridLinks 服务（tb-nodes、tb-rule-engine 和 tb-core 节点、传输节点）。某些服务上的高 CPU 负载意味着您需要扩展该部分系统。
    - PostgreSQL 和 pgpool（如果您处于<b>高可用性</b>模式）。Postgres 上的高负载可能导致所有与 Postgres 相关的规则节点（保存属性、读取属性等）以及整个系统的处理速度变慢。
    - Cassandra（如果您使用 Cassandra 作为时序数据存储）。Cassandra 上的高负载可能导致所有与 Cassandra 相关的规则节点（保存时序等）的处理速度变慢。
    - 队列。无论队列类型如何，请确保它始终有足够的资源。

- 检查 [消费者组滞后](#consumer-group-message-lag-for-kafka-queue)（如果您使用 Kafka 作为队列）。

- 启用 [消息包处理日志](#message-pack-processing-log)。它将允许您看到最慢的规则节点的名称。

- 通过不同的队列分离您的用例。如果您的某些设备组应与其他设备分开处理，则应为此组 [配置](/docs/{{docsPrefix}}user-guide/device-profiles/#queue-name) 单独的规则引擎队列。此外，您还可以根据某些逻辑将消息分离到根规则引擎内的不同队列中。通过这样做，您可以保证一个用例的处理速度慢不会影响另一个用例的处理。