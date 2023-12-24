* TOC
{:toc}

MQTT 代理的基本属性包括接收客户端发布的消息，根据主题对其进行过滤，然后将其分发给订阅者。
此过程非常重要，尤其是在处理大量工作负载时。
在本文中，我们将说明为确保 TBMQ 能够同时容纳大约 **100M** 个连接的客户端，并有效管理每秒 **3M MQTT 发布消息** 的流入和流出而采取的措施。

![image](/images/mqtt-broker/reference/perf-tests/mqtt-broker-perf-tests.png)

### 测试方法

我们选择亚马逊网络服务 (AWS) 作为进行性能测试的目标云提供商。
我们在 [EKS](https://aws.amazon.com/eks/) 集群（在一个 EC2 实例或节点上部署 1 个代理 pod）中部署了 25 个节点的 TBMQ 集群，并连接到 [RDS](https://aws.amazon.com/rds/) 和 [Kafka](https://kafka.apache.org/)。
有关 TBMQ 架构的全面了解，请参阅后续 [页面](/docs/mqtt-broker/architecture/)。
RDS 已部署为单个实例，而 Kafka 设置由分布在 3 个不同可用区 (AZ) 中的 9 个代理组成。

各种物联网设备配置文件根据它们产生的消息数量和每条消息的大小而有所不同。
我们模拟了发送具有五个数据点的消息的智能跟踪器设备。
单个“发布”消息的大小约为 **114 字节**。
您可以在下面看到模拟的消息结构，与实际测试案例有一些差异，因为测试代理会生成有效负载值。
```json
{ "lat": 40.761894, "long": -73.970455, "speed": 55.5, "fuel": 92, "batLvl": 81 }
```

发布者被组织成 500 个不同的组，总共产生 200k 个发布者和每个组 6k msg/s。
每个组负责将数据传输到其指定的主题模式，该模式遵循 `CountryCode/RandomString/GroupId/ClientId` 格式。
因此，发布者正在使用广泛的 **100M** 个唯一主题。
同时，配置了 500 个订阅者组，每个组都具有一个 `APPLICATION` 订阅者。
这些订阅者使用的主题过滤器与各自发布者组使用的主题模式相对应（即 `CountryCode/RandomString/GroupId/+`）。
因此，每个订阅者每秒能够接收 6k 条消息，确保有效处理传入的数据。

在所述场景中，TBMQ 集群始终维持 100,000,500 个连接，并有效处理每秒 3M 条消息，在 1 小时的测试运行过程中总共产生 10,800M 条消息。

[测试代理](#how-to-repeat-the-tests) 编排 MQTT 客户端的配置和建立，允许灵活配置其数量。
这些客户端持续运行，通过 MQTT 将时序数据不断发布到指定主题。
此外，该代理有助于配置 MQTT 客户端，这些客户端通过主题过滤器订阅上述客户端发布的消息。

考虑到客户端的预热阶段，值得注意的是，发布者发送单个消息的 6 次迭代已经发生。
因此，在 ~7 分钟内生成了总共 600M 条预热消息。
这些预热消息用于准备系统并启动数据流。
除了预热阶段外，整个测试总共处理了 11,400M 条消息。
此数字包含预热消息以及在整个测试期间生成和处理的后续消息。

如此大量的数据约为 1TB，存储在标记为 `tbmq.msg.all` 的初始 Kafka 主题中。
每个单独的订阅者被配置为 APPLICATION 订阅者，在 Kafka 中有其专用的主题，在该主题中它总共收到 22.8M 条消息以供进一步处理和分析。
值得注意的是，通过配置 500 个订阅者，数据收集过程仅依赖于 Kafka，而不涉及 Postgres。
这是因为只有归类为 `APPLICATION` 的持久客户端包含在当前配置设置中。

**提示**：要规划和管理 Kafka 磁盘空间，请调整 [大小保留策略](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes) 和 [时间段保留策略](https://www.baeldung.com/kafka-message-retention)。
有关与每个主题关联的配置的详细信息，请参阅 [配置](/docs/mqtt-broker/install/config/) 文档。

每个单独的 MQTT 客户端都与代理建立单独的连接。
这种方法确保每个客户端独立运行并维护其专用的连接，以便与代理进行无缝通信。

### 使用的硬件

| 服务名称              | **TBMQ**  | **AWS RDS (PostgreSQL)** | **Kafka**   |
|---------------------------|-----------|--------------------------|-------------|
| 实例类型             | m6g.metal | db.m6i.large             | m6a.2xlarge |
| 内存 (GiB)              | 256       | 8                        | 32          |
| vCPU                      | 64        | 2                        | 8           |
| 存储 (GiB)             | 10        | 100                      | 500         |
| 网络带宽 (Gibps) | 25        | 12.5                     | 12.5        |

[comment]: <> ( 要将表格格式化为 Markdown，请使用在线表格生成器 https://www.tablesgenerator.com/markdown_tables )

### 测试总结

客户端的连接速度达到每秒约 22k 个连接的显着水平，这表明设置高效。
为了确保随着时间的推移不会出现任何资源泄漏或性能下降，测试执行了一个小时，以便进行彻底的观察和分析。

以每秒发布 3M 条消息的速度，包括预热消息，在整个测试过程中总共处理了 11,400M 条消息，产生了大约 1TB 的惊人入站和出站吞吐量。
如此大量的数据展示了 TBMQ 的可扩展性和处理能力。
为了保持高水平的可靠性和消息传递保证，为发布者和订阅者都采用了 MQTT 服务质量 (QoS) 级别 **1**，特别是 `AT_LEAST_ONCE`。
此 QoS 级别确保消息至少传递一次，从而确保数据完整性和一致性。

考虑到测试的全面范围，回顾一张总结了进行的测试的关键要素和结果的信息表将是有益的。

| 设备 | Msgs/sec | 代理 CPU | 代理内存 | Kafka CPU | Kafka 读/写吞吐量 | PostgreSQL CPU | PostgreSQL 读/写 IOPS |
|---------|----------|------------|---------------|-----------|-----------------------------|-----------------|----------------------------|
| 100M    | 3M       | 45%        | 160GiB        | 58%       | 7k / 80k KiB/s              | 2%              | 小于 1 / 小于 3  |

以下统计数据提供了对测试期间使用的 Kafka 主题的见解
（即 `publish_msg`，在 [Kafka 主题重命名 [1]](https://github.com/thingsboard/tbmq/commit/8871403fcfdce3489ee2a49c1505b998ceb46c3c#diff-85b2fafc998caf1c7d67f51c40f5639ac9ee0ee68379e07ad2f63b083f010f13) `tbmq.msg.all` 之后，是所有消息存储在其中的主要 Kafka 主题，以及 APPLICATION 订阅者接收数据的应用程序主题的几个示例）。

{% include images-gallery.html imageCollection="broker-topics-monitoring" %}

值得强调的是，提供的信息表明在处理所有消息时成功率为 100%。
`publish_msg` 和应用程序主题包含压缩数据，因为生产者正在发送压缩数据，而 Kafka 代理保留生产者设置的原始压缩编解码器（`compression.type` 属性）。
这种方法确保有效的数据存储和传输，同时保持消息的完整性和原始压缩设置。

我们现在应该将注意力转向消息处理延迟的问题。
您可以在下面找到包含基本统计数据的表格，这些统计数据阐明了评估的这一关键方面。

| 消息延迟平均值 | 消息延迟第 95 个百分位 | 发布确认平均值 | 发布确认第 95 个百分位 |
|-----------------|------------------|-------------|--------------|
| 195 毫秒          | 295 毫秒           | 23 毫秒       | 55 毫秒        |

其中，“消息延迟平均值”表示从发布者发送消息到订阅者接收消息的时刻开始的平均持续时间，“发布确认平均值”表示从发布者发送消息到接收到 `PUBACK` 确认的时刻经过的平均时间，第 95 个百分位是延迟统计数据的第 95 个百分位。

**经验教训**

当前配置中的 TBMQ 集群能够处理更大的负载。Kafka 提供可靠且高可用性的消息处理。
在这种情况下，使用 `APPLICATION` 订阅者和测试的性质导致 PostgreSQL 的负载很小，每秒只执行少量操作。
TBMQ 节点之间没有直接通信，这有助于水平扩展以实现上述结果。
尽管采用 QoS 级别 0 会进一步提高消息速率，但我们的目的是通过更实用的设置来展示 TBMQ 的处理能力。
通常，QoS 级别 1 广受欢迎，因为它在消息传递速度和可靠性之间取得了平衡，使其成为一种流行的配置选择。
TBMQ 是低消息速率和高消息速率的绝佳选择。
它在各种处理案例中表现出色，例如扇入和扇出场景，并且同样适用于各种规模的部署。
由于其垂直和水平扩展的固有能力，该代理可以适应小规模或大规模部署的需求。

**测试期间遇到的挑战**

在追求如此大量连接和数据流的过程中，我们遇到了各种需要在代码优化方面付出一些努力的情况。

其中一个例子涉及解决 Kafka 生产者断开连接的问题，这导致了消息丢失的不良后果。
为了解决这个问题，我们实现了一个专门的执行器服务，用于处理 Kafka 生产者的发布 [回调[2]](https://github.com/thingsboard/tbmq/commit/4e8e6d8a2f9855c7df88074efc935cb7d19f593d)。
此措施有效地解决了上述断开连接的问题。

为了进一步提高性能，我们 [消除了对专用发布队列的需要[3]](https://github.com/thingsboard/tbmq/commit/443e260924e214ae89b0158a6369b06f38801bd0) 通过利用 Kafka 生产者的固有线程安全特性。
这种调整在整体系统效率方面产生了额外的好处，因为消息排序保证是以另一种方式实现的。

引入了其他调整来提高处理速度，正如与改进相关的提交所证明的那样 [消息包处理，UUID 生成[4]](https://github.com/thingsboard/tbmq/commit/47e674589269bb45291f471528c54370ebdaf7ed)，以及采用一种发送消息的机制 [无需显式刷新[5]](https://github.com/thingsboard/tbmq/commit/3ec317072dead5cb5355d29dd7319ccde3403d04)。

为了优化内存利用率并最大限度地减少不必要的垃圾创建，我们付出了大量努力来改善整体内存使用情况。
这些增强 [6](https://github.com/thingsboard/tbmq/commit/56ede8e5ebbaa8deafd24b7a0d4050401835ebc0)，
[7](https://github.com/thingsboard/tbmq/commit/395d48917be0186fafbdfa12c0a9b145b66f31d2)，
[8](https://github.com/thingsboard/tbmq/commit/fa424ffc32837b4d4aa48b890eb3bc06908a7476)
不仅有助于提高垃圾回收器性能，还减少了停止世界暂停，从而提高了整体系统响应能力。

在我们稍后的更大规模测试阶段，我们观察到客户端在代理节点之间的分布不均匀。
这导致特定代理节点的工作负载不成比例，这对发布者来说造成的问题很小，但对 APPLICATION 客户端产生了显着影响，需要更多实质性的资源利用。
这导致一个代理节点处理的请求比其他代理节点多得多。
为了解决这个问题，我们设计了一种机制来确保 [客户端在代理节点之间均匀分布[9]](https://github.com/thingsboard/tb-mqtt-perf-tests/commit/bd7649a9321f56f68303b380e634617fa0abc098)，以及其他一些次要的性能改进。

通过这些勤奋的努力，我们成功地解决了沿途遇到的各种挑战，优化了代码性能并确保了系统的平稳高效运行。

### TCO 计算

在此您可以找到使用 AWS 部署的 TBMQ 的总拥有成本 (TCO) 计算。

**重要通知**：以下提供的所有计算和定价都是近似值，仅用于说明目的。
为了获得准确的定价信息，强烈建议您咨询您各自的云服务提供商。
例如，AWS 提供了节省成本的机会，例如 [储蓄计划](https://aws.amazon.com/savingsplans/)（最高可享受 72% 的折扣）、
[RDS 预留实例](https://aws.amazon.com/rds/reserved-instances/)（最高可享受 69% 的折扣）、
[MSK 分层存储](https://aws.amazon.com/about-aws/whats-new/2022/10/amazon-msk-offers-low-cost-storage-tier-scales-virtually-unlimited-storage/)（50% 或更多），以及许多其他选项。

美国东部 1 地区的 AWS EKS 集群。大约价格为每月 73 美元。

AWS 实例类型：25 个 m6g.metal 实例（64 个 vCPU AWS Graviton2 处理器，256 GiB，EBS GP3 10GiB）用于托管 25 个 TBMQ 节点。大约价格为每月 23,800 美元。

AWS RDS：db.m6i.large（2 个 vCPU，8 GiB），100GiB 存储。大约价格为每月 100 美元。

AWS MSK：9 个代理（每个 AZ 3 个代理）x m6a.2xlarge（8 个 vCPU，32 GiB），总存储量为 4,500GiB。大约价格为每月 2,600 美元。

**TCO**：每月约 26,573 美元或每月每台设备 0.0003 美元。

### 运行测试

**负载配置：**

* 100M 发布 MQTT 客户端（智能跟踪器设备）；
* 500 个持久订阅 MQTT 客户端（消耗数据的特定应用程序 - 例如用于分析/图形）；
* 每秒超过 MQTT 的 3M 消息，每条 MQTT 消息包含 5 个数据点，消息大小为 114 字节；
* PostgreSQL 数据库用于存储 MQTT 客户端凭据、客户端会话状态；
* Kafka 队列用于持久化消息。

如前所述，上述消息速率和消息大小导致每小时大约 **~1TB** 的数据存储在初始 Kafka 主题中，以及每小时大约 **~1.6GB** 的数据存储在每个订阅者主题中。

但是，没有必要将数据存储很长时间以用于可视化、分析或其他目的。
TBMQ 负责接收消息、在订阅者之间分发消息，并根据需要将消息临时存储以供离线客户端使用。
因此，建议根据您的具体要求配置适当的存储大小。
此外，提醒您，必须为 Kafka 主题配置大小保留策略和保留期策略。

测试代理表示性能测试节点（运行器）的集群和监督这些运行器的编排器。
为了履行运行器的角色，我们部署了 2000 个发布者和 500 个订阅者 Kubernetes pod，而单个 pod 充当编排器。

通过利用 JSON 配置，我们能够分别指定发布者和订阅者，将它们组织成组以实现更灵活的控制。
现在让我们检查发布者和订阅者的配置。

发布者组：
```json
{
    "id":1,
    "publishers":200000,
    "topicPrefix":"usa/ydwvv/1/",
    "clientIdPrefix":null
}
```
{: .copy-code}
其中
* _id_ - 发布者组的标识符；
* _publishers_ - 组中的发布者客户端数量；
* _topicPrefix_ - 分别发布消息的主题前缀；
* _clientIdPrefix_ - 发布者的客户端 ID 前缀。

订阅者组：
```json
{
    "id":1,
    "subscribers":1,
    "topicFilter":"usa/ydwvv/1/+",
    "expectedPublisherGroups":[1],
    "persistentSessionInfo":{
        "clientType":"APPLICATION"
    },
    "clientIdPrefix":null
}
```
{: .copy-code}
其中
* _id_ - 订阅者组的标识符；
* _subscribers_ - 组中的订阅者客户端数量；
* _topicFilter_ - 分别订阅的主题过滤器；
* _expectedPublisherGroups_ - 当前订阅者将接收其消息的发布者组的 id 列表（参数用于调试和统计目的）；
* _persistentSessionInfo_ - 包含 [客户端类型](/docs/mqtt-broker/user-guide/mqtt-client-type/) 的持久信息对象；
* _clientIdPrefix_ - 订阅者的客户端 ID 前缀。

**测试运行**

测试从在客户端和集群之间建立连接开始。`APPLICATION` 客户端订阅相关主题，而发布者则经历预热阶段。
100,000,500 个客户端在性能测试 pod 之间均匀分布，便于与代理建立并行连接。

一段时间后，所有客户端都成功建立连接，每个性能测试 pod 都通知编排器其已准备就绪。

为了评估进度，我们可以检查 `client_session`（在 [Kafka 主题重命名 [1]](https://github.com/thingsboard/tbmq/commit/8871403fcfdce3489ee2a49c1505b998ceb46c3c#diff-85b2fafc998caf1c7d67f51c40f5639ac9ee0ee68379e07ad2f63b083f010f13) `tbmq.client.session`) 之后）Kafka 主题。
此主题提供了连接会话的近似计数。

![image](/images/mqtt-broker/reference/topics/100m-mqtt-clients.png)

一旦所有运行器都准备就绪，编排器就会通知集群已准备就绪并开始发布消息。

```text
09:12:35.407 [main] INFO  o.t.m.b.tests.MqttPerformanceTest - Start msg publishing.
```

经过一段时间的处理，我们可以评估在测试期间使用的监控工具，例如 JMX、Grafana 和 [Kafka UI](https://github.com/redpanda-data/console)，以及 AWS CloudWatch 以获得更全面的见解。
经过检查，我们观察到有利的结果。
已发布和已消费的消息正在处理，没有任何明显的延迟。
应用程序处理器有效地将消息传递给订阅者，确保平稳和不间断的流程。
此外，所有 100,000,500 个客户端都与代理保持稳定的连接。

{% include images-gallery.html imageCollection="broker-grafana-monitoring" %}

AWS 实例（其中部署了 TBMQ 节点）的监控显示平均 CPU 负载约为 45%。
另一方面，AWS RDS 资源没有被利用，因为没有 DEVICE 持久客户端，并且每秒只发送少量请求。
与此同时，Kafka 监控表明有更多可用资源，这表明它可以在必要时处理更高的负载。

{% include images-gallery.html imageCollection="broker-aws-monitoring" %}

最后，让我们检查 TBMQ 的 JVM 状态。
要做到这一点，我们必须转发 JMX 端口以建立连接并监视 Java 应用程序。

```bash
kubectl port-forward tb-broker-0 9999:9999
```
{: .copy-code}

要继续，请打开 [VisualVM](https://visualvm.github.io/) 并添加本地应用程序。
添加后，打开它并允许收集数据几分钟。
以下是 TBMQ 的 JMX 监控。代理节点运行稳定，没有任何显着问题。

{% include images-gallery.html imageCollection="broker-jmx-monitoring" %}

### 如何重复测试

请参阅后续 [安装指南](/docs/mqtt-broker/install/cluster/aws-cluster-setup/) 以了解如何在 AWS 上部署 TBMQ。
此外，您可以探索 [分支](https://github.com/thingsboard/tbmq/tree/100M/k8s/aws#readme) 
其中包含用于在性能测试期间运行 TBMQ 的脚本和参数。
最后，[性能测试工具](https://github.com/thingsboard/tb-mqtt-perf-tests/tree/100M) 可用于进行性能测试，
它生成 MQTT 客户端并产生负载。
为了配置性能测试，您可以查看和修改
[发布者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/100M/k8s/broker-tests-publishers-config.yml) 和
[订阅者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/100M/k8s/broker-tests-subscribers-config.yml) 
的配置文件以模拟所需的负载。

### 结论

此性能测试证明了 TBMQ 集群在有效接收、处理和分发来自不同设备的每秒 3M 条消息以及处理 100M 个并发连接方面的能力。
我们致力于持续改进，促使我们进一步努力提高性能。
因此，我们预计在不久的将来发布 TBMQ 集群的更新性能结果。
我们衷心希望本文对评估 TBMQ 的个人和希望在其自己的环境中进行性能测试的人员有价值。

您的反馈非常宝贵，我们鼓励您通过关注我们
[GitHub](https://github.com/thingsboard/tbmq) 和 [Twitter](https://twitter.com/thingsboard) 来与我们的项目保持联系。

### 参考提交

[1] - [Kafka 主题重命名](https://github.com/thingsboard/tbmq/commit/8871403fcfdce3489ee2a49c1505b998ceb46c3c#diff-85b2fafc998caf1c7d67f51c40f5639ac9ee0ee68379e07ad2f63b083f010f13)。

[2] - [Kafka 生产者回调](https://github.com/thingsboard/tbmq/commit/4e8e6d8a2f9855c7df88074efc935cb7d19f593d)。

[3] - [停止将发布消息添加到队列](https://github.com/thingsboard/tbmq/commit/443e260924e214ae89b0158a6369b06f38801bd0)。

[4] - [消息包处理、UUID 生成改进](https://github.com/thingsboard/tbmq/commit/47e674589269bb45291f471528c54370ebdaf7ed)。

[5] - [发送消息而不刷新](https://github.com/thingsboard/tbmq/commit/3ec317072dead5cb5355d29dd7319ccde3403d04)。

[6] - [ClientSessionInfo 对象重用](https://github.com/thingsboard/tbmq/commit/56ede8e5ebbaa8deafd24b7a0d4050401835ebc0)。

[7] - [删除应用程序发布消息副本](https://github.com/thingsboard/tbmq/commit/395d48917be0186fafbdfa12c0a9b145b66f31d2)。

[8] - [发布消息中的 Bytebuf](https://github.com/thingsboard/tbmq/commit/fa424ffc32837b4d4aa48b890eb3bc06908a7476)。

[9] - [MQTT 客户端在代理节点之间均匀分布](https://github.com/thingsboard/tb-mqtt-perf-tests/commit/bd7649a9321f56f68303b380e634617fa0abc098)。