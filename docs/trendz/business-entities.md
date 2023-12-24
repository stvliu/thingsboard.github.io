---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 业务实体
description: 业务实体
---

本指南介绍 Trendz 如何使用 GridLinks 中的实体，例如资产、设备、关系等。

* TOC
{:toc}

## 业务实体拓扑

假设我们有一个智能建筑解决方案。我们的拓扑包含建筑物、公寓和不同的仪表，它们通过关系相互连接。
以下是我们的拓扑结构：

![image](/images/reference/pe-demo/smart-metering-model.svg)


事实上，Trendz 将此拓扑用作具有此拓扑中所有设备/资产的所有属性/遥测的列的平面表。
实体之间的关系用于连接来自不同业务实体的字段。

## 工作原理

现在让我们检查 Trendz 如何使用以下报告从 ThingsBoard 解析数据：我们仅使用智能建筑拓扑中的 2 个字段：

- 属于建筑资产的“建筑名称”
- 属于能量表设备的“能量”遥测
- 聚合类型“SUM”
- 时间范围 - 上个月


* Trendz 将找到 GridLinks 中所有可用的建筑物。
* 然后为每个建筑找到所有公寓。
* 最后，找到属于公寓的所有能量表。
* 之后，对于每个建筑的所有能量表，Trendz 将加载上个月的所有能量遥测
* Trendz 使用“SUM”聚合聚合所有加载的遥测。
* 结果我们可以看到每栋建筑消耗了多少能量。

这不是一个确切的算法描述，并且在后台执行了许多优化。但它可以理解 Trendz 内部处理了多少复杂性，因此您可以专注于分析，而不是数据获取。

## 聚合遥测和组
下一步是定义如何聚合数据。以下是支持的聚合类型：
* AVG
* SUM
* MIN
* MAX
* LATEST
* COUNT
* UNIQ

要更改聚合类型 - 只需单击该字段并选择所需的值。
![image](/images/trendz/field-aggregation.png)


## 使用脉冲输出遥测
水表是一个具有脉冲输出的设备的一个很好的例子 - 遥测值总是增长，在分析过程中，我们希望将其转换为增量值。
以下是此类遥测的示例图表：

![image](/images/trendz/pulse-before.png)

让我们为此字段应用**DELTA**聚合，看看我们的数据会是什么样子：

![image](/images/trendz/pulse-after.png)

Trendz 会自动计算此字段的增量，以所需的粒度定义时间范围。
当**DELTA**聚合应用于多个设备时 - Trendz 将**SUM**聚合应用于聚合组 - 结果是，我们可以在不同级别（城市、建筑等）上看到总消耗量