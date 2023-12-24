---
layout: docwithnav
title: 在 DigitalOcean 上安装 GridLinks
description: 在 DigitalOcean 上安装 GridLinks

---

本指南介绍如何在 DigitalOcean 上安装 GridLinks 社区版。

* TOC
{:toc}

{% include templates/install/digital-ocean-droplet.md %}

### 第 4 步。使用 Ubuntu 的常规安装说明

请导航至 ThingsBoard [**安装说明**](/docs/user-guide/install/ubuntu/)
适用于 Ubuntu 并完成安装步骤。

**注意：**使用您的 droplet IP 地址而不是“localhost”来访问实例 WEB UI。

### 安装后步骤

{% include templates/install/ubuntu-haproxy-postinstall.md %}

### 故障排除

{% include templates/install/troubleshooting.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}