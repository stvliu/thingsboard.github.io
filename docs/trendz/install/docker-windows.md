---
layout: docwithnav-trendz
assignees:
- ashvayka
title: 使用 Docker 在 Windows 上安装 GridLinks Trendz Analytics
description: 使用 Docker 在 Windows 上安装 GridLinks Trendz Analytics

---

* TOC
{:toc}


本指南将帮助您在 Windows 上使用 Docker 安装并启动 Trendz Analytics。

## 先决条件

- [为 Windows 安装 Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)

## 步骤 1. 获取许可证密钥

我们假设您已经为 Trendz 选择了订阅计划并拥有许可证密钥。如果没有，请在继续之前获取您的 [免费试用许可证](/pricing/?section=trendz-options&product=trendz-self-managed&solution=trendz-pay-as-you-go)。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"}。

注意：我们将在此步骤中获得的许可证密钥称为 PUT_YOUR_LICENSE_SECRET_HERE 指南。

## 步骤 2. 运行 Trendz 服务

##### Docker Compose 设置

确保您已使用命令行 [登录](https://docs.docker.com/engine/reference/commandline/login/) 到 docker 中心。

为 Trendz Analytics 服务创建 docker compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。不要忘记用 **第一步获得的许可证密钥** 替换“PUT_YOUR_LICENSE_SECRET_HERE”

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
      - mytrendz-data:/data
      - mytrendz-logs:/var/log/trendz
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
  postgres:
    restart: always
    image: "postgres:12"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: trendz
      POSTGRES_PASSWORD: postgres
    volumes:
      - mytrendz-data/db:/var/lib/postgresql/data
volumes:
  mytrendz-data:
    external: true
  mytrendz-logs:
    external: true
  mytrendz-data-db:
    external: true
```
{: .copy-code}

其中：

- `TB_API_URL` - 用于连接到 GridLinks Rest API 的 URL（例如 http://10.5.0.11:8080）。请注意，Trendz docker 容器应该能够解析 ThingsBoard IP 地址
- `PUT_YOUR_LICENSE_SECRET_HERE` - 第一步获得的许可证密钥的占位符
- `8888:8888` - 将本地端口 8888 连接到公开的内部 HTTP 端口 8888
- `mytrendz-data:/data` - 将卷 `mytrendz-data` 挂载到 Trendz 数据目录
- `mytrendz-data/db:/var/lib/postgresql/datad` - 将卷 `mytrendz-data/db` 挂载到 Postgres 数据目录
- `mytrendz-logs:/var/log/trendz` - 将卷 `mytrendz-logs` 挂载到 Trendz 日志目录
- `mytrendz` - 此计算机的友好本地名称
- `--restart always` - 在系统重新启动时自动启动 Trendz，并在发生故障时重新启动。
- `thingsboard/trendz:1.10.3-HF3` - Trendz docker 镜像
- `thingsboard/trendz-python-executor:1.10.3` - Trendz python 脚本执行器 docker 镜像
- `SCRIPT_ENGINE_RUNTIME_TIMEOUT` - Python 脚本执行超时

##### 设置 Docker 卷

Windows 用户应使用 docker 管理的卷作为 Trendz 数据库。在执行 docker run 命令之前创建 docker 卷（例如 `mytrendz-data`）：打开“Docker 快速启动终端”。执行以下命令以创建 docker 卷：

```yml
docker volume create mytrendz-data
docker volume create mytrendz-data-db
docker volume create mytrendz-logs
```
{: .copy-code}

**注意**：将目录 ~/.mytrendz-data 和 ~/.mytrendz-logs 替换为计划在 docker-compose.yml 中使用的目录。

##### 运行服务

{% assign serviceName = "trendz" %}
{% include templates/install/docker/docker-compose-up.md %}

为了从 Windows 机器上的外部 IP/主机访问必要的资源，请执行以下命令：

```yml
set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"
VBoxManage controlvm "default" natpf1 "tcp-port8888,tcp,,8888,,8888"  
```
{: .copy-code}

其中

- `C:\Program Files\Oracle\VirtualBox` - VirtualBox 安装目录的路径

执行此命令后，您可以在浏览器中打开 `http://{your-host-ip}:8888`（例如 `http://localhost:8888`）。您应该会看到 Trendz 登录页面。

##### 身份验证

首次身份验证，您需要使用 **ThingsBoard** 中的 **租户管理员** 凭据

Trendz 使用 GridLinks 作为身份验证服务。在首次登录期间，GridLinks 服务也应该可用以验证凭据。

## 分离、停止和启动命令

{% assign serviceName = "trendz" %}
{% assign serviceFullName = "Trendz" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues-windows.md %}

## 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}