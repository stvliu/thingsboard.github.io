---
layout: docwithnav-pe
assignees:
- ashvayka
title: 在 Windows 上使用 Docker 安装 GridLinks PE
description: 在 Windows 上使用 Docker 安装 GridLinks PE IoT 平台
redirect_from: "/docs/pe/user-guide/install/docker-windows/"
---

* TOC
{:toc}


本指南将帮助您在 Windows 上使用 Docker 安装并启动  GridLinks专业版 (PE)。
本指南涵盖独立的 GridLinks PE 安装。
如果您正在寻找集群安装说明，请访问 [集群设置页面](/docs/user-guide/install/pe/cluster-setup/)。

## 先决条件

- [为 Windows 安装 Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)


## 步骤 1. 拉取 GridLinks PE 镜像

```bash
docker pull thingsboard/tb-pe:{{ site.release.pe_full_ver }}
```
{: .copy-code}

## 步骤 2. 获取许可证密钥

我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航至 [定价](/pricing/) 页面，为您的案例选择最佳许可证选项并获取许可证。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

注意：在本指南的后面，我们将引用您在此步骤中获得的许可证密钥，即 PUT_YOUR_LICENSE_SECRET_HERE。

## 步骤 3. 选择 GridLinks 队列服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
内存 <small>(内置且为默认)</small>%,%inmemory%,%templates/install/windows-pe-docker-queue-in-memory.md%br%
Kafka <small>(推荐用于本地生产安装)</small>%,%kafka%,%templates/install/windows-pe-docker-queue-kafka.md%br%
AWS SQS <small>(AWS 托管服务)</small>%,%aws-sqs%,%templates/install/windows-pe-docker-queue-aws-sqs.md%br%
Google Pub/Sub <small>(Google 托管服务)</small>%,%pubsub%,%templates/install/windows-pe-docker-queue-pub-sub.md%br%
Azure 服务总线 <small>(Azure 托管服务)</small>%,%service-bus%,%templates/install/windows-pe-docker-queue-service-bus.md%br%
RabbitMQ <small>(适用于小型本地安装)</small>%,%rabbitmq%,%templates/install/windows-pe-docker-queue-rabbitmq.md%br%
Confluent Cloud <small>(基于 Kafka 的事件流平台)</small>%,%confluent-cloud%,%templates/install/windows-pe-docker-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

其中：

- `8080:8080` - 将本地端口 8080 连接到公开的内部 HTTP 端口 8080
- `1883:1883` - 将本地端口 1883 连接到公开的内部 MQTT 端口 1883
- `7070:7070` - 将本地端口 7070 连接到公开的内部 Edge RPC 端口 7070
- `5683-5688:5683-5688/udp` - 将本地 UDP 端口 5683-5688 连接到公开的内部 COAP 和 LwM2M 端口
- `mytbpe-data:/data` - 将卷 `mytb-data` 挂载到 GridLinks 数据目录
- `mytbpe-data-db:/var/lib/postgresql/data` - 将卷 `mytbpe-data-db` 挂载到 Postgres 数据目录；
- `mytb-logs:/var/log/gridlinks` - 将卷 `mytb-logs` 挂载到 GridLinks 日志目录
- `mytbpe` - 此计算机的友好本地名称
- `restart: always` - 在系统重新启动时自动启动 ThingsBoard，并在发生故障时重新启动。
- `image: thingsboard/tb-pe:{{ site.release.pe_full_ver }}` - docker 镜像。

## 步骤 4. 运行

Windows 用户应为 GridLinks 数据库使用 docker 管理的卷。
在执行 docker run 命令之前创建 docker 卷（例如 `mytbpe-data`）：
打开“Docker 快速启动终端”。执行以下命令以创建 docker 卷：

``` 
docker volume create mytbpe-data
docker volume create mytbpe-data-db
docker volume create mytbpe-logs
```
{: .copy-code}


{% assign serviceName = "tbpe" %}
{% include templates/install/docker/docker-compose-up.md %}

为了从 Windows 计算机上的外部 IP/主机访问必要的资源，请执行以下命令：

``` 
set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"
VBoxManage controlvm "default" natpf1 "tcp-port8080,tcp,,8080,,8080"  
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

{% assign serviceName = "tbpe" %}
{% assign serviceFullName = "ThingsBoard PE" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 升级

如果需要数据库升级，请执行以下命令：

```bash
$ docker compose stop tb-node
$ docker compose run mytbpe upgrade-tb.sh
$ docker compose start mytbpe
```

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），以下是上述命令的列表：
<br>**docker-compose stop tb-node**
<br>**docker-compose run mytbpe upgrade-tb.sh**
<br>**docker-compose start mytbpe**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues-windows.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}