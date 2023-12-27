---
layout: docwithnav
assignees:
- ashvayka
title: 使用 AWS EKS 设置微服务
description: 使用 AWS EKS 中的 Kubernetes 设置 GridLinks IoT 平台微服务

rdsSetup:
    0:
        image: /images/install/cloud/aws/rds-1.png
        title: '确保你的 PostgreSQL 版本是最新 12.x，而不是 13.x。'
    1:
        image: /images/install/cloud/aws/rds-2.png
        title: '将你的 PostgreSQL 主密码保存在安全的地方。我们将在本指南的后面使用它，用 YOUR_RDS_PASSWORD 表示。'
    2:
        image: /images/install/cloud/aws/rds-3.png
        title: '使用“预置 IOPS”以获得更好的性能。'
    3:
        image: /images/install/cloud/aws/rds-4.png
        title: '确保你的 PostgreSQL RDS 实例可从 GridLinks 集群访问；实现此目的最简单的方法是在同一 VPC 中部署 PostgreSQL RDS 实例并使用“eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*”安全组。'
    4:
        image: /images/install/cloud/aws/rds-5.png
        title: '确保使用“thingsboard”作为初始数据库名称。'
    5:
        image: /images/install/cloud/aws/rds-6.png
        title: '禁用“自动次要版本更新”。'  

rdsEndpointUrl:
    0:
        image: /images/install/cloud/aws/rds-endpoint-url.png
        title: '一旦数据库切换到“可用”状态，导航到“连接和安全”并复制端点值。我们将在本指南的后面使用它，用 **YOUR_RDS_ENDPOINT_URL** 表示。'

mskSetup:
    0:
        image: /images/install/cloud/aws/msk-1.png
        title: '确保你的 Apache Kafka 版本是 2.6.x。'
    1:
        image: /images/install/cloud/aws/msk-2.png
        title: '确保你的 MSK 实例可从 GridLinks 集群访问。实现此目的最简单的方法是在同一 VPC 中部署 MSK 实例。我们还建议使用专用子网。这样，几乎不可能意外地将其暴露给互联网。'
    2:
        image: /images/install/cloud/aws/msk-3.png
        title: '使用 m5.large 或类似的实例类型。'
    3:
        image: /images/install/cloud/aws/msk-4.png
        title: '选择默认安全设置。确保启用“纯文本”模式。'
    4:
        image: /images/install/cloud/aws/msk-5.png
        title: '使用默认“监控”设置或启用“增强型主题级别监控”。'

mskConnectionParams:
    0:
        image: /images/install/cloud/aws/msk-connection-params.png
        title: '一旦 MSK 集群切换到“活动”状态，导航到“详细信息”并单击“查看客户端信息”。'
    1:
        image: /images/install/cloud/aws/msk-connection-params2.png
        title: '以纯文本形式复制引导服务器信息。我们将在本指南的后面使用它，用 **YOUR_MSK_BOOTSTRAP_SERVERS_PLAINTEXT** 表示。'

redisSetup:
    0:
        image: /images/install/cloud/aws/redis-single-1.png
        title: '指定 Redis Engine 版本 6.x 和至少 1 GB RAM 的节点类型。'
    1:
        image: /images/install/cloud/aws/redis-single-2.png
        title: '确保你的 Redis 集群可从 GridLinks 集群访问。实现此目的最简单的方法是在同一 VPC 中部署 Redis 集群。我们还建议使用专用子网。使用“eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*”安全组。'
    2:
        image: /images/install/cloud/aws/redis-single-3.png
        title: '禁用自动备份。'

redisEndpointUrl:
    0:
        image: /images/install/cloud/aws/redis-endpoint-url.png
        title: '一旦 Redis 集群切换到“可用”状态，导航到“详细信息”并复制“主端点”，不带“:6379”端口后缀。我们将在本指南的后面使用它，用 **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT** 表示。'

---

* TOC
{:toc}

本指南将帮助你使用 AWS EKS 在微服务模式下设置 GridLinks。
请参阅[微服务](/docs/reference/msa/)架构页面，了解有关将要安装的每个组件的更多详细信息。
我们将使用 Amazon RDS 管理 PostgreSQL，Amazon MSK 管理 Kafka，Amazon ElastiCache 管理 Redis。

## 前提条件

{% include templates/install/aws/eks-prerequisites.md %}

## 步骤 1. 克隆 GridLinks社区版 K8S 脚本存储库

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git
cd thingsboard-ce-k8s/aws/microservices
```
{: .copy-code}

## 步骤 2. 配置并创建 EKS 集群

{% assign eksNote = "**3** 个 **m5.xlarge** 类型的节点" %}
{% include templates/install/aws/eks-create-cluster.md %}

## 步骤 3. 创建 AWS 负载均衡器控制器

{% include templates/install/aws/eks-lb-controller.md %}

## 步骤 4. 配置数据库

### 步骤 4.1 Amazon PostgreSQL 数据库配置

{% include templates/install/aws/rds-setup.md %}

### 步骤 4.2 Cassandra

{% include templates/install/aws/configure-cassandra.md %}

## 步骤 5. Amazon MSK 配置

{% include templates/install/aws/msk-setup.md %}

## 步骤 6. Amazon ElactiCache（Redis）配置

{% include templates/install/aws/redis-setup.md %}

## 步骤 7. CPU 和内存资源分配

脚本预先配置了每个服务的资源值。你可以在 `resources` 子菜单下的 `.yml` 文件中更改它们。

**注意**：如果你想分配更多资源，你需要增加 Amazon 节点数或使用更大的机器。

建议的 CPU/内存资源分配：
- TB 节点：1.0 CPU / 2Gi 内存
- TB HTTP 传输：0.5 CPU / 0.5Gi 内存
- TB MQTT 传输：0.5 CPU / 0.5Gi 内存
- TB COAP 传输：0.5 CPU / 0.5Gi 内存
- TB Web UI：0.1 CPU / 100Mi 内存
- JS 执行器：0.1 CPU / 100Mi 内存
- Zookeeper：0.1 CPU / 0.5Gi 内存

## 步骤 8. 安装

执行以下命令以部署 GridLinks 服务：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，你可以调用 `kubectl get pods`。如果一切顺利，你应该能够看到：

* 5x `tb-pe-js-executor`
* 2x `tb-pe-web-ui`
* 1x `tb-pe-node`
* 1x `tb-pe-web-report`
* 3x `zookeeper`。

每个 pod 都应处于 `READY` 状态。

{% include templates/install/aws/start-transports.md %}

## 步骤 9. 配置负载均衡器

### 9.1 配置 HTTP(S) 负载均衡器

{% include templates/install/aws/http-lb.md %}

### 9.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-services.yml" %}
{% include templates/install/aws/configure-mqtt.md %}

### 9.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/aws/configure-udp.md %}

### 9.4. 配置边缘负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 10. 验证设置

{% include templates/install/aws/eks-validate.md %}

{% include templates/install/aws/eks-upgrading.md %}

{% include templates/install/aws/eks-deletion.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}