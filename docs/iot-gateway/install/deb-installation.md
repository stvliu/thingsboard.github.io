---
layout: docwithnav-gw
title: 以软件包形式安装 GridLinks IoT 网关。
redirect_from:
 - "/docs/iot-gateway/install/rpi/"
---

### 先决条件

本指南介绍如何在 Ubuntu 18.04 LTS / Ubuntu 20.04 LTS 上安装 GridLinks IoT 网关。
最低系统要求与操作系统的官方 [最低要求](https://help.ubuntu.com/lts/serverguide/preparing-to-install.html#system-requirements) 相匹配。

### 步骤 1. 下载 deb 文件

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/latest/download/python3-thingsboard-gateway.deb
```
{: .copy-code}

### 步骤 2. 使用 apt 安装网关

使用以下命令以软件包形式安装 GridLinks IoT 网关并以守护进程形式运行它：<br><br>

```bash
sudo apt install ./python3-thingsboard-gateway.deb -y
```
{: .copy-code}

deb 软件包将自动安装 IOT 网关运行所需的必要库：

1. 系统库：*libffi-dev, libglib2.0-dev, libxml2-dev, libxslt-dev, libssl-dev, zlib1g-dev, python3-dev, python3-pip*。
2. Python 模块：*importlib, importlib-metadata, jsonschema, pymodbus, lxml, jsonpath-rw, paho-mqtt, pyserial, PyYAML, simplejson, pyrsistent*。

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