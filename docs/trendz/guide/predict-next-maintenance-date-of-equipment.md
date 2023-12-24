---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 预测设备下次维护的剩余时间
description: 工业设备的预测性维护系统

predictive-maintenance-dashboard:
  0:
    image: /images/trendz/guide/predictive_maintenance/predict_remaining_time_to_next_maintenance_of_the_equipment.png
    title: '预测设备下次维护的剩余时间'
    
predictive-maintenance-forecast-next-maintenance-time:
  0:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_create_table_St1_1.png
    title: '在 Trendz Analytics 中创建表视图'
  1:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_add_fields_St1_2.png
    title: '将机器和计算字段添加到列部分'
  2:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_prediction_calculated_St1_3.png
    title: '根据生产预测计算到下次维护的剩余时间'

predictive-maintenance-save-remaining-time-as-telemetry:
  0:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_rename_St2_1.png
    title: '定义计算遥测的键名'
  1:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_TB_calculated_telemetry_save_St2_2.png
    title: '在 Tb 计算遥测保存部分启用遥测保存'
  2:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_row_click_entity_St2_3.png
    title: '将机器实体设置为行单击实体'

predictive-maintenance-create-alarm:
  0:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_open_machine_device_St3_1.png
    title: '转到 ThingsBoard 中的警报规则部分'
  1:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_create_alarm_rule_St3_2.png
    title: '定义剩余时间少于 14 天时将触发的警报'
  2:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_less_than_St3_3.png
    title: '设置阈值条件以创建警报'
  3:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_clear_alarm_rule_St3_4.png
    title: '添加清除条件以关闭活动警报'    
  4:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_save_alarm_St3_6.png
    title: '保存警报规则'

predictive-maintenance-notify-maintenance-team:
  0:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_open_root_rule_chain_St4_1.png
    title: '转到 ThingsBoard 中的默认规则链'
  1:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_to_email_St4_2.png
    title: '添加具有电子邮件属性的 toEmail 节点'
  2:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_to_email_setup_St4_3.png
    title: '设置动态电子邮件正文以通知维护团队'
  3:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_alarm_add_link_St4_4.png
    title: '将节点与设备配置文件节点连接'
  4:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_send_email_St4_5.png
    title: '添加发送电子邮件节点'
  5:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_rule_chain_view_St4_6.png
    title: '最终规则链视图'

---

* TOC
{:toc}

## 简介

我们的 FRTB-ZH3 盖装配机每小时可生产 200-350 件，但负载变化使预防性维护调度变得困难。
为了减少计划外停机时间并最大程度降低故障风险，我们计划在每台机器生产 500,000 个盖子后执行维护。
为了确保我们有足够的时间订购零件并安排维护团队，我们需要在计划维护前两周收到通知。
借助 Trendz Analytics，我们实施了预测性维护解决方案，该解决方案可以预测每台机器何时需要维护并提前足够的时间收到通知，
使我们能够保持机器高效运行并减少计划外停机时间。

**任务定义** - 预测每台盖装配机生产 500,000 个盖子所需的天数，并在预测日期前 14 天创建警报以通知。

{% include images-gallery.html imageCollection="predictive-maintenance-dashboard" %}

### 实施计划
* 使用 Trendz Analytics 创建每台机器生产的盖子数量的预测。
* 计算每台机器生产 500,000 个盖子所需的剩余天数。
* 将计算出的剩余天数保存为机器遥测。
* 如果剩余时间少于 14 天，则在 ThingsBoard 中创建警报。
* 一旦创建警报，就向维护团队发送电子邮件。

### 主要成果
* 将计划外停机时间减少 24%。
* 将维护成本降低 10%。
* 将维护团队效率提高 18%。

## 入门：

### 先决条件

