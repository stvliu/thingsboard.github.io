---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 酒店预测性入住率监测
description: 分析和预测建筑物中不同区域、区域和空间的入住率

building-occupancy-dashboard:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_dashboard.png
    title: '实时入住率跟踪仪表板'

building-occupancy-weakly-heatmap:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_heatmap_create.png
    title: '在 Trendz 中创建热图视图'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_add_dates.png
    title: '将日期字段添加到热图视图中，按小时和天对数据进行分组'
  2:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_calcualtion.png
    title: '计算每天每个小时的入住率'
  3:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_filtering.png
    title: '添加过滤选项以关注酒店的特定区域'
  4:
    image: /images/trendz/guide/building_occupancy/hotel_weakly_occupansy_heatmap.png
    title: '过去 7 天的每小时入住率热图'

building-occupancy-forecast-configuration:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_forecast_create.png
    title: '创建建筑入住率折线图'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_forecast_configuration.png
    title: '启用预测并配置预测设置'
  2:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_forecast_for_next_weak.png
    title: '未来一周的建筑入住率预测'

building-occupancy-top-crowded-areas:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancu_top_crowded_areas_sorting.png
    title: '按入住率降序排序以查找最拥挤的区域'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_occupancu_top_crowded_areas.png
    title: '建筑物中前 5 名拥挤区域'

building-occupancy-dashboard-configuration:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_create_dashboard.png
    title: '创建用于分析建筑入住率的仪表板'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_aliases.png
    title: '配置仪表板别名，按建筑、楼层和区域过滤实体'
  2:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_filter_alias.png
    title: '配置别名以显示所有可用建筑'
  3:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_add_hierarchy_widget.png
    title: '将层次结构小部件添加到仪表板'
  4:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_hierarchy.png
    title: '配置层次结构小部件以显示建筑物中的所有楼层'
  5:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_enable_rowclick.png
    title: '启用行单击事件以按所选实体应用过滤'
  6:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_filter_by_building.png
    title: '配置行单击事件'    
  7:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_share_view.png
    title: '在入住率仪表板上添加 Trendz 视图'
  8:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_add_on_dashboard.png
    title: '配置 Trendz 视图以显示所选建筑的入住率'

---

* TOC
{:toc}

## 简介

作为一家希望改善其客户体验并降低运营成本的中型酒店，我们的客户转向入住率监测。
他们希望更好地了解酒店哪些区域最受欢迎以及何时最受欢迎，以便更有效地分配人员和资源。
此外，他们有兴趣通过减少能源使用和识别其 HVAC 系统的潜在问题来减少其对环境的影响。

**任务定义** - 分析酒店内不同区域的入住率并预测未来一周的每小时入住率。

{% include images-gallery.html imageCollection="building-occupancy-dashboard" %}

### 实施计划
* 将每小时入住率计算为每个区域最大容量的百分比。
* 计算整个楼层和建筑的入住率。
* 构建未来一周入住率的预测。
* 显示每个区域/楼层/建筑的每周热图。
* 显示前 5 名拥挤区域。
* 显示前 5 名未充分利用的区域。
* 在 ThingsBoard 中创建入住率分析仪表板。

### 主要成果
* 公用事业成本降低 12%。
* 劳动力成本降低 15%。
* 正面客人评论增加 10%。

## 入门：

### 先决条件
我们在本指南中重点关注数据分析和可视化。因此，我们将省略有关传感器安装和配置的详细信息。以下是我们将在本指南中使用的系统的简要说明：

* 入住率传感器已安装在酒店的每个区域，并通过 LoRaWAN 集成连接到 ThingsBoard。
* ThingsBoard 中有 3 种资产类型 - 建筑、楼层、区域。建筑与多个楼层相关，楼层与多个区域相关，每个区域都有相关的入住率传感器。
* 传感器报告当前有多少人在该区域。
* 入住率传感器有效载荷 - `{"ts": 1651419204000, peopleCnt": 5}`
* 每个区域都有一个具有最大容量的属性。我们将使用此属性来计算入住率。初始值在系统配置期间设置。

