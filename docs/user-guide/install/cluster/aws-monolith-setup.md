---
layout: docwithnav
assignees:
- ashvayka
title: 使用 AWS EKS 的整体式设置
description: 使用 AWS EKS 中的 Kubernetes 设置 GridLinks IoT 平台整体式
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
        title: '确保你的 PostgreSQL RDS 实例可从 GridLinks 集群访问；实现此目的最简单的方法是在同一个 VPC 中部署 PostgreSQL RDS 实例，并使用“eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*”安全组。'
    4:
        image: /images/install/cloud/aws/rds-5.png
        title: '确保你使用“thingsboard”作为初始数据库名称。'
    5:
        image: /images/install/cloud/aws/rds-6.png
        title: '禁用“自动次要版本更新”。'

rdsEndpointUrl:
    0:
        image: /images/install/cloud/aws/rds-endpoint-url.png
        title: '一旦数据库切换到“可用”状态，导航到“连接和安全”，并复制端点值。我们将在本指南的后面使用它，用 **YOUR_RDS_ENDPOINT_URL** 表示。'
---

* TOC
{:toc}

{% assign tbServicesFile = "tb-node.yml" %}

本指南将帮助你使用 AWS EKS 在整体式模式下设置 GridLinks。
有关其工作原理的更多详细信息，请参阅[整体式](/docs/reference/monolithic/)体系结构页面。
与 Docker Compose 相比，通过 K8S 进行整体式部署的优势在于，如果 AWS 实例中断，
K8S 将在另一个实例上重新启动服务。我们将使用 Amazon RDS 来管理 PostgreSQL。

## 先决条件

{% include templates/install/aws/eks-prerequisites.md %}

## 步骤 1. 克隆 ThingsBoard CE K8S 脚本存储库

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git
cd thingsboard-ce-k8s/aws/monolith
```

## 步骤 2. 配置并创建 EKS 集群

{% assign eksNote = "**1** 个 **m5.xlarge** 类型的节点" %}
{% include templates/install/aws/eks-create-cluster.md %}

## 步骤 3. 创建 AWS 负载均衡器控制器

{% include templates/install/aws/eks-lb-controller.md %}

## 步骤 4. 配置数据库

### 步骤 4.1 Amazon PostgreSQL 数据库配置

{% include templates/install/aws/rds-setup.md %}

### 步骤 4.2 Cassandra（可选）

{% include templates/install/aws/configure-cassandra.md %}

## 步骤 5. 安装

{% include templates/install/aws/eks-installation.md %}

## 步骤 6. 启动

执行以下命令以部署资源：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，你可以调用 `kubectl get pods`。如果一切顺利，你应该能够在 `READY` 状态下看到 `tb-node-0` pod。

## 步骤 7. 配置负载均衡器

### 7.1 配置 HTTP(S) 负载均衡器

{% include templates/install/aws/http-lb.md %}

### 7.2. 配置 MQTT 负载均衡器（可选）

{% include templates/install/aws/configure-mqtt.md %}

### 7.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/aws/configure-udp.md %}

### 7.4. 配置边缘负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 8. 验证设置

{% include templates/install/aws/eks-validate.md %}

{% include templates/install/aws/eks-upgrading.md %}

{% include templates/install/aws/eks-deletion.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}