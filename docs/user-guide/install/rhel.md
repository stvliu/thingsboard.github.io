---
layout: docwithnav
assignees:
- ashvayka
title: 在 CentOS/RHEL 上安装 ThingsBoard CE
description: 在 CentOS/RHEL 上安装 ThingsBoard CE

---

* TOC
{:toc}

### 先决条件

本指南介绍如何在 RHEL/CentOS 7/8 上安装 ThingsBoard。
硬件要求取决于所选数据库和连接到系统的设备数量。
要在单台机器上运行 ThingsBoard 和 PostgreSQL，您至少需要 1Gb 的 RAM。
要在单台机器上运行 ThingsBoard 和 Cassandra，您至少需要 8Gb 的 RAM。

在继续安装之前，执行以下命令以安装必要的工具：

**对于 CentOS 7：**

```bash
# 安装 wget
sudo yum install -y nano wget
# 为 CentOS 7 添加最新的 EPEL 版本
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

```
{: .copy-code}

**对于 CentOS 8：**

```bash
# 安装 wget
sudo yum install -y nano wget
# 为 CentOS 8 添加最新的 EPEL 版本
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

```
{: .copy-code}

### 步骤 1. 安装 Java 11（OpenJDK）

{% include templates/install/rhel-java-install.md %} 

### 步骤 2. 安装 ThingsBoard 服务

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard/releases/download/{{ site.release.ce_tag }}/thingsboard-{{ site.release.ce_ver }}.rpm
```
{: .copy-code}

将 ThingsBoard 安装为服务

```bash
sudo rpm -Uvh thingsboard-{{ site.release.ce_ver }}.rpm
```
{: .copy-code}


### 步骤 3. 配置 ThingsBoard 数据库

{% include templates/install/install-db.md %}

{% capture contenttogglespec %}
PostgreSQL <small>（推荐用于 < 5K msg/sec）</small>%,%postgresql%,%templates/install/rhel-db-postgresql.md%br%
混合 <br>PostgreSQL+Cassandra<br><small>（推荐用于 > 5K msg/sec）</small>%,%hybrid%,%templates/install/rhel-db-hybrid.md%br%
混合 <br>PostgreSQL+TimescaleDB<br><small>（适用于 TimescaleDB 专业人员）</small>%,%timescale%,%templates/install/rhel-db-hybrid-timescale.md{% endcapture %}

{% include content-toggle.html content-toggle-id="rhelThingsboardDatabase" toggle-spec=contenttogglespec %} 

### 步骤 4. 选择 ThingsBoard 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>（内置且默认）</small>%,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>（推荐用于本地、生产安装）</small>%,%kafka%,%templates/install/rhel-queue-kafka.md%br%
AWS SQS <small>（AWS 的托管服务）</small> %,%aws-sqs%,%templates/install/ubuntu-queue-aws-sqs.md%br%
Google Pub/Sub <small>（Google 的托管服务）</small> %,%pubsub%,%templates/install/ubuntu-queue-pub-sub.md%br%
Azure 服务总线 <small>（Azure 的托管服务）</small>%,%service-bus%,%templates/install/ubuntu-queue-service-bus.md%br%
RabbitMQ <small>（适用于小型本地安装）</small>%,%rabbitmq%,%templates/install/rhel-queue-rabbitmq.md%br%
Confluent Cloud <small>（基于 Kafka 的事件流平台）</small>%,%confluent-cloud%,%templates/install/ubuntu-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

### 步骤 5. [可选] 为运行缓慢的机器（1GB RAM）更新内存

{% include templates/install/memory-on-slow-machines.md %} 

### 步骤 6. 运行安装脚本
{% include templates/run-install.md %} 


### 步骤 7. 启动 ThingsBoard 服务

默认情况下，ThingsBoard UI 可通过 8080 端口访问。
确保可以通过防火墙访问您的 8080 端口。
要打开 8080 端口，请执行以下命令：

```bash
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```
{: .copy-code}   

{% include templates/start-service.md %}

{% capture 90-sec-ui %}
请允许 Web UI 最多启动 90 秒。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的运行缓慢的机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

### 安装后步骤

{% include templates/install/rhel-haproxy-postinstall.md %}

### 故障排除

{% include templates/install/troubleshooting.md %}

## 后续步骤


{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}