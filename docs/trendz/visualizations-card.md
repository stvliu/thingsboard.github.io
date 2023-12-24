---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 卡片
description: Trendz 卡片
---

* TOC
{:toc}


卡片小部件允许可视化单个重要指标并监控其动态。

## 视频教程

&nbsp;

<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/ZXORc5nipgg" frameborder="0" allowfullscreen></iframe>
    </div>
</div>


## 简单卡片

若要创建简单卡片视图：

* 将您想要在“**主值**”列中监控的字段拖放；
* 选择所需的聚合类型

![image](/images/trendz/card-simple.png)

![image](/images/trendz/card-simple-view.png)

## 与其他值比较

我们可以将主值与另一个值进行比较。例如，我们有需要生产的产品数量，将其保存为设备遥测。
并且我们希望将其与已经生产的产品数量进行比较。

* 在“**比较值**”列中添加要比较的值；

![image](/images/trendz/card-compare.png)

![image](/images/trendz/card-compare-view.png)

比较值将以百分比的形式显示这两个数字之间的差异。

## 与前一个间隔比较

我们还可以将当前值与前一个间隔进行比较。如果我们想显示本月与上个月相比消耗了多少咖啡豆：

* 对于“**比较值**”部分中的字段，启用“**本地日期**”
* 选择“**上个月**”时间范围
* 对于主视图时间范围，设置“**本月**”

![image](/images/trendz/card-local-config.png)

![image](/images/trendz/card-local.png)

比较值将以百分比的形式显示这两个数字之间的差异。

## 卡片标题

在创建卡片时，您可以为其命名一个有意义的名称，以便快速导航。
为此，请打开右下角的设置部分，并在“标题”部分中添加名称。