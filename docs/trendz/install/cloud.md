---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 在 ThingsBoard Cloud 中启用 Trendz Analytics
description: 激活 Trendz Analytics Cloud

cloudPlan:
  0:
    image: /images/trendz/cloud-1.png
    title: '登录 ThingsBaord Cloud 帐户并选择“计划和计费”菜单选项。按“更新计划”按钮'
  1:
    image: /images/trendz/cloud-2.png
    title: '选择“ThingsBoard + Trendz”并选择最适合您的计划'
  2:
    image: /images/trendz/cloud-3.png
    title: '重新加载页面以在 ThingsBoard 菜单中查看新的“Trendz Analytics”选项'

---

* TOC
{:toc}

### 什么是 Trendz Cloud

Trendz Analytics Cloud 是 [Trendz Analytics 产品](/products/trendz/) 的一个完全托管、可扩展且容错的版本。它已与 ThingsBoard Cloud 集成，可用于分析 ThingsBoard Cloud 中的数据。

- **缩短上市时间。** 节省平台维护或功能配置的时间。
- **降低成本。** 集群基础设施的成本由平台用户分摊。
- **高可用性。** Trendz Cloud 使用微服务架构，并部署在多个可用区中。
- **数据持久性。** 平台使用数据复制和备份程序来确保您不会丢失数据。

### 先决条件

您需要拥有有效的 ThingsBoard Cloud 帐户才能激活 Trendz Analytics Cloud。如果您还没有 ThingsBoard Cloud 帐户，请 [注册](https://thingsboard.cloud/signup)。

### 激活 Trendz Analytics Cloud

- 登录 ThingsBaord Cloud 帐户并选择 [计划和计费](https://thingsboard.cloud/billing) 菜单选项。
- 按 **更新计划** 按钮
- 选择 **ThingsBoard + Trendz** 并选择最适合您的计划


{% include images-gallery.html imageCollection="cloudPlan" %}

### 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}