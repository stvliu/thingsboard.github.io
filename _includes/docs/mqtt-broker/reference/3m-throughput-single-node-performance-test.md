* TOC
{:toc}

在 MQTT 代理的背景下，在高工作负载期间的最佳性能至关重要。
本文探讨了 TBMQ 的最新性能测试，我们检查了它以个位数毫秒的延迟处理每秒 **300 万条消息** 的惊人吞吐量的能力。
我们仅使用一个节点，就突破了 TBMQ 的功能限制。

![image](/images/mqtt-broker/reference/single-node-test/tbmq-perf-test-diagram.png)

### 测试方法

我们通过在 [EKS](https://aws.amazon.com/eks/) 集群中部署一个 TBMQ 节点以及 3 个 [Kafka](https://kafka.apache.org/) 节点和一个 [RDS](https://aws.amazon.com/rds/) 实例来建立性能测试环境。此设置作为我们性能测试的基础。

在此测试中，我们引入了 100 个发布者，每个发布者负责每秒发布 10 条消息。
重要的是，每个发布者都在自己的主题上发布消息，遵循模式“`CountryCode/City/ID`”，其中“`ID`”是每个发布者的唯一标识符。
单个“发布”消息的大小约为 66 个字节。这种方法使我们能够模拟各种数据源。

为了评估 TBMQ 有效分发消息的能力，我们引入了一个由 3,000 个订阅者组成的网络。
每个订阅者都订阅主题过滤器“`CountryCode/City/#`”，表示他们有兴趣接收来自所有发布者的所有已发布消息。这种广泛的消息分发对代理的功能进行了测试。

在 30 分钟的性能测试期间，我们希望测试 TBMQ 是否能够证明其持续管理大量消息负载的能力，而不会遇到任何性能下降或资源耗尽的情况。

### 使用的硬件

| 服务名称              | **TBMQ**    | **AWS RDS (PostgreSQL)** | **Kafka** |
|---------------------------|-------------|--------------------------|-----------|
| 实例类型             | m7a.8xlarge | db.m6i.large             | m7a.large |
| vCPU                      | 32          | 2                        | 2         |
| 内存 (GiB)              | 128         | 8                        | 8         |
| 存储 (GiB)             | 10          | 30                       | 50        |
| 网络带宽 (Gibps) | 12.5        | 12.5                     | 12.5      |

[comment]: <> ( 要将表格格式化为 markdown，请使用在线表格生成器 https://www.tablesgenerator.com/markdown_tables )

### 测试摘要

TBMQ 在单个节点上运行，通过成功处理每秒 300 万条消息的吞吐量展示了卓越的性能。
这一重大成就在现实场景中突显了 TBMQ 的可靠性。

同样值得注意的是，该代理令人印象深刻的平均消息延迟仅为 **7.4 毫秒**。
这种低延迟证明了 TBMQ 在确保快速消息传递的同时处理高负载的能力。

| 消息延迟平均值 | 消息延迟第 95 个百分位数 |
|-----------------|------------------|
| 7.4 毫秒          | 11 毫秒            |

查看总结了测试的关键要素和结果的信息表会很有帮助。

| 发布者 | 订阅者 | 消息/秒 | 吞吐量 | QoS | 有效负载  | TBMQ CPU | TBMQ 内存 |
|------------|-------------|---------|------------|-----|----------|----------|-------------|
| 100        | 3000        | 10      | 300 万条消息/秒   | 0   | 66 字节 | 54 %     | 75 GiB      |

**经验教训**

我们的测试强调了优化 TBMQ 以实现可靠性和可扩展性的重要性。
它展示了该代理轻松处理大量消息负载的潜力，使其成为消息分发至关重要的场景的理想选择。

我们观察了 TBMQ 的资源管理能力及其在高负载下保持稳定性的能力。
此见解可以指导用户配置其设置以获得最佳性能。

**重要提示：**在此性能测试过程中，我们对各种实例类型进行了实验。
虽然我们为 TBMQ 选择了 AWS `m7a.8xlarge` 实例类型，但即使在 `m7a.4xlarge`（16 个 vCPU，64 GiB RAM）实例上，值得注意的结果也很重要。
此配置在保持 **90% 的 CPU 使用率** 的同时，提供了 **14.2 毫秒** 的平均消息延迟。
这些发现突出了 TBMQ 在各种实例类型中出色执行的灵活性和潜力，使用户能够选择最适合其特定要求的配置。

### 运行测试

测试代理表示性能测试节点（运行程序）的集群和监督这些运行程序的编排器。
为了履行各自的角色，我们部署了 1 个发布者和 6 个订阅者 Kubernetes pod，其中一个 pod 被指定为编排器。
值得注意的是，每个发布者和订阅者 pod 都分配给单独的 AWS EC2 实例。

有关在我们的测试设置中使用的 AWS EC2 实例的全面视图，您可以参考以下图像：

{% include images-gallery.html imageCollection="tbmq-3m-single-node-test-aws-instances" %}

测试启动涉及在客户端和 TBMQ 之间建立连接。订阅者客户端会立即设置其订阅，而发布者客户端会开始其预热阶段。
一旦所有运行程序都准备就绪，编排器就会通知集群已准备就绪，并开始发布消息。

经过一段时间的处理，我们可以评估监控工具，例如 JMX、htop 和 Kafka UI，以及 AWS CloudWatch 以获得更全面的见解。

监控工具显示平均 CPU 负载约为 **54%**。
这一发现表明 TBMQ 表现出强大的处理能力，表明它能够有效地处理更大的工作负载并管理消息传递高峰。

{% include images-gallery.html imageCollection="tbmq-3m-single-node-test-monitoring" %}

### 如何重复测试

我们建议参考我们的 [安装指南](/docs/mqtt-broker/install/cluster/aws-cluster-setup/)，其中提供了有关如何在 AWS 上部署 TBMQ 的分步说明。
此外，您可以浏览 [分支](https://github.com/thingsboard/tbmq/tree/3M-single-node-perf-test/k8s/aws#readme)，其中包含在此性能测试期间用于运行 TBMQ 的脚本和参数，
使您能够更深入地了解我们的配置。
为了实际执行性能测试，我们提供了一个专用的 [性能测试工具](https://github.com/thingsboard/tb-mqtt-perf-tests/tree/3M-single-node-perf-test)，
能够生成 MQTT 客户端并模拟所需的消息负载。
为了配置性能测试，您可以根据您的具体要求查看和修改 [发布者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/3M-single-node-perf-test/k8s/broker-tests-publishers-config.yml) 和 [订阅者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/3M-single-node-perf-test/k8s/broker-tests-subscribers-config.yml) 的配置文件。

### 结论

TBMQ 的性能测试成功地以仅 7.4 毫秒的平均延迟处理了每秒 300 万条消息，再次确认了其作为强大且可扩展的 MQTT 代理的地位。
这一成就突显了 TBMQ 处理苛刻工作负载的准备情况，使其成为依赖于高效消息分发的应用程序的可靠选择。

随着我们继续探索 TBMQ 的功能，我们致力于提供更高的性能和可靠性。
我们期待在未来分享更多见解和性能结果。

我们非常感谢您的反馈，并鼓励您关注我们的 [GitHub](https://github.com/thingsboard/tbmq) 以了解我们的最新进展。