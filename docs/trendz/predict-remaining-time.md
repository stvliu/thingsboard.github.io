---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 预测剩余时间
description: 指南，介绍如何预测到特定事件的剩余时间
---

* TOC
{:toc}

Trendz 功能提供了一项强大的功能，允许我们预测时序数据的行为。例如，我们可以预测发动机振动如何随时间变化，并将此信息可视化显示在仪表板上。
但是，我们可以从该功能中获得更有价值的见解。设想一下，我们知道振动能量应始终低于 87。如果超过此阈值，则发动机故障的风险很高。
在这种情况下，确定振动能量达到此临界水平之前我们还有多少时间变得至关重要。
本文将指导您完成配置 Trendz 以预测特定事件发生之前剩余时间的过程。在我们的案例中，事件是振动能量达到临界水平。


## 在 Trendz 中创建表

首先，我们需要在 Trendz 中创建一个表视图来显示计算结果。我们假设我们在 GridLinks 中注册了 `Engine` 设备，并且此设备上有 `vibration` 遥测。

* 创建表视图
* 将 **Engine** 字段添加到 **列** 部分。
* 将 **vibration** 遥测字段添加到 **列** 部分。为此字段选择聚合 `LATEST` - 此字段将显示设备报告的最新振动水平。
* 将 **Engine** 字段添加到 **过滤器** 部分，然后选择我们应该关注的所需引擎。

## 预测振动水平

让我们预测我们拥有的每个引擎未来 7 天的振动水平。我们将对计算出的字段启用预测，因为稍后我们需要根据预测数据执行其他计算。

* 将 **计算** 字段添加到 **列** 部分。
* 将字段标签设置为 `Predicted vibration`。
* 启用批量计算复选框。
* 启用复选框预测
  * 预测方法 - 傅里叶变换
  * 预测范围 - 7
  * 预测单位 - 天
* 编写以下函数 `return none(Engine.vibration);`
* 为批量计算字段设置 `MAX` 聚合。

在按下 **生成报告** 按钮后，我们将看到未来 7 天每个引擎的最大振动水平。我们已准备好预测剩余时间。

## 预测剩余时间

一旦在 Trendz 中启用了批量计算字段的预测，平台将构建从发动机获得的原始振动遥测数据的预测。然后，此预测用作计算函数的输入参数。
在该函数中，我们需要找到阈值（在本例中为 87）何时达到并返回到该点的小时数。如果未达到阈值，则我们需要返回 -1。
这意味着我们预计未来 7 天不会出现临界振动水平。

我们需要将计算函数更改为以下内容：

```javascript 
var remainingHours = -1;
var threshold = 87;
var vibrationForecast = none(Engine.vibration);

for(var i = 0; i < vibrationForecast.length; i++) {
  var point = vibrationForecast[i];
  if(point.value >= threshold) {
    var timeDeltaMillis = point.ts - Date.now();
    remainingHours = timeDeltaMillis / 1000 / 60 / 60;
    break;
  }
}

return [{ts: endTs, value: remainingHours}];
```

在此公式中，我们迭代预测的振动值并找到第一个大于或等于阈值的值。然后，我们计算此点与当前时间之间的时间增量并以小时为单位返回。

## 后续步骤

我们可以在 Trendz 中的任何可视化中使用计算出的指标。我们还可以将其保存回 ThingsBoard 作为 `Engine` 设备的新遥测，或基于此指标创建警报。
您可以在本文中找到有关如何执行此操作的分步指南 - [预测设备下次维护的剩余时间](/docs/trendz/guide/predict-next-maintenance-date-of-equipment/)。

{% assign currentGuide = "Prediction" %}{% include templates/trndz-guides-banner.md %}