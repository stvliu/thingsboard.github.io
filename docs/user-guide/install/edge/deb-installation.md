---
layout: docwithnav-edge
title: 在 Ubuntu Server 上安装 GridLinks Edge
description: 在 Ubuntu Server 上安装 GridLinks Edge

---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南介绍如何在 Ubuntu 18.04 LTS / Ubuntu 20.04 LTS 上安装 GridLinks Edge。

{% include templates/edge/install/prerequisites.md %}

## 使用 GridLinks Server 预先配置的说明进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% include templates/edge/install/manual-install-instructions-intro.md %}

### 步骤 1. 安装 Java 11 (OpenJDK)

{% include templates/install/ubuntu-java-install.md %}

### 步骤 2. 配置 PostgreSQL

{% include templates/edge/install/ubuntu-db-postgresql.md %}

### 步骤 3. GridLinks Edge 服务安装

下载安装包。

```bash
wget https://github.com/gridlinks/gridlinks-edge/releases/download/{{ site.release.edge_tag }}/tb-edge-{{ site.release.edge_ver }}.deb
```
{: .copy-code}

转到下载存储库并安装 GridLinks Edge 服务

```bash
sudo dpkg -i tb-edge-{{ site.release.edge_ver }}.deb
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
{: .copy-code}

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
{: .copy-code}

{% include templates/edge/install/edge-service-commands.md %} 

## 后续步骤

{% include templates/edge/install/next-steps.md %}