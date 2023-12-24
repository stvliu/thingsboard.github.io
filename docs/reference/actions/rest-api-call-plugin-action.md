---
layout: docwithnav
assignees:
- ashvayka
title: REST API 调用插件操作

---

## 概述

此组件允许通过将设备属性和消息数据替换到可配置模板中来创建 POST/PUT 请求正文。

## 配置

在操作配置期间，您可以指定以下内容：
- 设置标志以确认交付
- http 端点的操作路径
- 请求方法 - POST 或 PUT
- http 响应中的预期结果代码
- 请求的正文模板
正文模板语法基于 [Velocity](https://velocity.apache.org/)，并且已在 [警报处理器文档](/docs/reference/processors/alarm-deduplication-processor/#configuration) 中进行了描述。

## 示例