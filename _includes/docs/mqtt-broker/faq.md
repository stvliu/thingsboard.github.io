* TOC
{:toc}


### TBMQ 是什么？

TBMQ 是由 ThingsBoard 开发的开源软件产品，旨在促进 MQTT 客户端之间的通信。
此特定产品可免费用于个人和商业用途，并且具有可在任何所需位置部署的灵活性。
对于刚开始使用代理的新手，我们建议查阅综合资源，即
[what-is-tbmq](/docs/mqtt-broker/getting-started-guides/what-is-thingsboard-mqtt-broker/) 和
[入门指南](/docs/mqtt-broker/getting-started/)，以便全面了解其功能。
可以在专用页面上找到更多详细信息，其中提供了大量其他信息。

### 如何开始？

我们建议使用 Docker 在您的笔记本电脑或 PC 上本地[安装](/docs/mqtt-broker/install/installation-options/) TBMQ，
并按照[入门指南](/docs/mqtt-broker/getting-started/)进行操作。

### 我可以使用 TBMQ 做什么？

TBMQ 便于建立 MQTT 客户端之间的连接，从而实现数据的无缝交换。
此外，它还为各种 MQTT 功能提供了强大的支持，增强了系统的整体功能和多功能性。

### 我可以在哪里托管 TBMQ？

TBMQ 的托管选项非常灵活，您可以从基于云的环境、本地设置中进行选择，
甚至可以在您的个人笔记本电脑或 PC 上本地运行它。
为了启动设置过程，我们建议选择[Docker 安装](/docs/mqtt-broker/install/docker/)，它提供了一种简化且高效的方法。
如果您有兴趣配置集群设置，则提供了全面的[指南](/docs/mqtt-broker/install/cluster/docker-compose-setup/)，专门针对 Docker Compose 设置而设计。

### 安全性如何？

支持使用 SSL 加密的 MQTT，确保安全且加密的通信。
此外，还可以创建 MQTT 客户端凭据，从而能够对客户端进行身份验证和授权，
从而增强系统的整体安全性和控制力。

### TBMQ 每秒可以支持多少个客户端和消息？

TBMQ 具有水平可扩展性，这意味着它可以无缝扩展以适应不断增长的需求。
集群中的每个代理或节点都具有相同的功能，并处理特定子集的数据。
值得注意的是，系统的实际性能取决于具体的使用场景，
有效载荷大小和消息速率等因素在确定系统的整体效率和吞吐量方面起着至关重要的作用。
为了全面了解 TBMQ 的性能能力，我们建议参考专门的
[性能测试页面](/docs/mqtt-broker/reference/100m-connections-performance-test/)。

### TBMQ 在哪里存储数据？

数据存储在 [PostgreSQL](https://www.postgresql.org/) 数据库和 [Kafka](https://kafka.apache.org/) 中。

### TBMQ 使用什么类型的许可证？

TBMQ 采用 Apache 2.0 许可证。它可免费用于个人和商业用途，您可以在任何地方部署它。

### 如何获得支持？

您可以使用故障排除说明和社区资源，或[联系我们](/docs/contact-us)并详细了解我们提供的[服务](/docs/services/)。