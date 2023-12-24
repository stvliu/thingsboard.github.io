---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 将预测遥测数据保存到 ThingsBoard
description: 将预测遥测数据保存到 ThingsBoard
---

虽然 Trendz 提供了以各种视图可视化预测时间序列数据的功能，但现实生活中的场景通常需要基于此预测数据集执行其他操作和计算。
在这种情况下，利用 ThingsBoard（遥测数据的主要数据存储）的功能变得非常方便。
将预测数据另存为 ThingsBoard 中设备或资产的新遥测数据可开启多个有价值的使用案例。以下是一些示例：

* 预测遥测数据是有价值的数据，可用作其他计算或预测的输入参数。通过利用此数据，您可以提高进一步分析和预测的准确性和有效性。
* 基于预测遥测数据创建警报可实现主动监控和响应。通过设置阈值或条件，您可以在预测值达到临界水平时触发警报，确保及时采取行动。
* 通过利用预测遥测数据，您可以设置通知，为相关利益相关者提供实时更新或警报。此功能增强了沟通，并能够根据预测趋势做出快速决策。
* 通过将预测遥测数据与历史数据进行比较来跟踪预测的准确性。
* 性能优化 - 通过将预测遥测数据保存到 ThingsBoard，您可以减轻 Trendz 服务器的负载，因此它无需反复计算相同的预测。

将预测遥测数据保存到 ThingsBoard 的简化工作流如下：

* 使用 Trendz 创建遥测预测
* 在表格视图中可视化预测数据
* 配置后台作业，该作业将针对新的传入遥测数据运行预测模型
* 将预测数据集另存为 ThingsBoard 的新遥测数据

**您可以在本文中找到有关如何执行此操作的详细分步教程 - [同步到 ThingsBoard](/docs/trendz/save-telemetry-to-thingsboard/)。**

## 后续步骤

{% assign currentGuide = "Prediction" %}{% include templates/trndz-guides-banner.md %}