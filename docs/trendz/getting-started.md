---
layout: docwithnav-trendz
title: Trendz Analytics 入门
description: GridLinks Trends - 物联网驱动的业务的商业智能和分析平台

discover-topology:
  0:
    image: /images/trendz/getting-started/topology1.png
    title: "登录后，您应该点击 <b>发现拓扑</b> 按钮来发现 GridLinks 实体。"
  1:
    image: /images/trendz/getting-started/topology2.png
    title: '拓扑发现完成后，点击 <b>完成</b>'

table-view:
  0:
    image: /images/trendz/getting-started/table_1.png
    title: '创建表格视图'
  1:
    image: /images/trendz/getting-started/table_2.png
    title: '添加必需的字段'
  2:
    image: /images/trendz/getting-started/table_3.png
    title: '定义计算'
  3:
    image: /images/trendz/getting-started/table_4.png
    title: '添加过滤器'

add-on-dashboard:
  0:
    image: /images/trendz/getting-started/dashboard_1.png
    title: '点击共享按钮'
  1:
    image: /images/trendz/getting-started/dashboard_2.png
    title: '配置仪表盘详细信息'
  2:
    image: /images/trendz/getting-started/dashboard_3.png
    title: '仪表盘已添加到 GridLinks'

predict-energy-line-chart:
  0:
    image: /images/trendz/getting-started/prediction_1.png
    title: '创建折线图'
  1:
    image: /images/trendz/getting-started/prediction_2.png
    title: '添加必需的字段'
  2:
    image: /images/trendz/getting-started/prediction_3.png
    title: '启用时序预测'
  3:
    image: /images/trendz/getting-started/prediction_4.png
    title: '将 Y 轴合并为一个'
  4:
    image: /images/trendz/getting-started/prediction_5.png
    title: '带有预测的最终折线图'

anomaly-detection-model:
  0:
    image: /images/trendz/getting-started/anomaly_1.png
    title: '创建异常检测模型'
  1:
    image: /images/trendz/getting-started/anomaly_2.png
    title: '配置模型参数'
  2:
    image: /images/trendz/getting-started/anomaly_3.png
    title: '查看发现的异常'
  3:
    image: /images/trendz/getting-started/anomaly_4.png
    title: '安排异常自动发现作业'

save-anomaly-score:
  0:
    image: /images/trendz/getting-started/anomaly_telemetry_1.png
    title: '为每个电能表创建带有异常分数数据的表格视图'
  1:
    image: /images/trendz/getting-started/anomaly_telemetry_2.png
    title: '启用遥测保存作业'
  2:
    image: /images/trendz/getting-started/anomaly_telemetry_3.png
    title: '将行点击实体设置为电能表'

create-anomaly-alarm:
  0:
    image: /images/trendz/getting-started/alarm_1.png
    title: '打开设备配置文件'
  1:
    image: /images/trendz/getting-started/alarm_2.png
    title: '创建报警规则'
  2:
    image: /images/trendz/getting-started/alarm_3.png
    title: '定义清除并创建条件'
---

* TOC
{:toc}

## 简介

本教程的目的是演示 Trendz Analytics 的基本用法。您将学习如何：

* 首次登录 Trendz
* 从 GridLinks 发现拓扑
* 创建基本可视化
* 使用关系在不同级别聚合数据
* 使用属性和遥测字段过滤数据
* 将 Trendz 视图添加到 GridLinks 仪表盘

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/8a4cPI-XOkI" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 先决条件

您需要启动并运行 Trendz Analytics 服务器。
最简单的方法是使用 [Trendz Cloud](/docs/trendz/install/cloud/) SaaS。

另一种选择是使用 [安装指南](/docs/trendz/install/installation-options/)安装 Trendz Analytics。

## 步骤 1. 发现拓扑
Trendz 服务启动并运行后，您可以使用以下 URL 登录到 Trendz UI：

