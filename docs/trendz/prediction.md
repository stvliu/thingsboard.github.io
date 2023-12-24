---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 构建时间序列数据的预测模型
description: 如何构建时间序列数据的准确预测。探索可用于预测和可视化预测数据的机器学习模型。

trendz-prediction-overview-simple:
  0:
    image: /images/trendz/prediction-simple-initial.png
    title: '配置折线图上的能耗预测'
  1:
    image: /images/trendz/prediction-simple-cfg.png
    title: '选择预测模型和预测范围'

trendz-prediction-overview-bar-consumption:
 0:
  image: /images/trendz/prediction-sum-view.png
  title: '未来一年的资源使用预测'
 1:
  image: /images/trendz/prediction-sum-cfg1.png
  title: '选择预测模型和预测范围'

---

* TOC
{:toc}

Trendz 内置了只需点击几下即可进行时间序列预测的工具。所有必需的工作，如数据过滤、标准化和模型训练都在后台执行。您可以对包括计算字段在内的任何字段启用预测。时间序列预测解锁了许多可以从您的数据中提取的见解。以下是 Trendz 时间序列预测可以回答的一些问题：

* 预测未来一个季度或一年的能耗
* 预测下次应安排维护的时间
* 预测下次故障发生的时间
* 预测制造 KPI 以及它们如何受当前系统状态的影响
* 预测油箱将耗尽剩余时间

&nbsp;
<div id="video">  
    <div  id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/cuGPiBeaA18" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 预测模型

Trendz 为时间序列预测实现了不同的多变量和单变量机器学习模型：

* `傅里叶变换` - 将时间序列分解为其频率分量。它的优势在于识别数据中根深蒂固的循环趋势和季节性模式，有助于提高预测练习的效率。
* `Prophet` - 由 Facebook 设计的预测范例，精心设计用于处理以明显的季节性模式和假日影响为重点的时间序列数据集。此技术利用加法框架来封装趋势、季节性和假日引起的影响。
* `Multi Prophet` - 从 Prophet 预测模型演变而来，支持同时预测相互关联的时间序列。当处理需要预测见解的众多相互关联变量时，这一点尤其有利。
* `ARIMA` - 将自回归和移动平均方面结合起来，根据历史观测来预测即将到来的值。这种方法巧妙地适应了数据集中根深蒂固的趋势和季节性变化。
* `SARIMAX`（具有外生变量的季节性 ARIMA） - 通过同化能够影响预测结果的补充外生变量来扩展 ARIMA 方法。当外部因素与时间序列相互作用时，此模型就会发挥作用，使其成为提高预测准确性的宝贵工具。
* `线性回归` - 一种基本统计方法，用于根据一个或多个自变量预测因变量的轨迹。此技术在变量之间建立线性连接，为进行预测奠定基础。
* `自定义模型` - 您可以使用任何 Python 库编写我们自己的多变量时间序列预测模型。在这种情况下，您提供模型源，Trendz 负责从 ThingsBoard 插入输入数据集并处理预测输出。


## 简单预测

![image](/images/trendz/prediction-simple-view.png)

在此示例中，我们监控水站上泵的振动。我们希望预测振动何时会达到临界水平，以便我们可以为泵安排预防性维护并避免计划外停机。

* 创建折线图
* 在 **X 轴** 上添加 **Date(RAW)** 字段
* 将 **Pump** 名称字段添加到 **Filter** 部分并选择所需的 Pump
* 在 **Y 轴** 上添加 Pump **vibration** 遥测

现在我们的图表已准备好进行预测：
* 为预测字段启用 **Predction** 复选框
* 选择 **FOURIER_TRANSFORMATION** 作为 **Prediction Method**
* 将 **Prediction Unit** 设置为 **days**
* 将 **Prediction Range** 设置为 **2** - 我们对未来 2 天进行预测

{% include images-gallery.html imageCollection="trendz-prediction-overview-simple" %}

现在我们可以按“生成报告”按钮并检查我们的预测是什么样子。

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/prediction-simple-view.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-vibration-predict.webm" type="video/webm">                 
        </video> 
    </div>
</div>


## 预测资源使用情况

在此示例中，我们预测明年建筑物将消耗多少能源。我们有建筑物、公寓，每个公寓都有电表。我们需要汇总建筑物级别的传感器遥测，然后建立预测。

* 创建条形图
* 在 **X 轴** 上添加 **Date(RAW)** 字段
* 将 **Building** 名称字段添加到 **Filter** 部分并选择所需的 Building
* 在 **Y 轴** 上添加 Energy Meter **energyConsumption** 遥测
* 为 **energyConsumption** 字段启用 **Prediction** 复选框
* 选择 **LINEAR_REGRESSION** 作为 **Prediction Method**
* 将 **Prediction Unit** 设置为 **years**
* 将 **Prediction Range** 设置为 **1** - 我们对明年进行预测

{% include images-gallery.html imageCollection="trendz-prediction-overview-bar-consumption" %}

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/prediction-sum-view.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-enrgy-predict.webm" type="video/webm">                 
        </video> 
    </div>
</div>


## 将预测与历史数据进行比较

如果您想了解训练后的模型与历史数据相比如何，您需要在字段配置中启用 **Show Historical part** 复选框。启用后，预测数据集将包含使用相同模型预测的历史部分。
 
![image](/images/trendz/prediction-validation.png)
 
## 后续步骤

{% assign currentGuide = "Prediction" %}{% include templates/trndz-guides-banner.md %}