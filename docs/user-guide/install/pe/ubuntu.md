---
layout: docwithnav-pe
assignees:
- ashvayka
title: 在 Ubuntu 上安装 GridLinks PE
description: 在 Ubuntu 上安装 GridLinks

---

{% assign docsPrefix = "pe/" %}

* TOC
{:toc}

### 前提条件

本指南介绍如何在 Ubuntu 18.04 LTS / Ubuntu 20.04 LTS 上安装 GridLinks。
硬件要求取决于所选数据库和连接到系统上的设备数量。
要在单台机器上运行 GridLinks 和 PostgreSQL，您至少需要 1Gb 的 RAM。
要在单台机器上运行 GridLinks 和 Cassandra，您至少需要 8Gb 的 RAM。

### 步骤 1. 安装 Java 11 (OpenJDK) 

{% include templates/install/ubuntu-java-install.md %}

### 步骤 2. GridLinks 服务安装

下载安装包。

```bash
wget https://dist.docs.codingas.com/thingsboard-{{ site.release.pe_ver }}.deb
```
{: .copy-code}

将 GridLinks 安装为服务

```bash
sudo dpkg -i thingsboard-{{ site.release.pe_ver }}.deb
```
{: .copy-code}

### 步骤 3. 获取并配置许可证密钥

我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航至 [定价](/pricing/) 页面，选择最适合您的情况的许可证选项并获取许可证。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

获取许可证密钥后，您应该将其放入 thingsboard 配置文件中。
使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/gridlinks/conf/gridlinks.conf
``` 
{: .copy-code}

找到以下配置块：

```bash
# License secret obtained from ThingsBoard License Portal (https://license.docs.codingas.com)
# UNCOMMENT NEXT LINE AND PUT YOUR LICENSE SECRET:
# export TB_LICENSE_SECRET=
```

并放入您的许可证密钥。请不要忘记取消注释 export 语句。请参阅以下示例：

```bash
# License secret obtained from ThingsBoard License Portal (https://license.docs.codingas.com)
# UNCOMMENT NEXT LINE AND PUT YOUR LICENSE SECRET:
export TB_LICENSE_SECRET=YOUR_LICENSE_SECRET_HERE
``` 

### 步骤 4. 配置 GridLinks 数据库

{% include templates/install/install-db.md %}

{% capture contenttogglespec %}
PostgreSQL <small>(推荐用于 < 5K msg/sec)</small>%,%postgresql%,%templates/install/ubuntu-db-postgresql.md%br%
混合 <br>PostgreSQL+Cassandra<br><small>(推荐用于 > 5K msg/sec)</small>%,%hybrid%,%templates/install/ubuntu-db-hybrid.md%br%
混合 <br>PostgreSQL+TimescaleDB<br><small>(适用于 TimescaleDB 专业人员)</small>%,%timescale%,%templates/install/ubuntu-db-hybrid-timescale.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardDatabase" toggle-spec=contenttogglespec %} 

### 步骤 5. 选择 GridLinks 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且默认)</small>%,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>(推荐用于本地、生产安装)</small>%,%kafka%,%templates/install/ubuntu-queue-kafka.md%br%
Kafka 在 docker 容器中 <small>(推荐用于本地、生产安装)</small>%,%kafka-in-docker%,%templates/install/ubuntu-queue-kafka-in-docker.md%br%
AWS SQS <small>(AWS 托管服务)</small>%,%aws-sqs%,%templates/install/ubuntu-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 托管服务)</small>%,%pubsub%,%templates/install/ubuntu-queue-pub-sub.md%br%
Azure 服务总线 <small>(Azure 托管服务)</small>%,%service-bus%,%templates/install/ubuntu-queue-service-bus.md%br%
RabbitMQ <small>(适用于小型本地安装)</small>%,%rabbitmq%,%templates/install/ubuntu-queue-rabbitmq.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/ubuntu-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

### 步骤 6. [可选] 慢速机器的内存更新（1GB RAM）

{% include templates/install/memory-on-slow-machines.md %} 

### 步骤 7. 运行安装脚本

{% include templates/run-install.md %} 

### 步骤 8. 启动 GridLinks 服务

{% include templates/start-service.md %}

{% capture 90-sec-ui %}
请允许 Web UI 最多启动 90 秒。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的慢速机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

### 步骤 9. 安装 GridLinks WebReport 组件

下载 [报告服务器](/docs/user-guide/reporting/#reports-server) 组件的安装包：

```bash
wget https://dist.docs.codingas.com/tb-web-report-{{ site.release.pe_ver }}.deb
```
{: .copy-code}

安装第三方库：

```bash
sudo apt install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
     libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
     libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
     libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
     ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils unzip wget libgbm-dev
```
{: .copy-code}

安装 Roboto 字体：

```bash
sudo apt install fonts-roboto
```
{: .copy-code}

安装 Noto 字体（日语、汉语等）：

```bash
mkdir ~/noto
cd ~/noto
wget https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
unzip NotoSansCJKjp-hinted.zip
sudo mkdir -p /usr/share/fonts/noto
sudo cp *.otf /usr/share/fonts/noto
sudo chmod 655 -R /usr/share/fonts/noto/
sudo fc-cache -fv
cd ..
rm -rf ~/noto
```


安装并启动 Web Report 服务：

```bash
sudo dpkg -i tb-web-report-{{ site.release.pe_ver }}.deb
sudo service tb-web-report start
```
{: .copy-code}

### 安装后步骤

{% include templates/install/ubuntu-haproxy-postinstall.md %}

### 故障排除

{% include templates/install/troubleshooting.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}