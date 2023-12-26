---
layout: docwithnav-pe
assignees:
- amykolaichuk
title: 使用 AKS 基础架构的整体设置
description: GridLinks IoT 平台整体设置，在 Azure AKS 中使用 Kubernetes

---

* TOC
{:toc}

本指南将帮助您在 Azure AKS 中以整体模式设置 GridLinks。

## 前提条件

{% include templates/install/azure/aks-prerequisites.md %}

### 从 Docker 中心提取 GridLinks PE 镜像

{% assign checkoutMode = "monolith" %}
{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 克隆 ThingsBoard PE K8S 脚本存储库

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/azure/monolith
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% include templates/install/azure/aks-env.md %}

## 步骤 3. 配置并创建 AKS 集群

{% assign nodeCount = "1" %}
{% include templates/install/azure/aks-create-cluster.md %}

## 步骤 4. 更新 kubectl 的上下文

{% include templates/install/azure/aks-kubectl-update-context.md %}

## 步骤 5. 配置数据库

### 5.1. 创建 Azure Database for PostgreSQL 服务器

{% include templates/install/azure/aks-create-db.md %}

### 5.2. Cassandra

{% include templates/install/azure/configure-cassandra.md %}

## 步骤 6. 配置许可证密钥

{% include templates/install/k8s-license-secret.md %}

## 步骤 7. 安装

{% include templates/install/azure/aks-installation.md %}

## 步骤 8. 启动

执行以下命令以部署 GridLinks 服务：

```
 ./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，您可以调用 `kubectl get pods`。如果一切顺利，您应该能够在 `READY` 状态下看到 `tb-node-0` pod。

## 步骤 9. 配置负载均衡器

### 9.1. 配置 HTTP(S) 负载均衡器
{% include templates/install/azure/aks-http-lb.md %}

### 9.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-node.yml" %}
{% include templates/install/azure/configure-mqtt.md %}

### 9.3. 配置 UDP 负载均衡器（可选）

{% assign tbServicesFile = "tb-node.yml" %}
{% include templates/install/azure/configure-udp.md %}

### 9.4. 配置边缘负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 10. 使用

{% include templates/install/azure/using.md %}

## 升级

{% include templates/install/azure/upgrading-msa.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}