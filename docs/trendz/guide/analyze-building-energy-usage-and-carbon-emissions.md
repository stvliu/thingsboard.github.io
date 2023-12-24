---
layout: docwithnav-trendz
assignees:
  - vparomskiy
title: 分析建筑能源使用情况和排放跟踪
description: 如何优化建筑中的能源使用并减少碳排放

energy-analytic-dashboard:
  0:
    image: /images/trendz/guide/building_energy/energy_consumption_analytic_dashboard.png
    title: '建筑能源使用分析仪表板'

energy-consumption-by-source-table:
  0:
    image: /images/trendz/guide/building_energy/energy_sources_final_table.png
    title: '建筑中按来源划分的能源消耗表'
  1:
    image: /images/trendz/guide/building_energy/energy_sources_configuration.png
    title: '向表格配置中添加必需的字段'
  2:
    image: /images/trendz/guide/building_energy/energy_sources_calculate_cost.png
    title: '计算每种能源的总电费'
  3:
    image: /images/trendz/guide/building_energy/energy_sources_filtering.png
    title: '向表格中添加过滤选项以启用钻取分析'
  4:
    image: /images/trendz/guide/building_energy/energy_sources_default_sort.png
    title: '按总能源成本降序排列最终表格'

energy-consumption-by-areas-table:
  0:
    image: /images/trendz/guide/building_energy/energy_areas_final_table.png
    title: '表格中列出了建筑内不同区域的总电能消耗'

energy-compare-sources-bar:
  0:
    image: /images/trendz/guide/building_energy/energy_compare_sources_bar_configuration.png
    title: '比较条形图配置'
  1:
    image: /images/trendz/guide/building_energy/energy_compare_sources_bar_chart.png
    title: '在条形图上比较能源消耗'
    
energy-compare-time-ranges:
  0:
    image: /images/trendz/guide/building_energy/energy_consumption_compare_time_ranges_configuration.png
    title: '添加月份和年份日期字段以比较不同时间范围内的电力消耗'
  1:
    image: /images/trendz/guide/building_energy/energy_consumption_compare_time_ranges_filters.png
    title: '添加过滤选项以关注重要的地方'
  2:
    image: /images/trendz/guide/building_energy/energy_consumption_compare_time_ranges_bar.png
    title: '在条形图上比较不同时间范围内的电力消耗'

co2_emission_card_with_trend:
  0:
    image: /images/trendz/guide/building_energy/co2_emission_transform_formula_for_energy.png
    title: '添加计算字段以根据能源消耗计算碳排放'
  1:
    image: /images/trendz/guide/building_energy/co2_emission_compare_with_prev_interval.png
    title: '启用与前一个间隔的比较以查看趋势'
  2:
    image: /images/trendz/guide/building_energy/co2_emission_card_with_trend_and_dynamic.png
    title: '具有趋势和过去 7 天动态变化的 CO2 排放卡'

building_energy_dashboard:
  0:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_new.png
    title: '在 GridLinks 中创建新仪表板'
  1:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_config.png
    title: '将名称设置为 - 能耗报告'
  2:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_aliases.png
    title: '配置所需的仪表板别名'
  3:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_all_buildings_alias.png
    title: '使用按类型的所有资产别名在仪表板中显示所有建筑物'
  4:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_table.png
    title: '添加显示系统中所有建筑物的表格'
  5:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_configure_table.png
    title: '将其与建筑别名连接'
  6:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_row_click_for_building.png
    title: '在建筑物表格中添加行单击事件'
  7:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_rowclick_configuration.png
    title: '行单击事件应更新仪表板上所有小部件中的过滤器'
  8:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_trendz_views.png
    title: '将 Trendz 中的所有视图添加到新仪表板'
  9:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_trendz_confg.png
    title: '配置 Trendz 视图以启用按建筑过滤'

---


* TOC
{:toc}

## 简介

在当今竞争激烈的商业环境中，公司一直在寻找降低成本、提高利润并实施可持续商业实践的方法。
对于许多企业来说，最大的开支之一是能源消耗，尤其是那些在大型建筑中运营的企业。
然而，如果没有准确的能源使用数据，识别改进领域可能具有挑战性。这包括跟踪碳排放核算等元素，这是可持续运营日益重要的一个方面。
在本文中，我们将描述如何深入了解能源使用模式、识别改进领域以及实施措施以降低成本、提高可持续性，
并将碳排放核算纳入日常业务实践。

**任务定义** - 创建分析仪表板来分析建筑中的能源消耗来源并确定改进领域。

{% include images-gallery.html imageCollection="energy-analytic-dashboard" %}

### 实施计划
* 创建一个表格，按来源（暖通空调、照明、插头负载、电梯等）细分能源消耗数据
* 创建类似的表格，但按建筑物内的区域（办公室、会议室、厨房、储藏室等）细分
* 堆叠条形图，比较按来源划分的能源消耗。
* 堆叠条形图，比较当前和前一年，按月细分。
* 计算建筑中的碳排放
* 创建 GridLinks 仪表板以可视化具有过滤选项的数据

