---
layout: docwithnav-pe
assignees:
- ashvayka
title: ThingsBoard Professional Edition 集群设置与 Docker Compose 指南
description: ThingsBoard Professional Edition 集群设置与 Docker Compose 指南
redirect_from: "/docs/user-guide/install/pe/docker-cassandra/"  

---

* TOC
{:toc}

{% assign docsPrefix = "pe/" %}

本指南将帮助您使用 Docker Compose 在集群模式下设置 ThingsBoard。
为此，我们将使用 [Docker Hub](https://hub.docker.com/search?q=thingsboard&type=image&image_filter=store) 上提供的 Docker 容器映像。

## 先决条件

ThingsBoard 微服务在 Docker 化环境中运行。
在开始之前，请确保您的系统中已安装 Docker Engine 和 Docker Compose。

{% include templates/install/docker-install.md %}

{% capture rule_engine_note %}
请注意，要将规则引擎部署为单独的服务，需要额外的单独许可证密钥。
{% endcapture %}
{% include templates/info-banner.md content=rule_engine_note %}

{% include templates/install/docker-install-note.md %}

## 步骤 1. 拉取 ThingsBoard PE 映像

{% include templates/install/dockerhub/pull.md %}

## 步骤 2. 克隆 ThingsBoard PE Docker Compose 脚本

```bash
git clone -b release-{{ site.release.ce_ver }} https://github.com/thingsboard/thingsboard-pe-docker-compose.git tb-pe-docker-compose --depth 1
cd tb-pe-docker-compose
```
{: .copy-code}

## 步骤 3. 获取您的许可证密钥

我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航至 [定价](/pricing/) 页面，为您的案例选择最佳许可证选项并获取许可证。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

**重要提示：**如果您决定使用 [高级部署类型](/docs/user-guide/install/pe/cluster/docker-compose-setup/#step-6-configure-deployment-type)，请确保您已购买至少四个 ThingsBoard PE 实例的许可证密钥。
否则，您需要修改 [docker-compose.yml](https://github.com/thingsboard/thingsboard-pe-docker-compose/blob/master/advanced/docker-compose.yml)) 的本地副本，以使用您已购买的 ThingsBoard 实例数。
我们将在本指南的后面将您在此步骤中获得的许可证密钥称为 PUT_YOUR_LICENSE_SECRET_HERE。


## 步骤 4. 配置您的许可证密钥

```bash
nano tb-node.env
```
{: .copy-code}

并将许可证密钥参数放在 "PUT_YOUR_LICENSE_SECRET_HERE" 的位置：

```bash
# ThingsBoard 服务器配置
...
TB_LICENSE_SECRET=PUT_YOUR_LICENSE_SECRET_HERE
```

## 步骤 5. 配置部署类型

从 ThingsBoard v2.2 开始，可以使用新的微服务架构和 Docker 容器安装 ThingsBoard 集群。
有关更多详细信息，请参阅 [**微服务**](/docs/reference/msa/) 架构页面。

Docker Compose 脚本支持三种部署模式。要设置部署模式，请将 `.env` 文件中 `TB_SETUP` 变量的值更改为以下之一：

- `basic` **（推荐，默认设置）** - ThingsBoard Core 和规则引擎在一个 JVM 中启动（仅需一个许可证）。
  MQTT、CoAP 和 HTTP 传输在单独的容器中启动。
- `monolith` - ThingsBoard Core 和规则引擎在一个 JVM 中启动（仅需一个许可证）。
  MQTT、CoAP 和 HTTP 传输也在同一个 JVM 中启动，以最大程度地减少内存占用和服务器要求。
- `advanced`- ThingsBoard Core 和规则引擎在单独的容器中启动，并复制一个 JVM（需要 4 个许可证）。  
  
所有部署模式都支持单独的 JS 执行器、Redis 和不同的 [队列](/docs/user-guide/install/pe/cluster/docker-compose-setup/#step-8-choose-thingsboard-queue-service)。

## 步骤 6. 配置 ThingsBoard 数据库

{% include templates/install/configure-db-docker-compose.md %}

## 步骤 7. 选择 ThingsBoard 队列服务

{% include templates/install/install-queue-docker-compose.md %}

{% capture contenttogglespecqueue %}
Kafka <small>（默认，推荐用于本地、生产安装）</small>%,%kafka%,%templates/install/cluster-queue-kafka.md%br%
AWS SQS <small>（AWS 的托管服务）</small>%,%aws-sqs%,%templates/install/cluster-queue-aws-sqs.md%br%
Google Pub/Sub <small>（Google 的托管服务）</small>%,%pubsub%,%templates/install/cluster-queue-pub-sub.md%br%
Azure Service Bus <small>（Azure 的托管服务）</small>%,%service-bus%,%templates/install/cluster-queue-service-bus.md%br%
RabbitMQ <small>（适用于小型本地安装）</small>%,%rabbitmq%,%templates/install/cluster-queue-rabbitmq.md%br%
Confluent Cloud <small>（基于 Kafka 的事件流平台）</small>%,%confluent-cloud%,%templates/install/cluster-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %}

## 步骤 8. 启用监控（可选）

{% include templates/install/configure-monitoring-docker-compose.md %}

## 步骤 9. 运行

{% assign dockerComposeFileLocation = "-f $TB_SETUP/docker-compose.yml " %}
{% include templates/install/docker/docker-compose-setup-running.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}