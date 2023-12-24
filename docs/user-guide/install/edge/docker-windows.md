---
layout: docwithnav-edge
title: 使用 Docker 在 Windows 上安装 GridLinks Edge
description: 使用 Docker 在 Windows 上安装 GridLinks Edge
---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南将帮助您在 Windows 上使用 Docker 安装并启动 ThingsBoard Edge。

{% include templates/edge/install/prerequisites.md %}

### Docker 安装

- [为 Windows 安装 Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/){:target="_blank"}

## 安装和配置

### 步骤 1. 运行 GridLinks Edge

{% include templates/edge/install/docker-images-location.md %}

Windows 用户应为 GridLinks Edge 数据库使用 docker 管理的卷。
在执行 docker run 命令之前创建 docker 卷（例如 `mytb-edge-data`）：
打开“Docker 快速启动终端”。执行以下命令以创建 docker 卷：

``` 
docker volume create mytb-edge-data
docker volume create mytb-edge-logs
docker volume create mytb-edge-data-db
```
{: .copy-code}

{% include templates/edge/install/copy-edge-credentials.md %}

为 GridLinks Edge 服务创建 docker compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

```yml
version: '3.0'
services:
  mytbedge:
    restart: always
    image: "thingsboard/tb-edge:{{ site.release.edge_full_ver }}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "5683-5688:5683-5688/udp"
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/tb-edge
      CLOUD_ROUTING_KEY: PUT_YOUR_EDGE_KEY_HERE # e.g. 19ea7ee8-5e6d-e642-4f32-05440a529015
      CLOUD_ROUTING_SECRET: PUT_YOUR_EDGE_SECRET_HERE # e.g. bztvkvfqsye7omv9uxlp
      CLOUD_RPC_HOST: PUT_YOUR_CLOUD_IP # e.g. 192.168.1.250 or demo.thingsboard.io
    volumes:
      - mytb-edge-data:/data
      - mytb-edge-logs:/var/log/tb-edge
  postgres:
    restart: always
    image: "postgres:12"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: tb-edge
      POSTGRES_PASSWORD: postgres
    volumes:
      - mytb-edge-data-db:/var/lib/postgresql/data
volumes:
  mytb-edge-data:
    external: true
  mytb-edge-logs:
    external: true
  mytb-edge-data-db:
    external: true
```
{: .copy-code}

{% include templates/edge/install/docker_compose_details_explain.md %}

{% assign serviceName = "tbedge" %}
{% include templates/install/docker/docker-compose-up.md %}

为了从 Windows 机器上的外部 IP/主机访问必要的资源，请执行以下命令：
``` 
set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"
VBoxManage controlvm "default" natpf1 "tcp-port8080,tcp,,8080,,8080"  
VBoxManage controlvm "default" natpf1 "tcp-port1883,tcp,,1883,,1883"
VBoxManage controlvm "default" natpf1 "tcp-port5683,tcp,,5683,,5683"
```
{: .copy-code}

其中：
- `C:\Program Files\Oracle\VirtualBox` - VirtualBox 安装目录的路径

### 步骤 2. 打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %}

### 步骤 3. 分离、停止和启动命令

{% assign serviceName = "tbedge" %}
{% assign serviceFullName = "ThingsBoard Edge" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 故障排除

### DNS 问题

{% include templates/troubleshooting/dns-issues-windows.md %}

## 后续步骤

{% include templates/edge/install/next-steps.md %}