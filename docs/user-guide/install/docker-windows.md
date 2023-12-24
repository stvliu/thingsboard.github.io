---
layout: docwithnav
assignees:
- ashvayka
title: 使用 Docker 在 Windows 上安装 GridLinks
description: 使用 Docker 在 Windows 上安装 GridLinks IoT 平台

---

{% include templates/live-demo-banner.md %}

* TOC
{:toc}

本指南将帮助您在 Windows 上使用 Docker 安装并启动 GridLinks。


## 先决条件

- [为 Windows 安装 Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)

## 运行

根据所使用的数据库，有三种类型的 ThingsBoard 单实例 docker 镜像：

* [thingsboard/tb-postgres](https://hub.docker.com/r/thingsboard/tb-postgres/) - 带有 PostgreSQL 数据库的 ThingsBoard 单实例。

    适用于至少有 1GB RAM 和最小负载（每秒几条消息）的小型服务器的推荐选项。建议使用 2-4GB。
* [thingsboard/tb-cassandra](https://hub.docker.com/r/thingsboard/tb-cassandra/) - 带有 Cassandra 数据库的 ThingsBoard 单实例。

    性能最佳且推荐的选项，但至少需要 6GB RAM。建议使用 8GB。
* [thingsboard/tb](https://hub.docker.com/r/thingsboard/tb/) - 带有嵌入式 HSQLDB 数据库的 ThingsBoard 单实例。

    **注意：**不建议用于任何评估或生产用途，仅用于开发目的和自动测试。

在本说明中，将使用 `thingsboard/tb-postgres` 镜像。您可以选择具有不同数据库的任何其他镜像（见上文）。

Windows 用户应为 GridLinks 数据库使用 docker 管理的卷。在执行 docker run 命令之前创建 docker 卷（例如 `mytb-data`）：
打开“Docker 快速启动终端”。执行以下命令以创建 docker 卷：

``` 
docker volume create mytb-data
docker volume create mytb-logs
```

## 选择 ThingsBoard 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且默认)</small>%,%inmemory%,%templates/install/windows-docker-queue-in-memory.md%br%
Kafka <small>(推荐用于本地、生产安装)</small>%,%kafka%,%templates/install/windows-docker-queue-kafka.md%br%
AWS SQS <small>(AWS 托管服务)</small>%,%aws-sqs%,%templates/install/windows-docker-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 托管服务)</small>%,%pubsub%,%templates/install/windows-docker-queue-pub-sub.md%br%
Azure 服务总线 <small>(Azure 托管服务)</small>%,%service-bus%,%templates/install/windows-docker-queue-service-bus.md%br%
RabbitMQ <small>(适用于小型本地安装)</small>%,%rabbitmq%,%templates/install/windows-docker-queue-rabbitmq.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/windows-docker-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

其中：

- `8080:9090` - 将本地端口 8080 连接到公开的内部 HTTP 端口 9090
- `1883:1883` - 将本地端口 1883 连接到公开的内部 MQTT 端口 1883
- `7070:7070` - 将本地端口 7070 连接到公开的内部 Edge RPC 端口 7070
- `5683-5688:5683-5688/udp` - 将本地 UDP 端口 5683-5688 连接到公开的内部 COAP 和 LwM2M 端口
- `~/.mytb-data:/data` - 将主机的目录 `~/.mytb-data` 挂载到 GridLinks 数据库数据目录
- `~/.mytb-logs:/var/log/thingsboard` - 将主机的目录 `~/.mytb-logs` 挂载到 GridLinks 日志目录
- `mytb` - 此计算机的友好本地名称
- `restart: always` - 在系统重新启动时自动启动 ThingsBoard，并在发生故障时重新启动。
- `image: thingsboard/tb-postgres` - docker 镜像，也可以是 `thingsboard/tb-cassandra` 或 `thingsboard/tb`

{% assign serviceName = "tb" %}
{% include templates/install/docker/docker-compose-up.md %}

为了从 Windows 计算机上的外部 IP/主机访问必要的资源，请执行以下命令：

``` 
set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"
VBoxManage controlvm "default" natpf1 "tcp-port8080,tcp,,8080,,9090"  
VBoxManage controlvm "default" natpf1 "tcp-port1883,tcp,,1883,,1883"
VBoxManage controlvm "default" natpf1 "tcp-port7070,tcp,,7070,,7070"
VBoxManage controlvm "default" natpf1 "udp-port5683,udp,,5683,,5683"
VBoxManage controlvm "default" natpf1 "udp-port5684,udp,,5684,,5684"
VBoxManage controlvm "default" natpf1 "udp-port5685,udp,,5685,,5685"
VBoxManage controlvm "default" natpf1 "udp-port5686,udp,,5686,,5686"
VBoxManage controlvm "default" natpf1 "udp-port5687,udp,,5687,,5687"
VBoxManage controlvm "default" natpf1 "udp-port5688,udp,,5688,,5688"
```
{: .copy-code}

其中：

- `C:\Program Files\Oracle\VirtualBox` - VirtualBox 安装目录的路径


执行此命令后，您可以在浏览器中打开 `http://{your-host-ip}:8080`（例如 `http://localhost:8080`）。您应该会看到 GridLinks 登录页面。
使用以下默认凭据：

- **系统管理员**：sysadmin@gridlinks.com / sysadmin
- **租户管理员**：tenant@gridlinks.com / tenant
- **客户用户**：customer@gridlinks.com / customer
    
您始终可以在帐户个人资料页面中更改每个帐户的密码。

## 分离、停止和启动命令

{% assign serviceFullName = "ThingsBoard" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 升级

为了更新到最新镜像，请打开“Docker 快速启动终端”并执行以下命令：

```
$ docker pull thingsboard/tb-postgres
$ docker compose stop
$ docker run -it -v mytb-data:/data --rm thingsboard/tb-postgres upgrade-tb.sh
$ docker compose rm mytb
$ docker compose up
```

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），以下是上述命令的列表：
<br>**$ docker pull thingsboard/tb-postgres**
<br>**$ docker-compose stop**
<br>**$ docker run -it -v mytb-data:/data --rm thingsboard/tb-postgres upgrade-tb.sh**
<br>**$ docker-compose rm mytb**
<br>**$ docker-compose up**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}


**注意：**如果您使用不同的数据库，请在所有命令中将镜像名称从 `thingsboard/tb-postgres` 相应地更改为 `thingsboard/tb-cassandra` 或 `thingsboard/tb`。
 
**注意：**将卷 `mytb-data` 替换为在创建容器时使用的卷。

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues-windows.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}