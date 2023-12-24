---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 向 ThingsBoard 报告异常
description: 向 ThingsBoard 报告发现的异常
---

* TOC
{:toc}

借助 Trendz，我们可以创建一个异常检测模型并配置自动异常发现。
但是，我们的目标不仅仅是识别异常——我们希望在发现异常时触发特定操作。这就是 ThingsBoard 规则引擎发挥作用的地方。
ThingsBoard 规则引擎提供了一系列用于创建警报、发送通知、转换数据和触发操作的内置工具。
在本指南中，我们将重点介绍如何将有关发现的异常的信息发送到 ThingsBoard。

## 在 Trendz 中创建具有异常分数的表

第一步是在 Trendz 中创建一个表视图，该视图将按小时细分显示我们实体的异常分数。我们假设我们已经创建了异常检测模型，以便根据从设备收集的振动数据突出显示异常。

* 在 Trendz 中创建表视图
* 在列部分中添加 `equipment` 字段
* 在列部分中添加日期 FULL_HOUR 字段
* 在列部分中添加异常字段
    * 选择 `EquipmentVibrationAnomaly` 模型
    * 异常字段 - `score index`
    * 聚合 - `MAX`
    * 标签 - `vibrationAnomalyScore` - Trendz 将异常分数索引作为具有此名称的设备设备的遥测数据保存。
* 将默认时间范围设置为 **过去 7 天**

## 配置作业以将异常分数保存到 ThingsBoard

现在，我们需要配置作业，该作业将根据我们在上一步中创建的表视图将异常分数保存到 ThingsBoard。

* 打开视图设置并在 `Tb calculated telemetry save` 部分中启用遥测数据保存。
  * 启用 - true
  * 保存间隔 - 1
  * 保存单位 - 小时
* 在设置中打开 `View mode fields` 部分并在 `Row click entity` 下拉列表中选择 `equipment` 实体 - 此步骤告诉 Trendz 应在哪个实体下保存分数索引遥测数据。
* 使用名称 **设备异常分数保存作业** 保存视图

## 在 ThingsBoard 中为高异常分数创建警报

最后，我们需要在 ThingsBoard 中创建警报，当异常分数高于 100 时，该警报将被创建。

* 在 ThingsBoard 中打开热 `equipment` 设备配置文件并添加新的警报规则
* 警报类型 - **异常振动**
* 创建警报规则
  * 严重性 - `Critical`
  * 条件 - `vibrationAnomalyScore` 大于 `100`
* 清除警报规则
  * 条件 - `vibrationAnomalyScore` 小于或等于 `100`

## 后续步骤

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}