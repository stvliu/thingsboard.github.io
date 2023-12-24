---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 GCP 基础设施的单体设置
description: 在 GKE 中使用 Kubernetes 的 ThingsBoard IoT 平台单体设置

---

{% assign docsPrefix = "pe/" %}

* TOC
{:toc}

本指南将帮助您使用 [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine) 以单体模式设置 GridLinks。

## 先决条件

{% include templates/install/gcp/gke-prerequisites.md %}

### 从 Docker 中心提取 ThingsBoard PE 镜像

{% assign checkoutMode = "monolith" %}
{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 克隆 ThingsBoard PE K8S 脚本存储库

克隆存储库并将工作目录更改为 GCP 脚本。

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/gcp/monolith
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% assign tbClusterName = "tb-pe" %}
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

## 步骤 6. 配置许可证密钥

{% include templates/install/k8s-license-secret.md %}

## 步骤 7. 安装

{% include templates/install/gcp/install.md %}

## 步骤 8. 启动

{% include templates/install/gcp/start-monolith.md %}

## 步骤 9. 配置负载均衡器

### 9.1 配置 HTTP(S) 负载均衡器

{% include templates/install/gcp/http-lb.md %}

#### 透明负载均衡器

此类型的负载均衡器要求您自行配置和维护有效的 SSL 证书。
按照通用 [HTTP over SSL](/docs/{{docsPrefix}}user-guide/ssl/http-over-ssl/#ssl-configuration-using-pem-certificates-file) 指南在 *tb-node.yml* 文件中配置所需的变量。

然后，设置 TCP 负载均衡器，将 443 端口的流量转发到相应的服务端口 8080。此版本的设置不支持将 http 端口 80 自动重定向到 https 端口 443。

```bash
 kubectl apply -f receipts/transparent-http-load-balancer.yml.yml
```
{: .copy-code}


### 9.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "tb-node.yml" %}
{% include templates/install/gcp/configure-mqtt.md %}

### 9.3. 配置 UDP 负载均衡器（可选）

{% include templates/install/gcp/configure-udp.md %}

### 9.4. 配置边缘负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 10. 使用

{% include templates/install/gcp/using.md %}

## 升级

{% include templates/install/gcp/upgrading-monolith.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}