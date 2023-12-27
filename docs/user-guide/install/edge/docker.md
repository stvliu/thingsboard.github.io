---
layout: docwithnav-edge
title: 使用 Docker 安装 GridLinks Edge（Linux 或 Mac OS）
description: 使用 Docker 安装 GridLinks Edge（Linux 或 Mac OS）

---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南将帮助您在 Linux 或 Mac OS 上使用 Docker 安装并启动 ThingsBoard Edge。

{% include templates/edge/install/prerequisites.md %}

### Docker 安装

- [安装 Docker CE](https://docs.docker.com/engine/install/){:target="_blank"}
- [安装 Docker Compose](https://docs.docker.com/compose/install/){:target="_blank"}

{% include templates/install/docker-install-note.md %}

## 使用 GridLinks 服务器预配置说明进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% include templates/edge/install/manual-install-instructions-intro.md %}

### 步骤 1. 运行 GridLinks Edge

{% include templates/edge/install/docker-images-location.md %}

{% include templates/edge/install/copy-edge-credentials.md %}

为 GridLinks Edge 服务创建 docker compose 文件：

```text
nano docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件：

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
      CLOUD_ROUTING_KEY: PUT_YOUR_EDGE_KEY_HERE # 例如 19ea7ee8-5e6d-e642-4f32-05440a529015
      CLOUD_ROUTING_SECRET: PUT_YOUR_EDGE_SECRET_HERE # 例如 bztvkvfqsye7omv9uxlp
      CLOUD_RPC_HOST: PUT_YOUR_CLOUD_IP # 例如 192.168.1.250 或 demo.docs.codingas.com
    volumes:
      - ~/.mytb-edge-data:/data
      - ~/.mytb-edge-logs:/var/log/tb-edge
  postgres:
    restart: always
    image: "postgres:12"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: tb-edge
      POSTGRES_PASSWORD: postgres
    volumes:
      - ~/.mytb-edge-data/db:/var/lib/postgresql/data
```
{: .copy-code}

{% include templates/edge/install/docker_compose_details_explain.md %}

{% include templates/install/docker/docker-create-folders-sudo-explained.md %}

```
mkdir -p ~/.mytb-edge-logs && sudo chown -R 799:799 ~/.mytb-edge-logs
```
{: .copy-code}

```
mkdir -p ~/.mytb-edge-data && sudo chown -R 799:799 ~/.mytb-edge-data
```
{: .copy-code}

**注意**：将目录 `~/.mytb-edge-data` 和 `~/.mytb-edge-logs` 替换为计划在 `docker-compose.yml` 中使用的目录。

{% assign serviceName = "tbedge" %}
{% include templates/install/docker/docker-compose-up.md %}

### 步骤 2. 打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %}

### 步骤 3. 分离、停止和启动命令

{% assign serviceFullName = "ThingsBoard Edge" %}
{% include templates/install/docker/detaching-stop-start-commands.md %}

## 故障排除

{% include templates/edge/install/docker-troubleshooting.md %}

## 后续步骤

{% include templates/edge/install/next-steps.md %}