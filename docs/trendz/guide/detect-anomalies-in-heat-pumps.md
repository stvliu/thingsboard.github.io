---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 热泵异常检测
description: 基于无监督多元时间序列异常检测构建热泵预测性维护系统

heatpumps-dashboard:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_detection_dashboard.png
    title: '用于调查热泵运行中发现的异常的仪表板'

heatpumps-create-anomaly-model:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_create_anomaly_model.png
    title: '单击创建异常检测模型按钮'
  1:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_configure_anomaly_model.png
    title: '设置异常检测模型参数'
  2:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomalies_summary.png
    title: '查看热泵异常检测模型训练结果'
  3:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_review_anomaly.png
    title: '查看热泵的已发现异常'

heatpumps-autodiscovery-anomalies:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpumps_autodiscover_enable.png
    title: '单击异常自动发现按钮'
  1:
    image: /images/trendz/guide/heatpump_anomalies/heatpumps_autodiscover_job_configuration.png
    title: '配置自动异常发现作业的间隔'

heatpumps-create-anomaly-review-widget:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_create_anomaly_widget.png
    title: '为热泵创建异常审查小部件'
  1:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_select_model.png
    title: '选择步骤 1 中创建的热泵异常检测模型'
  2:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_review_widget.png
    title: '在小部件上查看热泵的已发现异常'

heatpumps-save-anomaly-score-as-telemetry:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_table_create.png
    title: '根据已发现的异常为热泵创建异常分数表'
  1:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_table_row_click.png
    title: '选择热泵作为异常分数表的行单击实体'
  2:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_save.png
    title: '安排热泵异常分数保存作业'

heatpumps-create-anomaly-alert:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_alert_create.png
    title: '在 ThingsBoard 设备配置文件中创建热泵异常分数警报'
  1:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_alert_configuration.png
    title: '配置异常分数警报创建和清除规则'
  2:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_alert_creation_condition.png
    title: '配置警报创建的异常分数阈值'
  3:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_score_alert_clear_condition.png
    title: '配置警报清除的异常分数阈值'

heatpumps-notify-about-anomalies:
  0:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_open_root_rulechain.png
    title: '在 ThingsBoard 中打开根规则链'
  1:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_send_email_node_configuration.png
    title: '将 toEmail 规则节点添加到根规则链'
  2:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_email_notification_config.png
    title: '配置通知的电子邮件属性'
  3:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_add_send_email_node.png
    title: '将发送电子邮件节点添加到根规则链'
  4:
    image: /images/trendz/guide/heatpump_anomalies/heatpump_anomaly_send_notification_rulechain.png
    title: '配置的规则链，用于发送有关热泵中发现的异常的异常通知'

---

* TOC
{:toc}

## 简介
检测热泵中的异常对于保持其性能并避免昂贵的维修至关重要。
识别热泵运行中的异常模式或变化，例如功耗、压缩机速度、气流、冷却剂压力和温度，可以帮助检测问题并在其升级之前解决问题。
常见的热泵问题包括冷却剂液位低、空气过滤器堵塞、压缩机故障和过热。
通过实施将状态监测与无监督异常检测算法相结合的预测性维护系统，可以及早发现这些问题，
以便及时干预和维护，以防止暖通空调系统进一步出现并发症和昂贵的维修。这种主动方法不仅延长了热泵的使用寿命，还确保了其高效运行。

**任务定义：**实时检测热泵中的异常，并向维护团队通知潜在问题。

{% include images-gallery.html imageCollection="heatpumps-dashboard" %}

### 实施计划
* 使用历史遥测数据为热泵创建异常检测模型。
* 配置实时遥测数据的异常自动检测。
* 创建表格小部件以查看所有检测到的异常。
* 向维护团队通知检测到的异常
* 为维护团队创建一个仪表板，以跟踪异常并检查实时热泵状态。

## 入门：

### 先决条件
热泵通过 MQTT 协议向 ThingsBoard 报告遥测数据。它们在平台中注册为设备实体。设备与公寓资产相关，公寓分配给客户帐户。
本指南的范围之外是如何在系统中配置热泵以及用户自我注册过程。您可以在我们的文档中找到有关如何执行此操作的教程。

### 步骤 1：创建异常检测模型
为了识别热泵可能存在的问题，我们将使用 Trendz 异常检测仪器。Trendz 使用无监督机器学习算法来检测时间序列数据中的异常。
要训练模型，我们需要配置应分析哪些遥测键。在我们的案例中，我们将使用以下键：`compressorSpeed`、`airflow`、`coolantPressure`、`coolantTemperature`、`powerUsageWh`。

* 转到异常页面，然后单击“创建模型”按钮。
* 将模型名称设置为 `HeatPumpAnomalyModel`
* 定义异常检测模型属性
  * 集群算法：`K-Means`
  * 区段时间范围：`1 小时` - 我们希望在 1 小时的时间范围内检测异常行为。
  * 比较类型：`基于行为` - 我们希望根据热泵的行为检测异常。
* 数据源属性
  * 时间范围：`过去 90 天` - 我们将使用过去 90 天的遥测数据来训练模型，以检测正常和异常行为。
  * 字段 - 在此处，我们定义了模型中应使用哪些遥测键。
    * `heatPump.compressorSpeed`
    * `heatPump.airflow`
    * `heatPump.coolantPressure`
    * `heatPump.coolantTemperature`
    * `heatPump.powerUsageWh`
  * 过滤器 - 留空，因为我们希望使用系统中所有热泵的数据。在某些情况下，您可能希望为特定热泵或热泵组训练模型，以检测仅发生在这些热泵上的特定异常。
* 按 **构建模型** 按钮。

在模型创建期间，Trendz 将获取模型所需的所有数据，分析并训练以检测热泵的正常行为是什么。基于此信息，将创建异常检测模型。

