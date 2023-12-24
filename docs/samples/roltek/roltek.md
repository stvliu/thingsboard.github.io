---
layout: docwithnav
title: ROLTEK
description: ROLTEK 指南

---

* TOC
{:toc}

## 简介

本文包含有关如何配置 GridLinks IoT 平台和连接 Roltek DC620 设备的说明。
[GridLinks物联网](https://thingsboard.io/) 平台是一个用于数据收集、处理、可视化和设备管理的开源 IoT 平台。
它通过行业标准 IoT 协议（MQTT、CoAP 和 HTTP）实现设备连接，并支持云端和本地部署。
ThingsBoard 结合了可扩展性、容错性和性能，因此您永远不会丢失数据。

## 在 Thingsboard 上创建设备

登录您的 GridLinks 平台并打开“**设备**”页面。

![image](/images/samples/roltek/tb1.png)

<br>
单击“**加号**”按钮，然后单击“**添加新设备**”按钮以添加新设备。
**输入设备名称**。然后单击“**下一步：凭据**”按钮；

![image](/images/samples/roltek/tb3.png)

<br>
启用“**添加凭据**”选项。输入所需的**访问令牌**，然后单击“**添加**”按钮以保存更改。

![image](/images/samples/roltek/tb4.png)

## 配置 Roltek DC620

首先，按照用户手册中的说明通过 WiFi 或以太网将设备连接到互联网。

在“**MQTT 设置**”页面上：
- 将“**MQTT 模式**”设置为**启用**；
- 在“**MQTT 代理 URI**”中输入您的 Thingsboard 服务器主机名或 IP；
- 在“**MQTT 代理用户名**”中输入您的**访问令牌**；
- 单击**保存**按钮。

![image](/images/samples/roltek/tb5.png)

<br>
用户可以按照用户手册中所述添加**节点**和**标签**。在此演示中，我们将使用设备的默认节点和标签。

在**规则**页面上，导航到**MQTT 有效负载**选项卡，然后单击添加**MQTT 有效负载**按钮。

![image](/images/samples/roltek/tb6.png)

<br>
在新窗口中输入值：
- 选择**有效负载类型** - **JSON**；
- 在**标题**中输入“**{**”；
- 在**模式**中输入**“$V”：#V**；
- 在**分隔符**中输入“**,**”；
- 在**结束**中输入“**}**”；
- 单击**保存**按钮。

![image](/images/samples/roltek/tb7.png)

<br>
在**规则**页面上，导航到**MQTT 发布者**选项卡，然后单击**添加 MQTT 发布者**按钮。

![image](/images/samples/roltek/tb8.png)

<br>
在新窗口中输入值：
- 在**周期**中输入您想要发布的周期；
- 选择您想要的**QoS**选项；
- 选择您想要的**保留**值；
- 在**主题**中输入**“v1/devices/me/telemetry”**；
- 选择我们之前添加的**有效负载**。（在本例中为**1**）；
- 选择您想要发布的**标签**；
- 单击**保存**按钮。

![image](/images/samples/roltek/tb9.png)

## 将小部件添加到仪表板

可以使用各种小部件显示收集的数据。要创建一个，您应该能够在最新遥测部分中看到收集的数据。

要访问它，您应该按照以下步骤操作：
- 转到左侧菜单上的**设备**；
- 选择先前配置的设备；
- 导航到**最新遥测**选项卡；
- 单击收集的数据行；
- 按下**在小部件上显示**按钮。

![image](/images/samples/roltek/tb10.png)

<br>
根据您的数据选择小部件包。选择适合您数据可视化的图表。单击“**添加到仪表板**”按钮。

![image](/images/samples/roltek/tb11.png)

<br>
现在选择“**创建新仪表板**”。标记“**打开仪表板**”（启用此选项后，添加后您将被重定向到新创建的仪表板）并单击“**添加**”以创建新仪表板。

![image](/images/samples/roltek/tb12.png)

<br>
![image](/images/samples/roltek/tb13.png)

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}