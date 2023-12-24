* TOC
{:toc}

## 概述

实体表小部件显示最新值，其中包含与所选别名和过滤器匹配的实体列表，并具有其他全文搜索和分页选项的功能。
使用 [小部件样式](/docs/{{docsPrefix}}user-guide/ui/entity-table-widget/#settings)、[数据源键](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/) 和
[小部件操作](/docs/{{docsPrefix}}user-guide/ui/widget-actions/) 进行高度自定义。

## 设置实体表小部件

要开始使用实体表小部件，首先需要创建一个仪表板并向其中添加一个小部件。

### 创建仪表板

因此，让我们 [创建一个仪表板](/docs/{{docsPrefix}}user-guide/dashboards/#adding-a-dashboard) 来可视化我们的遥测数据。
您可以使用现有仪表板或为新用例创建一个新仪表板。
在我们的示例中，我们创建了一个名为“实体表”的新仪表板，用于我们的教程。

### 向仪表板添加小部件

下一步是可视化遥测数据。要将实体表小部件添加到仪表板，您应该：

{% include images-gallery.html imageCollection="add-widget" showListImageTitles="true" %}

了解如何向小部件 [添加别名](/docs/{{docsPrefix}}user-guide/ui/aliases/)。

## 设置

要开始自定义小部件，您应该通过在仪表板编辑模式下单击小部件右上角的铅笔图标进入小部件编辑模式。

{% include images-gallery.html imageCollection="entity-edit" %}

### 1. 标题样式

您可以更改小部件标题工具提示和标题样式。您应该通过 [高级标题设置](/docs/{{docsPrefix}}user-guide/ui/entity-table-widget/#1-entities-table-title) 更改标题本身。
此外，您还可以向标题添加图标并调整其颜色、不透明度和大小。请参阅下面的配置和相应结果。

{% include images-gallery.html imageCollection="entity-title" showListImageTitles="true" %}

复选框负责显示/隐藏小部件标题、小部件阴影以及启用/禁用全屏模式。

### 2. 小部件样式

您可以使用 CSS 属性自定义小部件的个人样式。
此样式将应用于小部件的 main div 元素。
您还可以更改背景颜色、文本颜色、填充和边距。请参阅下面的配置和相应结果。

请注意，样式和背景颜色只是一个示例，绝对不是我们指南的一部分。

```json
{
  "border": "3px solid #2E86C1",
  "cursor": "pointer"
}
```
{: .copy-code}

{% include images-gallery.html imageCollection="entity-style" showListImageTitles="true" %}

### 3. 特殊符号和小数点后的数字位数

您可以在小部件的实体值旁边添加一个特殊符号。此外，您可以自定义小数值的小数点后要显示的数字位数。
请参阅下面的配置和相应结果。

{% include images-gallery.html imageCollection="entity-digits" showListImageTitles="true" %}

### 4. 图例设置

图例设置仅在默认启用此选项的时间序列小部件中进行配置才有意义。您可以在 [此处](/docs/{{docsPrefix}}user-guide/dashboards/#3-legend-settings) 阅读有关图例设置的更多信息。

## 高级设置

实体表小部件的高级设置允许 [调整小部件的标题](#1-entities-table-title)、[更改小部件上对象的可见性](#2-checkbox-settings)、
[自定义列](#3-the-columns-settings)、[设置分页](#4-the-pagination)、
[对表小部件中的数据进行排序](#5-sorting-data-in-the-table-widget) 和 [更改小部件行样式](#6-row-style-function)。

要进入高级模式并开始调整上述设置，您应该：

{% include images-gallery.html imageCollection="enter-advanced-mode" showListImageTitles="true" %}


### 1. 实体表标题

ThingsBoard 在符号或字符数量上没有任何名称限制。
尽管如此，如果标题太长，它将不会在实体表小部件中完全显示，而是以三个点结尾。
但是，在应用更改并在全屏模式下打开小部件后，您将能够看到小部件的完整名称。
例如，让我们为标题使用一些简单的内容，例如“新小部件标题”：


{% include images-gallery.html imageCollection="entities-table-title" showListImageTitles="true" %}

### 2. 复选框设置

{% include images-gallery.html imageCollection="checkboxes" %}

- 启用实体搜索

如果选中复选框，小部件右上角的放大镜允许您搜索小部件实体。

{% include images-gallery.html imageCollection="entities-search" %}

- 启用选择要显示的列

如果选中复选框，小部件右上角的黑色条允许您选择要隐藏和要显示的列。

{% include images-gallery.html imageCollection="columns-to-display" %}

- 始终显示标题

如果选中复选框，当我们滚动实体列表时，小部件标题始终可见。如果未选中该框，小部件标题将保留在顶部。

{% include images-gallery.html imageCollection="display-header" %}

- 始终显示操作列

如果选中复选框，当我们滚动小部件的遥测数据时，行操作单元格始终可见。如果取消选中，行操作单元格将保留在行的末尾。

{% include images-gallery.html imageCollection="actions-column" %}

- 显示实体名称列

如果选中复选框，则实体名称列可见。如果取消选中，它将被隐藏。

{% include images-gallery.html imageCollection="entity-name-column" %}

### 3. 列设置

#### 3.1. 实体列标题

要更改列的标题，您应该：

{% include images-gallery.html imageCollection="entity-column-title" showListImageTitles="true" %}

#### 3.2. 显示实体标签列

如果选中“显示实体标签列”复选框，则可以添加标签列并对其命名。
在单击右上角的橙色复选标记后，带有自定义名称的标签列将出现在小部件中。

{% include images-gallery.html imageCollection="entity-label-column" %}

#### 3.3. 显示实体类型列

复选框“显示实体类型列”负责在小部件上显示实体的类型（例如“设备”）。
默认情况下，显示实体类型列，但您可以取消选中该框以将其隐藏。

### 4. 分页

默认情况下，小部件显示每页可以显示多少项以及总共有多少页。显示此信息是可选的。
通过选中/取消选中名为“显示分页”的复选框来更改它。
如果禁用复选框，则不会显示有关每页项目和页数的信息。
要应用更改，请单击右上角的橙色复选标记。

{% include images-gallery.html imageCollection="paggination-off" %}

**请注意：**要理解接下来的设置，我们需要启用“显示分页”复选框来查看每页的项目数。

默认情况下，**页面大小**设置为每页 10 项。
如果您需要更改此数字，您应该：

{% include images-gallery.html imageCollection="page-size" %}

### 5. 对表小部件中的数据进行排序

默认情况下，表小部件中的数据按升序排列。
如果列中的值不是数字（例如名称和类型），则将根据字母顺序规则进行排序。

{% include images-gallery.html imageCollection="sortingorder-name" %}

如果您想对数据进行排序，例如，按遥测数据键类型（温度、湿度等）进行排序，
您可以通过在默认排序顺序行中输入您的值名称来执行此操作。
在示例中，使用了温度。
如果您需要使排序顺序降序，您应该：

{% include images-gallery.html imageCollection="sorting-data" showListImageTitles="true" %}

### 6. 行样式函数

自 3.2.2 版本以来，出现了根据条件更改小部件行样式的机会。让我们看看它在简单示例中的工作原理：假设我们需要观察哪些设备处于活动状态，哪些设备处于非活动状态。为了让我们的任务更轻松，我们应该使用行样式函数。

一个示例及其相应结果：

```ruby
result = {background:"white"};
if (entity.active == "false") {
   result.background = '#FF0000';
} else {
   result.background = '#00FF00';
}
return result;
```

{% include images-gallery.html imageCollection="style-function" %}


## 保存更改

要应用并保存更改，您必须单击仪表板右下角的橙色复选标记。

然后，您可以确保对表小部件的更改已正确应用并保存。

{% include images-gallery.html imageCollection="saving-changes" %}