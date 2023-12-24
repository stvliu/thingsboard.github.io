---
layout: docwithnav
assignees:
- ashvayka
title: 使用 AWS EC2 实例进行自托管设置
description: 使用 AWS EC2 实例进行 ThingsBoard IoT 平台自托管设置

---

* TOC
{:toc}

本指南将帮助您在 AWS EC2 实例中设置 ThingsBoard。

## 先决条件

您需要具有对 AWS 帐户中 ec2 资源的管理员访问权限。

### 步骤 1. 创建 EC2 实例

创建 EC2 实例（[Amazon 用户指南](https://docs.aws.amazon.com/efs/latest/ug/gs-step-one-create-ec2-resources.html)）并选择 Ubuntu Server 20.04 LTS。我们为我们的产品推荐此发行版和操作系统版本。

### 步骤 2. 为实例配置安全组。

您需要在入站规则中打开 TCP 22,80,443,1883 和 UDP 5683 端口。


之后，您可以从此 [指南](/docs/user-guide/install/ubuntu/) 开始安装。