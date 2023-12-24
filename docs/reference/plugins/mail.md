---
layout: docwithnav
assignees:
- ashvayka
title: 邮件插件

---

{% include templates/old-guide-notice.md %}

## 概述

邮件插件负责发送由相应规则 [操作](/docs/reference/actions/send-mail-action/)触发的电子邮件。

## 配置

您可以指定以下参数：

- 邮件服务器主机
- 邮件服务器端口
- 用户名
- 密码
- 包含其他属性的映射。
有关更多详细信息，请参阅 [java 邮件发送器](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/mail/javamail/JavaMailSenderImpl.html#setJavaMailProperties-java.util.Properties-)。

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

作为租户管理员，您可以在 **插件->演示电子邮件插件**中查看插件示例，该插件已配置为 Gmail 服务器。
您可能需要更新用户名和密码以匹配现有帐户并开始接收电子邮件。