## 入门：

### 先决条件
已安装在建筑物中并通过 MQTT API 连接到 GridLinks 的电能表。为了简化数据聚合和分析，每个电能表具有 2 个属性：
* `sourceType` - 能源消耗来源的名称（暖通空调、照明、插头负载、电梯等）。有多个具有相同来源的电能表。
* `area` - 安装区域的名称（办公室、会议室、大厅厨房等）。该区域有多个电能表。

电能表与建筑资产相关。每个建筑都与客户相关。这种关系简化了不同级别的分析和数据聚合 - 我们可以跟踪特定建筑或特定客户的所有建筑的指标。

### 第 1 步：按来源划分的能源消耗表
我们在建筑中有很多不同的能源消耗来源。为了了解能源使用结构，我们将为每种消耗源类型计算以下指标：

* 以千瓦时为单位的能耗
* 价格，单位为美元
* 二氧化碳排放量，单位为千克

此表格报告应该能够显示任何建筑和任何时间范围的数据。用户还应该能够按来源类型、区域和建筑过滤数据。让我们开始吧：

* 在 Trendz 中创建表格视图
* 将 `energyMeter.sourceType` 添加到列部分 - 它允许按电能表的来源类型拆分电能表读数。
* 将 `energyMeter.usageKWH` 添加到列部分，聚合为 `SUM` - 此字段显示每个来源的总能耗。
* 添加计算字段，标签为 **价格**，将单位设置为 `$`，小数位数设置为 `2`。以下是如何根据建筑中的能源价格计算每个来源的总价格的代码：

```javascript
var price = uniq(building.energyPrice);
var totalUsage = sum(energyMeter.usageKWH);

return totalUsage * price;
```

* 添加计算字段，标签为 **二氧化碳排放**，将单位设置为 `kg CO2e`，小数位数设置为 `1`

```javascript
var emissionConversionFactor = 0.21233;
var totalUsage = sum(energyMeter.usageKWH);

return totalUsage * emissionConversionFactor;
```

为了让最终用户更容易理解报告，让我们按默认降序排列并添加过滤器选项：

* 将 `energyMeter.sourceType` 添加到过滤器部分
* 将 `energyMeter.area` 添加到过滤器部分
* 将 `building` 添加到过滤器部分
* 打开视图设置，`常规` 部分并配置默认排序
  * 点击 `排序顺序`
  * 启用降序排序
  * 排序列 - `usageKWH`
* 将默认时间范围设置为本月
* 使用名称 **按来源划分的能耗** 保存报告

报告已准备就绪，稍后我们将将其添加到仪表板。

{% include images-gallery.html imageCollection="energy-consumption-by-source-table" %}

### 第 2 步：按区域划分的能耗表
可以创建类似的表格报告，但这种情况下，我们将关注区域而不是来源类型。为了做到这一点，我们应该重复上一个表格报告中的相同步骤。
唯一的区别是使用 `energyMeter.area` 而不是 `energyMeter.sourceType` 字段。使用以下名称保存视图 - **按区域划分的能耗**。

{% include images-gallery.html imageCollection="energy-consumption-by-areas-table" %}

### 第 3 步：比较按来源类型划分的能耗
在前面的步骤中创建的表格对于获取有关能耗的确切数字非常有用。但它们并不适合快速比较不同的能耗来源。为了更轻松地比较按来源类型划分的能耗，我们将创建一个堆叠条形图。

* 在 Trendz 中创建条形图
* 将 `energyMeter.sourceType` 添加到 X 轴部分
* 将 `energyMeter.usageKWH` 添加到 Y 轴部分
* 将 `building` 添加到过滤器部分
* 将默认时间范围设置为本月
* 打开视图设置，`常规` 部分并配置默认排序
  * 点击 `排序顺序`
  * 启用降序排序
  * 排序列 - `usageKWH`
* 通过在视图设置中启用 `水平条形图` 复选框使条形图变为水平
* 使用名称 **条形图：按来源比较能耗** 保存报告

有了这样的可视化，将更容易、更快速地了解系统中的主要消费者。

{% include images-gallery.html imageCollection="energy-compare-sources-bar" %}

### 第 4 步：比较当前和前一年的能耗，按月细分
为了更好地了解能耗的年同比和月同比动态，我们将创建一个条形图，显示月度消耗。我们还将把它分成多个系列，以比较不同年份的月度能耗。
以下是如何做到这一点的说明：

* 在 Trendz 中创建条形图
* 将类型为 `MONTH` 的 `Date` 字段添加到 X 轴部分 - 它允许按月拆分数据
* 将 `energyMeter.usageKWH` 添加到 Y 轴部分
* 将类型为 `YEAR` 的 `Date` 字段添加到系列部分 - 它允许按年拆分数据
* 将 `energyMeter.sourceType` 添加到过滤器部分
* 将 `energyMeter.area` 添加到过滤器部分
* 将 `building` 添加到过滤器部分
* 将默认时间范围设置为过去 3 年
* 使用名称 **条形图：比较年同比能耗** 保存报告

