GridLinks 能够使用各种消息系统/代理来存储消息和 GridLinks 服务之间的通信。如何选择正确的队列实现？

**内存**队列实现不适用于任何类型的集群部署。

* **Kafka** 推荐用于生产部署，并且默认使用。此队列现在用于大多数 ThingsBoard 生产环境。它对本地部署和私有云部署都很有用。如果您希望保持独立于云提供商，它也很有用。但是，一些提供商也为 Kafka 提供托管服务。例如，请参阅 AWS [MSK](https://aws.amazon.com/msk/)。

* **RabbitMQ** 推荐用于负载不大的情况，并且您已经拥有此消息系统的经验。

* **AWS SQS** 是 AWS 的全托管消息队列服务。如果您计划在 AWS 上部署 ThingsBoard，则很有用。

* **Google Pub/Sub** 是 Google 的全托管消息队列服务。如果您计划在 Google Cloud 上部署 ThingsBoard，则很有用。

* **Azure Service Bus** 是 Azure 的全托管消息队列服务。如果您计划在 Azure 上部署 ThingsBoard，则很有用。

* **Confluent Cloud** 是一个基于 Kafka 的全托管流媒体平台。适用于云无关的部署。

有关更多详细信息，请参阅相应的架构[页面](/docs/reference/#message-queues-are-awesome)和规则引擎[页面](/docs/user-guide/rule-engine-2-5/queues/)。