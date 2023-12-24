* TOC
{:toc}

所有 [物联网仪表盘](/docs/{{docsPrefix}}user-guide/dashboards/) 均使用小部件库中定义的 **ThingsBoard 小部件** 构建。

小部件是在仪表盘上显示特定类型的信息或功能的元素。
小部件用于显示数据并可视化从连接到 GridLinks 平台的设备获取的信息、远程设备控制、警报管理以及显示静态自定义 HTML 内容。

## 小部件类型

根据提供的功能，每个小部件定义都代表一个特定的小部件类型。
有五种小部件类型：

- [最新值;](#latest-values)
- [时序;](#time-series)
- [控制小部件;](#control-widget)
- [警报小部件;](#alarm-widget)
- [静态小部件.](#static)

{% include images-gallery.html imageCollection="wl-dashboard-widgets" preview="false" %}

每种小部件类型都有其自己的特定数据源配置来可视化数据。可用数据源的类型取决于小部件类型：

- **警报源** - 此数据源类型主要用于警报小部件，需要一个源实体来显示相关警报及其相应字段；
- **警报计数** - 此数据源类型用于最新值小部件。您需要指定目标实体；
- **设备** - 此数据源类型用于时序和小部件的最新值。基本上，您需要指定目标设备和时序键、属性名称或实体字段；
- **实体计数** - 此数据源类型用于最新值小部件。您需要指定目标实体；
- **实体** - 此数据源类型用于时序和小部件的最新值。基本上，您需要通过指定 [实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/)、时序键或属性名称来选择目标实体；
- **函数** - 此数据源类型用于时序和小部件的最新值，用于调试。基本上，您可以指定一个 JavaScript 函数，该函数将模拟来自设备的数据以设置可视化。

### 最新值

最新值小部件类型旨在展示特定实体属性或时序数据点的最新值（例如，任何仪表小部件或实体表小部件）。
此类型的小部件使用实体属性或时序的值作为数据源。
示例中的数字仪表显示当前温度值。

{% include images-gallery.html imageCollection="wl-latest-values-datasource" %}

### 时序

时序小部件类型显示所选时间段的历史值，或特定时间窗口中的最新值（例如，时序折线图或时序条形图）。
此小部件类型仅使用实体时序的值作为数据源。
为了指定显示值的时间范围，使用 _Timewindow_ 设置。
可以在仪表盘页面或通过小部件详细信息指定时间窗口。它可以是 _实时_ - 某个最新间隔的动态更改的时间范围，也可以是 _历史_ - 固定历史时间范围。
所有这些设置都是时序小部件配置的一部分。
在示例中，“时序折线图”实时显示设备的速度值。

{% include images-gallery.html imageCollection="wl-timeseries" %}

### 控制小部件

控制小部件允许向设备发送 RPC 命令，它处理并可视化来自设备的回复（例如，Raspberry Pi GPIO 控制）。
通过将目标设备指定为 RPC 命令的目标端点来配置 RPC 小部件。
在示例中，“基本 GPIO 控制”小部件发送 GPIO 开关命令并检测当前 GPIO 开关状态。

{% include images-gallery.html imageCollection="wl-control-widget" %}

### 警报小部件

警报小部件类型显示与特定实体相关的警报，位于特定时间窗口中（例如，警报表）。
要配置警报小部件，您需要将实体指定为警报源并定义相应的警报字段。
作为 _时序小部件_，警报小部件具有 _timewindow_ 配置来指定显示警报的时间范围。
此外，配置还包括“警报状态”、“警报严重性”和“警报类型”等参数。
“警报状态”参数显示正在获取的警报的状态。
“警报严重性”参数显示以秒为单位的警报获取频率。
“警报类型”参数有助于识别警报的主要来源。
例如，“高温”和“低湿度”代表两个不同的警报。
在此上下文中，“警报表”小部件实时显示设备的最新警报。

{% include images-gallery.html imageCollection="wl-alarms" %}

### 静态

静态小部件类型显示静态可自定义 HTML 内容（例如，HTML 卡）。
静态小部件不使用任何数据源，通常通过指定静态 HTML 内容和（可选）CSS 样式进行配置。
静态小部件的一个示例是显示指定 HTML 内容的“HTML 卡”。

{% include images-gallery.html imageCollection="wl-static" %}

<details>

<summary>
<b>调整 HTML 卡样式的 CSS 样式函数示例。</b>
</summary>

{% highlight ruby %}
.card {
font-weight: bold;
font-size: 32px;
color: #999;
width: 100%;
height: 100%;
display: flex;
align-items: center;
justify-content: center;
}
{% endhighlight %}

</details>

<details>

<summary>
<b>用于指定卡片内容的 HTML 代码示例。</b>
</summary>

{% highlight ruby %}
<h1>静态小部件标题</h1>
<div class='card'>您的文本在此处</div>
{% endhighlight %}

</details>

## 小部件库（捆绑包）

小部件根据其用途分组到小部件捆绑包中。
某些小部件可以同时在多个包中找到。例如，警报计数小部件可以在警报小部件捆绑包和计数小部件捆绑包中找到。

有系统级和小部件捆绑包。GridLinks 初始安装附带了一组基本系统级小部件捆绑包。

系统级捆绑包可以由 **系统管理员** 管理，任何租户都可以使用。
租户级捆绑包可以由 **租户管理员** 管理，只能由该租户及其客户使用。
您始终可以按照本 [指南](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/) 实现并添加您的部件。

要在所有小部件捆绑包中找到您需要的小部件，您可以使用搜索功能。

{% include images-gallery.html imageCollection="wl-bundle" %}

您还可以在“小部件”选项卡上按名称找到您需要的小部件。在此处，默认情况下按字母顺序列出所有可用小部件。

{% include images-gallery.html imageCollection="wl" %}

### 空气质量

此小部件捆绑包包括用于可视化空气质量数据的小部件。

{% include images-gallery.html imageCollection="wl-air-quality" %}

### 警报小部件

警报小部件捆绑包可用于可视化特定实体的警报，无论是在实时模式还是历史模式下。

{% include images-gallery.html imageCollection="wl-alarm-bundle" %}

### 模拟仪表

模拟仪表小部件捆绑包可用于可视化温度、湿度、速度和其他整数或浮点值。

{% include images-gallery.html imageCollection="wl-analog-gauges-bundle" %}

### 卡片

卡片捆绑包可用于在表格或卡片小部件中可视化时序数据或属性。

{% include images-gallery.html imageCollection="wl-cards-bundle" %}

### 图表

图表捆绑包可用于可视化具有时间窗口的历史或实时数据。

{% include images-gallery.html imageCollection="wl-charts-bundle" %}

### 控制小部件

控制小部件捆绑包可用于可视化当前状态并向目标设备发送 RPC 命令。

{% include images-gallery.html imageCollection="wl-control-bundle" %}

### 计数小部件

计数器小部件捆绑包可用于根据所选过滤器计数和可视化当前警报和实体的数量。

{% include images-gallery.html imageCollection="wl-count-bundle" %}

### 日期

日期小部件捆绑包可用于更改仪表盘上其他小部件的数据范围。

{% include images-gallery.html imageCollection="wl-date-bundle" %}

### 数字仪表

数字仪表捆绑包可用于可视化温度、湿度、速度和其他整数或浮点值。

{% include images-gallery.html imageCollection="wl-digital-bundle" %}

### 边缘小部件

边缘小部件捆绑包可用于概述与指定 ThingsBoard 边缘实例相关联的实体。

{% include images-gallery.html imageCollection="wl-edge-widgets-bundle" %}

### 实体管理小部件

实体管理小部件是复杂小部件的模板，允许列出和创建/更新/删除设备和资产。

{% include images-gallery.html imageCollection="wl-entity-admin-bundle" %}

### 实体小部件

实体管理小部件显示具有其数据的实体列表、计数实体以及根据其关系显示实体的层次结构。

{% include images-gallery.html imageCollection="wl-entity-bundle" %}

### 文件

{% capture difference %}
**仅在 PE 和 PaaS 中可用。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

文件小部件将文件或 PDF 报告列表显示为表格。允许下载和删除文件。

{% include images-gallery.html imageCollection="wl-files-bundle" %}

### 网关小部件

网关小部件捆绑包可用于管理扩展。

{% include images-gallery.html imageCollection="wl-gateway-bundle" %}

### GPIO 小部件

GPIO 小部件捆绑包可用于可视化和控制目标设备的 GPIO 状态。

{% include images-gallery.html imageCollection="wl-gpio" %}

### 主页小部件

主页小部件捆绑包可用于自定义和显示快速链接到平台的 UI 组件、文档或主页上的任何其他资源、显示有关实体数量和 API 使用情况的统计信息等。

{% include images-gallery.html imageCollection="wl-home" %}

### HTML 小部件

HTML 小部件捆绑包可用于注入自定义 HTML 代码。或用于显示可配置的 HTML，并能够注入来自所选数据源的值。

{% include images-gallery.html imageCollection="wl-html" %}

### 室内环境

室内环境小部件捆绑包可有效地可视化与室内环境相关的数据。

{% include images-gallery.html imageCollection="wl-indoor-environment-bundle" %}

### 输入小部件

输入小部件捆绑包可用于修改实体的属性。

{% include images-gallery.html imageCollection="wl-input-bundle" %}

### 液位

液位小部件捆绑包包括用于可视化油箱内液体液位的小部件。

{% include images-gallery.html imageCollection="wl-liquid-level-bundle" %}

### 地图

地图小部件捆绑包可用于可视化设备的地理位置，并在实时和历史模式下跟踪设备路线。

{% include images-gallery.html imageCollection="wl-maps-bundle" %}

### 导航小部件

导航小部件捆绑包可用于定义用户的首页仪表盘。

{% include images-gallery.html imageCollection="wl-navigation-bundle" %}

### 户外环境

户外环境小部件捆绑包可有效地可视化与户外环境相关的数据。

{% include images-gallery.html imageCollection="wl-outdoor-environment-bundle" %}

### 状态指示器

状态指示器小部件捆绑包包括用于可视化电池电量、信号强度和进度条的小部件。

{% include images-gallery.html imageCollection="wl-status-indicators-bundle" %}

### 调度小部件

{% capture difference %}
**仅在 PE 和 PaaS 中可用。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

调度小部件捆绑包可用于 [调度](/docs/{{docsPrefix}}user-guide/scheduler/) 具有灵活调度配置的各种类型的事件。

{% include images-gallery.html imageCollection="wl-scheduling-bundle" %}

### 表格小部件

表格小部件捆绑包在您需要显示实体列表、警报信号列表以及一个或多个实体的时序数据时非常有用。
此外，此小部件捆绑包展示了基于实体别名的持久 RPC 请求。
它还可以选择进行过滤，并支持分页以增强可用性。

{% include images-gallery.html imageCollection="wl-tables-bundle" %}

## 小部件操作

### 添加小部件

当系统管理员添加新小部件时，它会自动成为系统小部件。
这意味着只有管理员有权修改或删除小部件。
租户管理员也可以创建小部件，但他们只能修改自己创建的小部件。
您始终可以按照本 [指南](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/) 实现并添加您的部件。

要添加新小部件，您应该：

{% include images-gallery.html imageCollection="add-widget" showListImageTitles="true" %}

### 导出小部件

您可以以 JSON 格式从小部件捆绑包中导出特定类型的小部件，并在相同或不同的 GridLinks 实例中导入它。

为了导出小部件类型，您应该转到小部件库页面，导航到“小部件”选项卡，然后单击特定小部件卡上的导出按钮。小部件配置文件将以 JSON 格式保存在您的计算机上。

{% include images-gallery.html imageCollection="export-widget" %}

### 导入小部件

请注意，只有系统管理员才能修改系统（默认）小部件。这包括在捆绑包内编辑、删除、添加或导入小部件的能力。
当系统管理员创建新的部件捆绑包时，它被设置为租户的系统级项目，从而阻止他们对其进行修改。
尽管如此，租户可以添加他们自己的小部件。在这种情况下，他们有权在捆绑包内管理已创建的小部件类型。

要导入小部件，您应该：

{% include images-gallery.html imageCollection="import-widget" showListImageTitles="true" %}

### 删除小部件

系统管理员或租户管理员可以使用以下方式之一删除小部件类型：

第一种方式：

{% include images-gallery.html imageCollection="delete-widget-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-widget-2" showListImageTitles="true" %}

## 小部件捆绑包操作

### 添加小部件捆绑包

当系统管理员添加新的部件捆绑包时，它会自动成为系统部件捆绑包。
这意味着只有他们可以删除、编辑和向捆绑包中添加小部件。
租户管理员也可以创建小部件捆绑包。在这种情况下，他们有权修改已经创建的捆绑包。
您始终可以按照本 [指南](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/) 实现并添加您的部件。

要添加新的部件捆绑包，您应该：

{% include images-gallery.html imageCollection="wl-add-widgets-bundle" showListImageTitles="true" %}

### 导出小部件捆绑包

您可以以 JSON 格式导出小部件捆绑包，并在相同或不同的 GridLinks 实例中导入它。

为了导出小部件捆绑包，您应该：

{% include images-gallery.html imageCollection="export-widgets-bundle" showListImageTitles="true" %}

### 导入小部件捆绑包

要导入小部件捆绑包，您应该：

{% include images-gallery.html imageCollection="import-widgets-bundle" showListImageTitles="true" %}

### 删除小部件捆绑包

系统管理员或租户管理员可以使用以下方式之一删除小部件捆绑包：

第一种方式：

{% include images-gallery.html imageCollection="delete-widgets-bundle-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-widgets-bundle-2" showListImageTitles="true" %}