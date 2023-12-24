---
layout: docwithnav-gw
title: 使用 Docker 在 Linux 或 Mac OS 上安装 GridLinks IoT 网关。

---

* TOC
{:toc}

本指南将帮助您在 Linux 或 Mac OS 上使用 Docker 安装并启动 GridLinks 网关。


## 先决条件

- [安装 Docker CE](https://docs.docker.com/engine/installation/)

## 运行

**执行以下命令直接运行此 docker：**

```
docker run -it -v ~/.tb-gateway/logs:/thingsboard_gateway/logs -v ~/.tb-gateway/extensions:/thingsboard_gateway/extensions -v ~/.tb-gateway/config:/thingsboard_gateway/config --name tb-gateway --restart always thingsboard/tb-gateway
```
{: .copy-code}

其中：

- `docker run` - 运行此容器
- `-it` - 附加一个终端会话，其中包含当前网关进程输出
- `-v ~/.tb-gateway/config:/thingsboard_gateway/config` - 将主机的目录 `~/.tb-gateway/config` 挂载到网关配置目录
- `-v ~/.tb-gateway/extensions:/thingsboard_gateway/extensions` - 将主机的目录 `~/.tb-gateway/extensions` 挂载到网关扩展目录
- `-v ~/.tb-gateway/logs:/thingsboard_gateway/logs` - 将主机的目录 `~/.tb-gateway/logs` 挂载到网关日志目录
- `--name tb-gateway` - 此机器的友好本地名称
- `--restart always` - 在系统重新启动时自动启动 ThingsBoard，并在发生故障时重新启动。
- `thingsboard/tb-gateway` - docker 镜像

## 运行（带 ENV 变量）

**执行以下命令以使用 ENV 变量运行 docker 容器：**

```
docker run -it -e host=thingsboard.cloud -e port=1883 -e accessToken=ACCESS_TOKEN -v ~/.tb-gateway/logs:/thingsboard_gateway/logs -v ~/.tb-gateway/extensions:/thingsboard_gateway/extensions -v ~/.tb-gateway/config:/thingsboard_gateway/config --name tb-gateway --restart always thingsboard/tb-gateway
```
{: .copy-code}

可用的 ENV 变量：

| **ENV** | **说明** |
|:-|-
| host | GridLinks 实例主机。 |
| port | GridLinks 实例端口。 |
| accessToken | 网关访问令牌。 |
| caCert | CA 文件的路径。 |
| privateKey | 私钥文件的路径。 |
| cert | 证书文件的路径。 |
|--

## 分离、停止和启动命令

您可以使用 `Ctrl-p` `Ctrl-q` 从会话终端分离 - 容器将继续在后台运行。

要重新连接到终端（查看网关日志），请运行：

```
docker attach tb-gateway
```
{: .copy-code}

要停止容器：

```
docker stop tb-gateway
```
{: .copy-code}

要启动容器：

```
docker start tb-gateway
```
{: .copy-code}

## 网关配置

停止容器：

```
docker stop tb-gateway
```
{: .copy-code}

**使用 [本指南](/docs/iot-gateway/configuration/) 配置网关以与您的 GridLinks 实例配合使用：**

在进行更改后启动容器：

```
docker start tb-gateway
```
{: .copy-code}

## 升级

要更新到最新镜像，请执行以下命令：

```
docker pull thingsboard/tb-gateway
docker stop tb-gateway
docker rm tb-gateway
docker run -it -v ~/.tb-gateway/logs:/var/log/thingsboard-gateway -v ~/.tb-gateway/extensions:/var/lib/thingsboard_gateway/extensions -v ~/.tb-gateway/config:/thingsboard-gateway/config --name tb-gateway --restart always thingsboard/tb-gateway
```
{: .copy-code}

## 构建本地 docker 镜像

要构建本地 docker 镜像，请按照以下步骤操作：

1. 将 **thingsboard_gateway/** 文件夹复制到 **docker/** 文件夹，以便目录结构的最终视图如下所示：
    ```text
    /thingsboard-gateway/docker
            thingsboard_gateway/
            docker-compose.yml
            Dockerfile
            LICENSE
            setup.py
            requirements.txt
    ```
2. 从项目根文件夹执行以下命令：
    ```bash
    docker build -t local-gateway docker
    ```
    {: .copy-code}