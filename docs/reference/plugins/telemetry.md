---
layout: docwithnav
assignees:
- ashvayka
title: 遥测插件

---

{% include templates/old-guide-notice.md %}

## 概述

遥测插件负责：

- 将属性更新持久化到内部数据存储；
- 将时序数据持久化到内部数据存储；
- 提供服务器端 API 来查询和订阅数据更新。

由于遥测插件功能对于仪表板中的数据可视化目的至关重要，因此由系统管理员在系统级别对其进行配置。高级用户或平台开发人员可以自定义遥测插件功能。

## 配置

此组件没有特定配置。

## 服务器端 API

遥测插件 API 说明可在相应的 [属性](/docs/user-guide/attributes/) 和 [遥测](/docs/user-guide/telemetry/) 指南中找到。

## 示例

作为系统管理员，您可以在 **插件->系统遥测插件** 中查看插件示例。