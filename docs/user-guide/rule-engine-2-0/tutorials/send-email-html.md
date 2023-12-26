---
layout: docwithnav
title: 在电子邮件中发送 HTML 或图像
description: 教程，介绍如何在电子邮件中发送 HTML 页面或图像

to_email_node:
  0:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/add_rule_node_to_email.png
  1:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/mail_body_type.png
  2:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/dynamic_body_template.png

rule_chain:
  0:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/rule_chain.png

image_generator:
  0:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/function_generate_image_to_email.png

results:
  0:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/message_from_tb_html.png
  1:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/message_from_tb_image.png

html_generator:
  0:
    image: /images/user-guide/rule-engine-2-0/tutorials/html-in-email/html_to_email_generator.png

---

本教程将向您展示如何发送包含 HTML 页面或图像的电子邮件。

* TOC
{:toc}

## 前提条件

* [入门](/docs/getting-started-guides/helloworld/) 指南。
* [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
* [发送电子邮件](/docs/user-guide/rule-engine-2-0/external-nodes/#send-email-node) 节点。


## 消息流
- 作为起点，我们将使用 [生成器](/docs/user-guide/rule-engine-2-0/action-nodes/#generator-node)，它将模仿常规规则链消息流：准备好的消息和元数据，其中我们可以包含 **发送电子邮件** 节点的某些动态字段。
- [发送电子邮件节点](/docs/user-guide/rule-engine-2-0/transformation-nodes/#to-email-node) 准备数据、目标电子邮件和其他电子邮件消息。
- [发送电子邮件节点](/docs/user-guide/rule-engine-2-0/external-nodes/#send-email-node) 发送消息。

## 配置规则节点

#### 配置“发送电子邮件”节点

首先，让我们创建并配置“发送电子邮件”节点。

1. 转到规则链，找到 `发送电子邮件` 节点并将其拖动到画布。
2. 指定：**名称**、**来自模板**、**发送至模板** - 我们将使用模式在消息数据中查找电子邮件，**主题模板**。选择 **邮件正文类型** HTML 或动态。我们将使用动态。
3. 将 HTML 指定给 **正文模板**（您可以使用我们的示例）。
4. 按 **添加**。

{% include images-gallery.html imageCollection="to_email_node" %}

{% capture bodyTemplateExamples %}
HTML 页面的示例%,%loriot-account%,%templates/rule-nodes/to-email-node/html-page.md%br%
带有图像的 HTML 示例%,%basic-credential%,%templates/rule-nodes/to-email-node/html-image.md{% endcapture %}

{% include content-toggle.html content-toggle-id="bodyTemplateExamples" toggle-spec=bodyTemplateExamples %}

#### 配置生成器
在第二阶段，让我们配置“生成器”节点：
1. 在规则链中找到 `生成器` 并将其拖动到画布
2. 指定名称字段，为 **消息计数** 选择“1”，例如为 **以秒为单位的周期** 选择“2”
3. 现在我们需要准备 JS 代码，您也可以使用我们的示例。

*在这里我们需要指定元数据中的字段，这些字段在“发送电子邮件”节点中是动态的。在我们的示例中，它是“isHtml”和“userEmail”字段。*

{% capture generatorCode %}
HTML 页面的 JS 代码%,%html-page%,%templates/rule-nodes/to-email-node/generator-code-for-html.md%br%
图像的 JS 代码%,%image%,%templates/rule-nodes/to-email-node/generator-code-for-image.md{% endcapture %}

{% include content-toggle.html content-toggle-id="generatorCode" toggle-spec=generatorCode %}

#### 发送电子邮件并完成
找到并配置新的 **发送电子邮件** 节点，并将所有节点相互连接，如屏幕截图所示。
保存规则链。

{% include images-gallery.html imageCollection="rule_chain" %}

## 结果
检查目标电子邮件以查看“发送电子邮件”节点工作的结果。
我们收到了以下消息：

{% include images-gallery.html imageCollection="results" %}

## 另请参阅

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}