装配机已通过 OPC-UA 集成连接到 ThingsBoard，并且遥测数据可在 ThingsBoard 中使用。您可以在我们的 [连接指南](https://thingsboard.io/docs/pe/guides/#AnchorIDConnectYourDevice) 中找到有关如何执行此操作的更多详细信息。
设备报告了许多有用的遥测数据，但对于此用例，我们只使用 `capsProduced` 遥测。


### 步骤 1：创建每台机器生产的盖子数量的预测
我们首先创建每台机器生产的盖子数量的预测。机器每 5 分钟报告一次生产的盖子数量，格式为 `{ts: 1675421880000, values: { capsProduced: 738}}`。
提交的值始终递增，并在执行维护后重置。让我们从对未来 3 个月的 `capsProduced` 遥测进行预测开始。

* 创建表格。
* 将 `machine name` 添加到列部分 - 此步骤将为每台机器创建单独的预测。
* 将计算字段添加到列部分。
* 启用批量计算复选框。
* 启用复选框 `预测`
    * 预测方法 - **傅里叶变换**
    * 预测范围 - 3
    * 预测单位 - 月

在为批量计算字段启用预测后，Trendz 将构建来自机器的原始遥测的预测，然后将其用作计算函数的输入参数。
在该函数中，我们需要找到何时达到阈值并返回到该点剩余的天数。如果在未来 3 个月内未达到阈值，则我们需要返回 -1。

* 编写返回到下次维护的剩余时间的函数

```javascript
var threshold = 500000;
var remainingDays = -1;

var data = none(machine.capsProduced);
for(var i = 0; i < data.length; i++) {
    var point = data[i];
    if(point.value >= threshold) {
        var timeDeltaMillis = point.ts - Date.now();
        remainingDays = timeDeltaMillis / 1000 / 60 / 60 /24;
        break;
    }
}

return [{ts: 1, value: remainingDays}];
```

在按下 `构建报告` 按钮后，我们将看到一张表格，其中列出了每台机器到下次维护的估计时间（以天为单位）。

{% include images-gallery.html imageCollection="predictive-maintenance-forecast-next-maintenance-time" %}

### 步骤 2：将剩余时间保存为机器遥测
下一步是将计算出的剩余时间保存为机器的遥测。在这种情况下，Trendz 会定期对新数据执行计算函数，并将结果作为机器的遥测保存回 ThingsBoard。
我们需要告诉它我们希望执行计算函数的频率。在我们的例子中，它将是每小时一次。

* 将计算字段的标签更改为 **capsForecast** - Trendz 将计算函数的结果保存为具有此名称的遥测。
* 打开视图设置并在 `Tb 计算遥测保存` 部分中启用遥测保存。
    * 启用 - true
    * 保存间隔 - 1
    * 保存单位 - 小时
* 在设置中打开 `视图模式字段` 部分并在 `行单击实体` 下拉列表中打开 **机器** 实体 - 此步骤告诉 Trendz 应在哪个实体下保存计算出的遥测。
* 将默认时间范围设置为 **过去 7 天**
* 使用名称 **机器维护剩余天数预测作业** 保存视图

一旦视图保存，Trendz 将调度后台作业，该作业将定期执行计算函数并将结果保存为机器的遥测。在每次运行时，Trendz 都会从 ThingsBoard 中获取新数据并在其上执行计算函数。

{% include images-gallery.html imageCollection="predictive-maintenance-save-remaining-time-as-telemetry" %}

### 步骤 3：如果剩余时间少于 14 天，则创建警报
此时，我们已经在 ThingsBoard 中为每台机器提供了 `capsForecast` 遥测，该遥测告诉我们距离下次维护还有多少天。这意味着我们可以在 ThignsBoard 中创建警报规则，如果剩余时间少于 14 天，则触发警报。

* 在 ThingsBoard 中打开机器的设备配置文件并添加新的警报规则
* 警报类型 - **需要维护**
* 创建警报规则
  * 严重性 - `警告`
  * 条件 - `capsForecast` 小于 `14`
* 清除警报规则
  * 条件 - `capsForecast` 大于 `14`

一旦创建警报规则，ThingsBoard 就会在剩余时间少于 14 天时触发警报，并在剩余时间大于 14 天时清除警报。

{% include images-gallery.html imageCollection="predictive-maintenance-create-alarm" %}

### 步骤 4：一旦创建警报就发送通知
最后一步是一旦创建警报就向维护团队发送通知。我们将使用 ThingsBoard 规则引擎向维护团队发送电子邮件通知。如果设备配置文件中的警报规则触发警报，我们可以捕获此事件并添加发送电子邮件的步骤。

* 在 ThingsBoard 中打开根规则链
* 在 `设备配置文件` 节点后添加 `toEmail` 规则节点，并通过 `警报创建` 关系将其连接起来。
* 打开 `toEmail` 节点设置并将其配置为向维护团队发送电子邮件。
  * `来自模板` - info@testmail.org
  * `到模板` - maintenance@testmail.com
  * `主题模板` - ${entityName} 需要维护
  * `正文模板` - ${entityName} 需要维护。剩余时间：${capsForecast} 天
* 在 `toEmail` 节点后添加 `发送电子邮件` 规则节点，并通过 `成功` 关系将其连接起来。
* 保存规则链。

通过此配置，ThingsBoard 将在创建警报后向维护团队发送通知。

{% include images-gallery.html imageCollection="predictive-maintenance-notify-maintenance-team" %}

## 总结
在制造现场使用 Trendz Analytics 实施预测性维护策略可以帮助减少设备的计划外停机时间并提高盖装配机的效率。
通过预测每台机器何时生产 500,000 个盖子并在计划维护前 14 天创建警报以通知维护团队，
您可以确保有必要的零件和资源来执行维护并防止机器故障。

总体而言，使用 Trendz Analytics 等高级分析工具的预测性维护策略可以帮助组织通过在问题发生之前识别潜在问题、防止设备停机和最大程度减少对计划外维护的需求来降低成本并提高运营效率。