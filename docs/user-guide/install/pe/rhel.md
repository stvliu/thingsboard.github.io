---
layout: docwithnav-pe
assignees:
- ashvayka
title: 在 CentOS/RHEL 上安装 GridLinks PE
description: 在 CentOS/RHEL 上安装 GridLinks PE

---

{% assign docsPrefix = "pe/" %}

* TOC
{:toc}

### 先决条件

本指南介绍如何在 RHEL/CentOS 7/8 上安装 GridLinks。
硬件要求取决于所选数据库和连接到系统的设备数量。
要在单台机器上运行 GridLinks 和 PostgreSQL，您至少需要 1Gb 的 RAM。
要在单台机器上运行 GridLinks 和 Cassandra，您至少需要 8Gb 的 RAM。

在继续安装之前，执行以下命令以安装必要的工具：

**对于 CentOS 7：**

```bash
# 安装 wget
sudo yum install -y nano wget
# 添加 CentOS 7 的最新 EPEL 版本
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

```
{: .copy-code}

**对于 CentOS 8：**

```bash
# 安装 wget
sudo yum install -y nano wget
# 添加 CentOS 8 的最新 EPEL 版本
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

```
{: .copy-code}

### 步骤 1. 安装 Java 11 (OpenJDK) 

{% include templates/install/rhel-java-install.md %}

### 步骤 2. GridLinks 服务安装

下载安装包。

```bash
wget https://dist.thingsboard.io/thingsboard-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

将 GridLinks 安装为服务

```bash
sudo rpm -Uvh thingsboard-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

### 步骤 3. 获取并配置许可证密钥

我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航至 [定价](/pricing/) 页面，为您的案例选择最佳许可证选项并获取许可证。
有关更多详细信息，请参阅 [如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

获取许可证密钥后，您应该将其放入 thingsboard 配置文件中。
使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

找到以下配置块：

```bash
# License secret obtained from ThingsBoard License Portal (https://license.thingsboard.io)
# UNCOMMENT NEXT LINE AND PUT YOUR LICENSE SECRET:
# export TB_LICENSE_SECRET=
```

并放入您的许可证密钥。请不要忘记取消注释 export 语句。请参阅以下示例：

```bash
# License secret obtained from ThingsBoard License Portal (https://license.thingsboard.io)
# UNCOMMENT NEXT LINE AND PUT YOUR LICENSE SECRET:
export TB_LICENSE_SECRET=YOUR_LICENSE_SECRET_HERE
``` 

### 步骤 4. 配置 ThingsBoard 数据库

{% include templates/install/install-db.md %}

{% capture contenttogglespec %}
PostgreSQL <small>(推荐用于 < 5K msg/sec)</small>%,%postgresql%,%templates/install/rhel-db-postgresql.md%br%
混合 <br>PostgreSQL+Cassandra<br><small>(推荐用于 > 5K msg/sec)</small>%,%hybrid%,%templates/install/rhel-db-hybrid.md%br%
混合 <br>PostgreSQL+TimescaleDB<br><small>(适用于 TimescaleDB 专业人员)</small>%,%timescale%,%templates/install/rhel-db-hybrid-timescale.md{% endcapture %}


{% include content-toggle.html content-toggle-id="rhelThingsboardDatabase" toggle-spec=contenttogglespec %} 

### 步骤 5. 选择 ThingsBoard 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且默认)</small>%,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>(推荐用于本地、生产安装)</small>%,%kafka%,%templates/install/rhel-queue-kafka.md%br%
AWS SQS <small>(AWS 的托管服务)</small>%,%aws-sqs%,%templates/install/ubuntu-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 的托管服务)</small>%,%pubsub%,%templates/install/ubuntu-queue-pub-sub.md%br%
Azure Service Bus <small>(Azure 的托管服务)</small>%,%service-bus%,%templates/install/ubuntu-queue-service-bus.md%br%
RabbitMQ <small>(适用于小型本地安装)</small>%,%rabbitmq%,%templates/install/rhel-queue-rabbitmq.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/ubuntu-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

### 步骤 6. [可选] 为速度较慢的机器更新内存 (1GB RAM) 

{% include templates/install/memory-on-slow-machines.md %} 

### 步骤 7. 运行安装脚本
{% include templates/run-install.md %} 


### 步骤 8. 启动 GridLinks 服务

默认情况下，GridLinks UI 可通过 8080 端口访问。
确保可以通过防火墙访问您的 8080 端口。
为了打开 8080 端口，执行以下命令：

```bash
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```   

{% include templates/start-service.md %}

{% capture 90-sec-ui %}
请允许 Web UI 启动长达 90 秒。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的速度较慢的机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

### 步骤 9. 安装 GridLinks WebReport 组件

下载 [报表服务器](/docs/user-guide/reporting/#reports-server) 组件的安装包：

```bash
wget https://dist.thingsboard.io/tb-web-report-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

安装第三方库：

```bash
sudo yum install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 \
     libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 \
     alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi \
     xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc unzip nss -y
```
{: .copy-code}

安装 Roboto 字体：

```bash
sudo yum install google-roboto-fonts -y
```
{: .copy-code}

安装 Noto 字体（日语、中文等）：

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
sudo rpm -Uvh tb-web-report-{{ site.release.pe_ver }}.rpm
sudo service tb-web-report start
```

### 安装后步骤

{% include templates/install/rhel-haproxy-postinstall.md %}

### 故障排除

{% include templates/install/troubleshooting.md %}

## 后续步骤



{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}