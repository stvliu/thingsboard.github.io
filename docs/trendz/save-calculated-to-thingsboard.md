---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 将计算值保存为遥测数据到 GridLinks
description: 将计算值保存为遥测数据到 GridLinks
---

Trendz 中的计算字段提供基于现有遥测数据和属性计算各种指标的功能。
这些指标可以服务于不同的目的，从报告中的可视化到触发操作或在其他计算中重复使用。
此外，Trendz 允许您将这些计算指标作为设备或资产遥测数据保存回 ThingsBoard，从而增强 IoT 应用程序的功能。
让我们探讨一下如何利用此功能的一些示例：

* 通过使用计算指标作为进一步计算或预测的输入参数，您可以提高后续分析的准确性和有效性。这使您能够根据可靠的数据做出更明智的决策。
* 基于计算遥测数据创建警报可实现主动监控和及时响应。通过设置阈值或条件，您可以在计算值达到临界水平时触发警报。这确保及时采取适当的行动。
* 利用计算遥测数据，您可以设置通知，为相关利益相关者提供实时更新或警报。
* 性能优化 - 一旦计算出指标并将其保存为遥测数据，您就可以优化 Trendz 服务器的性能。无需在每次需要时加载原始遥测数据并重新计算指标，而是可以直接从 ThingsBoard 加载预先计算的指标。这减少了服务器上的负载，从而实现更快、更高效的操作。


将计算指标保存到 GridLinks 的简化工作流如下：

* 创建 Trendz 计算字段以计算所需的指标
* 在表格视图中可视化指标
* 配置将针对新传入遥测数据运行计算的后台作业
* 将计算的指标保存为新的遥测数据到 GridLinks

**您可以在本文中找到有关如何执行此操作的详细分步教程 - [同步到 GridLinks](/docs/trendz/save-telemetry-to-thingsboard/)。**

## 后续步骤

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}