### 步骤 1：将每小时入住率计算为每个区域最大容量的百分比
让我们从计算每个区域的入住率开始。为此，我们使用 Trendz 计算字段，在该字段中，我们定义基于最大区域容量和传感器报告的历史入住率的公式。
我们使用热图来可视化过去 7 天每天每个小时的入住率。用户可以更改时间范围以关注实时数据或历史时期。

* 创建热图视图
* 将 **日期（小时）** 添加到 **X 轴** 部分
* 将 **日期（天）** 添加到 **Y 轴** 部分
* 将 **计算** 字段添加到 **值** 部分。将标签更改为 **入住率**
* 编写返回入住率（以最大容量的百分比表示）的函数

```javascript
var peopleCnt = sum(occupancySensor.peopleCnt);
var maxCapacity = uniq(area.maxCapacity);

return peopleCnt / maxCapacity * 100;
```

* 将计算字段 **单位** 设置为 **%**
* 将区域、楼层和建筑字段添加到 **过滤器** 部分，以便用户可以关注酒店的特定区域。
* 将默认时间范围设置为 **过去 7 天**
* 使用名称 **每周入住率热图** 保存视图

{% include images-gallery.html imageCollection="building-occupancy-weakly-heatmap" %}

### 步骤 2：计算整个楼层和建筑的入住率
在 _步骤 1_ 中创建的热图包含过滤器字段。如果未选择任何过滤器，热图将显示整个系统的入住率。来自所有区域、楼层和建筑的数据将被汇总并显示在热图上。

在现实生活中，我们很可能希望关注特定的建筑或区域。为此，我们可以使用过滤器。例如，如果用户在过滤器中选择特定建筑 - 热图将仅显示此建筑的入住率。
在后台，Trendz 将执行以下步骤：
* 获取所选建筑的所有楼层。
* 然后为每个楼层加载所有区域。
* 为区域中的每个传感器加载入住率数据。
* 对每个传感器应用计算。
* 在建筑级别汇总结果。

这意味着如果用户想查看整个楼层或建筑的入住率 - 我们可以使用相同的视图，只需在过滤器中选择楼层或建筑即可。

### 步骤 3：使用每小时细分预测未来一周的入住率
到目前为止，我们一直使用历史数据。现在，我们将使用 Trendz 预测工具来构建未来一周的预测。首先，我们将创建一个折线图，显示过去 7 天的入住率，每小时细分。

* 创建折线图视图
* 将 **日期（整小时）** 添加到 **X 轴** 部分
* 将 **计算** 字段添加到 **Y 轴** 部分。将标签更改为 **入住率**
* 编写返回入住率（以最大容量的百分比表示）的函数

```javascript
var peopleCnt = sum(occupancySensor.peopleCnt);
var maxCapacity = uniq(area.maxCapacity);

return peopleCnt / maxCapacity * 100;
```

* 启用复选框 **预测**
  * 预测方法 - **傅里叶变换**
  * 预测范围 - 7
  * 预测单位 - 天
* 将计算字段 **单位** 设置为 **%**
* 将区域名称添加到 ``系列'' 部分 - 它将显示每个区域的入住率作为单独的线。
* 将区域、楼层和建筑字段添加到 **过滤器** 部分，以便用户可以关注酒店的特定区域。
* 将默认时间范围设置为 **过去 7 天**

最后，我们必须预测未来 7 天的计算 **入住率** 字段。为此，我们将使用 **傅里叶变换** 预测方法，该方法对季节性时间序列数据显示出良好的结果。

* 在 **Y 轴** 部分单击 **入住率** 字段
* 启用复选框 **预测**
  * 预测方法 - **傅里叶变换**
  * 预测范围 - 7
  * 预测单位 - 天
* 使用名称 **每小时入住率预测** 保存视图

历史数据针对每个区域用实线可视化，预测用虚线显示。

{% include images-gallery.html imageCollection="building-occupancy-forecast-configuration" %}

### 步骤 4：条形图显示酒店中前 5 名拥挤/未充分利用的区域
前 5 名条形图是更好地了解我们在很大时间范围内的系统的不错选择。我们可以比较资产并了解哪些区域人满为患，哪些区域未充分利用。让我们从拥挤的区域开始。

