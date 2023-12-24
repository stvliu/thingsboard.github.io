{% assign feature = "平台集成" %}

* TOC
{:toc}

## 概述

在本示例中，我们将研究行程动画小部件的功能。

此小部件可能对不同的用例有用，但主要可用于实时跟踪、研究实体的移动并对其进行可视化。
{% if docsPrefix == null %}
{% else %}
本指南适用于 [云](https://thingsboard.cloud)，因此某些步骤与社区版略有不同。
{% endif %}

它适用于所有进一步的版本。

## 创建设备模拟器

首先，您需要创建一个设备，从中收集遥测数据。

此外，您可以使用任何具有坐标遥测（经度和纬度）的设备。

这可以是任何实时接收其坐标的设备。

经度和纬度是地图可视化的关键数据，以便您在所选仪表板的小部件上看到它。



创建新设备 **Tracker1**。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-device-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-device-1-pe.png)
{% endif %}

{% if docsPrefix == null %}
{% assign YOUR_HOST = "[emulator](/docs/user-guide/resources/timeseries-map-bus-ce.js)" %}
{% endif %}
{% if docsPrefix == "pe/" %}
{% assign YOUR_HOST = "[emulator](/docs/user-guide/resources/timeseries-map-bus-pe.js)" %}
{% endif %}
{% if docsPrefix == "paas/" %}
{% assign YOUR_HOST = "[emulator](/docs/user-guide/resources/timeseries-map-bus-cloud.js)" %}
{% endif %}
在我们的示例中，该设备使用 javascript 编写的 {{YOUR_HOST}} 接收其经度、纬度、速度、圆圈半径、状态和多边形坐标。

要接收遥测数据并在仪表板上进一步对其进行可视化，请在命令行中执行脚本：

```bash
node timeseries-map-bus.js $ACCESSTOKEN
```
{: .copy-code}
其中 **$ACCESSTOKEN** 是您的设备访问令牌。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/device-emulator-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/device-emulator-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/device-emulator-paas.png)
{% endif %}

**$ACCESSTOKEN** 位于设备详细信息中。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/access-token-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/access-token-1-pe.png)
{% endif %}

模拟器与 Node.js v8.10.0 兼容

## 设置行程动画小部件

### 创建仪表板

我们需要创建一个仪表板，以便对我们的遥测数据进行可视化。如果您想跟踪实体在特定时期的移动情况，这可能很有用。

我们可以使用现有的仪表板，也可以为我们的新用例创建一个新的仪表板。

在我们的示例中，我们为指南原因创建了一个名为“Dashboard1”的新仪表板。

### 添加小部件

创建并打开一个空仪表板。让我们用一些内容填充它。单击铅笔按钮“进入编辑模式”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-1-pe.png)
{% endif %}

首先，我们需要创建一个 **别名** 来指定我们将从中接收遥测数据的实体。

本指南中的我们的实体将是 **“Tracker1”** 设备，我们之前创建过该设备。我们将为我们的别名命名 **“GeoData1”**。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-2-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-2-pe.png)
{% endif %}

现在我们开始添加小部件！

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-3-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-3-pe.png)
{% endif %}

行程动画小部件位于地图包中

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-4-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-4-pe.png)
{% endif %}

在我们的窗口小部件中，我们添加了 **坐标**、**纬度**、**经度**、**半径**、**速度** 和 **状态** 作为我们的别名 **“GeoData1”** 的参数。

它们的标签与它们的键相同。其次，我们在其上创建一个小部件，以便对我们的遥测数据进行可视化。

我们在指南中使用 **行程动画** 小部件。它位于地图包的时间序列选项卡中。

此外，我们将选择“使用仪表板时间窗口”，以便更轻松地同步我们的数据。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-5-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-5-pe.png)
{% endif %}

除此之外，我们将使用最后收到的分钟数据进行可视化，并将聚合函数更改为无，因为我们不需要猜测下一个时间段的可能数据值，我们实时接收数据而不会出现任何错误。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-6-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-6-pe.png)
{% endif %}

现在我们可以看看我们的设备在过去一分钟内是如何实时移动的。按“开始”按钮。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-7-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-7-pe.png)
{% endif %}

