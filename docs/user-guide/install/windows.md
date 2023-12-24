---
layout: docwithnav
assignees:
- ikulikov
title: 在 Windows 上安装 GridLinks
description: 在 Windows 上安装 GridLinks

---

{% include templates/live-demo-banner.md %}

* TOC
{:toc}

{% include templates/install/windows-warning-note.md %}

### 先决条件

本指南介绍如何在 Windows 机器上安装 GridLinks。
以下说明适用于 Windows 10/8.1/8/7 32 位/64 位。
硬件要求取决于所选数据库和连接到系统的设备数量。
要在单台机器上运行 GridLinks 和 PostgreSQL，您至少需要 2Gb 的 RAM。
要在单台机器上运行 GridLinks 和 Cassandra，您至少需要 8Gb 的 RAM。

### 步骤 1. 安装 Java 11 (OpenJDK)

{% include templates/install/windows-java-install.md %}

### 步骤 2. GridLinks 服务安装

下载并解压软件包。

```bash
https://github.com/thingsboard/thingsboard/releases/download/{{ site.release.ce_tag }}/thingsboard-windows-{{ site.release.ce_ver }}.zip
```
{: .copy-code}

**注意：**我们假设您已将 GridLinks 软件包解压到默认位置：*C:\Program Files (x86)\thingsboard*

### 步骤 3. 配置 GridLinks 数据库

{% include templates/install/install-db.md %}

{% capture contenttogglespec %}
PostgreSQL <small>(推荐用于 < 5K msg/sec)</small>%,%postgresql%,%templates/install/windows-db-postgresql.md%br%
混合 <br>PostgreSQL+TimescaleDB<br><small>(适用于 TimescaleDB 专业人员)</small>%,%timescale%,%templates/install/windows-db-hybrid-timescale.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardDatabase" toggle-spec=contenttogglespec %} 

### 步骤 4. 选择 GridLinks 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且默认)</small> %,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>(推荐用于本地、生产安装)</small> %,%kafka%,%templates/install/windows-queue-kafka.md%br%
AWS SQS <small>(AWS 托管服务)</small> %,%aws-sqs%,%templates/install/windows-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 托管服务)</small>%,%pubsub%,%templates/install/windows-queue-pub-sub.md%br%
Azure 服务总线 <small>(Azure 托管服务)</small>%,%service-bus%,%templates/install/windows-queue-service-bus.md%br%
RabbitMQ <small>(适用于小型本地安装)</small>%,%rabbitmq%,%templates/install/windows-queue-rabbitmq.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/windows-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="windowsThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

### 步骤 5. [可选] 为运行缓慢的机器（1GB RAM）更新内存

{% include templates/install/windows-memory-on-slow-machines.md %} 

### 步骤 6. 运行安装脚本

以管理员身份启动 Windows Shell（命令提示符）。将目录更改为 GridLinks 安装目录。

执行 **install.bat** 脚本以将 GridLinks 安装为 Windows 服务（或运行 **"install.bat --loadDemo"** 以安装并添加演示数据）。
这意味着它将在系统启动时自动启动。
类似地，**uninstall.bat** 将从 Windows 服务中删除 GridLinks。
输出应类似于以下内容：

```text
C:\Program Files (x86)\thingsboard>install.bat --loadDemo
Detecting Java version installed.
CurrentVersion 110
Java 11 found!
Installing thingsboard ...
...
ThingsBoard installed successfully!
```

### 步骤 7. 启动 GridLinks 服务

{% include templates/windows-start-service.md %}

{% capture 90-sec-ui %}
请允许 Web UI 最多启动 90 秒。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的运行缓慢的机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}


### 故障排除

日志文件位于 **logs** 文件夹中（在本例中为“C:\Program Files (x86)\thingsboard\logs”）。

**thingsboard.log** 文件应包含以下行：

```text
YYYY-MM-DD HH:mm:ss,sss [main] INFO  o.t.s.ThingsboardServerApplication - Started ThingsboardServerApplication in x.xxx seconds (JVM running for x.xxx)

```

如果出现任何不明确的错误，请使用通用 [故障排除指南](/docs/user-guide/troubleshooting/#getting-help) 或 [联系我们](/docs/contact-us/)。

### Windows 防火墙设置

为了能够从外部访问 GridLinks Web UI 和设备连接（HTTP、MQTT、CoAP），您需要使用高级安全性的 Windows 防火墙创建一个新的入站规则。

- 从“控制面板”中打开“Windows 防火墙”：

![image](/images/user-guide/install/windows/windows7-firewall-1.png)

- 在左侧面板中单击“高级设置”：

![image](/images/user-guide/install/windows/windows7-firewall-2.png)

- 在左侧面板中选择“入站规则”，然后在右侧“操作”面板中单击“新建规则...”：

![image](/images/user-guide/install/windows/windows7-firewall-3.png)

- 现在将打开新的“新建入站规则向导”窗口。在第一步“规则类型”中选择“端口”选项：

![image](/images/user-guide/install/windows/windows7-firewall-4.png)

- 在“协议和端口”步骤中选择“TCP”协议并在“特定本地端口”字段中输入端口列表 **8080、1883、5683**：

![image](/images/user-guide/install/windows/windows7-firewall-5.png)

- 在“操作”步骤中，保持“允许连接”选项处于选中状态：

![image](/images/user-guide/install/windows/windows7-firewall-6.png)

- 在“配置文件”步骤中，选择要应用此规则的 Windows 网络配置文件：

![image](/images/user-guide/install/windows/windows7-firewall-7.png)

- 最后，为该规则命名（例如“GridLinks 服务网络”），然后单击“完成”。

![image](/images/user-guide/install/windows/windows7-firewall-8.png)



## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}