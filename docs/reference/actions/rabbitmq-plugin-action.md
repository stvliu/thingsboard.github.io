---
layout: docwithnav
assignees:
- ashvayka
title: RabbitMQ插件操作

---

## 概述

此组件允许通过将设备属性和消息数据替换到可配置模板中来创建 RabbitMQ 消息。

## 配置

在操作配置期间，您可以指定以下内容：
- 设置标志以确认交付
- rabbitmq 交换名称
- rabbitmq 队列名称
- rabbitmq 消息属性 (BASIC、MINIMAL_BASIC、MINIMAL_PERSISTENT_BASIC、PERSISTENT_BASIC、PERSISTENT_TEXT_PLAIN、TEXT_PLAIN)
- rabbitmq 消息正文模板
正文模板语法基于 [Velocity](https://velocity.apache.org/)，并且已在 [警报处理器文档](/docs/reference/processors/alarm-deduplication-processor/#configuration) 中进行了描述。

## 示例