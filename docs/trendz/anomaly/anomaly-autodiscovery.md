---
layout: docwithnav-trendz
title: 设置实时异常检测作业
description: 有关配置作业以自动检测来自物联网传感器和资产的实时数据中的异常的分步指南。通过正确的设置确保准确、及时的见解。

anomaly-autodiscovery:
  0:
    image: /images/trendz/anomaly/anomalies-autodiscovery-schedule.png
    title: '自动发现异常的日历热图'   

configuration:
  0:
    image: /images/trendz/anomaly/anomalies-autodiscovery-configuration.png 
    title: '异常自动发现作业配置'

anomaly-configuration-history:
  0:
    image: /images/trendz/anomaly/anomalies-autodiscovery-history.png
    title: '异常自动发现作业历史执行'
---

* TOC
{:toc}

异常自动发现是一项功能，允许设置定期计划以检测接收到的遥测中的异常。
使用它，您可以实时监控数据并识别可能影响业务运营的任何异常。

可以通过单击右上角的自动发现按钮来配置异常刷新。

{% include images-gallery.html imageCollection="anomaly-autodiscovery" %}        

**自动发现**按钮打开异常自动发现配置对话框。您可以在此处启用或禁用自动发现。
启用自动发现后，您可以编辑计划设置。该计划具有以下参数：
* **每**字段允许指定异常检测过程运行的频率。
* **时间单位**字段允许指定在每字段中指定的频率的时间单位。它可以设置为_小时_、_天_、_周_或_月_。

{% include images-gallery.html imageCollection="configuration" %}

此外，异常自动发现配置对话框还包括一个历史记录功能，该功能显示所有自动发现执行的记录。
要查看历史记录，请单击历史记录按钮，这将打开一个表格，显示有关每个计划的自动发现事件的日期、状态和执行持续时间的信息。

{% include images-gallery.html imageCollection="anomaly-configuration-history" %}