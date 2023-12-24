---
layout: docwithnav
title: 4G LTE 工业路由器和 GridLinks
description: 具有 ThingsBoard PE 平台的 4G LTE 工业路由器
hidetoc: "true"
---

* TOC
{:toc}

## 简介

本文包含有关如何配置 ThingsBoard PE 平台和连接 KERNEL 设备的说明。GridLinks PE 平台是一个用于数据收集、处理、可视化和设备管理的开源物联网平台。它通过行业标准 MQTT 协议实现设备连接。GridLinks 结合了可扩展性、容错性和性能，因此您永远不会丢失数据。

## 集成流程：

### 步骤 1 ThingsBoard：设备配置

* [步骤 1.1] 登录到您的 GridLinks 实例，打开“设备组”页面。
<br>
<img src="/images/samples/kingpigeon/home.png" width="1000" alt="home">
<br>

* [步骤 1.2] 导航到默认设备组“全部”。
<br>
<img src="/images/samples/kingpigeon/device.png" width="1000" alt="device">
<br>1.单击设备组概述页面中以红色标记的按钮之一。在此页面中，您还可以添加其他设备组，以便区分具有唯一数据流的不同设备。
<br>2.单击标记的“+”按钮将新设备添加到组中。
<br>

* [步骤 1.3] 输入设备名称，例如“R40”。此时无需进行其他更改。单击“下一步：凭据”以配置凭据。
<br>
<img src="/images/samples/kingpigeon/device_new.png" width="1000" alt="device new">
<br>

* [步骤 1.4] 凭据类型：MQTT Basic
<br>
<img src="/images/samples/kingpigeon/mqtt_basic.png" width="1000" alt="mqtt basic">
<br>1.选择凭据类型：MQTT Basic。
<br>2.设置客户端 ID，例如“R40”。
<br>3.设置将在 MQTT 授权中使用的用户名。
<br>4.设置将在 MQTT 授权中使用的密码。
<br>

### 步骤 2 工业路由器配置

* [步骤 2.1] 登录到路由器。默认用户名为“admin”，无密码。
<br>
<img src="/images/samples/kingpigeon/r4000.png" width="800" alt="step 1">
<br>

* [步骤 2.2] 单击菜单“云平台”，选择“自定义云”，单击“添加”以添加云配置。
<br>
<img src="/images/samples/kingpigeon/r4001.png" width="800" alt="step 2">
<br>

* [步骤 2.3] 单击“编辑”以编辑配置。
<br>
<img src="/images/samples/kingpigeon/r4002.png" width="800" alt="step 3">
<br>

* [步骤 2.4] 编辑 thingsboard 配置。
<br>
<img src="/images/samples/kingpigeon/r4003.png" width="800" alt="step 4">
<br>1.选择 GridLinks 平台。
<br>2.设置 MQTT ID，请参阅“步骤 1.4”。
<br>3.设置用户名，请参阅“步骤 1.4”。
<br>4.设置密码，请参阅“步骤 1.4”。
<br>5.设置发布周期。
<br>6.单击“保存”以保存配置并“返回概述”。
<br>

* [步骤 2.5] 选中“启用设置”，单击“保存并应用”以应用配置。
<br>
<img src="/images/samples/kingpigeon/r4004.png" width="800" alt="step 5">
<br>

### 步骤 3 将小部件添加到仪表板
* [步骤 3.1] 可以使用各种小部件显示收集的数据。要创建一个，您应该能够在最新遥测部分中看到收集的数据。要访问它，您应该按照以下步骤操作：
<br>
<img src="/images/samples/kingpigeon/telemetry.png" width="1000" alt="telemetry">
<br>1.单击配置的设备。
<br>2.从弹出菜单中选择最新遥测选项。您应该在那里看到收集的数据。
<br>

* [步骤 3.2] 为了在小部件中显示数据，您应该：
<br>
<img src="/images/samples/kingpigeon/telemetry02.png" width="1000" alt="telemetry 2">
<br>1.单击收集的数据行。
<br>2.按小部件上的显示按钮。
<br>
<img src="/images/samples/kingpigeon/chart.png" width="1000" alt="chart 1">
<br>1.根据您的数据选择捆绑包。
<br>2.选择适合您的数据可视化的图表。
<br>3.将小部件添加到仪表板。
<br>
<img src="/images/samples/kingpigeon/chart02.png" width="400" alt="chart 2">
<br>1.创建新仪表板。
<br>2.启用此选项后，添加后您将被重定向到新创建的仪表板
<br>3.将小部件添加到仪表板。
<br>
<img src="/images/samples/kingpigeon/chart03.png" width="400" alt="chart 3">
<br>

探索与主要 GridLinks 功能相关的指南：

- [创建仪表板](/docs/getting-started-guides/helloworld/#step-3-create-dashboard) - 如何创建新仪表板。
- [使用物联网仪表板](/docs/user-guide/dashboards/) - 如何使用仪表板。
<br>

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}