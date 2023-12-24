---
layout: docwithnav-pe
title: 在 DigitalOcean 上安装 GridLinks PE
description: 在 DigitalOcean 上安装 GridLinks PE

---

本指南介绍如何在 DigitalOcean 上安装 GridLinks Professional Edition。
使用本指南，您将安装产品的“自备许可证”版本。
基本上，您可以直接从 ThingsBoard, Inc 获取许可证，但从 DigitalOcean 购买相应的服务器实例和基础设施。

* TOC
{:toc}


{% include templates/install/digital-ocean-droplet.md %}

### 第 4 步。对 Ubuntu 使用常规安装说明

请导航至 ThingsBoard PE [**安装说明**](/docs/user-guide/install/pe/ubuntu/)
适用于 Ubuntu 并完成安装步骤。

**注意：**使用您的 droplet IP 地址而不是“localhost”来访问实例 WEB UI。

### 安装后步骤

{% include templates/install/ubuntu-haproxy-postinstall.md %}

### 故障排除

{% include templates/install/troubleshooting.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}