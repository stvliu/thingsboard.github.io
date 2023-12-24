---
layout: docwithnav-gw
title: IoT 网关 Pip 安装。

---

### 软件包管理器安装

若要将 GridLinks 网关安装为 Python 模块，您应按照以下步骤操作：

**1. 使用 apt 在系统中安装所需的库：**

```bash
sudo apt install python3-dev python3-pip libglib2.0-dev 
```
{: .copy-code}

**2. 使用 pip 安装 GridLinks 网关模块：**

```bash
sudo pip3 install thingsboard-gateway
```
{: .copy-code}

**3. 下载配置示例，创建日志文件夹：**

 - 下载配置示例：

```bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/download/2.0/configs.tar.gz
```
{: .copy-code}

 - 创建配置目录：
```bash
sudo mkdir /etc/thingsboard-gateway
```
{: .copy-code}

 - 创建日志目录：
```bash
sudo mkdir /var/log/thingsboard-gateway
```
{: .copy-code}

 - 解压配置：
```bash
sudo tar -xvzf configs.tar.gz -C /etc/thingsboard-gateway
```
{: .copy-code}


**4. 为文件夹设置权限：**

- 对于日志文件夹：
```bash
sudo chown YOUR_USER:YOUR_USER -R /var/log/thingsboard-gateway
```
{: .copy-code}

- 对于配置文件夹
```bash
sudo chown YOUR_USER:YOUR_USER -R /etc/thingsboard-gateway
```
其中 `YOUR_USER` 是将运行网关的用户。

**5. 您可以使用命令检查安装**（您将收到有关连接的错误，因为您没有为自己配置网关。*有关配置，请使用 [配置指南](/docs/iot-gateway/configuration/)）：*

```bash
thingsboard-gateway
```
{: .copy-code}