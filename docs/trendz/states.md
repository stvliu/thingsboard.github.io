---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 状态
description: Trendz 状态
---

* TOC
{:toc}

&nbsp;
<div id="video">  
    <div  id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/FrubZ-odF1s" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 状态

### 简单状态

![image](/images/trendz/state-simple-view.png)

在此示例中，我们有 **Machine** 设备，它提交了生产了多少个细节。我们希望了解机器的生产率是多少。

让我们定义我们的状态：
* **低产量** - 生产的细节数量 < 75；
* **中等产量** - 生产的细节数量介于 75 和 110 之间；
* **高产量** - 生产的细节数量大于 110；

以下是检查机器是否处于 **低产量** 状态的条件：
{% highlight javascript %}
    var okRate = none(Machine.okDetails);
    return okRate < 75;
{% endhighlight %}  

执行此操作需要以下步骤：
* 创建 **条形图**
* 将 **Date(RAW)** 添加到 **X 轴**
* 添加 **State** 字段并将标题更改为 **低产量**
* 将字段聚合更改为 **DURATION_PERCENT**
* 为 **低产量** 编写公式
* 对 **中等产量** 和 **高产量** 状态重复最后 3 个操作
* 在视图设置中启用堆叠模式、100% 堆叠条形图和标签

![image](/images/trendz/state-simple-config-drop.png)

![image](/images/trendz/state-simple-config.png)

我们的视图已准备就绪，现在我们知道机器在不同状态下花费了多少时间（以百分比表示）。

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/state-simple-view.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-state-duration-percent.webm" type="video/webm">                 
        </video> 
    </div>
</div>


### 具有多个字段的状态

![image](/images/trendz/state-multiple-view.png)

我们还可以使用来自不同资产/设备的多个字段来计算状态。在此示例中，我们希望检测机器在关键状态下花费了多少时间。这种可视化将让人们了解机器与其他机器相比的性能，以及何时应维护机器以防止停机。

我们知道当 **压力** 升高且 **转速** 降低时，我们的机器处于关键状态。因此，让我们了解在关键状态下花费了多少时间。

以下是 **关键** 状态的正式定义：
{% highlight javascript %}
    var pressure = none(Machine.pressure);
    var speed = none(Machine.rotationSpeed);
    return pressure > 700 && speed < 35;
{% endhighlight %}  

* 创建 **热图** 图表
* 添加 **State** 字段并将标题更改为 **Critical**
* 将字段聚合更改为 **DURATION_PERCENT**
* 为 **Critical** 状态编写公式
* 在 **按** 字段中选择 **小时与星期几**

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/state-multiple-view.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-state-multiple-heatmap.webm" type="video/webm">                 
        </video> 
    </div>
</div>

### 状态聚合

以下是状态字段支持的聚合函数列表：
* 持续时间 - 在组内以状态花费的总时间。以小时、分钟、秒等为单位。
* 持续时间百分比 - 在组内以状态花费的时间百分比。

### 获取原始字段值

在应用转换之前，您需要获取对原始字段值的引用。以下是如何执行此操作的示例：

```
var temp = none(Machine.temperature);
```

* none() - 聚合函数
* Machine - 实体名称（可以是资产类型或设备类型）
* temperature - 字段名称

**所有 3 个部分都是必需的**，如果没有聚合函数，您将无法访问原始字段值。

如果原始字段值是属性、实体名称或所有者名称 - 您应该使用 **uniq()** 聚合函数。

此模板可用于比较文本字段：

```
var currentState = none(machine.status);
return "running" === currentState;
```

### 支持的聚合函数

状态字段支持以下聚合函数：

* none()

每个函数只允许 1 个参数 - 对格式为 EntityName.fieldName 的字段的引用。例如：

```
sum(Machine.temperature)
```

通常，状态用于计算设备/资产在不同状态下花费了多少时间。为了获得更精确的结果，建议您使用 **none()** 聚合 - 在这种情况下，系统将仅处理原始遥测数据以定义设备是否处于定义的状态。

聚合函数应用于分组数据集。在 [本文](/docs/trendz/data-grouping-aggregation/) 中查找有关分组和聚合的更多详细信息

### 保存和重用状态字段

创建状态字段后，您可以通过按函数编辑器下的 **保存字段** 按钮来保存它以备将来重用。将使用当前字段标签作为字段名称。如果已经存在具有此名称的字段 - 系统将覆盖它。

保存的状态字段只是一个模板。一旦它从左侧导航树中拖放到某个轴上，就会创建一个新的状态字段，并且此字段将不会与原始模板连接。

这意味着如果您将来更新字段配置，它只会更新模板，但添加到视图配置的真实状态字段不会受到影响。

### 语言

状态字段使用 Javascript 作为编写转换函数的语言。内部引擎提供对 ECMAScript 5.1 的 100% 支持

## 后续步骤

{% assign currentGuide = "States" %}{% include templates/trndz-guides-banner.md %}