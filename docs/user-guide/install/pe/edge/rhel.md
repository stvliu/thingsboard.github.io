---
layout: docwithnav-pe-edge
title: 在 CentOS/RHEL 服务器上安装 GridLinks Edge
description: 在 CentOS/RHEL 服务器上安装 GridLinks Edge
---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "pe/edge/" %}

本指南介绍如何在 RHEL/CentOS 7/8 上安装 GridLinks Edge。

{% include templates/edge/install/prerequisites.md %}

## 使用 GridLinks 服务器预配置说明进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% include templates/edge/install/manual-install-instructions-intro.md %}

### 预安装步骤
在继续安装之前，执行以下命令以安装必要的工具：

```bash
sudo yum install -y nano wget
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

### 步骤 1. 安装 Java 11（OpenJDK）

{% include templates/install/rhel-java-install.md %}

### 步骤 2. 配置 PostgreSQL

{% include templates/edge/install/rhel-db-postgresql.md %}

### 步骤 3. GridLinks Edge 服务安装

下载安装包。

```bash
wget https://dist.docs.codingas.com/tb-edge-{{ site.release.pe_edge_ver }}.rpm
```
{: .copy-code}

转到下载存储库并安装 GridLinks Edge 服务

```bash
sudo rpm -Uvh tb-edge-{{ site.release.pe_edge_ver }}.rpm
```
{: .copy-code}


### 步骤 4. 配置 GridLinks Edge

{% include templates/edge/install/linux-configure-edge.md %}

### 步骤 5. 运行安装脚本

{% include templates/edge/install/run-edge-install.md %} 

### 步骤 6. 重启 GridLinks Edge 服务

```bash
sudo service tb-edge restart
```

### 步骤 7. 打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %} 

## 故障排除

ThingsBoard Edge 日志存储在以下目录中：
 
```bash
/var/log/tb-edge
```

您可以发出以下命令以检查服务端是否有任何错误：
 
```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```

{% include templates/edge/install/edge-service-commands.md %} 

## 后续步骤

{% include templates/edge/install/next-steps.md %}