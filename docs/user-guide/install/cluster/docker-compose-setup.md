---
layout: docwithnav
assignees:
- ashvayka
title: 使用 Docker Compose 进行集群设置
description: 使用 Docker Compose 指南设置 ThingsBoard IoT 平台集群

---

* TOC
{:toc}

本指南将帮助您使用 Docker Compose 工具在集群模式下设置 ThingsBoard。

## 先决条件

ThingsBoard 微服务在 docker 化环境中运行。
在开始之前，请确保您的系统中已安装 Docker Engine 和 Docker Compose。

{% include templates/install/docker-install.md %}

{% include templates/install/docker-install-note.md %}

## 步骤 1. 拉取 ThingsBoard CE 镜像

确保您已使用命令行登录到 docker hub。

```bash
docker pull thingsboard/tb-node:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-web-ui:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-js-executor:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-http-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-mqtt-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-coap-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-lwm2m-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-snmp-transport:{{ site.release.ce_full_ver }}
```

## 步骤 2. 查看架构页面

从 ThingsBoard v2.2 开始，可以使用新的微服务架构和 docker 容器安装 ThingsBoard 集群。
有关更多详细信息，请参阅[**微服务**](/docs/reference/msa/)架构页面。

## 步骤 3. 克隆 ThingsBoard CE 存储库

```bash
git clone -b {{ site.release.branch }} https://github.com/thingsboard/thingsboard.git --depth 1
cd thingsboard/docker
```
{: .copy-code}

## 步骤 4. 配置 ThingsBoard 数据库

{% include templates/install/configure-db-docker-compose.md %}

## 步骤 5. 选择 ThingsBoard 队列服务

{% include templates/install/install-queue-docker-compose.md %}

{% capture contenttogglespecqueue %}
Kafka <small>（默认，推荐用于本地、生产安装）</small>%,%kafka%,%templates/install/cluster-queue-kafka.md%br%
AWS SQS <small>（AWS 托管服务）</small>%,%aws-sqs%,%templates/install/cluster-queue-aws-sqs.md%br%
Google Pub/Sub <small>（Google 托管服务）</small>%,%pubsub%,%templates/install/cluster-queue-pub-sub.md%br%
Azure Service Bus <small>（Azure 托管服务）</small>%,%service-bus%,%templates/install/cluster-queue-service-bus.md%br%
RabbitMQ <small>（适用于小型本地安装）</small>%,%rabbitmq%,%templates/install/cluster-queue-rabbitmq.md%br%
Confluent Cloud <small>（基于 Kafka 的事件流平台）</small>%,%confluent-cloud%,%templates/install/cluster-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

## 步骤 6. 启用监控（可选）

{% include templates/install/configure-monitoring-docker-compose.md %}

## 步骤 7. 运行

{% assign dockerComposeFileLocation = "" %}
{% include templates/install/docker/docker-compose-setup-running.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}