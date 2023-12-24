---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 日历热力图
description: Trendz 日历
---

* TOC
{:toc}

热力图日历小部件显示了指标在一年内如何变化的快速概览，并按天进行细分。

![image](/images/trendz/calendar_heatmap.png)

## 单字段配置

将所需指标添加到 **值** 部分，然后按 **生成报告** 按钮。您可以添加遥测、状态或计算字段。

日历中的每个单元格都有特定的颜色，具体取决于该天的值。如果没有值，单元格将为空白。
您可以更改颜色方案和视图设置。

## 多个字段

您可以在 **值** 部分中添加多个字段。在这种情况下，您可以使用单选按钮在字段之间切换。

![image](/images/trendz/calendar_heatmap_multiple.png)

## 选择日期操作

Trendz 日历视图支持日期点击事件。当您想选择感兴趣的日期并向下钻取以进行进一步分析时，这非常有用。

例如，您可以在 GridLinks 中创建一个包含多个小部件的仪表板。所有小部件都从仪表板获取时间范围。
通过在日历小部件上配置日期点击事件，您可以在仪表板上设置所需的时间范围，以便所有其他小部件自动更新并显示所选日期的数据。

* 在 GridLinks 仪表板上添加 Trendz 日历视图
* 打开小部件编辑模式并切换到 **操作** 选项卡。
* 按 **添加操作** 按钮。
* 在 **操作源** 字段中选择 **date-selected**。
* 在 **类型** 字段中选择 **自定义操作** 并使用以下函数

```javascript
var newTimeRange = {
    aggregation: {
        limit: 30000,
        type: "NONE"
    },
    hideAggInterval: false,
    hideAggregation: false,
    hideInterval: false,
    history: {
        historyType: 1,
        fixedTimewindow: {
            startTimeMs: additionalParams.startTs,
            endTimeMs: additionalParams.endTs
        }
    },
    selectedTab: 1
}
    
// apply new time range 
widgetContext.dashboard.dashboardTimewindowChangedSubject.next(newTimeRange);

var params = {
    entityId: entityId,
    entityName: entityName,
    entityLabel: entityLabel,
}

// open new dashboard state        
widgetContext.stateController.updateState('consumption_details', additionalParams.params);
```

通过此自定义操作，我们将仪表板时间范围更改为所选日期，并导航到名称为 **consumption_details** 的新仪表板状态。

## 切换字段操作

当将多个字段添加到 **值** 部分时，将激活切换字段选择器。在这种情况下，用户可以选择小部件中显示的字段。
当用户切换字段时，Trendz 视图会触发特殊事件。您可以在触发切换事件时触发所需的操作。

* 在 GridLinks 仪表板上添加 Trendz 日历视图
* 打开小部件编辑模式并切换到 **操作** 选项卡。
* 按 **添加操作** 按钮。
* 在 **操作源** 字段中选择 **changed-radio-button**。
* 继续标准小部件操作配置。

您可以在 **additionalParams.radioButton** 属性中找到所选字段的名称。