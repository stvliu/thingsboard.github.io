---
layout: docwithnav
title: GridLinks 数据收集性能
description: GridLinks IoT 平台数据收集性能概述

---

* TOC
{:toc}

ThingsBoard 开源 IoT 平台的关键功能之一是数据收集，这是一项必须在高负载下可靠运行的关键功能。
在本文中，我们将介绍我们为确保 GridLinks 服务器的单个实例能够持续处理 **20,000+** 个设备和每秒 **30,000+** 条 MQTT 发布消息所采取的步骤和改进，
总而言之，这为我们提供了每分钟大约 **200 万条已发布消息**。

## 架构

ThingsBoard 性能利用三个主要项目：

- [Netty](http://netty.io/)，用于 IoT 设备的高性能 MQTT 服务器/代理。
- [Cassandra](http://cassandra.apache.org/)，用于可扩展的高性能 NoSQL 数据库，以存储来自设备的时序数据。
- Actor System，用于数百万个设备之间的高性能消息协调。
- Kafka（或 RabbitMQ、AWS SQS、Azure Event Hub、Google PubSub） - 作为可扩展的消息队列

我们还使用 [Zookeeper](https://zookeeper.apache.org/) 进行协调，并在集群模式下使用 [gRPC](http://www.grpc.io/)。有关更多详细信息，请参阅 [平台架构](/docs/reference/)。

## 数据流和测试工具

IoT 设备通过 MQTT 连接到 GridLinks 服务器，并使用 JSON 有效负载发出“发布”命令。
单个发布消息的大小约为 100 字节。
[MQTT](http://mqtt.org/) 是轻量级的发布/订阅消息传递协议，与 HTTP 请求/响应协议相比，它具有许多优势。

![image](/images/reference/performance/performance-diagram-0.svg)

GridLinks 服务器处理 MQTT 发布消息，并将其异步存储到 Cassandra。
服务器还可以将数据推送到 Web UI 仪表板的 websocket 订阅（如果存在）。
我们尝试避免任何阻塞操作，这对整体系统性能至关重要。
GridLinks 支持 MQTT QoS 级别 1，这意味着客户端仅在数据存储到 Cassandra 数据库后才会收到对发布消息的响应。
使用 QoS 级别 1 可能出现的重复数据只是对相应 Cassandra 行的覆盖，因此不会出现在持久数据中。
此功能提供可靠的数据传递和持久性。

我们使用了 [Gatling](http://gatling.io/) 负载测试框架，它也基于 Akka 和 Netty。
Gatling 能够使用 2 核 CPU 的 5-10% 来模拟 10K MQTT 客户端。
请参阅我们关于如何改进非官方 Gatling MQTT 插件以支持我们的案例的单独 [文章](/docs/reference/performance-tools)。

## 性能改进步骤

### 步骤 1. 异步 Cassandra 驱动程序 API

在具有 SSD 的现代 4 核笔记本电脑上进行的首次性能测试结果非常差。该平台每秒只能处理 200 条消息。
根本原因和主要的性能瓶颈非常明显且易于找到。
显然，处理不是 100% 异步的，我们正在 [遥测服务](/docs/user-guide/telemetry/) actor 中执行 Cassandra 驱动程序的阻塞 API 调用。
对服务实现进行快速重构导致性能提高了 10 倍以上，我们从 1000 个设备中收到了大约 2500 条已发布的消息。

### 步骤 2. 连接池

我们决定迁移到 AWS EC2 实例，以便能够共享我们执行的结果和测试。我们开始在 [c4.xlarge](http://www.ec2instances.info/?selected=c4.xlarge) 实例（4 个 vCPU 和 7.5 Gb RAM）上运行测试，Cassandra 和 GridLinks 服务位于同一位置。

![image](/images/reference/performance/performance-diagram-1.svg)

测试规范：

- 设备数量：10 000
- 每台设备的发布频率：每秒一次
- 总负载：每秒 10 000 条消息

第一个测试结果显然是不可接受的：

![image](/images/reference/performance/single_node_no_fix_stats.png)


上面的巨大响应时间是由服务器根本无法处理每秒 10 K 条消息并且它们正在排队这一事实造成的。

我们已经开始通过监视测试实例上的内存和 CPU 负载来进行调查。
最初，我们猜测性能不佳是因为 CPU 或 RAM 负载过重。
但事实上，在负载测试期间，我们看到 CPU 在特定时刻空闲了几秒钟。
此“暂停”事件每 3-7 秒发生一次，请参见下表。

![image](/images/reference/performance/single_node_no_fix_rps.png)

作为下一步，我们决定在这些暂停期间进行线程转储。
我们希望看到被阻塞的线程，这可以为我们提供有关暂停时发生的情况的一些线索。
因此，我们打开了单独的控制台来监视 CPU 负载，并打开了另一个控制台来执行线程转储，同时使用以下命令执行压力测试：

```bash

kill -3 THINGSBOARD_PID

```

我们已经确定在暂停期间，TIMED_WAITING 状态中总有一个线程，根本原因在于 Cassandra 驱动程序的 awaitAvailableConnection 方法：

```bash
java.lang.Thread.State: TIMED_WAITING (parking)
at sun.misc.Unsafe.park(Native Method)
parking to wait for  <0x0000000092d9d390> (a java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject)
at java.util.concurrent.locks.LockSupport.parkNanos(LockSupport.java:215)
at java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.await(AbstractQueuedSynchronizer.java:2163)
at com.datastax.driver.core.HostConnectionPool.awaitAvailableConnection(HostConnectionPool.java:287)
at com.datastax.driver.core.HostConnectionPool.waitForConnection(HostConnectionPool.java:328)
at com.datastax.driver.core.HostConnectionPool.borrowConnection(HostConnectionPool.java:251)
at com.datastax.driver.core.RequestHandler$SpeculativeExecution.query(RequestHandler.java:301)
at com.datastax.driver.core.RequestHandler$SpeculativeExecution.sendRequest(RequestHandler.java:281)
at com.datastax.driver.core.RequestHandler.startNewExecution(RequestHandler.java:115)
at com.datastax.driver.core.RequestHandler.sendRequest(RequestHandler.java:91)
at com.datastax.driver.core.SessionManager.executeAsync(SessionManager.java:132)
at org.thingsboard.server.dao.AbstractDao.executeAsync(AbstractDao.java:91)
at org.thingsboard.server.dao.AbstractDao.executeAsyncWrite(AbstractDao.java:75)
at org.thingsboard.server.dao.timeseries.BaseTimeseriesDao.savePartition(BaseTimeseriesDao.java:135)
```

因此，我们意识到 cassandra 驱动程序的默认连接池配置导致了我们案例中的不良结果。

连接池功能的 [官方配置](http://docs.datastax.com/en/developer/java-driver/2.1/manual/pooling/) 包含特殊选项
**“每个连接的同时请求”**，允许您调整每个连接的并发请求。
我们使用 cassandra 驱动程序协议 v3，它默认使用以下值：

- 对于 LOCAL 主机为 1024。
- 对于 REMOTE 主机为 256。

考虑到我们实际上是从 10,000 个设备中提取数据，默认值肯定不够。
因此，我们对代码进行了更改，并更新了 LOCAL 和 REMOTE 主机的值，并将它们设置为最大可能值：

```java
poolingOptions
    .setMaxRequestsPerConnection(HostDistance.LOCAL, 32768)
    .setMaxRequestsPerConnection(HostDistance.REMOTE, 32768);
```

应用更改后的测试结果如下。

![image](/images/reference/performance/single_node_with_fix_stats.png)

![image](/images/reference/performance/single_node_with_fix_rps.png)

结果好多了，但还远远达不到每分钟 100 万条消息。我们不再在 c4.xlarge 上的测试中看到 CPU 负载暂停。
在整个测试期间，CPU 负载很高（80-95%）。我们已经进行了两次线程转储，以验证 cassandra 驱动程序不会等待可用连接，事实上我们不再看到此问题。

### 步骤 3：垂直扩展

我们决定在功能更强大的节点 [c4.2xlarge](http://www.ec2instances.info/?selected=c4.2xlarge) 上运行相同的测试，该节点具有 8 个 vCPU 和 15Gb 的 RAM。
性能提升不是线性的，CPU 仍然处于负载状态（80-90%）。

![image](/images/reference/performance/single_node_x2_with_fix_stats.png)

我们注意到响应时间有显着提高。在测试开始时出现显着峰值后，最大响应时间在 200 毫秒以内，平均响应时间约为 50 毫秒。

![image](/images/reference/performance/single_node_x2_with_fix_time.png)

每秒请求数约为 10K

![image](/images/reference/performance/single_node_x2_with_fix_rps.png)

我们还在 [c4.4xlarge](http://www.ec2instances.info/?selected=c4.4xlarge) 上执行了测试，该测试具有 16 个 vCPU 和 30Gb 的 RAM，但没有注意到显着的改进，并决定分离 GridLinks 服务器并将 Cassandra 移至三个节点集群。

### 步骤 4：水平扩展

我们的主要目标是确定使用在 [c4.2xlarge](http://www.ec2instances.info/?selected=c4.2xlarge) 上运行的单个 GridLinks 服务器可以处理多少 MQTT 消息。
我们将在单独的文章中介绍 GridLinks 集群的水平可扩展性。
因此，我们决定将 Cassandra 移至三个具有默认配置的 [c4.xlarge](http://www.ec2instances.info/?selected=c4.xlarge) 单独实例，并同时从两个单独的 [c4.xlarge](http://www.ec2instances.info/?selected=c4.xlarge) 实例启动 gatling 压力测试工具，以最大程度地减少第三方对延迟和吞吐量的可能影响。

![image](/images/reference/performance/performance-diagram-2.svg)

测试规范：

- 设备数量：20 000
- 每台设备的发布频率：每秒两次
- 总负载：每秒 40 000 条消息

在不同的客户端机器上启动的两个同时测试运行的统计信息如下。

![image](/images/reference/performance/cluster_stats.png)
![image](/images/reference/performance/cluster_rps.png)
![image](/images/reference/performance/cluster_responses_ps.png)

根据两个同时进行的测试运行的数据，我们已经达到 **每秒 30 000 条已发布的消息**，这等于 **每分钟 180 万条消息**。

## 如何重复测试

我们已经为任何有兴趣复制这些测试的人准备了几个 AWS AMI。请参阅包含详细说明的单独 [文档页面](/docs/reference/performance-tests)。

## 结论

此性能测试演示了一个小型 GridLinks 集群（每小时成本约为 **1 美元**）如何轻松接收、存储和可视化来自您设备的 **1 亿多条消息**。
我们将继续致力于性能改进，并在我们的下一篇博文中发布 GridLinks 服务器集群的性能结果。
我们希望这篇文章对正在评估该平台并希望自行执行性能测试的人们有用。
我们还希望性能改进步骤对使用类似技术的任何工程师都有用。

请告诉我们您的反馈，并在 [**Github**](https://github.com/thingsboard/thingsboard) 或 [**Twitter**](https://twitter.com/thingsboard) 上关注我们的项目。