这种可视化允许快速识别能耗高的月份，并将其与前一年进行比较，以了解年同比动态。

{% include images-gallery.html imageCollection="energy-compare-time-ranges" %}


### 第 5 步：计算碳排放并显示过去 6 个月的动态
最终卡片应显示建筑的整体二氧化碳足迹，以简化碳排放核算。仅显示 1 个指标并不有趣，因为它无法描述全貌。由于我们致力于能耗分析，因此让我们为此卡片添加其他见解。
第一个将是与前一时间段的比较。第二个将是过去 6 个月作为火花线图的碳排放动态。

* 在 Trendz 中创建 `带有折线图的卡片` 视图
* 添加计算字段，标签为 **二氧化碳排放**，将单位设置为 `kg CO2e`，小数位数设置为 `1`

```javascript
var emissionConversionFactor = 0.21233;
var totalUsage = sum(energyMeter.usageKWH);

return totalUsage * emissionConversionFactor;
```

* 将默认时间范围设置为本月

现在我们有一张卡片，上面显示了本月的二氧化碳排放量以及按日细分，这将突出显示异常行为和趋势线。现在让我们启用比较：

* 打开 `常规` 视图设置
* 将复选框 `启用比较` 设置为 `true`
* 将卡片标题设置为 **二氧化碳排放**
* 使用名称 **卡片：二氧化碳排放见解** 保存视图

现在我们的卡片比较了二氧化碳排放。我们看到的值是与前一时间段相比的百分比。默认情况下，如果值高于前一时间段，则值为绿色；如果值低于前一时间段，则值为红色。
但我们可以通过在视图设置中启用 `反转比较颜色` 来反转颜色方案。

{% include images-gallery.html imageCollection="co2_emission_card_with_trend" %}

### 第 6 步：在 GridLinks 中创建能耗分析仪表板
在最后一步中，我们将把我们在一个交互式仪表板中创建的所有视图连接到我们的用户。该仪表板可以与我们所有的客户共享，它将仅显示与用户相关的数据。他们将能够使用过滤器来选择建筑、
消耗来源和区域。我们从将我们在前面的步骤中创建的所有 Trendz 视图添加到 GridLinks 中的一个仪表板开始：

* 在 GridLinks 中创建名称为 **能耗报告** 的仪表板
* 在 Trendz 中：对于我们在前面的步骤中创建的每个小部件：
  * 点击 `共享到 GridLinks` 按钮并复制 `添加到仪表板`。
  * 选择 **能耗报告** 仪表板。
  * 启用 **创建别名** 复选框。
  * 选择 `建筑` 作为过滤器。
* 返回 ThingsBoard **能耗报告** 仪表板并调整仪表板布局。

然后，我们将创建别名，用于过滤仪表板中的数据。

* 创建新别名 **所有建筑** - 此别名将保存对用户可见的所有建筑。
  * 过滤器类型 - **资产类型**
  * 资产类型 - **建筑**
* 创建新别名 **所选实体** - 此别名将保存用户点击的实体。
  * 过滤器类型 - **来自仪表板状态的实体**
  * 状态实体参数名称 - `selectedEntity`

最后，我们必须添加层次结构小部件，该小部件将显示酒店中的所有建筑/楼层/区域，并允许用户选择特定区域。一旦用户点击实体 - **过滤区域** 别名将刷新并加载所选实体的所有区域。
之后，仪表板上的所有 Trendz 小部件都将更新，因为它们使用 **过滤区域** 别名作为数据源。结果，用户将看到所选区域的占用数据。

* 将 GridLinks 表格小部件 `卡片` -> `实体表` 添加到仪表板。它将显示对用户可见的所有建筑。
  * 将数据源别名设置为 **所有建筑**
  * 最新数据键 - **名称**
* 为实体表小部件添加 `点击行` 操作。它将更新仪表板状态中的 `selectedEntity` 参数。
  * 操作类型 - `更新当前仪表板状态`
  * 状态实体参数名称 - `selectedEntity`
* 对于仪表板上的所有 Trendz 小部件，将数据源别名设置为 `selectedEntity`。
* 保存仪表板。

{% include images-gallery.html imageCollection="building_energy_dashboard" %}

## 总结
对于希望改善其利润和可持续性的企业来说，减少能耗和碳排放至关重要。
为了实现这一目标，了解能耗模式并确定改进领域至关重要。
通过遵循本文中概述的实施计划，企业可以创建一个分析仪表板，以按来源和建筑内部区域可视化其能耗数据，
比较当前和前几年以及按月细分，并计算二氧化碳排放。这些步骤可以帮助企业降低成本、提高可持续性，
并为更可持续的未来做出贡献。通过积极主动地应对能耗，企业可以为自己在竞争激烈的商业环境中取得长期成功做好准备。