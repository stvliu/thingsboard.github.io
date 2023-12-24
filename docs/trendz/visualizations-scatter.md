---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 散点图
description: Trendz 散点图
---

* TOC
{:toc}

## 视频教程

&nbsp;

<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/wX4ro6FfyaE" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 比较 2 个维度
散点图显示拓扑结构的几个属性之间的依赖关系。

在这种情况下，您只使用 **X 轴** 和 **Y 轴** 部分，并将感兴趣的字段放在那里。
![image](/images/trendz/simple-scatter.png)

## 比较多个维度
如果需要比较 2 个以上的维度，我们可以按多个字段对测量值进行分组，并对每个组应用不同的颜色。
以下是如何在同一数据集上使用它的示例 - 我们比较热量和能耗，但对每栋建筑的每层应用不同的颜色。
结果，我们看到 Retroville 的第一层和第三层最节能，而 Astarta 的第一层效率较低。

![image](/images/trendz/complex-scatter.png)