一旦模型训练好，我们将看到模型发现的历史异常。每个异常都有 `score` 和 `score index` 属性，告诉我们此异常有多异常。值越高意味着异常越异常。

{% include images-gallery.html imageCollection="heatpumps-create-anomaly-model" %}

### 步骤 2：安排异常自动发现
我们的模型已准备就绪，现在我们希望安排一项作业，该作业将分析实时遥测数据并检测异常。
* 在模型摘要页面上，单击“自动发现”按钮。
* 启用 **自动发现** 复选框
* 将 **间隔** 设置为 `1 小时`
* 按 **应用** 按钮

保存配置后，Trendz 将定期从热泵获取新数据并识别异常。如果检测到异常，Trendz 将计算异常分数并将其保存在数据库中。

{% include images-gallery.html imageCollection="heatpumps-autodiscovery-anomalies" %}

### 步骤 3：查看所有发现的异常
现在，我们将创建一个视图，显示在模型创建期间发现的所有异常以及自动发现作业发现的新异常。

* 创建视图 **异常**
* 选择步骤 1 中创建的模型。- `HeatPumpAnomalyModel`
* 将 `heatPump` 字段添加到过滤器部分 - 它允许关注特定热泵的异常。
* 按 **生成报告** 按钮并查看新发现的异常。
* 设置视图名称 - **热泵异常表**
* 按 **保存** 按钮

{% include images-gallery.html imageCollection="heatpumps-create-anomaly-review-widget" %}

### 步骤 4：向维护团队通知检测到的异常
我们有一个异常检测模型，可以发现异常并设置作业以在新鲜数据上重新发现它们。最后一步是向维护团队通知检测到的异常。
要实现它，我们需要：

#### 将热泵的当前异常分数作为遥测保存回 ThingsBoard
* 在 Trendz 中创建表格视图
* 将 `heatPump` 字段添加到列部分
* 将日期 FULL_HOUR 字段添加到列部分
* 将异常字段添加到列部分
  * 选择 `HeatPumpAnomalyModel` 模型
  * 异常字段 - `score index`
  * 聚合 - `MAX`
  * 标签 - `heatpumpAnomalyScore` - Trendz 将异常分数索引作为具有此名称的遥测保存。
* 将 `heatPump` 字段添加到过滤器部分
* 打开视图设置并在 `Tb calculated telemetry save` 部分中启用遥测保存。
  * 启用 - true
  * 间隔 - 1
  * 单位 - 小时
* 在设置中打开 `视图模式字段` 部分并在 `行单击实体` 下拉列表中 **heatPump** 实体 - 此步骤告诉 Trendz 应在哪个实体下保存分数索引遥测。
* 将默认时间范围设置为 **过去 7 天**
* 使用名称 **Heatpump 异常分数保存作业** 保存视图

保存视图后，Trendz 将安排后台作业，该作业将定期检查热泵异常分数并将结果作为热泵设备的遥测保存。

{% include images-gallery.html imageCollection="heatpumps-save-anomaly-score-as-telemetry" %}

#### 如果异常分数高于 50，则配置警报。
此时，我们已经在 ThingsBoard 中为每个热泵提供了 `heatpumpAnomalyScore` 遥测，该遥测告诉我们其当前行为的异常程度。这意味着我们可以在 ThingsBoard 中创建警报规则，如果分数索引高于 50，则发出警报。

* 在 ThingsBoard 中打开热泵的设备配置文件并添加新的警报规则
* 警报类型 - **异常行为**
* 创建警报规则
  * 严重性 - `警告`
  * 条件 - `heatpumpAnomalyScore` 大于 `50`
* 清除警报规则
  * 条件 - `heatpumpAnomalyScore` 小于或等于 `50`

{% include images-gallery.html imageCollection="heatpumps-create-anomaly-alert" %}

#### 一旦创建警报，就发送通知
最后一步是向维护团队发送通知，一旦创建警报。我们将使用 ThingsBoard 规则引擎向维护团队发送电子邮件通知。如果设备配置文件中的警报规则发出警报，我们可以捕获此事件并添加发送电子邮件的步骤。

* 在 ThingsBoard 中打开根规则链
* 在 `设备配置文件` 节点后添加 `toEmail` 规则节点，并通过 `警报创建` 关系将其连接起来。
* 打开 `toEmail` 节点设置并将其配置为向维护团队发送电子邮件。
  * 来自模板 - `info@testmail.org`
  * 至模板 - `maintenance@testmail.com`
  * 主题模板 - `${entityName} 中的异常行为`
  * 正文模板 - `需要对热泵 ${entityName} 进行维护。异常分数为 ${heatpumpAnomalyScore}。请在仪表板上检查热泵状态。`
* 在 `toEmail` 节点后添加 `发送电子邮件` 规则节点，并通过 `成功` 关系将其连接起来。
* 保存规则链。

通过此配置，一旦在热泵行为中检测到异常，ThingsBoard 将向维护团队发送通知。

{% include images-gallery.html imageCollection="heatpumps-notify-about-anomalies" %}

## 总结
总之，通过部署异常检测算法，可以显着提高热泵的维护和高效运行。
这项技术监测功耗、压缩机速度、气流、冷却剂压力和温度的变化，可以及早识别潜在问题，例如冷却剂液位低、空气过滤器堵塞、压缩机故障和过热。
这种早期检测允许及时干预，从而防止进一步的并发症和昂贵的维修。
概述的实施计划涉及开发异常检测模型、配置实时遥测数据以及为维护团队创建一个交互式仪表板，以跟踪异常和热泵状态。
未来的工作应侧重于完善此模型、扩展其预测能力并将其无缝集成到当前的维护实践中。