我们还可以将时间线光标加速至 1.5、10、25 倍，以便我们可以更快地检查其路由。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-8-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/adding-widget-8-pe.png)
{% endif %}

## 自定义

### 设置选项卡

现在，当我们了解了小部件可以提供哪些基本信息时，让我们编辑其设置以使其更具功能性和吸引力。首先，我们转到设置，在那里我们可以指定：

* 小部件的标题、其样式

* 标题工具提示

* 标题图标、图标颜色、图标大小（以像素为单位）

* 更改小部件样式

* 背景颜色、文本颜色、填充、边距

* 启用/禁用阴影

* 为小部件启用/禁用全屏模式

* 启用/禁用图例显示

* 指定移动设置


让我们看看它是如何工作的。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/widget-settings-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/widget-settings-1-pe.png)
{% endif %}

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/widget-settings-2-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/widget-settings-2-pe.png)
{% endif %}

### 高级选项卡

在设置选项卡中，我们可以为行程动画小部件指定仅它可以提供的功能的唯一参数。我们有：

#### 地图提供程序设置

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-1-pe.png)
{% endif %}

#### 行程动画设置

##### 归一化数据步骤（毫秒）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-2-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-2-pe.png)
{% endif %}

##### 纬度和经度键名
您可以指定基于该名称更新小部件。它使用基于数据标签的数据。因此，您可以为经度键值指定标签“data-1”，并在我们编辑经度键名称为“data-1”后从别名中获取经度。

{% include images-gallery.html imageCollection="advanced-settings-key-name" %}

##### 工具提示功能
您可以显示/隐藏工具提示、其颜色、其字体颜色、工具提示的不透明度和工具提示文本，或使用工具提示功能（您可以根据 *data、dsData、dsIndex* 更改工具提示中包含的数据）

{% include images-gallery.html imageCollection="advanced-settings-tooltip" %}

工具提示功能：
```javascript
var speed = data['speed'];
var res;
if (speed > 0) {
    res = "${entityName}</br><b>Speed:</b> " + String(speed)
} else {
    res = "${entityName}</br><b>Status: On The stop</b>"
}
return res;
```
{: .copy-code}

#### 标记设置

##### 标签功能

* 为标记设置其他旋转角度

{% include images-gallery.html imageCollection="advanced-settings-additional-rotation-angle-for-marker" %}

* 小部件标签，或指定标签功能（您可以根据 *data、dsData、dsIndex* 更改小部件标签中包含的数据）

{% include images-gallery.html imageCollection="advanced-settings-label" %}
 
标签功能：
```javascript
var speed = data['speed'];
var res;
if (speed > 55) {
    res = "Too Fast"
} else {
    res = "Everything is OK"
}
return res;
```
{: .copy-code}

##### 标记功能：

除了所有这些之外，标记还有一些设置，您可以为其指定以下设置：

* 自定义标记图像

* 自定义标记图像大小像素

{% include images-gallery.html imageCollection="advanced-settings-marker-image" %}

* 标记图像功能（您可以根据 *data、dsData、dsIndex* 更改标记图像、标记图像颜色）

* 指定其他可能的标记图像，可用于标记图像功能中

{% include images-gallery.html imageCollection="advanced-settings-marker-image-function" %}

标记图像功能：
```javascript
var speed = data['speed'];
var res = {
    url: images[0],
    size: 40
}
if (speed < 55) {
    res.url = images[0];
} else {
    res.url = images[1];
}
return res;
```
{: .copy-code}

#### 路径设置

您可以指定路径颜色或指定路径颜色函数（您可以根据 *data、dsData、dsIndex* 更改数据） - 标记移动的颜色

{% include images-gallery.html imageCollection="advanced-settings-path-color-function" %}

路径颜色函数：
```javascript
var speed = data['speed'];
var res;
if (speed > 55) {
    res = "red"
} else {
    res = "green"
}
return res;
```
{: .copy-code}

##### 路径装饰器

* 路径装饰器、其大小（以像素为单位）、结束/开始偏移、装饰器重复器、笔触粗细和笔触不透明度

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-path-decorator-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-path-decorator-1-pe.png)
{% endif %}

#### 点设置

