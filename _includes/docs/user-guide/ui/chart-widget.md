* TOC
{:toc}

## 概述

本指南将研究图表小部件：它们的功能、特性、小部件的基本和高级设置以及小部件的数据键。

图表小部件允许您使用可自定义的折线图和条形图显示时间序列数据。此外，您可以使用各种饼图来显示最新值。

## 如何创建图表小部件

要将任何图表小部件添加到您的仪表板，您应该：

{% include images-gallery.html imageCollection="charts-addwidget" showListImageTitles="true" %}

## 图表小部件类型

图表小部件分为时间序列和小部件和最新值小部件。时间序列小部件对于可视化时间序列数据随时间的变化非常有用。
最新值小部件用于当您需要查看多个实体的最新属性值或时间序列数据时。

### 时间序列小部件

时间序列小部件可视化时间序列数据随时间的变化。阅读[此处](/docs/{{docsPrefix}}user-guide/dashboards/#time-window)以了解如何设置时间窗口。

##### 条形图

[条形图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#timeseries-bar-chart)小部件显示时间序列数据随时间的变化。示例显示温度读数。

{% include images-gallery.html imageCollection="charts-bar" %}

##### 折线图

[折线图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#timeseries-line-chart)小部件显示时间序列数据随时间的变化。示例显示温度和湿度读数。

{% include images-gallery.html imageCollection="charts-line" %}

##### 状态图

[状态图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#state-chart-1)小部件显示实体状态随时间的变化。
例如，如果设备开和关，其状态和条件。

{% include images-gallery.html imageCollection="charts-state" %}

### 最新值小部件

最新值小部件呈现多个实体的属性或时间序列数据的最新值。最新值小部件主要支持数值。

##### 雷达

雷达小部件在雷达图中显示多个实体的最新属性或时间序列数据值。仅支持数值。

在示例中，小部件显示三个设备的最新压力时间序列数据。

{% include images-gallery.html imageCollection="charts-radar" %}

##### 极坐标面积图

极坐标面积图小部件在极坐标面积图中显示多个实体的最新属性或时间序列数据值。仅支持数值。

在示例中，小部件显示三个设备的最新压力时间序列数据。

{% include images-gallery.html imageCollection="charts-polar" %}

##### 饼图 - Chart.js

饼图 - Chart.js 小部件在饼图中显示多个实体的最新属性或时间序列数据值。仅支持数值。

在示例中，小部件显示三个设备的最新温度时间序列数据值。

{% include images-gallery.html imageCollection="charts-piejs" %}

##### 饼图 - Flot

[饼图 - Flot](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#latest-values-pie---flot)小部件在饼图中显示多个实体的最新属性或时间序列数据值。
仅支持数值。

在示例中，小部件显示三个设备的最新压力时间序列数据值。

{% include images-gallery.html imageCollection="charts-pieflot" %}

##### 甜甜圈

[甜甜圈](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#latest-values-doughnut)小部件在甜甜圈图中显示多个实体的最新属性或时间序列数据值。
仅支持数值。

在示例中，小部件显示三个设备的最新湿度时间序列数据值。

{% include images-gallery.html imageCollection="charts-doughnut" %}

##### 条形图

条形图小部件将多个实体的属性或时间序列数据的最新值显示为单独的条形图。
唯一允许使用不仅是数值的最新值图表小部件。

在示例中，小部件显示三个设备的最新压力时间序列数据值。

{% include images-gallery.html imageCollection="charts-bars" %}

## 图表小部件设置

### 基本小部件设置

基本小部件设置负责小部件的外观和样式：从标题样式和图例配置到移动设备的设置。
所有 ThingsBoard 小部件都具有相同的基本设置，您可以在[此处](/docs/{{docsPrefix}}user-guide/dashboards/#basic-widget-settings)了解如何自定义它们。

### 高级小部件设置

高级小部件设置因不同的小部件类型而异。高级设置负责配置特定小部件的独特功能。
要进入小部件编辑模式并开始配置其高级设置，首先进入仪表板编辑模式。然后，您应该：

{% include images-gallery.html imageCollection="charts-bar-advanced" showListImageTitles="true" %}

#### 时间序列条形图

##### 1. 常规设置

**1.1.** 堆叠

如果数据聚合函数**未**设置为无，请使用此功能。
如果选中堆叠框，则条形图将根据所用实体的值进行拆分。
如果未选中此框，则小部件将显示所用实体值的总和。要查看所有实体的值，您需要将鼠标悬停在条形图上。

{% include images-gallery.html imageCollection="charts-bar-adv-stacking" showListImageTitles="true" %}

如果您的数据未聚合，您可以通过更改数字来调整**非聚合数据的默认条形图宽度（毫秒）**。此操作使图表中的条形图更宽。

**条形图对齐**负责图表小部件上条形图相对于时间点的放置。

**所有阈值的默认线宽**、**阴影大小**、**字体颜色和大小**适用于时间序列折线图和状态图小部件。

**工具提示值格式函数，f(value)**用于您想要手动自定义工具提示时。
您可以通过[设置](/docs/{{docsPrefix}}user-guide/dashboards/#5-other-settings)或
[高级数据键配置](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#2-charts)自定义将在工具提示中显示的值。
通过设置进行的工具提示配置是基本的，同时应用于所有实体。在高级数据键配置中配置时，
它仅应用于特定时间序列数据，并且基本工具提示函数将被此配置覆盖。

但是，如果您的小部件需要一些非常特别的东西，那么工具提示值格式函数适合您。
假设您有温度读数，并且您希望在小部件上看到摄氏度和华氏度值，这些值将以两个浮点数显示。

{% include images-gallery.html imageCollection="bars-tooltipfunction" showListImageTitles="true" %}

**1.2.** 网格设置

您可以更改图表网格的外观：自定义背景颜色、网格框架及其刻度；更改线条的宽度并关闭它们的可见性。

{% include images-gallery.html imageCollection="bars-grid" showListImageTitles="true" %}

**1.3.** 轴设置

{% include images-gallery.html imageCollection="bars-axis" showListImageTitles="true" %}

**1.4.** 刻度格式化程序函数，f(value)

假设我们有遥测数据，其值非常大，尤其是在值附近有特殊符号时。
但是，我们需要构建一个小的图形（因为仪表板上没有太多可用空间）。
因此，使用刻度格式化程序函数，我们可以将刻度值转换为更紧凑的形式。

{% include images-gallery.html imageCollection="bars-ticksfun" showListImageTitles="true" %}

##### 2. 比较设置

比较设置允许您比较特定时间段内值的差异。仅在历史时间窗口中有效。

{% include images-gallery.html imageCollection="bars-comparison" showListImageTitles="true" %}

##### 3. 自定义图例设置

自定义图例设置适用于您需要显示图表中无法显示的数据的情况，例如属性或仅在图表图例中显示特定时间序列。
例如，让我们使用无法在图表中显示的活动/非活动属性，只能在表格小部件中显示。

{% include images-gallery.html imageCollection="bars-legend" showListImageTitles="true" %}

#### 时间序列折线图

时间序列折线图小部件的高级设置与时间序列条形图相同。您可以在[上面](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#timeseries-bar-chart)了解这些设置。

##### 1. 显示平滑（曲线）线

{% include images-gallery.html imageCollection="lines-smooth" showListImageTitles="true" %}

###### 2. 所有阈值的默认线宽

{% include images-gallery.html imageCollection="lines-thresholds" showListImageTitles="true" %}

#### 状态图

##### 1. 常规设置

**1.1.** 堆叠

堆叠模式适用于您需要查看实体值的小部件。

**1.2.** 显示平滑（曲线）线仅适用于折线图。

**1.3.** 悬停单个点

选中**悬停单个点**框后，您将看不到线上的值点。

**1.4.** 堆叠模式中的累积值

在堆叠模式开启时，您可以选中“累积值”框以使您的图表显示所有实体值的总和。

**1.5. 工具提示值格式函数，f(value)**用于您想要手动自定义工具提示时。
您可以通过[设置](/docs/{{docsPrefix}}user-guide/dashboards/#5-other-settings)或
[高级数据键配置](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#2-charts)自定义将在工具提示中显示的值。
通过设置进行的工具提示配置是基本的，同时应用于所有实体。在高级数据键配置中配置时，
它仅应用于特定时间序列数据，并且基本工具提示函数将被此配置覆盖。

在状态图中，您可以根据实体值将实体状态配置为显示在工具提示上。

<summary>
<b>让我们使用函数来设置所需的配置：</b>
</summary>

{% highlight ruby %}
let celsiusValue = parseFloat(value).toFixed(2);
let farenheitValue = parseFloat(celsiusValue*1.8 + 32).toFixed(2);
return celsiusValue + ' °C (' + farenheitValue + ' °F)';
{% endhighlight %}

{% include images-gallery.html imageCollection="state-tooltipfunction" showListImageTitles="true" %}

**1.6. 网格设置**

网格设置与[时间序列条形图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#1-common-settings)中的相同。

**1.7. 轴设置**

轴设置与[时间序列条形图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#1-common-settings)中的相同。

**1.8. 刻度格式化程序函数**

{% include images-gallery.html imageCollection="state-ticksfun" showListImageTitles="true" %}

##### 2. 比较设置

{% include images-gallery.html imageCollection="state-comparison" showListImageTitles="true" %}

##### 3. 自定义图例设置

自定义图例设置与[时间序列条形图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#3-custom-legend-settings)中的相同。

#### 最新值饼图 - Flot

##### 1. 半径

设置饼的半径。如果值在 0 和 1（包括）之间，则将其用作可用空间（容器大小）的百分比。
否则，它将使用该值作为直接像素长度。

{% include images-gallery.html imageCollection="pieflot-radius" showListImageTitles="true" %}

##### 2. 内半径

设置甜甜圈孔的半径。如果值在 0 和 1（包括）之间，则将其用作半径的百分比，否则它将使用该值作为直接像素长度。

{% include images-gallery.html imageCollection="pieflot-innerradius" showListImageTitles="true" %}

##### 3. 启用饼动画

随着实体值的改变，饼图 - Flot 显然会移动，但这些移动是相当剧烈的动作。尽管如此，饼动画使这些动作更流畅、更柔和。

{% include images-gallery.html imageCollection="pieflot-animation" showListImageTitles="true" %}

##### 4. 倾斜

倾斜的百分比范围从 0 到 1，其中 1 没有变化（完全垂直），0 是完全平坦（完全水平，在这种情况下实际上没有任何东西被绘制）。
现在在计算饼的最大半径与容器高度的关系时使用倾斜值。
这应该可以防止饼在某些情况下比需要的小，并减少饼上方和下方生成的额外空白空间。

{% include images-gallery.html imageCollection="pieflot-tilt" showListImageTitles="true" %}

##### 5. 描边

{% include images-gallery.html imageCollection="pieflot-stroke" showListImageTitles="true" %}

#### 最新值甜甜圈

##### 1. 边框

{% include images-gallery.html imageCollection="donut-border" showListImageTitles="true" %}

##### 2. 图例设置

{% include images-gallery.html imageCollection="donut-legend" showListImageTitles="true" %}