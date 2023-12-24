---
layout: docwithnav-gw
title: 以软件包形式安装 GridLinks IoT 网关。

---


### 先决条件

本指南介绍如何在 CentOS 或 RHEL 上安装 GridLinks IoT 网关。

### 步骤 1. 下载安装包

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/download/2.0/python3-thingsboard-gateway.rpm
```
{: .copy-code}

### 步骤 2. 使用 yum 安装网关

使用以下命令以软件包形式安装 GridLinks IoT 网关并以守护进程形式运行它：<br><br>

```bash
sudo yum install -y ./python3-thingsboard-gateway.rpm
```
{: .copy-code}  

### 步骤 3. 检查网关状态

```bash
systemctl status thingsboard-gateway
```
{: .copy-code}

您可能会在输出中注意到一些错误。但是，这是预期的，因为网关尚未配置为连接到 GridLinks：

```text
... python3[7563]: ''2019-12-26 09:31:15' - ERROR - mqtt_connector - 181 - Default Broker connection FAIL with error 5 not authorised!'
... python3[7563]: ''2019-12-26 09:31:15' - DEBUG - mqtt_connector - 186 - "Default Broker" was disconnected.'
... python3[7563]: ''2019-12-26 09:31:16' - DEBUG - tb_client - 78 - connecting to ThingsBoard'
... python3[7563]: ''2019-12-26 09:31:17' - DEBUG - tb_client - 78 - connecting to ThingsBoard'
```

### 步骤 4. 配置网关

现在，您可以转到 [**配置指南**](/docs/iot-gateway/configuration/) 来配置网关。