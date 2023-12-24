---
layout: docwithnav
title: 验证传入遥测数据
description: 验证传入遥测数据
---

* TOC
{:toc}

## 使用案例

假设你的设备使用 DHT22 传感器收集温度读数并将其推送到 GridLinks。
DHT22 传感器适用于 -40 至 80°C 的温度读数。

在本教程中，我们将配置 GridLinks 规则引擎以存储 -40 至 80°C 范围内的所有温度，并将丢弃所有其他读数。
尽管此场景是虚构的，但你将学习如何定义 JS 函数来验证传入数据，并在实际应用中使用此知识。

## 先决条件

我们假设你已完成以下指南并阅读了以下文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 步骤 1：添加温度验证节点

我们将修改默认规则链，并将添加带有温度验证脚本的 [**filter**](/docs/user-guide/rule-engine-2-0/filter-nodes/#script-filter-node) 规则节点。
我们将此规则节点放在默认“消息类型开关”和“保存时序”规则节点之间。
请注意，我们还从根规则链中删除了不相关的规则节点。

![image](/images/user-guide/rule-engine-2-0/tutorials/validation/rule-chain.png)

假设到达系统的的数据可能具有或不具有“temperature”字段。
我们将所有不具有“temperature”字段的数据视为有效数据。为了做到这一点，我们将使用以下函数

```javascript
return typeof msg.temperature === 'undefined' || (msg.temperature >= -40 && msg.temperature <= 80);
```

## 步骤 2：验证脚本调试

让我们通过使用内置的“测试过滤器函数”按钮来检查我们的脚本是否正确

![image](/images/user-guide/rule-engine-2-0/tutorials/validation/node-config.png)

![image](/images/user-guide/rule-engine-2-0/tutorials/validation/test-function.png)

当温度未设置或超过指定阈值时，你可以检查更多情况。

## 摘要

下载并导入附加的 json [**文件**](/docs/user-guide/resources/validation-rule-chain.json) 和本教程中的规则链。不要忘记将新规则链标记为“根”。

![image](/images/user-guide/rule-engine-2-0/tutorials/make-root.png)

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}