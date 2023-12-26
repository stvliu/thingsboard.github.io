---
layout: docwithnav
assignees:
- ashvayka
title: 使用 GCP 基础设施设置微服务
description: 在 GKE 中使用 Kubernetes 设置 GridLinks IoT 平台微服务

---

* TOC
{:toc}

本指南将帮助您在 GKE 中以微服务模式设置 GridLinks。

## 前提条件

{% include templates/install/gcp/gke-prerequisites.md %}


## 步骤 1. 克隆 ThingsBoard CE K8S 脚本存储库

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git
cd thingsboard-ce-k8s/gcp/microservices
```

## 步骤 2. 定义环境变量

{% assign tbClusterName = "tb-ce-msa" %}
{% include templates/install/gcp/env-variables-msa.md %}

## 步骤 3. 配置并创建 GKE 集群

{% include templates/install/gcp/regional-gke-cluster.md %}

## 步骤 4. 更新 kubectl 的上下文

{% include templates/install/gcp/update-kubectl-region.md %}

## 步骤 5. 配置数据库

### 步骤 5.1 Google Cloud SQL（PostgreSQL）实例

{% include templates/install/gcp/provision-postgresql.md %}

### 步骤 5.2 Cassandra（可选）

{% include templates/install/gcp/configure-cassandra.md %}

## 步骤 6. 安装

{% include templates/install/gcp/install.md %}

## 步骤 7. 启动

{% include templates/install/gcp/start-msa.md %}

## 步骤 8. 配置负载均衡器

### 8.1 配置 HTTP(S) 负载均衡器

{% include templates/install/gcp/http-lb.md %}

### 8.2. 配置 MQTT 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-mqtt-transport.yml" %}
{% include templates/install/gcp/configure-mqtt.md %}

### 8.3. 配置 CoAP 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-coap-transport.yml" %}
{% include templates/install/gcp/configure-coap.md %}

### 8.4. 配置 LwM2M 负载均衡器（可选）

{% assign tbServicesFile = "transport/tb-lwm2m-transport.yml" %}
{% include templates/install/gcp/configure-lwm2m.md %}

### 8.5. 配置 Edge 负载均衡器（可选）

{% include templates/install/k8s-configure-edge-load-balancer.md %}

## 步骤 9. 使用

{% include templates/install/gcp/using.md %}

## 升级

{% include templates/install/gcp/upgrading-msa.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}