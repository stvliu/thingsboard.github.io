---
layout: docwithnav
title: 动态添加和删除设备到组
description: 添加和删除设备到组

---

{% assign feature = "设备和资产组" %}{% include templates/pe-feature-banner.md %}

本教程将演示如何根据设备发来的数据动态添加和删除设备到设备组。

* TOC
{:toc}

## 使用案例

假设你的设备向 ThingsBoard 报告温度读数，你想可视化报告温度 > 50°C 的设备。

在本教程中，我们将配置 ThingsBoard 规则引擎根据设备发来的温度读数自动更新“高温设备”组成员。你可以将本教程作为更复杂过滤的基础。

## 先决条件

我们假设你已经完成以下指南并阅读了下面列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 模型定义

我们将使用名称为“传感器 A”且类型为“DHT22”的温度传感器设备。

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/add-device.png)

## 消息流

在本节中，我们将解释本教程中每个节点的用途。

### 根规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/root-rule-chain.png)

  * **节点 A**：规则链节点

    * 我们修改默认根规则链，将所有遥测数据转发到新的“将设备添加到组”规则链

### 新的“将设备添加到组”规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/rule-chain.png)

  * **节点 B**：脚本过滤器节点

    * 检查来自设备的传入消息是否包含温度读数
    * 如果来自设备的消息包含温度读数，则将其转发到节点 C

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/has-temperature-node.png)

  * **节点 C**：脚本过滤器节点

    * 检查传入消息的温度是否 > 50°C
    * 如果温度 > 50°C，则将消息转发到节点 D
    * 如果温度 <= 50°C，则将消息转发到节点 E

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/high-temperature-node.png)

  * **节点 D**：添加到组节点

    * 将设备添加到组
    * 通过替换 deviceType 元数据值来构造组名
    * 在需要时自动创建设备组

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/add-group-node.png)

  * **节点 E**：从组中移除节点

    * 从组中移除设备
    * 通过替换 deviceType 元数据值来构造组名

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/remove-group-node.png)


## 配置规则链

下载并[**导入**](/docs/user-guide/ui/rule-chains/#rule-chains-importexport)附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/pe/tutorials/add_device_to_group.json) 作为新的“将设备添加到组”规则链。请注意，所有节点都启用了调试。这会影响性能。在根规则链中创建节点 A，如上图所示，将遥测数据转发到新的规则链。

## 验证流程

[发布](/docs/getting-started-guides/helloworld/#pushing-data-from-the-device) 新设备的温度读数，并观察自动创建的新组：

![image](/images/user-guide/rule-engine-2-0/tutorials/groups/results.png)   

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}