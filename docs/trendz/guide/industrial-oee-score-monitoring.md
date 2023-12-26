---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 跟踪工业厂房的整体设备效率 (OEE)
description: 如何使用来自物联网传感器的实时数据来跟踪制造厂房的 OEE 得分。深入了解可用性、性能和质量指标，以优化装配线并解决停机原因。  

oee-score-dashboard:
  0:
    image: /images/trendz/guide/oee_score/oee_score_industrial_plant.png
    title: '工厂中 OEE 得分跟踪仪表板'

oee-score-availability-calculation:
  0:
    image: /images/trendz/guide/oee_score/OEE_create_view_St1_1.png
    title: '在 Trendz 中创建折线图'
  1:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St1_2.png
    title: '配置可用性图表以跟踪停机事件'
  2:
    image: /images/trendz/guide/oee_score/OEE_calculated_St1_3.png
    title: '使用状态来跟踪装配线运行了多长时间'
  3:
    image: /images/trendz/guide/oee_score/OEE_final_view_St1_4.png
    title: '机器运行时间动态'

oee-score-downtime-reasons: 
  0:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St2_1.png
    title: '为每条装配线创建包含前 5 个停机原因的条形图'
  1:
    image: /images/trendz/guide/oee_score/OEE_settings_St2_2.png
    title: '设置计算字段以计算前 5 个停机原因'
  2:
    image: /images/trendz/guide/oee_score/OEE_final_view_St2_3.png
    title: '每条装配线的前 5 个停机原因'

oee-score-production-speed-vs-planned:
  0:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St3_1.png
    title: '创建折线图，将生产速度与计划生产进行比较'
  1:
    image: /images/trendz/guide/oee_score/OEE_batch_calculation_St3_2.png
    title: '设置计算字段以计算性能指标'
  2:
    image: /images/trendz/guide/oee_score/OEE_final_view_St3_3.png
    title: '工厂的每小时生产速度'
    
oee-score-quality-score:
  0:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St4_1.png
    title: '创建折线图，显示损坏零件的百分比'
  1:
    image: /images/trendz/guide/oee_score/OEE_calculated_St4_2.png
    title: '设置计算字段以根据损坏零件的数量计算质量得分'
  2:
    image: /images/trendz/guide/oee_score/OEE_final_view_St4_3.png
    title: '跟踪工厂的拒收明细数量和整体质量得分'

---

* TOC
{:toc}

## 简介
一家制造厂生产汽车零件，全天候运营。该工厂有 3 条装配线，每条线的整体设备效率 (OEE) 得分分别为 85%、90% 和 75%。
通过利用安装在智能工厂装配线附近的物联网传感器的数据，并分析来自装配线上的实时数据，我们可以跟踪整个工厂和装配线中每个单独零件的可用性、性能和质量指标。一旦我们实时跟踪这些指标
并且每天跟踪，我们将能够分析设备停机原因并确定 OEE 得分低下的根本原因，例如计划外停机、性能低下或质量低下。

**任务定义：**实时跟踪整个工厂和每条装配线的 OEE 得分，并每天跟踪。

{% include images-gallery.html imageCollection="oee-score-dashboard" %}


### 实施计划
* 通过跟踪停机事件的数量和原因来计算装配线的**可用性**指标。
* 确定每条装配线的前 5 个停机原因以执行根本原因分析。
* 通过跟踪与计划速度相比的生产速度来分析**性能**指标。
* 根据拒收零件的数量和拒收原因计算**质量**指标。


## 入门：

### 前提条件
让我们看看在讨论的解决方案范围内 GridLinks 中存在的实体。了解它们如何相互连接以及我们从传感器接收哪些原始遥测数据非常重要。本指南的范围之外是实体和传感器是如何配置的。您可以在我们的文档中找到如何执行此操作的详细信息。因此，我们的域模型如下所示：

* 在 GridLinks 中注册为资产的“制造厂”。
* 在 GridLinks 中注册为设备的“装配线”，并与制造厂资产相关联。
* 现场网关通过 modbus 协议从装配线收集数据，并将其作为遥测数据发送到 GridLinks。
* 从装配线收集以下指标：
  * `powerUsageWh` - 装配线消耗的能量（以瓦时为单位）
  * `producedParts` - 生产的零件数量
  * `rejectedParts` - 在质量检查期间拒收的零件数量
  * `status` - 装配线的当前状态（运行、停止、维护等）
  * `reason` - 停机事件的原因（维护、材料不足等）

### 步骤 1：分析设备停机持续时间并计算可用性指标
我们拥有来自装配线的所有必要信息，以计算其停机时间以及原因。每 30 秒，我们都会收到装配线的能耗详细信息
格式为 `{powerUsageWh: 10, ts: 1675421880000}`。此外，每次设备停止时，操作员都会选择原因，GridLinks 会收到有关状态更改的事件，格式为 `{status: "stopped", reason: "maintenance", ts: 1675421880000}`。

为了分析装配线运行或停止了多长时间，我们将使用 Trendz **状态字段**。状态字段是一种特殊类型的字段，它可以根据简单的布尔条件来告诉设备在特定状态下停留了多长时间。那么，让我们开始吧：

* 在 Trendz 中创建折线图
* 将 `Date` 字段添加到 X 轴部分 - 它允许按月、周、日或小时拆分数据
* 将 `assemblyLine` 字段添加到系列部分 - 它允许按装配线拆分数据
* 将状态字段添加到 Y 轴部分
  * 将聚合更改为“持续时间百分比” - 使用此聚合，我们将看到每条装配线以百分比表示的运行时间。
  * 将标签更改为“可用性得分”
  * 使用以下 JavaScript 公式来定义操作状态