* 创建条形图视图
* 将 **区域名称** 添加到 **X 轴** 部分
* 将 **入住率** 添加到 **Y 轴** 部分。重复使用步骤 1 中的计算字段。
* 打开视图设置
  * 将排序设置为 **降序**
  * 将 `Limit` 设置为 5
  * 启用水平条形图
* 将区域、楼层和建筑字段添加到 **过滤器** 部分，以便用户可以关注酒店的特定区域。
* 将默认时间范围设置为 **过去 7 天**
* 使用名称 **前 5 名拥挤区域** 保存视图

对于酒店中前 5 名未充分利用的区域的条形图，应执行几乎相同的步骤。只需将排序更改为 **升序** 并将视图名称更改为 **前 5 名未充分利用的区域**。

{% include images-gallery.html imageCollection="building-occupancy-top-crowded-areas" %}

### 步骤 5：在 ThingsBoard 中创建入住率分析仪表板
所有 Trendz 分析图表都已准备就绪，我们可以在 ThingsBoard 中创建用户仪表板。请注意，用户可以访问多个酒店，我们希望创建一个适用于所有酒店的仪表板。用户应该能够选择酒店、楼层和区域。
首先，我们将仪表板上的所有 Trendz 视图：

* 在 ThingsBoard 中创建名称为 **入住率分析** 的仪表板
* 在 Trendz 中：对于我们在前面步骤中创建的每个小部件：
  * 单击 `Share to ThingsBoard` 按钮并复制 `Add on Dashboard`。
  * 选择 **入住率分析** 仪表板。
  * 启用 **创建别名** 复选框。
  * 选择 **区域名称** 作为过滤器。
* 返回 ThingsBoard **入住率分析** 仪表板并调整仪表板布局。

然后，我们将创建将在仪表板中用于过滤数据的仪表板别名。

* 创建新别名 **所有建筑** - 此别名将保存对用户可见的所有建筑。
  * 过滤器类型 - **资产类型**
  * 资产类型 - **建筑**
* 创建新别名 **选定实体** - 此别名将保存用户单击的实体。
  * 过滤器类型 - **仪表板状态中的实体**
  * 状态实体参数名称 - **selectedEntity**
* 创建新别名 **过滤区域** - 此别名将保存用户想要关注的所有区域。
  * 过滤器类型 - **资产搜索查询**
  * 启用 **根实体** 复选框，实体参数名称 - **selectedEntity**
  * 启用复选框 **仅获取最后一级关系**
  * 方向 - 从
  * 最大关系级别 - 3
  * 资产类型 - **区域**

最后，我们必须添加层次结构小部件，该小部件将显示酒店中的所有建筑/楼层/区域，并允许用户选择特定区域。一旦用户单击实体 - **过滤区域** 别名将刷新并加载所选实体的所有区域。
之后，仪表板上的所有 Trendz 小部件都将更新，因为它们使用 **过滤区域** 别名作为数据源。因此，用户将看到所选区域的入住率数据。

* 将层次结构小部件 `Cards` -> `Entities hierarchy` 添加到仪表板。它将显示酒店中的所有建筑/楼层/区域。
  * 将数据源别名设置为 **所有建筑**
  * 最新数据键 - **名称**
* 为层次结构小部件添加 `On node selected` 操作。它将更新仪表板状态中的 `selectedEntity` 参数。
  * 操作类型 - **更新当前仪表板状态**
  * 状态实体参数名称 - **selectedEntity**
* 对于仪表板上的所有 Trendz 小部件，将数据源别名设置为 **过滤区域**。
* 保存仪表板。

{% include images-gallery.html imageCollection="building-occupancy-dashboard-configuration" %}

## 总结
总之，入住率监测技术的实施帮助我们的客户实现了改善客人体验、降低运营成本和最大限度地减少环境足迹的目标。
通过利用实时数据和预测分析，他们能够优化其人员配备水平，更有效地分配资源并减少能源消耗。
此实施的主要成果包括降低公用事业和劳动力成本，以及增加正面客人评论。