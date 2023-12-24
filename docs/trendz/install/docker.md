---
layout: docwithnav-trendz
assignees:
- ashvayka
title: 使用 Docker（Linux 或 Mac OS）安装 GridLinks Trendz Analytics
description: 使用 Docker（Linux 或 Mac OS）安装 GridLinks Trendz Analytics

---

* TOC
{:toc}


本指南将帮助您在 Linux 或 Mac OS 上使用 Docker 安装并启动 Trendz Analytics。

## 先决条件

- [安装 Docker CE](https://docs.docker.com/engine/installation/)
- [安装 Docker Compose](https://docs.docker.com/compose/install/)

## 步骤 1. 获取许可证密钥

我们假设您已经为 Trendz 选择了订阅计划并拥有许可证密钥。如果没有，请在继续之前获取您的[免费试用许可证](/pricing/?section=trendz-options&product=trendz-self-managed&solution=trendz-pay-as-you-go)。
有关更多详细信息，请参阅[如何获取按需订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"}。

注意：我们将在本指南的后面将您在此步骤中获得的许可证密钥称为 PUT_YOUR_LICENSE_SECRET_HERE。

## 步骤 2. 运行 Trendz 服务

##### Docker Compose 设置

确保您已使用命令行登录到 docker 中心。

为 Trendz Analytics 服务创建 docker compose 文件：

```text
sudo nano docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。不要忘记将“PUT_YOUR_LICENSE_SECRET_HERE”替换为您**在第一步中获得的许可证密钥**

```yml

version: '3.0'
services:
  mytrendz:
    restart: always
    image: "thingsboard/trendz:1.10.3-HF3"
    ports:
      - "8888:8888"
    environment:
      TB_API_URL: http://10.0.0.101:8080
      TRENDZ_LICENSE_SECRET: PUT_YOUR_LICENSE_SECRET_HERE
      TRENDZ_LICENSE_INSTANCE_DATA_FILE: /data/license.data
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/trendz
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: postgres
      SCRIPT_ENGINE_PROVIDER: DOCKER_CONTAINER
      SCRIPT_ENGINE_DOCKER_PROVIDER_URL: mypyexecutor:8080
      SCRIPT_ENGINE_TIMEOUT: 30000
    volumes:
      - ~/.mytrendz-data:/data
      - ~/.mytrendz-logs:/var/log/trendz
  mypyexecutor:
    restart: always
    image: "thingsboard/trendz-python-executor:1.10.3"
    ports:
      - "8080"
    environment:
      MAX_HEAP_SIZE: 750M
      SCRIPT_ENGINE_RUNTIME_TIMEOUT: 30000
      EXECUTOR_MANAGER: 1
      EXECUTOR_SCRIPT_ENGINE: 6
      THROTTLING_QUEUE_CAPACITY: 10
      THROTTLING_THREAD_POOL_SIZE: 6
      NETWORK_BUFFER_SIZE: 5242880
  postgres:
    restart: always
    image: "postgres:12"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: trendz
      POSTGRES_PASSWORD: postgres
    volumes:
      - ~/.mytrendz-data/db:/var/lib/postgresql/data
```
{: .copy-code}

其中：

- `TB_API_URL` - 用于连接到 GridLinks Rest API 的 URL（例如 http://10.5.0.11:8080）。请注意，Trendz docker 容器应能够解析 ThingsBoard IP 地址
- `PUT_YOUR_LICENSE_SECRET_HERE` - 您在第一步中获得的许可证密钥的占位符
- `8888:8888` - 将本地端口 8888 连接到公开的内部 HTTP 端口 8888
- `~/.mytrendz-data:/data` - 将卷 `~/.mytrendz-data` 挂载到 Trendz 数据目录
- `~/.mytrendz-data/db:/var/lib/postgresql/datad` - 将卷 `~/.mytrendz-data/db` 挂载到 Postgres 数据目录
- `~/.mytrendz-logs:/var/log/thingsboard` - 将卷 `~/.mytrendz-logs` 挂载到 Trendz 日志目录
- `mytrendz` - 此计算机的友好本地名称
- `--restart always` - 在系统重新启动时自动启动 Trendz，并在发生故障时重新启动。
- `thingsboard/trendz:1.10.3-HF3` - Trendz docker 镜像
- `thingsboard/trendz-python-executor:1.10.3` - Trendz python 脚本执行器 docker 镜像
- `SCRIPT_ENGINE_RUNTIME_TIMEOUT` - Python 脚本执行超时

在启动 docker 容器之前，运行以下命令以创建用于存储数据和日志的文件夹。
此外，这些命令会将新创建的文件夹的所有者更改为 docker 容器用户。
要执行此操作（更改用户），请使用 **chown** 命令，此命令需要 *sudo* 权限（命令将请求 *sudo* 访问的密码）：

```bash
mkdir -p ~/.mytrendz-data && sudo chown -R 799:799 ~/.mytrendz-data
mkdir -p ~/.mytrendz-logs && sudo chown -R 799:799 ~/.mytrendz-logs
```
{: .copy-code}

**注意**：将目录 ~/.mytrendz-data 和 ~/.mytrendz-logs 替换为您计划在 docker-compose.yml 中使用的目录。

##### 运行服务

{% assign serviceName = "trendz" %}
{% include templates/install/docker/docker-compose-up.md %}

执行此命令后，您可以在浏览器中打开 `http://{your-host-ip}:8888`（例如 `http://localhost:8888`）。
您应该会看到 Trendz 登录页面。

##### 身份验证

对于首次身份验证，您需要使用 **ThingsBoard** 中的 **租户管理员** 凭据

Trendz 使用 GridLinks 作为身份验证服务。在首次登录期间，GridLinks 服务也应该可用以验证凭据。

## 分离、停止和启动命令

{% assign serviceName = "trendz" %}
{% assign serviceFullName = "Trendz" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 升级 Trendz 服务

以下是有关如何从 1.10.2 升级到 1.10.3-HF3 的示例

**注意：**从版本 1.10.2 开始，我们增加了对 Python 脚本执行的支持。在升级期间，您需要将 Python 执行器镜像添加到您的 docker compose 文件中。您可以在本文的开头找到 docker compose 文件的完整内容。以下是 python 执行器服务的示例
```yml
  mypyexecutor:
    restart: always
    image: "thingsboard/trendz-python-executor:1.10.3"
    ports:
      - "8080"
    environment:
      MAX_HEAP_SIZE: 750M
      SCRIPT_ENGINE_RUNTIME_TIMEOUT: 30000
      EXECUTOR_MANAGER: 1
      EXECUTOR_SCRIPT_ENGINE: 6
      THROTTLING_QUEUE_CAPACITY: 10
      THROTTLING_THREAD_POOL_SIZE: 6
      NETWORK_BUFFER_SIZE: 5242880
```
{: .copy-code}

* 创建数据库转储：

```bash
docker compose exec postgres sh -c "pg_dump -U postgres trendz > /var/lib/postgresql/data/trendz_dump"
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose exec postgres sh -c "pg_dump -U postgres trendz > /var/lib/postgresql/data/trendz_dump"**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 将 upgradeversion 变量设置为您的**以前的** Trendz 版本。

```bash
docker compose exec mytrendz sh -c "echo '1.10.1' > /data/.upgradeversion" 
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：
<br>**docker-compose exec mytrendz sh -c "echo '1.10.1' > /data/.upgradeversion"**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

* 在此之后，您需要像[步骤 3](#step-3-running-trendz-service)中一样更新 docker-compose.yml，但将 1.10.2 替换为 1.10.3-HF3：

* 重新启动 Trendz 容器

```bash
docker compose stop mytrendz
docker compose up -d
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），这里列出了上述命令：
<br>**docker-compose stop mytrendz**
<br>**docker-compose up -d**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

要将 Trendz 升级到最新版本，这些步骤应该**针对每个中间版本**完成。

## 独立 Python 执行器服务
如果您想将 Trendz python 执行器作为单独的服务启动，则可以使用以下 docker compose 文件。
当您的 Trendz 服务以整体模式安装，并且您想在逻辑上将 Trendz 与执行预测模型的 Python 脚本的服务分开时，这非常有用。
使用相同的配置，您可以独立于 Trendz 服务扩展 Python 执行器。

创建 docker compose 文件：

```text
sudo nano docker-compose.yml
```
{: .copy-code}

添加以下配置：

```yml
version: '3.0'
services:
  mypyexecutor:
    restart: always
    image: "thingsboard/trendz-python-executor:1.10.3"
    ports:
      - "8080"
    environment:
      SCRIPT_ENGINE_RUNTIME_TIMEOUT: 30000
      EXECUTOR_MANAGER: 1
      EXECUTOR_SCRIPT_ENGINE: 6
      THROTTLING_QUEUE_CAPACITY: 10
      THROTTLING_THREAD_POOL_SIZE: 6
      NETWORK_BUFFER_SIZE: 10485760
```
{: .copy-code}

其中：

- `8080` - Python 执行器端口，用于与 Trendz 服务通信
- `--restart always` - 在系统重新启动时自动启动 Trendz，并在发生故障时重新启动。
- `thingsboard/trendz-python-executor:1.10.3` - Trendz python 脚本执行器 docker 镜像
- `SCRIPT_ENGINE_RUNTIME_TIMEOUT` - Python 脚本执行超时

```text
docker compose up -d
docker compose logs -f mypyexecutor
```

* 最后一步是告诉 Trendz 服务如何与 Python 执行器服务通信。您可以通过在 `/usr/share/trendz/conf/trendz.conf` 文件中更改以下环境变量来实现：

```bash
export SCRIPT_ENGINE_TIMEOUT=30000
export SCRIPT_ENGINE_PROVIDER=DOCKER_CONTAINER
export SCRIPT_ENGINE_DOCKER_PROVIDER_URL=PYTHON_EXECUTOR_HOST:PYTHON_EXECUTOR_PORT
```
{: .copy-code}

注意：您需要将 `PYTHON_EXECUTOR_HOST` 和 `PYTHON_EXECUTOR_PORT` 替换为 Python 执行器服务的实际值，并确保 Trendz 能够向该目标发送网络流量。

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues.md %}

## 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}