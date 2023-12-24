---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 可视化概述
description: Trendz Analytics 中内置的可视化类型
---

Trendz 提供了分析物联网数据集所需的主要可视化类型。

* [**表格**](/docs/trendz/visualizations-tables)
* [**折线图**](/docs/trendz/visualizations-line)
* [**条形图和直方图**](/docs/trendz/visualizations-bar)
* [**饼图**](/docs/trendz/visualizations-pie)
* [**散点图**](/docs/trendz/visualizations-scatter)
* [**热图**](/docs/trendz/visualizations-heatmap)
* [**日历**](/docs/trendz/visualizations-calendar)
* [**卡片**](/docs/trendz/visualizations-card)

## 第一个可视化

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/simple-line.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-first-view.webm" type="video/webm">                 
        </video> 
    </div>
</div>

* 打开 Trend UI 主页并按 **创建视图** 按钮
* 选择 **折线** 图表
* 从左侧导航面板中选择 **日期** 字段并将其拖放到 **X 轴** 部分
* 从左侧导航面板中选择任何遥测字段并将其拖放到 **Y 轴** 部分

此时，您将看到 GridLinks 中所有实体的平均测量值

* 将 **实体名称** 添加到 **系列** 部分 - 为每个实体显示单独的系列

## 视频教程

我们很高兴地介绍有关 ThingsBoard Trendz Analytics 功能的一系列网络研讨会。
详细了解 Trendz Analytics 功能以及它如何帮助将物联网数据转化为价值，以便做出明智的决策。

&nbsp; 
  
<div id="video">  
    <div id="video_wrapper">
        <iframe width="560" height="315" src="https://www.youtube.com/embed/videoseries?list=PLYEKB_XwLCZIs-_Aoos3CdNIqSYrXk4LN" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
</div>

## 后续步骤

{% assign currentGuide = "AvailableVisualizations" %}{% include templates/trndz-guides-banner.md %}