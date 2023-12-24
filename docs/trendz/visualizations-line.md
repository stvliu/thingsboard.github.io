---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 折线图
description: Trendz 折线图
---

* TOC
{:toc}

## 视频教程

&nbsp;

<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/v2pZKQhiw8s" frameborder="0" allowfullscreen></iframe>
    </div>
</div>


## 简单折线图
对于条形图和折线图，您有 3 个可配置的部分：
* **X 轴** - 定义将在图表 X 轴（水平轴）中使用什么值。在大多数情况下，它将是原始日期字段，但它可以是拓扑中的任何字段或字段组合。
* **Y 轴** - 定义将在图表 Y 轴（垂直轴）中使用什么值。您可以在此部分中删除一些遥测字段，并进行所需的聚合。
* **系列** - 使用单个（或多个）字段条件将数据分成多个组


在 **X 轴** 上添加日期字段，在 **Y 轴** 上添加数字遥测

![image](/images/trendz/simple-line.png)

## 带系列的折线图

#### 遥测作为系列
当您想为选定的设备/资产显示多个遥测字段时，您必须将所需字段添加到 **Y 轴** 中，并留空 **系列** 部分。要关注感兴趣的设备，您可以使用 **过滤器**。

![image](/images/trendz/line-multi-telemetry.png)

#### 组作为系列
在这种情况下，您想了解相同遥测对于不同资产/设备或类别的外观。将所需的分组字段添加到 **系列** 部分：

![image](/images/trendz/basic-line.png)

另一个示例显示了如何在 1 个部分中组合多个字段。此具体示例显示了不同季度按星期几划分的建筑整体能耗。

![image](/images/trendz/multiple-bar.png)

## 垂直线
任何机器消息都可以转换为事件，并显示在折线图上以供调查。此类事件可以表示为图表上的垂直线，遥测值（数字或文本）将显示为垂直线的标签。

* 在 **Y 轴** 部分添加所需的遥测字段
* 在遥测卡上选择聚合类型 **无**

![image](/images/trendz/line-vertical-annotation.png)

## 彩色区域

![image](/images/trendz/line-background-example.png)

可以将彩色区域添加到条形图和折线图中，以直观地识别某些阈值。

* 导航到设置卡并选择注释。
* 从调色板中选择值和颜色，然后按确定。
* 单击生成报告按钮。

可以将多个彩色区域添加到一个可视化中。


![image](/images/trendz/line-background-config.png)

## 混合图表

![image](/images/trendz/line-mixed.png)

混合图表叠加具有共享水平轴但不同垂直轴刻度的不同图表（每个组件图表一个）。通常使用不同的基本图表类型（如条形和折线组合）来减少每个组件图表不同轴刻度的混淆。

如果“系列”部分为空，Trendz 支持列、线和区域的组合。

* 导航到具有所选遥测的卡
* 选择所需的图表类型 - **区域**、**折线**、**条形**

![image](/images/trendz/line-mixed-config.png)

## 控制 Y 轴

默认情况下，**Y 轴** 中的每个时序字段都会重复使用单独的轴。如果您在图表上显示 3 个时序，您将有 3 个不同的 Y 轴。

但是，如果所有字段的测量单位相同，您可以将它们连接起来并显示在单个轴上：

* 打开视图设置
* 选择 **启用单轴**

![image](/images/trendz/line-single-axis.png)