* Trendz Cloud：[https://thingsboard.cloud/trendz](https://thingsboard.cloud/trendz)。
* 自托管 Trendz：http://localhost:8888

您可以使用 GridLinks 的租户管理员凭据登录。Trendz 使用 GridLinks 作为身份验证服务。任何租户管理员或客户用户都可以使用其在 GridLinks 中用于身份验证的登录名/密码登录 Trendz UI。

{% include images-gallery.html imageCollection="discover-topology" showListImageTitles="true" %}

## 步骤 2. 创建表格视图
让我们创建一个表格，其中包含所有建筑物和公寓，并计算每间公寓每平方米的电力和热能消耗量。

* 在主页上，单击按钮 **创建视图**，然后选择 **表格**
* 将以下字段添加到列部分：`building`、`apartment`、`area`
* 将 `Date (Month)` 添加到动态列部分，设置单位 `kW/m2`
* 将默认时间范围设置为今年
* 将 `Calculated` 字段添加到 **动态值** 部分，将其命名为 `AVG Heat+Energy Consumption per m2`。以下是计算代码：

```javascript
var energy = sum(energyMeter.energyConsumption);
var heat = sum(energyMeter.heatConsumption);
var size = uniq(apartment.area);
return (energy + heat) / size;
```

* 将 `building` 添加到过滤器部分以查看特定建筑物的消耗情况
* 单击 `生成报告`
* 通过单击名称旁边的铅笔图标重命名视图，并将其重命名为“能源/热能消耗”
* 单击 **保存** 按钮将表格保存在所需的文件夹中
* 选择文件夹 `Energy consumption page` 以保存新表格

{% include images-gallery.html imageCollection="table-view" %}

## 步骤 3. 将表格添加到 GridLinks 仪表盘
现在，我们可以将此表格添加到 GridLinks 仪表盘。

* 单击 `Share to ThingsBoard` 按钮，然后选择 `Add on New Dashboard`
* 将仪表盘名称设置为 `Energy/Heat consumption`
* 选择仪表盘状态 `default`
* 选择过滤器 `Building`，然后单击 **Add** 按钮

Thingsboard 中创建了一个新仪表盘，我们的表格就在那里，可以按建筑物进行过滤

{% include images-gallery.html imageCollection="add-on-dashboard" %}

## 步骤 4. 预测能源使用情况
下一步是使用历史数据为每个建筑物预测未来 6 个月的能源和热能使用情况。

* 单击按钮 `Create view`，然后选择 **折线图**
* 将日期字段添加到 **X 轴** 部分 - 它允许按月、周、日或小时拆分数据
* 将 `energyConsumption` 和 `heatConsumption` 字段添加到 **Y 轴** 部分
* 将 `appartment` 添加到 **过滤器** 部分
* 将默认时间范围设置为 **今年**，按以下方式分组：**天**

要设置预测，请对 `energyConsumption` 和 `heatConsumption` 字段执行以下操作。
* 在 **Y 轴** 部分单击 `energyConsumption` 字段
* 启用复选框 `Prediction`
  * 预测方法 - **傅里叶变换**
  * 预测范围 - **3**
  * 预测单位 - **月**
* 单击按钮 `生成报告`
* 打开视图 **设置** -> **常规** 部分，然后启用 `Use single Y-axis` 复选框
* 单击名称旁边的铅笔图标，并将其重命名为“预测”
* 单击 **保存** 按钮将表格保存在所需的文件夹中
* 选择文件夹 `Forecast page` 以保存新预测

每个区域的历史数据以实线可视化，预测以虚线显示。

{% include images-gallery.html imageCollection="predict-energy-line-chart" %}

## 步骤 5. 查找能源消耗中的异常情况
让我们讨论如何构建能源消耗异常检测模型、跟踪异常消耗行为以及为异常情况设置通知。

* 转到异常部分，然后单击按钮 **创建模型**
* 将模型名称设置为 `Energy consumption Anomaly`
* 定义异常检测模型属性：
  * 聚类算法：K-Means，
  * 区段时间范围：1 天，
  * 比较类型：基于行为 - 我们希望根据能源消耗的行为来检测异常情况。
* 数据源属性：
  * 时间范围：`今年` - 我们将使用今年的遥测数据来训练模型，以检测正常和异常行为。
  * 字段 `energyConsumption` - 在此，我们定义了模型中应使用哪些遥测键。
  * 过滤器 `energyMeter` - 为特定电能表或电能表组训练模型，以检测仅在这些电能表上发生的特定异常情况。
* 按 **构建模型** 按钮

您可以在 Trendz 中查看模型识别的历史异常。每个异常都与分数和分数索引相关联，表示其异常程度。较高的值表示异常程度较高。

准备好模型后，下一步是在 Trendz 中安排作业。此作业将持续分析实时遥测数据，检测发生的异常情况。

* 单击 `Auto discovery` 按钮
* 选中 `Enable Auto discovery` 复选框
* 将间隔设置为 **1 小时**
* 按 **应用** 按钮

在 Trendz 中保存配置后，它将定期从电能表中检索新数据。将分析此数据以识别异常情况。每当检测到异常情况时，Trendz 都会计算异常分数并将其存储在数据库中。

{% include images-gallery.html imageCollection="anomaly-detection-model" %}

## 步骤 6. 在发现异常时创建警报
我们有一个异常检测模型，可以识别异常情况，我们创建一个作业来在来自传感器的新的传入数据中发现异常情况。最后一步是通知维护团队我们发现的异常情况。为此，我们需要在 GridLinks 中发现异常情况后创建警报。

* 在 Trendz 中创建表格视图
* 将以下字段添加到列部分：`energyMeter`、`Date FULL_HOUR`，
* 添加 `Anomaly` 字段并选择 `Energy consumption Anomaly` 模型
  * 选择 `Anomaly field` 类型 - **Score Index**
  * 将聚合设置为 **MAX**
  * 标签 - `energyConsumptionAnomalyScore`
* 打开 **视图设置** 并启用 `Tb calculated telemetry save` 复选框。将间隔设置为 **1 小时**
* 在设置中打开 **视图模式字段** 部分，然后在 **行点击实体** 下拉列表中选择 `energyMeter` 实体 - 此步骤告诉 Trendz 应为哪个实体保存分数索引遥测。
* 将默认时间范围设置为过去 7 天
* 使用名称 `energyConsumption anomaly score` 保存视图

在 Trendz 中保存视图后，将安排后台作业。此作业将定期检查能源消耗异常分数并将结果作为电能表设备的遥测保存。

{% include images-gallery.html imageCollection="save-anomaly-score" %}А

目前，我们在 GridLinks 中为每个电能表都有一个名为 `energyConsumptionAnomalyScore` 的遥测。此遥测指示仪表当前行为的异常性。有了这些信息，我们可以在 GridLinks 中设置 **警报规则**，如果分数索引超过 200，则触发警报。


* 在 GridLinks 中打开电能表的设备配置文件并添加新的警报规则
* 警报类型 - `Abnormal behavior`
* 创建警报规则：严重性 - 警告，条件 - **energyConsumptionAnomalyScore** 大于 200
* 清除警报规则
* 条件 - **energyConsumptionAnomalyScore** 小于或等于 200

{% include images-gallery.html imageCollection="create-anomaly-alarm" %}

## 后续步骤

{% assign currentGuide = "GettingStartedGuide" %}{% include templates/trndz-guides-banner.md %}