---
layout: docwithnav-mqtt-broker
title: 使用 Docker 安装 TBMQ（Linux 或 Mac OS）
description: 使用 Docker 安装 TBMQ（Linux 或 Mac OS）

---

* TOC
{:toc}

本指南将帮助您在 Linux 或 macOS 上使用 Docker 安装和启动独立的 TBMQ。
如果您正在寻找集群安装说明，请访问 [集群设置页面](/docs/mqtt-broker/install/cluster/docker-compose-setup/)。

### 先决条件

要在单台机器上运行 TBMQ，您至少需要 2Gb 的 RAM。

- [安装 Docker](https://docs.docker.com/engine/installation/)

{% include templates/install/docker-install-note.md %}

### 安装

执行以下命令下载将安装和启动 TBMQ 的脚本：

```shell
wget https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/msa/tbmq/configs/tbmq-install-and-run.sh &&
sudo chmod +x tbmq-install-and-run.sh && ./tbmq-install-and-run.sh
```
{: .copy-code}

该脚本下载 _docker-compose.yml_ 文件，创建必要的 docker 卷，安装 TBMQ 的数据库，并启动 TBMQ。
docker-compose 文件中 TBMQ 的主要配置点：

- `8083:8083` - 将本地端口 8083 连接到公开的内部 HTTP 端口 8083；
- `1883:1883` - 将本地端口 1883 连接到公开的内部 MQTT 端口 1883；
- `tbmq-postgres-data:/var/lib/postgresql/data` - 将 `tbmq-postgres-data` 卷映射到 TBMQ 数据库数据目录；
- `tbmq-kafka-data:/bitnami/kafka` - 将 `tbmq-kafka-data` 卷映射到 Kafka 数据目录；
- `tbmq-logs:/var/log/thingsboard-mqtt-broker` - 将 `tbmq-logs` 卷映射到 TBMQ 日志目录；
- `tbmq-data:/data` - 将 `tbmq-data` 卷映射到 TBMQ 数据目录，其中包含安装数据库后的 _.firstlaunch_ 文件；
- `tbmq` - 此机器的友好本地名称；
- `restart: always` - 在系统重新启动时自动启动 TBMQ，并在发生故障时重新启动；
- `SECURITY_MQTT_BASIC_ENABLED: "true"` - 启用 MQTT 基本安全性。 **注意**：默认情况下安全性处于禁用状态。

**注意**：如果在已经运行 GridLinks 的同一主机上安装 TBMQ，则可能会看到以下问题：

```
Error response from daemon: ... Bind for 0.0.0.0:1883 failed: port is already allocated
```

为了解决此问题，您需要为 TBMQ 容器公开另一个主机端口，
即用 `1889:1883` 替换下载的 docker-compose.yml 文件中的 `1883:1883` 行。然后重新运行脚本。

```shell
./tbmq-install-and-run.sh
```
{: .copy-code}

安装过程完成后，您可以通过在浏览器中访问以下 URL `http://{your-host-ip}:8083` 来访问 TBMQ UI（例如 **http://localhost:8083**）。

{% include templates/mqtt-broker/login.md %}

### 日志、停止和启动命令

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 TBMQ 日志，请执行以下命令：

```
docker compose logs -f tbmq
```
{: .copy-code}

要停止容器：

```
docker compose stop
```
{: .copy-code}

要启动容器：

```
docker compose start
```
{: .copy-code}

### 升级

{% include templates/mqtt-broker/install/migration.md %}

要更新到最新版本，请执行以下命令：

```shell
wget https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/msa/tbmq/configs/tbmq-upgrade.sh &&
sudo chmod +x tbmq-upgrade.sh && ./tbmq-upgrade.sh
```
{: .copy-code}

**注意**：用数据库初始化期间使用的相应值替换脚本中的 `db_url`、`db_username` 和 `db_password` 变量。

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}