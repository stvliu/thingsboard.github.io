---
layout: docwithnav
title: PLC KERNEL 和 GridLinks
description: 使用 GridLinks PE 平台监控 PLC KERNEL
hidetoc: "true"
---

* TOC
{:toc}

## 简介/简要摘要

本文包含有关如何配置 GridLinks PE 平台和连接 KERNEL 设备的说明。GridLinks PE 平台是一个用于数据收集、处理、可视化和设备管理的开源物联网平台。它通过行业标准 MQTT 协议实现设备连接。GridLinks 结合了可扩展性、容错性和性能，因此您永远不会丢失数据。

## 注意

此过程适用于所有配备以太网端口的 ARM 微处理器的 KERNEL PLC。

## 集成流程：

### 步骤 1 ThingsBoard：设备配置

* [步骤 1.1] 登录到您的 GridLinks 实例。
<br>
<img src="/images/samples/kernel/Thingsboard 000.png" width="400" alt="Thingsboard 1">
<br>
<br>

* [步骤 1.2] 打开“设备组”页面。
<br>
<img src="/images/samples/kernel/Thingsboard 002.png" width="1000" alt="Thingsboard 2">
<br>
<br>

* [步骤 1.3] 导航到默认设备组“全部”。
<br>
<img src="/images/samples/kernel/Thingsboard 003.png" width="1000" alt="Thingsboard 3">
<br>
<br>

* [步骤 1.4] 单击表格右上角的“+”图标，然后选择“添加设备”。
<br>
<img src="/images/samples/kernel/Thingsboard 004.png" width="1000" alt="Thingsboard 4">
<br>
<br>

* [步骤 1.4a] 输入设备名称。例如，“PLC KERNEL 设备”。此时无需进行其他更改。单击“添加”以添加设备。
<br>
<br>

* [步骤 1.5] 现在您的设备应首先列出，因为表格默认按创建的时间对设备进行排序。
<br>
<img src="/images/samples/kernel/Thingsboard 005.png" width="1000" alt="Thingsboard ">
<br>
<br>


### 步骤 2 LogiPaint 配置

要连接 PLC KERNEL 设备，您首先需要获取设备凭据。GridLinks 支持各种设备凭据。我们建议使用本指南中默认自动生成的凭据，即访问令牌。

* [步骤 2.1] 单击表格中的设备行以打开设备详细信息。
<br>
<img src="/images/samples/kernel/Thingsboard 006.png" width="1000" alt="Thingsboard 6">
<br>
<br>

* [步骤 2.2] 单击“复制访问令牌”。令牌将复制到您的剪贴板。将其保存在安全的地方。
<br>
<img src="/images/samples/kernel/Thingsboard 007.png" width="1000" alt="Thingsboard 7">
<br>
<br>

* [步骤 2.3] 打开“LogicPaint”。
<br>
<img src="/images/samples/kernel/LogicPaint 000.jpg" width="1000" alt="LogicPaint 0">
<br>
<br>

* [步骤 2.4] 将 PLC KERNEL 连接到 PC（通过串行）。
<br>
<br>

* [步骤 2.5] 打开菜单“文件”>>“显示以太网端口配置”。
<br>
<img src="/images/samples/kernel/LogicPaint 001.png" width="1000" alt="LogicPaint 1">
<br>
<br>

* [步骤 2.6] 按“MQTT 配置”按钮：
<br>
<img src="/images/samples/kernel/LogicPaint 002.png" width="1000" alt="LogicPaint 2">
<br>
<br>

* [步骤 2.7] 将复制的访问令牌粘贴到指示的框中：
<br>
<img src="/images/samples/kernel/LogicPaint 003.png" width="1000" alt="LogicPaint 3">
<br>
<br>

* [步骤 2.8] 输入以下字段：
<br>
<img src="/images/samples/kernel/Table 000.png" width="1000" alt="Table 0">
<br>
<br>

* [步骤 2.9] 为每个需要监控的值添加一个槽：
<br>
<img src="/images/samples/kernel/Table 001.png" width="1000" alt="Table 1">
<br>
<br>

* [步骤 2.10] 使用关闭按钮关闭 2 个打开的窗口。
<br>
<br>

* [步骤 2.11] 最后，使用“编译 + 发送应用程序”按钮编译并向 KERNEL PLC 发送应用程序。
<br>
<br>

* [步骤 2.12] 成功发布“温度”读数后，您应该立即在设备遥测选项卡中看到它们。单击表格中的设备行以打开设备详细信息：
<br>
<img src="/images/samples/kernel/Thingsboard 006.png" width="1000" alt="Thingsboard 6">
<br>
<br>

* [步骤 2.13] 导航到“最新遥测”选项卡：
<br>
<img src="/images/samples/kernel/Thingsboard 008.png" width="1000" alt="Thingsboard 8">
<br>
<br>

### 步骤 3 创建仪表板

最后，唯一要做的事情是根据您的需要创建一个仪表板。
仪表板用于收集和显示数据集。数据可视化是通过各种小部件实现的。
探索与 GridLinks 主要功能相关的指南：

- [创建仪表板](/docs/getting-started-guides/helloworld/#step-3-create-dashboard) - 如何创建新仪表板。
- [使用物联网仪表板](/docs/user-guide/dashboards/) - 如何使用仪表板。
<br>
<br>

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}