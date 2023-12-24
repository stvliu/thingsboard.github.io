* TOC
{:toc}

## 简介

高级数据键配置负责图表上特定数据键列或行的可见性、样式和外观。

“**警报表**”小部件和“**表格**”、“**实体小部件**”和“**实体管理小部件**”捆绑包具有 [相同的先进数据键配置](#advanced-data-key-configuration)。

“**图表**”小部件捆绑包具有其 [独特的高级数据键配置](#advanced-data-key-configuration-for-charts-widget-bundle)。

所有其他小部件捆绑包仅具有 [基本数据键配置](/docs/{{docsPrefix}}user-guide/widgets/#data-keys)。

<br>
要输入数据键配置，请单击要调整的特定数据键上的铅笔图标。

{% if docsPrefix == null %}
![image](/images/user-guide/widgets/advanced-data-key/enter-data-key-configuration-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/widgets/advanced-data-key/enter-data-key-configuration-pe.png)
{% endif %}

## 高级数据键配置

众所周知，“警报表”小部件、“表格”、“实体小部件”和“实体管理小部件”捆绑包具有相同的高级数据键配置。
让我们使用“表格”捆绑包中的“实体表”小部件作为示例，来了解这些小部件的高级数据键配置。

请按照以下步骤开始高级配置键数据。

{% include images-gallery.html imageCollection="entity-table-example" showListImageTitles="true" %}

### 自定义标题

默认情况下，列名与键名相同。_"自定义标题"_ 选项允许您将列标题更改为您喜欢的任何内容。

{% include images-gallery.html imageCollection="custom-header-title" %}

### 列宽（像素或百分比）

_"列宽"_ 功能允许您以像素或百分比调整列的宽度。手动输入所需的宽度（例如，200px）。
同样，您可以将宽度更改为百分比。

{% include images-gallery.html imageCollection="column-width" %}

### 单元格样式功能

_"单元格样式功能"_ 允许根据值、实体或 [ctx](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/#basic-widget-api) 调整行的颜色。
要配置单元格样式功能，您应该选中 _使用单元格样式功能_ 框，并在下面的 _单元格样式功能_ 字段中输入函数。

{% include images-gallery.html imageCollection="style-function" %}

单元格颜色根据其值而变化的单元格样式函数示例：

```ruby
if(value < 0) {
   return {"background-color" : "#5F4DEB"};
} else if (value < 35) {
    return {"background-color" : "#62c5e3", "color" : "#19154a"};
} else if (value < 45) {
    return {"background-color" : "#b50232", "color" : "#f7e18f"};
} else if (value < 55) {
    return {"background-color" : "#e6b500", "color" : "#ff2200"};
} else if (value < 65) {
    return {"background-color" : "#ff9419"};
} else if (value < 75) {
    return {"background-color" : "#d0ff00"};
} else if (value < 85) {
    return {"background-color" : "#35c433"};
} else { 
    return { "background-color" : "red" };
}
```
{: .copy-code}

### 单元格内容功能

_"单元格内容功能"_ 允许根据值、实体或 [ctx](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/#basic-widget-api) 更改数据键列的文本。
要配置单元格样式功能，您应该选中 _使用单元格内容功能_ 框，并在下面的 _单元格内容功能_ 字段中输入函数。

在示例中，我们有两个可能的设备答案：真或假。单元格内容功能可以更改答案文本。当设备不多时，这是可以接受的。

{% include images-gallery.html imageCollection="content-function-1" %}

```ruby
if (value == "true") {
    return "Active";
} else {
    return "Inactive";
}
```
{: .copy-code}

但是，有时阅读返回文本来确定设备是否处于活动或非活动状态并不方便。
单元格内容功能提供了一种更用户友好的方法，允许配置自定义函数以直观地将设备状态表示为活动或非活动（请参阅下面的示例函数）。

{% include images-gallery.html imageCollection="content-function-2" %}

可配置函数以显示活动/非活动状态：

```ruby
if (value == "true") {
    return '<div style="border-radius:50%;background-color:green;width:18px;height:18px"></div>';
} else {
    return '<div style="border-radius:50%;background-color:red;width:18px;height:18px"></div>';
}
```
{: .copy-code}

### 默认列可见性

列的 _"默认列可见性"_ 功能允许您选择数据键列在小部件上可见还是隐藏。
当您需要排除特定数据键时，在导出小部件时，这尤其有用。

{% include images-gallery.html imageCollection="column-visibility" %}

### 在“要显示的列”中选择列

_"在‘要显示的列’中选择列"_ 功能允许您选择列是否显示在可见性选择菜单中。因此，没有权限的客户端无法隐藏它。

{% include images-gallery.html imageCollection="column-to-display" %}

### 在导出中包含列

{% assign feature = "在导出中包含列" %}{% include templates/pe-feature-banner.md %}

_"在导出中包含列"_ 功能允许您选择小部件可以在什么条件下导出具有特定数据键列。
有三个选项：始终、仅当列可见时（您可以在 [默认列可见性](#default-column-visibility)）中更改可见性，以及从不。

{% include images-gallery.html imageCollection="column-export" %}

## “图表”小部件捆绑包的高级数据键配置

“图表”小部件捆绑包的高级数据键配置不同于其他小部件捆绑包的高级数据键配置。

让我们使用“图表”捆绑包中的“时序线形图”小部件作为示例，来分解数据键配置。

请按照以下步骤开始高级配置数据键。

{% include images-gallery.html imageCollection="timeseries-line-chart-example" showListImageTitles="true" %}

### 数据默认隐藏

默认情况下，数据源中指定键的所有数据都显示在图表上。

为所选键启用 _"数据默认隐藏"_ 功能，以便此键的数据在图表上默认隐藏。

{% include images-gallery.html imageCollection="data-is-hidden-by-default" %}

### 禁用数据隐藏

为所选键启用 _"禁用数据隐藏"_ 功能，以便您和您的用户无法通过单击键名来隐藏图表上的数据。

{% include images-gallery.html imageCollection="disable-data-hiding" %}

### 从图例中删除数据键

启用 _"从图例中删除数据键"_ 功能以防止所选键显示在图例中。

{% include images-gallery.html imageCollection="remove-datakey-from-legend" %}

### 排除堆叠

您可以从堆叠中排除特定键。此功能仅在“堆叠”模式下可用。
在此处阅读有关堆叠模式及其使用方法的更多信息 [here](/docs/{{docsPrefix}}user-guide/widgets/#common-settings)。

### 显示线

您可以使用 _"显示线"_ 功能在图表上显示/隐藏线，并以像素为单位设置线宽。

{% include images-gallery.html imageCollection="show-line" %}

#### 填充线

启用 _"填充线"_ 功能以填充线与图表底边之间的空间。您还可以在 0 到 1 的范围内指定填充的不透明度。

{% include images-gallery.html imageCollection="fill-line" %}

### 显示点

启用 _"显示点"_ 功能以在图表上显示数据点。
您还可以指定点的线宽（以像素为单位）、它们的半径（以像素为单位）及其形状。

{% include images-gallery.html imageCollection="show-points" %}

### 工具提示设置

通过高级小部件设置自定义 _工具提示_ 是适用于所有数据键的基本设置。
在此处阅读有关小部件工具提示设置的更多信息 [here](/docs/{{docsPrefix}}user-guide/widgets/#tooltip-settings)。

通过对所选数据键使用 _"工具提示值格式功能"_，您可以仅为该数据键配置将显示在工具提示中的值，并且基本工具提示功能将被此配置覆盖。

{% include images-gallery.html imageCollection="tooltip-settings" %}

### 纵轴

启用 _"显示单独的轴"_ 以显示此数据键的单独轴。对于此轴，您可以设置自己的标题、刻度的最小值和最大值、指定小数位数以及纵轴上刻度线之间的步长。

{% include images-gallery.html imageCollection="vertical-axis-1" %}

在 _"刻度格式化程序功能"_ 窗口中，指定将格式化为 Y 轴刻度的值的函数。

{% include images-gallery.html imageCollection="vertical-axis-2" %}

### 阈值

使用此功能为所选键设置 _阈值_ 值。阈值将作为水平线显示在图表上。
您可以指定此线的颜色和宽度。

{% include images-gallery.html imageCollection="thresholds" %}

### 比较设置

在图表上显示历史数据，以便轻松比较不同时间段的数据。
当在小部件设置中激活 _比较模式_ 时，此功能有效。
有关比较设置及其使用方法的更多详细信息，请阅读 [here](/docs/{{docsPrefix}}user-guide/widgets/#comparison-settings)。