---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 条形图和直方图
description: 条形图和直方图
---

* TOC
{:toc}

有关基本条形图的详细信息，请参阅[折线图配置](/docs/trendz/visualizations-line/)
折线图和条形图的主要概念是相同的。在本教程中，我们将重点介绍差异。

## 视频教程

&nbsp;

<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/Sc6vySTadCQ" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 水平条形图

默认情况下，条形图是垂直的。在某些情况下，需要使用垂直条形图显示数据。为此：

* 打开视图设置
* 启用**水平条形图**模式

![image](/images/trendz/bar-horizontal.png)
![image](/images/trendz/bar-horizontal-conf.png)

**注意** 仅当**Y 轴**包含一个字段时，才可以使用水平模式。当将多个字段添加到**Y 轴**并且**系列**部分中有字段时，水平条形图将不会显示。

## 堆叠条形图

当条形图包含多个时序或系列字段时，每个系列都会独立显示。并且可以为条形图启用堆叠模式。这里有一些示例：禁用堆叠、启用堆叠和 100% 堆叠条形图。

![image](/images/trendz/bar-stack-off.png)
![image](/images/trendz/bar-stack-onn.png)
![image](/images/trendz/bar-stack-100.png)

您可以在视图设置中控制堆叠选项

![image](/images/trendz/bar-stack-conf.png)

## 按遥测值分组

当您需要根据遥测字段值对数据进行分组和聚合时，可以使用此选项。
例如，我们有一台生产不同杯子的机器。机器提交包含以下信息的遥测：

* 生产了多少产品（数量）
* 生产了哪种类型的产品（产品类别）
* 利用了多少资源（能源）

原始有效负载格式如下：

{% highlight javascript %}
  {
    "ts": 1540892498884,
    "amount": 12,
    "product": "glass",
    "energy": 218,
  }
{% endhighlight %}

我们想要找到的是不同类型产品生产了多少。或者生产某种类型产品消耗了多少能量。

在这两种情况下，我们需要按**产品**值对遥测进行分组，然后应用所需的聚合（在本例中为 SUM）：

* 将**产品**字段添加到**系列**部分并选择**UNIQ**聚合 - 在此步骤中，我们将对遥测进行分组。
* 将**产品**字段添加到**Y 轴**部分并选择**SUM**聚合 - 在此步骤中，我们对每个组应用聚合。
* 将**机器**字段添加到**X 轴**部分 - 我们将看到每台机器的细分

现在我们知道不同机器生产了多少不同类别的产品。

![image](/images/trendz/bar-group-ts.png)

## 标签
您可以使用视图设置中的复选框添加/隐藏条形图中的标签。

![image](/images/trendz/bar-labels.png)