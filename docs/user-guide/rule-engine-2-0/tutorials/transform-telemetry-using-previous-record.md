---
layout: docwithnav
title: 使用上一条记录转换遥测数据
description: 使用上一条记录转换遥测数据
---

* TOC
{:toc}

## 使用案例

假设你的设备报告了与用水量相对应的绝对“计数器”。
但是，你希望可视化不是“绝对”值而是“增量”值，例如，在过去的一天、一周、一个月内消耗了多少水。

在本教程中，我们将根据当前读数和上一条读数计算计数器读数的“增量”。

假设计数器的上一个报告值为 90，我们将转换传入的遥测数据：

```json
{
  "counter": 100
}
```

为

```json
{
  "counter": 100,
  "delta": 10
}
```

## 先决条件

我们假设你已经完成了以下指南并阅读了下面列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
  * [转换传入遥测数据](/docs/user-guide/rule-engine-2-0/tutorials/transform-incoming-telemetry/) 指南。

## 步骤 1：添加数据扩充节点

我们将修改默认规则链，并将添加一个 [**数据扩充**](/docs/user-guide/rule-engine-2-0/enrichment-nodes/#originator-attributes) 规则节点，以从数据库中获取上一条遥测值并将其放入消息元数据中。

![image](/images/user-guide/rule-engine-2-0/tutorials/previous/rule-chain.png)

我们将使用以下节点配置：

![image](/images/user-guide/rule-engine-2-0/tutorials/previous/node-config-step-1.png)

请注意，如果缺少“计数器”值，规则节点将返回失败。
我们将通过在下一步中设置默认上一个计数器来防止此失败。

## 步骤 2：默认上一个计数器节点

此 [**转换**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node) 节点将传入消息的元数据设置为默认计数器。这将用于在下一步中将默认“增量”值设置为 0。

![image](/images/user-guide/rule-engine-2-0/tutorials/previous/node-config-step-2.png)

## 步骤 3：增量转换节点

此 [**转换**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node) 节点将根据元数据中的上一个计数器值和消息中的当前值计算增量。

![image](/images/user-guide/rule-engine-2-0/tutorials/previous/node-config-step-3.png)

## 步骤 4：设置仪表盘以查看数据

我们添加了一个简单的卡片小部件来显示规则链生成的最新值

![image](/images/user-guide/rule-engine-2-0/tutorials/previous/dashboard.png)

## 总结

下载并导入附加的 json [**文件**](/docs/user-guide/resources/previous-telemetry-rule-chain.json)，其中包含本教程中的规则链。不要忘记将新的规则链标记为“根”。

![image](/images/user-guide/rule-engine-2-0/tutorials/make-root.png)

下载并导入附加的 json [**文件**](/docs/user-guide/resources/previous-telemetry-dashboard.json)，其中包含本教程中的仪表盘。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}