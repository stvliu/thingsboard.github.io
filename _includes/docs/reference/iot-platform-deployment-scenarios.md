* TOC
{:toc}

本文介绍了 ThingsBoard 支持的最流行的部署架构。
所有部署方案都包含一定的优缺点。
为你的部署选择合适的架构取决于 TCO、性能和高可用性要求。
我们将从最简单的方案开始，看看如何将最小的部署升级到最复杂的部署。

在此你可以找到使用 AWS 部署 ThingsBoard 的总拥有成本 (TCO) 计算。
重要提示：以下所有计算和定价都是近似的，仅作为示例列出。
请咨询你的云提供商以获取准确的定价。

## 性能要求

我们准备了一份清单，以便快速估算典型的物联网解决方案的性能要求：

1. 生产中或每年连接的设备、资产、客户、客户用户和租户的总数；
2. 每台设备每天的最大和平均消息数量；
3. 设备有效负载的最大和平均大小；
4. 每条消息中的数据点平均数量；
5. 用于设备连接的通信协议或集成类型；
6. 实体数据生命周期（以年为单位）。

一旦我们对上述参数有了大致的了解，我们（以及你）就可以估算出所需的基础设施。
ThingsBoard 的性能在很大程度上取决于设备产生的消息数量和这些消息的结构。

**示例 1：20,000 个追踪器**

20,000 台设备每分钟向云发送一次消息。每条消息包含以下参数：

```json
{"latitude": 42.222222, "longitude": 73.333333, "speed": 55.5, "fuel": 92, "batteryLevel": 81}
```

在这种情况下，ThingsBoard 持续保持 20,000 个连接，并每秒处理 333 条消息。
每条消息传递 5 个数据点，这些数据点可能需要分别绘制图表/分析/提取。
这导致每秒向数据库发出 1,667 个写请求，每天产生 1.43 亿个请求。
根据所选的数据库类型，这每天大约产生 1-2GB（Cassandra）或 7-10GB（PostgreSQL）。

**示例 2：100,000 个智能电表**

100,000 台 LoRaWAN 设备每小时向云发送一次消息。每条消息的结构如下：

```json
{"pulseCounter": 1234567, "leakage": false, "batteryLevel": 81}
```

ThingsBoard 通过 HTTP 或 MQTT 从可用网络服务器之一接收上行消息。
典型消息速率为 100,000 / 3600 = 每秒 28 条消息，这相当低。
每条消息包含 3 个数据点，这些数据点可能需要分别绘制图表/分析/提取。
但是，我们决定不存储“泄漏”属性，因为它冗余（大多数时候为“false”）。
我们只会用它来生成警报。
这导致每秒向数据库发出 55.5 个写请求，每天产生 478 万个请求。
根据所选的数据库类型，这每天大约产生 100MB（Cassandra）或 2.38MB（PostgreSQL）。

## 关键基础设施特征

