---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 热图
description: Trendz 热图
---

* TOC
{:toc}

热图是最简单的方式之一，可用于描述可重复的模式并查找异常值。它类似于表格，但表格的单元格会根据值突出显示不同的颜色。
* **X 轴** - 字段定义表格列（水平轴）
* **Y 轴** - 字段定义表格行（垂直轴）
* **值** - 字段定义单元格值

## 视频教程

&nbsp;

<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/XJjC3xdTJq4" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 日、周、月热图

在时间范围附近的 **按** 字段中，热图有几个预定义的模板可用：
* 小时与星期几
* 分钟与小时
* 日与月
* 小时与日期

在此示例中，我们可以看到每周能源消耗的模式。现在我们知道，在什么日期和时间消耗的能源最多。

![image](/images/trendz/heat-week-pattern.png)

## 自定义轴

您始终可以使用最符合您情景的配置，并将所需字段添加为热图的维度。

以下示例显示
* 建筑物中的每套公寓作为单独一行。
* 每列代表一年的月份。
* 总能源消耗作为单元格值

现在可以轻松识别异常值及其动态。

![image](/images/trendz/complex-heatmap.png)