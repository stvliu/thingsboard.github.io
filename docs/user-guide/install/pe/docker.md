---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 Docker 在 Linux 或 Mac OS 上安装 GridLinks PE
description: 使用 Docker 在 Linux 或 Mac OS 上安装 GridLinks PE IoT 平台
redirect_from: "/docs/pe/user-guide/install/docker/"
---

* TOC
{:toc}


本指南将帮助您在 Linux 或 Mac OS 上使用 Docker 和 Docker Compose 安装并启动  GridLinks专业版 (PE)。
本指南涵盖独立的 GridLinks PE 安装。
如果您正在寻找集群安装说明，请访问 [集群设置页面](/docs/user-guide/install/pe/cluster-setup/)。

## 先决条件

{% include templates/install/docker-install.md %}

{% include templates/install/docker-install-note.md %}

## 步骤 1. 拉取 GridLinks PE 镜像

```bash
docker pull thingsboard/tb-pe:{{ site.release.pe_full_ver }}
```
{: .copy-code}

## 步骤 2. 获取许可证密钥

我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航至 [定价](/pricing/) 页面，为您的案例选择最佳许可证选项并获取许可证。
有关更多详细信息，请参阅 [如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

注意：我们将在本指南的后面将您在此步骤中获得的许可证密钥称为 PUT_YOUR_LICENSE_SECRET_HERE。

## 步骤 3. 选择 ThingsBoard 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且默认)</small>%,%inmemory%,%templates/install/pe-docker-queue-in-memory.md%br%
Kafka <small>(推荐用于本地生产安装)</small>%,%kafka%,%templates/install/pe-docker-queue-kafka.md%br%
AWS SQS <small>(AWS 托管服务)</small>%,%aws-sqs%,%templates/install/pe-docker-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 托管服务)</small>%,%pubsub%,%templates/install/pe-docker-queue-pub-sub.md%br%
Azure 服务总线 <small>(Azure 托管服务)</small>%,%service-bus%,%templates/install/pe-docker-queue-service-bus.md%br%
RabbitMQ <small>(适用于小型本地安装)</small>%,%rabbitmq%,%templates/install/pe-docker-queue-rabbitmq.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/pe-docker-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %}

其中：

- `PUT_YOUR_LICENSE_SECRET_HERE` - 您在第三步中获得的许可证密钥的占位符；
- `8080:8080`            - 将本地端口 8080 连接到公开的内部 HTTP 端口 8080；
- `1883:1883`            - 将本地端口 1883 连接到公开的内部 MQTT 端口 1883；
- `7070:7070`            - 将本地端口 7070 连接到公开的内部 Edge RPC 端口 7070；
- `5683-5688:5683-5688/udp`            - 将本地 UDP 端口 5683-5688 连接到公开的内部 COAP 和 LwM2M 端口；
- `~/.mytbpe-data:/data`   - 将主机的目录 `~/.mytbpe-data` 挂载到 GridLinks 数据目录；
- `~/.mytbpe-data/db:/var/lib/postgresql/data`   - 将主机的目录 `~/.mytbpe-data/db` 挂载到 Postgres 数据目录；
- `~/.mytbpe-logs:/var/log/thingsboard`   - 将主机的目录 `~/.mytbpe-logs` 挂载到 GridLinks 日志目录；
- `mytbpe`             - 此计算机的友好本地名称；
- `restart: always`        - 在系统重新启动时自动启动 ThingsBoard，并在发生故障时重新启动；
- `thingsboard/tb-pe:{{ site.release.pe_full_ver }}`          - docker 镜像。

## 步骤 4. 运行

{% include templates/install/docker/docker-create-folders-sudo-explained.md %}

```
mkdir -p ~/.mytbpe-data && sudo chown -R 799:799 ~/.mytbpe-data
mkdir -p ~/.mytbpe-logs && sudo chown -R 799:799 ~/.mytbpe-logs
```
{: .copy-code}

**注意**：将目录 `~/.mytbpe-data` 和 `~/.mytbpe-logs` 替换为您计划在 `docker-compose.yml` 中使用的目录。

{% assign serviceName = "tbpe" %}
{% include templates/install/docker/docker-compose-up-and-ui-credentials.md %}

## 分离、停止和启动命令

{% assign serviceFullName = "ThingsBoard PE" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues.md %}

### 从 3.1.0PE 升级

以下是有关如何从 3.1.0 升级到 3.1.1 的示例

* 停止 mytbpe 容器

```bash
docker compose stop mytbpe
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose stop mytbpe**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 创建数据库转储：

```bash
docker compose exec postgres sh -c "pg_dump -U postgres thingsboard > /var/lib/postgresql/data/thingsboard_dump"
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose exec postgres sh -c "pg_dump -U postgres thingsboard > /var/lib/postgresql/data/thingsboard_dump"**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 在此之后，您需要按照 [步骤 3](#步骤-3-选择-thingsboard-队列-服务) 中的说明更新 docker-compose.yml，但将 3.1.0PE 替换为 3.1.1PE：

* 将 upgradeversion 变量更改为您的 **当前** GridLinks 版本。

 ```bash
sudo sh -c "echo '3.1.0' > ~/.mytbpe-data/.upgradeversion"
```
{: .copy-code}

* 然后执行以下命令：

```bash
docker compose run mytbpe upgrade-tb.sh
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose run mytbpe upgrade-tb.sh**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 启动 ThingsBoard：

```bash
docker compose up -d
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose up -d**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

要将 GridLinks 升级到最新版本，这些步骤应该 **针对每个中间版本** 完成。

请注意，升级不是累积的。
请参阅 [升级说明](/docs/user-guide/install/pe/upgrade-instructions/) 以了解正确的升级顺序（例如，如果您要从 3.1.0 升级到 3.2.1，则需要按以下顺序进行：3.1.0 -> 3.1.1 -> 3.2.0 -> 3.2.1，例如当前版本 -> 下一个发布版本 -> 等）


如果您需要 **从备份中恢复**：

* 停止 mytbpe 容器

```bash
docker compose stop mytbpe
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose stop mytbpe**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 将 docker-compose.yml 更新为初始版本。

* 执行

```bash
docker compose exec postgres sh -c "psql -U postgres -c 'drop database thingsboard'"
docker compose exec postgres sh -c "psql -U postgres -c 'create database thingsboard'"
docker compose exec postgres sh -c "psql -U postgres thingsboard < /var/lib/postgresql/data/thingsboard_dump"
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），这里列出了上述命令：
<br>**docker-compose exec postgres sh -c "psql -U postgres -c 'drop database thingsboard'"**
<br>**docker-compose exec postgres sh -c "psql -U postgres -c 'create database thingsboard'"**
<br>**docker-compose exec postgres sh -c "psql -U postgres thingsboard < /var/lib/postgresql/data/thingsboard_dump"**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 启动 ThingsBoard：

```bash
docker compose up -d
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose up -d**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

如果您需要 **将备份复制到本地目录** 以便在另一台服务器上恢复它：

```
docker cp tb-docker_postgres_1:/var/lib/postgresql/data/thingsboard_dump .
```
{: .copy-code}


注意：您应该粘贴 postgres 容器的名称。

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}