根据 [性能要求](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#performance-requirements)，
你可以确定 ThingsBoard 服务器/集群的关键特征：

- 每秒传入消息的数量（主要影响 RAM 和 CPU 消耗）；
- 并发活动设备会话的数量（主要影响 RAM 消耗）；
- 规则引擎处理的消息数量（主要影响 CPU 消耗）；
- 持久化数据点数量（直接影响 IOPS 和相应数据库）。

ThingsBoard 集群可以横向扩展，因此你可以很容易地处理 RAM/CPU 影响因素。
但是，你需要仔细规划持久化数据点数量（上述列表中的最后一项）。
如果你打算使用 PostgreSQL，我们建议每秒少于 20,000 个数据点记录。
如果你计划使用混合数据库方法（PostgreSQL 和 Cassandra），你可以将遥测（Cassandra）写入扩展到每秒 100 万个数据点，尽管属性更新被推送到 PostgreSQL，因此 20,000 的限制仍然有效。

## 部署方案

### 独立服务器部署（方案 A）

最简单的部署方案适用于多达 300,000 台设备，每秒 10,000 条消息和 10,000 个数据点，基于实际生产用例。
此方案要求在同一服务器（内部部署或云端）中部署 ThingsBoard 平台和 PostgreSQL 数据库。
HAProxy 负载均衡器也安装在同一服务器上，充当反向代理和可选的 TLS 终止代理。
请参见下图。

<object width="80%" data="/images/reference/deployment/single.svg"></object>

**优点**：

* 非常简单的设置，从字面上看：使用 [我们的安装指南](/docs/user-guide/install/{{docsPrefix}}installation-options/)部署只需 10 分钟。
* 易于维护和更新软件实例。

**缺点**：

* 升级会导致停机，每次升级大约需要 5-10 分钟。
* 最低高可用性。如果硬件或应用程序发生故障，所有设备和用户都会受到影响。
* 没有数据持久性。所有内容都存储在一个服务器上。
* 系统的性能受到单个服务器性能的限制。

**性能**：

解决方案的整体性能取决于实例硬件，并且在很大程度上依赖于数据库的性能。
我们建议在独立服务器部署方案中将 PostgreSQL 用于实体和遥测数据。
平均虚拟环境每秒可以处理约 5,000 个遥测数据点。
请参阅不同 AWS 实例上的 [关键基础设施特征](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#key-infrastructure-characteristics) 和 [性能测试](/docs/{{docsPrefix}}reference/performance-aws-instances/)。此信息对于为你的解决方案的基础设施做出正确决策非常有用。

**总拥有成本 (TCO) 示例**：

假设 10,000 台 LoRaWAN 智能电表设备每小时向云发送一次消息。

单个 AWS EC2“m5.large”实例每月花费约 41.66 美元（如果预付一年，则每年约 500 美元）。
500 GB 存储价格为每月 50 美元。
相应的基础设施成本约为每月 100 美元。

单个 ThingsBoard PE 永久许可证（低于 v3.0）的成本为 2,999 美元（包括可选更新和使用第一年的基本支持）。1,199 美元是后续年份的软件更新 + 基本支持的相应定价。

TCO：每月约 350 美元。此价格与每台设备每月 0.035 美元相关，而设备数量为 10k。
添加 [高级支持](/docs/services/support/)套餐，每月花费约 850 美元，或每台设备每月 0.085 美元。

**评论和建议**：

此部署方案非常简单，非常适合开发环境、原型设计和早期创业公司。
在投入生产之前，我们建议你设置数据备份脚本，并定期将数据库快照上传到持久存储（AWS S3 等）。
为了在可能发生中断的情况下最大限度地缩短恢复时间，定期对你的服务器实例进行快照也很有用。

如果你想最大限度地减少用于数据库维护的资源，我们建议使用云托管数据库。有关更多详细信息，请参阅方案 B。

### 带有外部数据库的单服务器部署（方案 B）

此部署方案与方案 A 非常相似，但需要在单独的服务器上部署完全托管的数据库。
ThingsBoard 客户成功利用 [AWS RDS](https://aws.amazon.com/rds/postgresql/)、[Azure Database for PostgreSQL](https://azure.microsoft.com/en-us/services/postgresql/) 和
[Google Cloud SQL](https://cloud.google.com/sql/docs/postgres/) 来最大限度地减少数据库设置、备份和支持方面的工作。
请参见下图。

<object width="80%" data="/images/reference/deployment/standalone.svg"></object>

**优点**：

* 非常简单的设置（使用我们的安装指南部署大约需要 1 小时）。
* 易于维护和更新软件实例。
* 数据与托管备份和故障转移分开存储。

**缺点**：

* 升级会导致停机。每次升级大约需要 5 分钟的停机时间。
* 最低高可用性。如果硬件或应用程序发生故障，管理员有义务执行手动操作来启动并运行系统。
* 系统的性能受到单个服务器性能的限制。

**性能**：

解决方案的整体性能取决于实例硬件，并且在很大程度上依赖于数据库的性能。
我们建议在此方案中将 PostgreSQL 用于实体和遥测数据。
平均虚拟环境每秒可以处理约 5,000 个遥测数据点。
请参阅不同 AWS 实例上的 [关键基础设施特征](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#key-infrastructure-characteristics) 和 [性能测试](/docs/{{docsPrefix}}reference/performance-aws-instances/)。

**方案 B 的总拥有成本示例**：

假设 10,000 台 LoRaWAN 智能电表设备每小时向云发送一次消息。

单个 AWS EC2“m5.large”实例的每月成本约为 41.66 美元（如果预付一年，则每年约 500 美元）。
Amazon RDS PostgreSQL 实例的成本约为每月 200 美元，如果是 db.t2.medium 和多可用区部署。
基础设施成本约为每月 250 美元。

单个 ThingsBoard PE 永久许可证的成本为 2,999 美元（包括可选更新和使用第一年的基本支持）。1,199 美元是后续年份的软件更新 + 基本支持的相应定价。

TCO：每月约 500 美元，或每台设备每月 0.05 美元，适用于多达 10k 台设备的用例。
添加 [高级支持](/docs/services/support/)套餐，每月花费约 1000 美元，或每台设备每月 0.1 美元。

### 具有微服务架构的集群部署（方案 C）

ThingsBoard 支持微服务架构 (MSA) 来执行数百万台设备的可扩展部署。有关更多详细信息，请参阅 [平台架构](/docs/{{docsPrefix}}reference/msa/)。使用 MSA 部署，系统管理员可以灵活地调整传输、规则引擎、Web UI 和 JavaScript 执行器微服务的数量，以根据当前负载优化集群。

ThingsBoard 使用 [Kafka](https://kafka.apache.org/) 作为主要的消息队列和流式解决方案，[Redis](https://redis.io/) 作为分布式缓存，[Cassandra](https://cassandra.apache.org/) 作为高可用、可扩展和快速的 NoSQL 数据库。
请注意，Cassandra 的使用是可选的，并且在遥测数据速率高（每秒超过 20,000 个数据点）的情况下建议使用。
在其他情况下，基于 PostgreSQL 的部署就足够了。

**优点**：

* 简单 Kubernetes 部署。
* 无 SPOF。
* 高可用性和系统。
* 在小版本升级期间没有停机时间。

**缺点**：

* 在少量设备（每个 ThingsBoard 集群少于 100,000 台设备）上 TCO 高。

**性能**：

解决方案的整体性能取决于集群硬件，并且在很大程度上依赖于所用数据库的性能。
一个包含 5 个 ThingsBoard 服务器和 5 个 Cassandra 节点的虚拟机集群可以处理 100 万台设备；
有关更多详细信息，请参阅 [关键基础设施特征](/docs/{{docsPrefix}}reference/iot-platform-deployment-scenarios/#key-infrastructure-characteristics)。

**集群部署方案的总拥有成本示例**：

#### 100 万智能电表的 TCO

**示例 1：**假设 **1,000,000** 台 LoRaWAN/NB-IoT **智能电表**设备每小时向云发送一次消息。
每条消息包含 3 个数据点，可能需要单独绘制/分析/获取。
我们认为消息是通过 HTTP 或 UDP 集成发送到 ThingsBoard 的，这对于这种情况很典型。

1,000,000 台设备表示每秒 280 条消息的负载（1,000,000 台设备/3600 秒），这导致每秒 280 x 3 = 840 个对数据库的写请求（数据点），或每天 7260 万个请求。
基于所选的数据库类型，上述情况每天大约会消耗 1.2GB（Cassandra）或 4GB（PostgreSQL）的磁盘空间。

以下 Kubernetes 集群足以支持此用例：

- 2 个“r5.xlarge”实例（4 个 vCPU 和 32 GB RAM）来托管 2 个 ThingsBoard 节点容器。大约价格为每月 380 美元。
- 3 个“c5.large”实例（2 个 vCPU 和 4 GB RAM）来托管 3 个 Zookeeper 和约 9 个 JS 执行器。大约价格为每月 120 美元。
- 基于 2 个“cache.m5.large”的 Amazon ElastiCache for Redis。大约价格为每月 200 美元。
- 基于 3 个“kafka.m5.large”和 1TB 数据存储的 Amazon Managed Streaming for Kafka。估计：每月 620 美元。
- 基于“db.m5.large”多可用区部署的 Amazon RDS for PostgreSQL。估计：每月 220 美元。
- 1TB 多可用区部署存储。价格为每月 230 美元。

<object width="100%" data="/images/reference/deployment/smart-meter-cluster.svg"></object>

因此，基础设施成本约为每月 1,770 美元，或每台设备每月 0.00177 美元。

两个 ThingsBoard PE 永久许可证的成本为 5,998 美元（包括可选更新和使用第一年的基本支持）。2,398 美元是后续年份的软件更新 + 基本支持的相应定价。
对于超过 10k 台设备的用例，我们提供 **托管服务** 来支持生产环境（而不是基本支持订阅）。费率为每台设备每月 0.01 美元。

TCO：每月约 12,270 美元，或每台设备每月 0.01227 美元。

**如果你想在你的集群设置中复制此案例，请按照以下指南操作：**
[智能电表用例性能测试](https://github.com/ashvayka/tb-pe-k8s-perf-tests/tree/scenario/1-million-smart-meters)

#### 100 万智能追踪器的 TCO

**示例 2：**假设 1,000,000 台 **智能追踪器** 设备每分钟向云发送读数。
每条消息包含 5 个数据点，可能需要单独绘制/分析/获取。

典型的消息速率为 1,000,000 / 60 秒 = 每秒 16,667 条消息。
这导致每秒 16667 x 5 = 83,335 个对数据库的写请求（数据点），或每天 7.2B 个请求。
Cassandra 可以可靠地处理此负载，并每天产生 144GB。由于数据需要在 Cassandra 中复制 3 次，因此每天产生 432GB 的磁盘空间。

以下 Kubernetes 集群足以支持此用例：

- 8 个“c5.large”实例（2 个 vCPU 和 4 GB RAM）来托管 8 个 ThingsBoard MQTT 传输容器。大约价格为每月 320 美元。
- 15 个“c5.xlarge”实例（4 个 vCPU 和 8 GB RAM）来托管 15 个 ThingsBoard 节点容器。大约价格为每月 1095 美元。
- 15 个“c5.xlarge”实例（4 个 vCPU 和 8 GB RAM）来托管 15 个 Cassandra 容器。大约价格为每月 1095 美元。
- 3 个“c5.xlarge”实例（2 个 vCPU 和 4 GB RAM）来托管 3 个 Zookeeper 和约 30 个 JS 执行器。大约价格为每月 240 美元。
- 基于 2 个“cache.m5.large”的 Amazon ElastiCache for Redis。大约价格为每月 200 美元。
- 基于 3 个“kafka.m5.large”和 1TB 数据存储的 Amazon Managed Streaming for Kafka。估计：每月 620 美元。
- 基于“db.m5.large”多可用区部署的 Amazon RDS for PostgreSQL。估计：每月 220 美元。
- 100TB 的部署存储。价格：每月 10,000 美元。

<object width="100%" data="/images/reference/deployment/smart-tracker-cluster.svg"></object>

因此，基础设施成本约为每月 13,790 美元，或每台设备每月 0.0138 美元。
15 个 ThingsBoard PE 永久许可证（低于 v3.0）的成本为 44,985 美元（包括可选更新和使用第一年的基本支持）。17,985 美元是后续年份的软件更新 + 基本支持的相应定价。
ThingsBoard **托管服务** 来支持生产环境：每台设备每月 0.01 美元。

TCO：每月约 27,508 美元，或每台设备每月 0.0275 美元。

**如果你想在你的集群设置中复制此案例，请按照以下指南操作：**
[智能追踪器用例性能测试](https://github.com/ashvayka/tb-pe-k8s-perf-tests/tree/scenario/1-million-smart-trackers)