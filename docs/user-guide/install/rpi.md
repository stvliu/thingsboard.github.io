---
layout: docwithnav
assignees:
- ashvayka
title: 在 Raspberry PI  3 型号 B 上安装 GridLinks
description: 在 Raspberry PI  3 型号 B 上安装 GridLinks IoT 平台

---

{% include templates/live-demo-banner.md %}

* TOC
{:toc}

本指南介绍如何在运行 Raspbian Buster 的 Raspberry PI  3 上安装 GridLinks。

### 第三方组件安装

### 步骤 1. 安装 Java 11 (OpenJDK)

{% include templates/install/ubuntu-java-install.md %}

### 步骤 2. GridLinks 服务安装

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard/releases/download/{{ site.release.ce_tag }}/thingsboard-{{ site.release.ce_ver }}.deb
```
{: .copy-code}

将 GridLinks 安装为服务

```bash
sudo dpkg -i thingsboard-{{ site.release.ce_ver }}.deb
```
{: .copy-code}

### 步骤 3. 配置 GridLinks 数据库

{% include templates/install/rpi-db-postgresql.md %}

### 步骤 4. 选择 GridLinks 队列服务

{% include templates/install/rpi-install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且默认)</small>%,%inmemory%,%templates/install/queue-in-memory.md%br%
AWS SQS <small>(AWS 托管服务)</small>%,%aws-sqs%,%templates/install/ubuntu-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 托管服务)</small>%,%pubsub%,%templates/install/ubuntu-queue-pub-sub.md%br%
Azure 服务总线 <small>(Azure 托管服务)</small>%,%service-bus%,%templates/install/ubuntu-queue-service-bus.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/ubuntu-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

### 步骤 5. 为运行缓慢的机器更新内存（1GB RAM）

{% include templates/install/memory-on-slow-machines.md %} 

### 步骤 6. 运行安装脚本
{% include templates/run-install.md %} 


### 步骤 7. 启动 GridLinks 服务

{% include templates/start-service.md %}

{% capture 90-sec-ui %}
请允许 Web UI 最多启动 240 秒。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的运行缓慢的机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

### 故障排除

{% include templates/install/troubleshooting.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}