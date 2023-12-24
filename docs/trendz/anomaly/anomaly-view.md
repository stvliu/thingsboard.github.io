---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 异常视图
description: 异常视图

create-Anomaly-View:
  0:
    image: /images/trendz/anomaly/anomaly-view-model-selection-on-create.png
    title: '创建异常视图'

Default-Anomaly-Selection:
  0:
    image: /images/trendz/anomaly/anomaly-view-default-model.png
    title: '默认异常选择'

Hide-anomalies:
  0:
    image: /images/trendz/anomaly/anomaly-view-hide-options.png
    title: '隐藏异常列表或图表'
---

* TOC
{:toc}

## 异常视图小部件

要可视化在模型创建期间发现的异常以及在异常刷新作业期间重新发现的异常，可以使用 Trendz 中的“异常视图”小部件。

视图异常小部件显示异常模型检测到的异常。它由两部分组成：

* 包含所有检测到的异常的列表，允许您选择一个特定异常以在图表中查看其信息。
* 显示所选异常信息的折线图。

![image](/images/trendz/anomaly/anomaly-view-sampl.png)

要创建异常视图，您可以从列表中选择一个已经创建的异常模型或创建一个新的异常模型。

{% include images-gallery.html imageCollection="create-Anomaly-View" %}

## 默认异常选择

默认情况下，我们在异常视图小部件上看到的第一个异常是得分指数最高的异常。

但是，在某些情况下，首先显示最后检测到的异常会更有用。要将小部件配置为首先显示最新异常，请按照以下步骤操作：

* 打开视图设置
* 在默认异常选择菜单中选择最后一个选项

{% include images-gallery.html imageCollection="Default-Anomaly-Selection" %}

## 隐藏异常列表或图表

如果您只想在视图模式下显示异常视图小部件的特定部分，例如图表或异常列表，可以在图表设置 - 视图模式字段中进行配置。在此部分中，您可以选择启用或禁用**隐藏异常列表/图表**选项以显示异常视图的所需部分。

{% include images-gallery.html imageCollection="Hide-anomalies" %}

## 异常字段

此外，您可以在 Trendz 中提供的任何可视化中使用“异常”字段。它可能有助于可视化异常的更大图景 - 应用所需的过滤、数据分组等。

例如，您可以创建一个饼图，该饼图将显示按设备分组的已发现异常数量，以便用户可以了解最成问题的设备。