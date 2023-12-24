---
layout: docwithnav-mqtt-broker
title: 使用 Docker Compose 进行集群设置
description: 使用 Docker Compose 进行集群设置

---

* TOC
{:toc}


本指南将帮助您使用 Docker Compose 在集群模式下设置 TBMQ。

### 先决条件

- [安装 Docker](https://docs.docker.com/engine/installation/)

{% include templates/install/docker-install-note.md %}

### 步骤 1. 拉取 TBMQ 镜像

确保您已使用命令行[登录](https://docs.docker.com/engine/reference/commandline/login/)docker 中心。

```bash
docker pull thingsboard/tbmq-node:{{ site.release.broker_full_ver }}
```
{: .copy-code}

### 步骤 2. 克隆 TBMQ 存储库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/docker
```
{: .copy-code}

### 步骤 3. 安装

执行以下命令为所有服务创建必要的卷，并在创建的卷中更新 haproxy 配置。

```bash
./scripts/docker-create-volumes.sh
```
{: .copy-code}

执行以下命令运行安装：

```bash
./scripts/docker-install-tbmq.sh
```
{: .copy-code}

### 步骤 4. 运行

执行以下命令启动服务：

```bash
./scripts/docker-start-services.sh
```
{: .copy-code}

一段时间后，当所有服务成功启动后，您可以在浏览器中向 `http://{your-host-ip}:8083` 发出请求（例如 **http://localhost:8083**），并使用 MQTT 协议在 1883 端口连接客户端。

{% include templates/mqtt-broker/login.md %}

### 步骤 5. 日志、停止和启动命令

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 TBMQ 日志，请执行以下命令：

```bash
docker compose logs -f tbmq1
```
{: .copy-code}

或者使用以下命令查看所有容器的状态。
```bash
docker compose ps
```
{: .copy-code}
使用下一个命令检查所有正在运行的服务的日志。
```bash
docker compose logs -f
```
{: .copy-code}
有关更多详细信息，请参阅 [docker compose logs](https://docs.docker.com/compose/reference/logs/) 命令参考。

执行以下命令停止服务：

```bash
./scripts/docker-stop-services.sh
```
{: .copy-code}

执行以下命令停止并完全删除已部署的 docker 容器：

```bash
./scripts/docker-remove-services.sh
```
{: .copy-code}

如果您想删除所有容器的 docker 卷，请执行以下命令。
**注意：**它将删除您的所有数据，因此在执行之前请务必小心。

```bash
./scripts/docker-remove-volumes.sh
```
{: .copy-code}

在运行时更新日志（启用 DEBUG/TRACE 日志）或更改 TBMQ 或 Haproxy 配置可能很有用。为了
为此，您需要对 _haproxy.cfg_ 或 _logback.xml_ 文件进行更改，例如。
之后，执行下一个命令以对容器应用更改：

```bash
./scripts/docker-refresh-config.sh
```
{: .copy-code}

### 升级

{% include templates/mqtt-broker/install/migration.md %}

如果您想升级，请从最新的发行版分支中提取最近的更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

**注意：**确保在合并过程中不会丢失您可用的自定义更改。确保 .env 文件中的 `TBMQ_VERSION` 设置为目标版本（例如，如果您要升级到最新版本，请将其设置为 {{ site.release.broker_full_ver }}）。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

之后执行以下命令：

```bash
./scripts/docker-stop-services.sh
./scripts/docker-upgrade-tbmq.sh --fromVersion=FROM_VERSION
./scripts/docker-start-services.sh
```
{: .copy-code}

其中 `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/mqtt-broker/install/upgrade-instructions/)。

### 生成 HTTPS 证书

我们使用 HAproxy 将流量代理到容器，默认情况下，我们使用 8083 和 443 端口进行 Web UI。
要使用具有有效证书的 HTTPS，请执行以下命令：

```bash
docker exec haproxy-certbot certbot-certonly --domain your_domain --email your_email
docker exec haproxy-certbot haproxy-refresh
```
{: .copy-code}

**注意：**仅当您通过 URL 中的域访问 Web UI 时，才会使用有效的证书。

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}