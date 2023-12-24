---
layout: docwithnav
title: 定期聚合最新遥测值
description: 计算仓库中的平均温度
hidetoc: "true"

---

{% assign feature = "Analytics Rule Nodes" %}{% include templates/pe-feature-banner.md %}

本教程将演示如何根据仓库内多个温度传感器的数据计算仓库中的平均温度。

* TOC
{:toc}

## 使用案例

假设您有一个仓库，其中有多个温度传感器。例如，每个区域一个。我们还假设只有当传感器检测到温度变化时，才会报告温度读数。
因此，一些传感器可能已经有一周没有活动了，而另一些传感器可能最近才报告了温度变化。

在本教程中，我们将配置 GridLinks 规则引擎，以便根据来自多个温度传感器的最新读数，每分钟自动计算仓库中的平均温度。
请注意，这只是一个简单的理论案例，用于演示平台的功能。您可以将本教程作为更复杂场景的基础。


出于演示目的，我们将仅使用 1 个仓库、2 个传感器和 1 分钟执行周期。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 模型定义

我们将创建一个名为“仓库 A”且类型为“仓库”的资产。我们将此资产添加到名为“仓库”的资产组。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/add-asset.png)

我们将创建两个名为“传感器 A1”和“传感器 A2”且类型为“温度计”的设备。我们将此设备添加到名为“温度计”的设备组。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/add-meters.png)

我们还必须在仓库资产和温度计之间创建关系。此关系将在规则链中用于将温度计读数与仓库本身关联。
在仪表板中使用关系来提供向下钻取功能也很方便。您可能会注意到以下屏幕截图中从仓库资产到温度计的两个出站关系：

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/add-relations.png)

**注意**：请查看以下 [**文档页面**](/docs/user-guide/entities-and-relations/) 以了解如何创建资产和关系。

## 消息流

在本节中，我们将解释本教程中每个节点的用途。将涉及两个规则链：

  * “温度计模拟器” - 可选规则链，用于模拟来自两个温度传感器的温度数据；
  * “仓库温度” - 实际计算仓库中平均温度的规则链；

### 温度计模拟器规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/emulator-rule-chain.png)

  * **节点 A 和 B**：生成器节点

    * 两个类似的节点，定期生成一个非常简单的消息，其中包含随机温度读数。

    ![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/nodes-a-and-b.png)

  * **节点 C**：规则链节点

    * 将所有消息转发到默认规则链。

### 仓库温度规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/aggregation-rule-chain.png)

  * **节点 D**：聚合最新。定期（执行周期定义为“执行周期值”）执行以下操作：

    * 使用“包含”关系获取与“仓库 A”资产相关的所有设备。
    * 获取每个设备的最新温度读数并计算平均温度读数。
    * 生成包含平均温度值的“POST_TELEMETRY_REQUEST”消息。

    ![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/node-d-part1.png)

    ![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/node-d-part2.png)

  * **节点 E**：保存遥测节点

    * 一个简单的节点，将传入消息存储到数据库并向订阅者分发更新。


## 配置规则链

下载并 [**导入**](/docs/user-guide/ui/rule-chains/#rule-chains-importexport) 附加的模拟器规则链 [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/thermometer_emulators.json) 作为新的“温度计模拟器”规则链，并
附加仓库温度规则链 [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/warehouse_temperature.json) 作为新的“仓库温度”规则链。
请注意，某些节点已启用调试。这会影响性能。如上图所示，在温度计模拟器规则链中创建节点 C，以将遥测数据转发到根规则链。

## 验证流程

下载并 [**导入**](/docs/user-guide/ui/dashboards/#iot-dashboard-importexport) 附加的仪表板 [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/warehouse_thermometers.json) 作为新的“仓库温度”仪表板。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/dashboard-part1.png)

请注意，您可以通过单击相应行来向下钻取到特定仓库的图表。

![image](/images/user-guide/rule-engine-2-0/tutorials/aggregation-latest/dashboard-part2.png)

## 后续步骤

{% assign currentGuide = "DataAnalytics" %}{% include templates/guides-banner.md %}