```javascript
var state = none(assemblyLine.status);
return state == "running";
```

* 使用名称 **OEE 可用性折线图** 保存视图

因此，我们可以看到一个实时折线图，显示每条装配线的 OEE 可用性得分。稍后，我们可以在此处添加一个阈值，以突出可用性得分低于预期目标的情况，以便我们可以更快地对潜在问题做出反应。

{% include images-gallery.html imageCollection="oee-score-availability-calculation" %}


### 步骤 2：为每条装配线构建包含前 5 个停机原因的条形图。
现在我们想知道不同机器中最常见的停机原因是什么。此数据应以堆叠条形图的形式显示，其中每个条形代表一条装配线，每个条形按前 5 个停机原因拆分。

* 在 Trendz 中创建条形图
* 将 `assemblyLine` 字段添加到 X 轴部分 - 它允许按装配线拆分数据
* 将 `assemblyLine.status` 字段添加到系列部分，聚合为 `UNIQ` - 它允许按状态对数据进行分组
* 将 `assemblyLine.status` 字段添加到值部分，聚合为 `COUNT` - 它允许计算每个状态的事件数量
* 将 `assemblyLine.status` 字段添加到过滤器并选择表示停机的所有可用状态。
* 打开视图设置
  * 将排序设置为“降序”
  * 将排序列设置为 `assemblyLine.status`
  * 将“限制”设置为 5
  * 启用复选框“堆叠条形图”
* 使用名称 **可用性：前 5 个停机原因** 保存视图

{% include images-gallery.html imageCollection="oee-score-downtime-reasons" %}

### 步骤 3：比较当前和计划的生产速度
OEE 框架中的性能得分是实际生产速度与计划速度的比率。我们为每个装配线存储一个计划速度作为属性值，并且我们可以根据生产的零件数量计算实际速度。
装配线上的传感器每 60 秒报告一次生产的零件数量，格式为 `{producedParts: 10, ts: 1675421880000}`。我们希望创建一个折线图，显示每条生产线的装配线性能得分。

* 在 Trendz 中创建折线图
* 将 `Date` 字段添加到 X 轴部分 - 它允许按月、周、日或小时拆分数据
* 将 `assemblyLine` 字段添加到系列部分 - 它允许按装配线拆分数据
* 将计算字段添加到 Y 轴部分
  * 将标签更改为“性能得分”
  * 启用“批量计算”复选框 - 我们希望使用原始遥测值来计算性能得分
  * 使用 AVG 聚合 - 我们希望为每个时间间隔计算平均性能得分，因为用户可以在小时、天、周和月之间切换间隔
  * 使用以下 JavaScript 公式计算性能得分
 
```javascript
var plannedSpeed = uniq(assemblyLine.plannedSpeed)[0].value;
var rawProducedPartsArray = none(assemblyLine.producedParts);

var performanceScore = [];
for (var i = 0; i < rawProducedPartsArray.length; i++) {
  var point = rawProducedPartsArray[i];
  var score = point.value * 100 / plannedSpeed;
  performanceScore.push({ts: point.ts, value: score});
}

return performanceScore;
```

* 使用名称 **OEE 性能得分折线图** 保存视图

在此视图中，我们使用批量计算字段，因为我们需要访问传感器报告的原始值。
一旦执行转换，Trendz 会将选定的聚合函数（在本例中为 AVG）应用于结果数组，以接收每个时间间隔和装配线的一个值。与此相反，简单的计算字段在转换之前应用聚合。

{% include images-gallery.html imageCollection="oee-score-production-speed-vs-planned" %}

### 步骤 4：根据拒收零件的数量计算质量得分
要分析的最后一个方面是质量得分，它会告诉我们有多少拒收零件以及装配线之间有何差异，因为某些设备可能存在机械损失或轮班中缺乏经验的操作员，因此我们会有更多拒收零件。
此信息以以下格式从传感器提交：`{rejectedParts: 10, ts: 1675421880000}`。我们希望创建一个折线图，显示每条生产线的装配线质量得分。

* 在 Trendz 中创建折线图
* 将 `Date` 字段添加到 X 轴部分 - 它允许按月、周、日或小时拆分数据
* 将 `assemblyLine` 字段添加到系列部分 - 它允许按装配线拆分数据
* 将计算字段添加到 Y 轴部分
  * 将标签更改为“质量得分”
  * 使用以下 JavaScript 公式计算质量得分

```javascript
var producedParts = sum(assemblyLine.producedParts);
var rejectedParts = sum(assemblyLine.rejectedParts);

var qualityScore = 100 - rejectedParts * 100 / producedParts;
return qualityScore;
```

* 使用名称 **OEE 质量得分折线图** 保存视图

在计算字段的公式中，我们正在计算装配线生产的“合格”明细的百分比。

{% include images-gallery.html imageCollection="oee-score-quality-score" %}

## 总结
通过跟踪每个装配线的 OEE 得分及其组成部分，我们可以精确定位影响效率的具体因素，并确定改进机会。
这些知识使工厂经理能够实施针对性解决方案来应对每条装配线面临的独特挑战，最终导致更高效、更具生产力的制造工厂。通过分析可用性、性能和质量数据，工厂
经理可以确定 OEE 得分低下的根本原因并制定有针对性的解决方案来改进它们。通过持续监控和改进，
工厂可以优化其装配线，减少停机时间，并以更快的速度生产更高质量的零件。随着技术不断发展，实时数据收集和分析将变得更加重要，以确保制造工厂的成功和竞争力。