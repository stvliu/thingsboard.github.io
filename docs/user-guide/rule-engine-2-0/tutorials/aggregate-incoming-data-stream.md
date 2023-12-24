---
layout: docwithnav
title: 聚合传入的数据流
description: 聚合有关建筑物中耗水量的数据
hidetoc: "true"

---

{% assign feature = "分析规则节点" %}{% include templates/pe-feature-banner.md %}

本教程将演示如何根据建筑物中所有水表传感器的传入数据计算建筑物中的总耗水量。

* TOC
{:toc}

## 使用案例

假设您有建筑物，每个建筑物内有多个水表传感器。例如，每个公寓或类似公寓一个。

在本教程中，我们将配置 GridLinks 规则引擎，根据来自多个水表和特定时间间隔的读数自动计算建筑物中的总耗水量。
出于演示目的，我们将仅使用 1 个建筑物、2 个传感器和 10 秒间隔。
您可以将本教程用作更复杂场景的基础。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 模型定义

我们将创建一个名为“建筑物 A”且类型为“建筑物”的资产。我们将此资产添加到名为“建筑物”的资产组。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/add-asset.png)

我们将创建两个名为“水表 A1”和“水表 A2”且类型为“水表”的设备。我们将此设备添加到名为“水表”的设备组。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/add-meters.png)

我们还必须在建筑物资产和水表之间创建关系。此关系将在规则链中用于将水表读数与建筑物本身关联。
在仪表板中使用关系来提供向下钻取功能也很方便。您可能会注意到以下屏幕截图中从建筑物资产到水表的两个出站关系：

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/add-relations.png)

**注意**：请查看以下 [**文档页面**](/docs/user-guide/entities-and-relations/) 以了解如何创建资产和关系。

## 消息流

在本节中，我们将解释本教程中每个节点的用途。将涉及三个规则链：

  * “模拟器” - 可选规则链，用于模拟来自两个水表的数据；
  * “耗水量” - 实际聚合耗水量读数的规则链；
  * “根规则链” - 主默认规则链，分派所有消息。在我们的案例中，根规则链使用“模拟器”生成的数据，将它们存储到数据库并推送到“耗水量”规则链以进行进一步处理。


### 模拟器规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/emulator-rule-chain.png)

  * **节点 A 和 B**：生成器节点

    * 两个类似的节点定期生成一个非常简单的消息，其中包含随机耗水量。

    ![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/nodes-a-and-b.png)

  * **节点 C**：规则链节点

    * 将所有消息转发到默认规则链

### 根规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/root-rule-chain.png)

  * **节点 D**：规则链节点

    * 将所有遥测消息转发到聚合规则链。
    请注意，我们故意不引入任何过滤节点以简化指南。
    通常，您应该在将传入遥测转发到更复杂的节点之前对其进行过滤。
    例如，检查传入遥测是否包含水表读数。


### 耗水量规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/aggregation-rule-chain.png)

  * **节点 E**：更改发起者

    * 更新与消息关联的实体 ID。
      将实体 ID 从特定水表更新为父资产。

    ![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/node-e.png)

  * **节点 F**：聚合流节点

    * 将“waterConsumption”读数的聚合传入数据流每 10 秒转换为一次“totalWaterConsumption”值。
    * 在特定间隔结束时和之后属于此间隔的每条新消息上保留新的遥测。
      如果某些遥测读数可能会延迟，这将很有用。

    ![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/aggregate-stream.png)

  * **节点 G**：保存遥测节点

    * 将传入消息存储到数据库并分派更新到订阅者的简单节点。


## 配置规则链

下载并 [**导入**](/docs/user-guide/ui/rule-chains/#rule-chains-importexport) 附加的模拟器规则链 [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/aggregation_emulators.json) 作为新的“模拟器”规则链和
附加的耗水量规则链 [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/aggregation_water_consumption.json) 作为新的“耗水量”规则链。
请注意，某些节点已启用调试。这会影响性能。如上图所示，在根规则链中创建节点 C 和节点 D 以将遥测转发到新规则链。

## 验证流程

下载并 [**导入**](/docs/user-guide/ui/dashboards/#iot-dashboard-importexport) 附加的仪表板 [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/building_water_meters.json) 作为新的“建筑物水表”仪表板。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/dashboard-part1.png)

请注意，您可以通过单击相应行向下钻取到特定仓库的图表。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation/dashboard-part2.png)

## 后续步骤

{% assign currentGuide = "DataAnalytics" %}{% include templates/guides-banner.md %}