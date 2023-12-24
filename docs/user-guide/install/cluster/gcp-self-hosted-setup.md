---
layout: docwithnav
assignees:
- ashvayka
title: 使用 GCP VM 实例进行自托管设置
description: 使用 GCP VM 实例进行 GridLinks IoT 平台自托管设置

---

* TOC
{:toc}

本指南将帮助您在 GCP VM 实例中设置 GridLinks。

## 先决条件

您需要对 GCP 帐户中的 Compute Engine 拥有管理员访问权限。

### 步骤 1. 创建 VM 实例

创建 EC2 实例（[创建和启动 VM 实例](https://cloud.google.com/compute/docs/instances/create-start-instance)），并选择 Ubuntu Server 20.04 LTS。我们建议您为我们的产品使用此发行版和操作系统版本。

### 步骤 2. 为实例配置防火墙规则。

您需要在入站规则中打开 TCP 22、80、443、1883 和 UDP 5683 端口。


之后，您可以从本 [指南](/docs/user-guide/install/ubuntu/) 开始安装。