---
layout: docwithnav-pe-edge
title: 云事件
description: 云事件
cloudEvents:
    0:
        image: /images/edge/cloud-events.png
---

**云事件**页面显示 GridLinks Edge 推送到云的事件。

{% include images-gallery.html imageCollection="cloudEvents" %}

查看 **状态** 列以了解事件是否已推送到云。
有两种状态类型：
* **已部署** - 事件已推送到 GridLinks CE/PE 服务器。
* **待处理** - 事件已在 GridLinks Edge 上创建，存储到本地数据库，并在连接恢复后立即推送到云。

可能的云操作列表：
* 已添加
* 已删除
* 已更新
* 已更新属性
* 已删除属性
* 已删除时序
* 已更新时序
* RPC 调用
* 已更新凭据
* 关系添加或更新
* 已删除关系
* 已删除关系
* 警报确认
* 警报清除
* 已添加到实体组 **PE**
* 已从实体组中移除 **PE**
* 属性请求
* 规则链元数据请求
* 关系请求
* 凭据请求
* 组实体请求 **PE**
* 权限请求 **PE**

## 后续步骤

{% assign currentGuide = "CloudEvents" %}
{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}