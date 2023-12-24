---
layout: docwithnav
assignees:
- ashvayka
title: 发送邮件操作

---

## 概述

此组件允许通过将设备属性和消息数据替换到可配置模板中来构建电子邮件消息。

## 配置

在操作配置期间，您可以指定以下模板：发件人、收件人、抄送、密送、主题和正文。
模板语法基于 [Velocity](https://velocity.apache.org/)，已在 [警报处理器文档](/docs/reference/processors/alarm-deduplication-processor/#configuration) 中进行了说明。

此外，您可以指定 *发送标志* 属性。
这是一个可选属性，可以与 [isNewAlarm](/docs/reference/processors/alarm-deduplication-processor/#overview) 结合使用，也可以留空。

## 示例

作为租户管理员，您可以在 **规则->演示警报规则->操作->发送邮件操作** 中查看操作示例。