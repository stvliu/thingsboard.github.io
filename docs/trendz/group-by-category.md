---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 按类别分组
description: 按类别分组和聚合数据
---

借助 Trendz，您可以根据业务实体的不同属性对数据进行分组。例如，在能源计量场景中，您可以按建筑物、公寓、房间等对数据进行分组。
业务实体模型中定义的任何字段均可用于对数据进行分组和筛选。这意味着我们可以实时对整个组应用所需的遥测聚合。
您无需在分析前明确定义聚合规则并预先计算不同级别的值。

在此示例中，我们仅添加 2 个字段 - **建筑物名称** 和 **能耗**。我们在规则引擎中没有任何聚合规则。Trendz 知道每个建筑物中注册了哪些能源计，因此能源计分为每个建筑物的单独组。

![image](/images/trendz/data-grouping-simple.png)

我们看到过去一年的总消耗量。现在，让我们按季度对数据进行分组 - 添加具有 **季度** 类型的 **日期** 字段：

![image](/images/trendz/data-grouping-quarter.png)

最后，让我们深入了解并查看按房间号分开的总消耗量 - 从 **公寓** 业务实体中添加 **房间号** 属性：

![image](/images/trendz/data-grouping-room.png)


## 后续步骤

{% assign currentGuide = "GroupAndAggregateData" %}{% include templates/trndz-guides-banner.md %}