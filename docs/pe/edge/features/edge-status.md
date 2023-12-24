---
layout: docwithnav-pe-edge
title: 边缘信息页面
description: 边缘信息页面
edgeInfo:
    0:
        image: /images/edge/edge-status.png
---

**边缘信息**页面介绍了有关基本边缘配置和 ThingsBoard **PE 服务器信息（URL 和服务器版本）的用户信息：
* 名称、ID、类型、路由密钥
* 与云的连接状态：**已连接/已断开连接**
* 允许的最大设备和资产数量
* 上次连接到/断开与云的连接的时间

{% include images-gallery.html imageCollection="edgeInfo" %}

## 后续步骤

{% assign currentGuide = "EdgeStatus" %}
{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}