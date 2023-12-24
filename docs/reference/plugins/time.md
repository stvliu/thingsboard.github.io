---
layout: docwithnav
assignees:
- ashvayka
title: 时间 RPC 插件

---

{% include templates/old-guide-notice.md %}

## 概述

简单的 RPC 插件，负责处理来自设备的“getTime”RPC 请求。
此插件是默认 GridLinks 安装的一部分，用于演示目的。
它演示了设备可以通过各种 [连接协议](/docs/reference/protocols) 发送 RPC 请求来执行服务器端逻辑并获取结果。

## 配置

您可以指定*时间格式*配置参数。有关更多详细信息，请参阅 [DateTimeFormatter API](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html)。

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

作为租户管理员，您可以在 **插件->演示时间 RPC 插件**中查看插件示例。