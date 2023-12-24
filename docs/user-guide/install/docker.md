---
layout: docwithnav
assignees:
- ashvayka
title: 使用 Docker 安装 GridLinks（Linux 或 Mac OS）
description: 使用 Docker 安装 GridLinks IoT 平台（Linux 或 Mac OS）

---

{% include templates/live-demo-banner.md %}

* TOC
{:toc}

本指南将帮助您在 Linux 或 Mac OS 上使用 Docker 安装并启动 GridLinks。


## 先决条件

{% include templates/install/docker-install.md %}

{% include templates/install/docker-install-note.md %}

## 运行

根据所使用的数据库，有三种类型的 ThingsBoard 单实例 docker 镜像：

* [thingsboard/tb-postgres](https://hub.docker.com/r/thingsboard/tb-postgres/) - 带有 PostgreSQL 数据库的 ThingsBoard 单实例。

    推荐用于至少有 1GB RAM 和最小负载（每秒几条消息）的小型服务器。建议使用 2-4GB。
* [thingsboard/tb-cassandra](https://hub.docker.com/r/thingsboard/tb-cassandra/) - 带有 Cassandra 数据库的 ThingsBoard 单实例。

    性能最佳且推荐使用，但至少需要 4GB RAM。建议使用 8GB。
* [thingsboard/tb](https://hub.docker.com/r/thingsboard/tb/) - 带有嵌入式 HSQLDB 数据库的 ThingsBoard 单实例。

    **注意：** 不建议用于任何评估或生产用途，仅用于开发目的和自动测试。

在本说明中，将使用 `thingsboard/tb-postgres` 镜像。您可以选择具有不同数据库的任何其他镜像（见上文）。

## 选择 ThingsBoard 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>（内置且默认）</small>%,%inmemory%,%templates/install/docker-queue-in-memory.md%br%
Kafka <small>（推荐用于本地、生产安装）</small>%,%kafka%,%templates/install/docker-queue-kafka.md%br%
AWS SQS <small>（AWS 托管服务）</small>%,%aws-sqs%,%templates/install/docker-queue-aws-sqs.md%br%
Google Pub/Sub <small>（Google 托管服务）</small>%,%pubsub%,%templates/install/docker-queue-pub-sub.md%br%
Azure 服务总线 <small>（Azure 托管服务）</small>%,%service-bus%,%templates/install/docker-queue-service-bus.md%br%
RabbitMQ <small>（适用于小型本地安装）</small>%,%rabbitmq%,%templates/install/docker-queue-rabbitmq.md%br%
Confluent Cloud <small>（基于 Kafka 的事件流平台）</small>%,%confluent-cloud%,%templates/install/docker-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

其中：

- `8080:9090`            - 将本地端口 8080 连接到公开的内部 HTTP 端口 9090
- `1883:1883`            - 将本地端口 1883 连接到公开的内部 MQTT 端口 1883
- `7070:7070`            - 将本地端口 7070 连接到公开的内部 Edge RPC 端口 7070
- `5683-5688:5683-5688/udp`            - 将本地 UDP 端口 5683-5688 连接到公开的内部 COAP 和 LwM2M 端口
- `~/.mytb-data:/data`   - 将主机的目录 `~/.mytb-data` 挂载到 GridLinks 数据库数据目录
- `~/.mytb-logs:/var/log/thingsboard`   - 将主机的目录 `~/.mytb-logs` 挂载到 GridLinks 日志目录
- `mytb`             - 此机器的友好本地名称
- `restart: always`        - 在系统重新启动时自动启动 ThingsBoard，并在发生故障时重新启动。
- `image: thingsboard/tb-postgres`          - docker 镜像，也可以是 `thingsboard/tb-cassandra` 或 `thingsboard/tb`

{% include templates/install/docker/docker-create-folders-sudo-explained.md %}

```
mkdir -p ~/.mytb-data && sudo chown -R 799:799 ~/.mytb-data
mkdir -p ~/.mytb-logs && sudo chown -R 799:799 ~/.mytb-logs
```
{: .copy-code}

**注意：** 将目录 `~/.mytb-data` 和 `~/.mytb-logs` 替换为计划在 `docker-compose.yml` 中使用的目录。

{% assign serviceName = "tb" %}
{% include templates/install/docker/docker-compose-up-and-ui-credentials.md %}

## 分离、停止和启动命令

{% assign serviceFullName = "ThingsBoard" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 升级

要更新到最新镜像，请执行以下命令：

```
docker pull thingsboard/tb-postgres
docker compose stop
docker run -it -v ~/.mytb-data:/data --rm thingsboard/tb-postgres upgrade-tb.sh
docker compose rm mytb
docker compose up
```
{: .copy-code}

**注意：** 如果您使用不同的数据库，请在所有命令中将镜像名称从 `thingsboard/tb-postgres` 更改为 `thingsboard/tb-cassandra` 或 `thingsboard/tb`。

**注意：** 将主机的目录 `~/.mytb-data` 替换为在创建容器时使用的目录。

**注意：** 如果您已经使用了一个数据库，并且想尝试另一个数据库，那么使用 `docker-compose rm` 命令删除当前的 docker 容器，并在 `docker-compose.yml` 中为 `~/.mytb-data` 使用不同的目录。

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），以下是上述命令的列表：
<br>**docker pull thingsboard/tb-postgres**
<br>**docker-compose stop**
<br>**docker run -it -v ~/.mytb-data:/data --rm thingsboard/tb-postgres upgrade-tb.sh**
<br>**docker-compose rm mytb**
<br>**docker-compose up**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}