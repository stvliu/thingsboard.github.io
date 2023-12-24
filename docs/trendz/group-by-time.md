---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 按时间分组和聚合数据
description: 按时间分组和聚合数据
---

在大多数情况下，数据按时间间隔分组 - 按小时、天、周、月等。您应该使用左侧面板中的 **日期** 字段，并将其拖放到 **X 轴** 部分。

日期聚合的默认函数为 **RAW** - 这意味着用户可以使用时间范围选择器附近的 **按分组** 组合框来控制聚合间隔。系统将从时间范围选择器中获取完整范围，并根据所选值将其划分为较小的间隔。然后，为每个间隔应用选定的聚合函数。**按分组** 字段允许的值为：
* 月
* 周
* 天
* 小时
* 分钟

![image](/images/trendz/date-raw-group.png)


您可以通过选择其他可用的日期聚合选项来更好地控制日期间隔：
* RAW，
* MINUTE
* HOUR
* FULL_HOUR - '2020-03-01 23'
* DAY - 星期几
* DATE - 月份中的日期
* FULL_DATE - '2020-03-01'
* START_OF_WEEK - 2020-03-01
* WEEK_OF_YEAR - 一年中的数字周
* WEEK_OF_MONTH - 一个月中的数字周
* MONTH
* QUARTER
* YEAR
* YEARMONTH - '2020-Feb'