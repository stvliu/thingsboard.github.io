---
layout: docwithnav
assignees:
- ashvayka
title: 使用 GCP 基础架构的单体设置
description: 在 GKE 中使用 Kubernetes 的 GridLinks IoT 平台单体设置

---

* TOC
{:toc}

本指南将帮助您在 GKE 中以单体模式设置 GridLinks。

## 前提条件

{% include templates/install/gcp/gke-prerequisites.md %}

## 步骤 1. 克隆 ThingsBoard CE K8S 脚本存储库

克隆存储库并将工作目录更改为 GCP 脚本。

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-сe-k8s.git
cd thingsboard-сe-k8s/gcp/monolith
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% assign tbClusterName = "tb-ce" %}
{% include templates/install/gcp/env-variables-monolith.md %}

## 步骤 3. 配置并创建 GKE 集群

{% include templates/install/gcp/zonal-gke-cluster.md %}

## 步骤 4. 更新 kubectl 的上下文

{% include templates/install/gcp/update-kubectl-zone.md %}

## 步骤 5. 配置数据库

### 步骤 5.1 Google Cloud SQL（PostgreSQL）实例

{% include templates/install/gcp/provision-postgresql.md %}

### 步骤 5.2 Cassandra（可选）

{% include templates/install/gcp/configure-cassandra.md %}

## 步骤 6. 安装

{% include templates/install/gcp/install.md %}

## 步骤 7. 启动

{% include templates/install/gcp/start-monolith.md %}

## 步骤 8. 配置负载均衡器

### 8.1 配置 HTTP(S) 负载均衡器

{% include templates/install/gcp/http-lb.md %}

#### 透明负载均衡器

此类型的负载均衡器要求您自行配置和维护有效的 SSL 证书。
按照通用 [HTTP over SSL](/docs/{{docsPrefix}}user-guide/ssl/http-over-ssl/#ssl-configuration-using-pem-certificates-file) 指南在 *tb-node.yml* 文件中配置所需的变量。

之后，设置 TCP 负载均衡器以将 443 端口的流量转发到相应的服务端口 8080。
此版本的设置不支持将 http 端口 80 自动重定向到 https 端口 443。

```bash
 kubectl apply -f receipts/transparent-http-load-balancer.yml
```
{: .copy-code}
 
### 8.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-node.yml" %}
{% include templates/install/gcp/configure-mqtt.md %}

### 8.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/gcp/configure-udp.md %}

### 8.4. 配置边缘负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 9. 使用

{% include templates/install/gcp/using.md %}

## 升级

{% include templates/install/gcp/upgrading-monolith.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}