下一个选项是显示点选项。点是遥测数据更新，以便您可以检查每个点。对于点，可以使用以下选项。

* 显示/隐藏点

* 点颜色

* 点大小像素

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-points-settings-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-points-settings-1-pe.png)
{% endif %}

* 使用彩色点函数

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-point-color-function-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-point-color-function-1-pe.png)
{% endif %}

点颜色函数：
```javascript
var speed = data['speed'];
var res;
if (speed > 55) {
    res = "red"
} else {
    res = "green"
}
return res;
```
{: .copy-code}

* 将点用作锚点（您可以根据 *data、dsData、dsIndex* 更改数据）

{% include images-gallery.html imageCollection="advanced-settings-anchor-function" %}

点作为锚点函数：
```javascript
var speed = data['speed'];
if (speed > 55) {
    return true;
} else {
    return false;
}
```
{: .copy-code}

* **独立点工具提示**


#### 多边形设置

什么是多边形？它是一个平面图形，由有限数量的点描述。我们使用基于我们在使用的设备中指定的多边形，但您可以使用任何其他实体。

您可以使用多边形选项标记您的资产和任何其他实体。

多边形坐标以以下格式接收：

```
[[1CoordinateLatitude,1CoordinateLatitude],[2CoordinateLatitude,2CoordinateLatitude]...[nCoordinateLatitude,nCoordinateLatitude]]
``` 

其中 **n** - 多边形由其描述的坐标数。

<br>
对于多边形，我们可以指定以下设置：

* 显示/隐藏多边形

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-1-pe.png)
{% endif %}

* 启用/禁用多边形编辑

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-2-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-2-pe.png)
{% endif %}

* 多边形标签文本或多边形标签函数（您可以根据 *data、dsData、dsIndex* 更改多边形标签中包含的数据）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-3-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-3-pe.png)
{% endif %}

* 多边形工具提示文本或多边形工具提示函数（您可以根据 *data、dsData、dsIndex* 更改多边形工具提示中包含的数据）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-4-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-4-pe.png)
{% endif %}

* 多边形颜色、多边形不透明度或多边形颜色函数（您可以根据 *data、dsData、dsIndex* 更改多边形颜色）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-5-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-5-pe.png)
{% endif %}

* 多边形笔触颜色、多边形不透明度、多边形粗细或多边形笔触颜色函数（您可以根据 *data、dsData、dsIndex* 更改多边形颜色）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-6-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-polygon-settings-6-pe.png)
{% endif %}

#### 圆形设置

圆是一个平面图形，其边界点始终与一个固定的中心点保持相同的距离。我们使用基于我们在使用的设备中指定的圆，但您可以使用任何其他实体。

您可以使用圆形选项标记您的资产和任何其他实体。

圆形坐标以以下格式接收：

```
{"latitude": 37.770460000, "longitude":-122.510870000, "radius":700}
``` 

<br>
对于圆形，我们可以指定以下设置：

* 显示/隐藏圆形

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-1-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-1-pe.png)
{% endif %}

* 启用/禁用圆形编辑

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-2-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-2-pe.png)
{% endif %}

* 圆形标签文本或圆形标签函数（您可以根据 *data、dsData、dsIndex* 更改圆形标签中包含的数据）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-3-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-3-pe.png)
{% endif %}

* 圆形工具提示文本或圆形工具提示函数（您可以根据 *data、dsData、dsIndex* 更改圆形工具提示中包含的数据）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-4-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-4-pe.png)
{% endif %}

* 圆形填充颜色、圆形填充颜色不透明度或圆形填充颜色函数（您可以根据 *data、dsData、dsIndex* 更改圆形颜色）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-5-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-5-pe.png)
{% endif %}

* 圆形笔触颜色、笔触不透明度、笔触粗细或圆形笔触颜色函数（您可以根据 *data、dsData、dsIndex* 更改圆形颜色）

{% if docsPrefix == null %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-6-ce.png)
{% else %}
![image](/images/user-guide/ui/widgets/trip-animation-widget/advanced-settings-circle-settings-6-pe.png)
{% endif %}


## 视频教程
 
我们还建议您查看此视频教程。

  
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/qWCmDjca-T8" frameborder="0" allowfullscreen></iframe>
    </div>
</div>