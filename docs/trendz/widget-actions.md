---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: Trendz 小部件操作
description: Trendz 小部件操作

---

* TOC
{:toc}

#### 配置 OnRowClock 操作
Trendz 表视图支持 onRowClick 操作。您可以配置用户在表中单击行时应发生的情况。
例如，您可以将实体保存到仪表板状态别名或打开新的仪表板状态。

若要启用行单击事件：
* 在 ThingsBoard 仪表板上添加 Trendz 表视图。
* 打开小部件编辑模式并切换到 **操作** 选项卡。
* 按 **添加操作** 按钮。
* 在 **操作源** 字段中选择 **行单击**。
* 继续标准小部件操作配置。

每行都有来自一个或多个设备/资产的多个字段。这意味着 1 行可以与多个项目连接。
如果您想使用“onRowClick”操作 - 您需要定义单击行时选择哪个项目。
* 在 Trendz 视图编辑模式中打开 **视图设置**。
* 打开 **视图模式字段** 部分。
* 在 **行单击实体** 下拉列表中选择所需的设备/资产类型。
* 保存更改。

#### 配置所选日期操作

#### 配置切换字段操作

![image](/images/trendz/trndz_dashboard_time.png)

## 后续步骤

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}