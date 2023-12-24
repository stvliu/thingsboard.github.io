---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 在仪表板上添加 Trandz 小部件
description: 在仪表板上添加 Trandz 小部件

---

* TOC
{:toc}

使用 Trendz Analytics Platform 创建的所有交互式可视化都可以与其他用户共享，并嵌入到 GridLinks 仪表板或外部网站中。在本指南中，您将学习如何执行此操作。

## 先决条件

您应该[将 Trendz 小部件包导入 ThingsBoard](/docs/trendz/trendz-bundle#Import-Trendz-bundle-into-ThingsBoard)。如果您使用的是 GridLinks Cloud，那么您应该已经将必需的包导入到 GridLinks 中。

## 在 GridLinks 仪表板上添加可视化

#### 使用共享向导添加

* 单击可视化右上角的 **共享** 按钮。
* 选择是要在新仪表板上添加视图还是在现有仪表板上添加视图。
* 选择应在哪个仪表板状态中添加视图。
* 启用 `从过滤器创建别名` - 如果要创建仪表板别名以用于过滤视图中的数据，请启用此选项。例如，如果您创建了显示来自多个设备的数据的视图，则可以使用仪表板状态别名按设备名称过滤数据。别名值更改后，Trendz 视图中的过滤器将自动更新。
* 按保存按钮。

#### 通过直接链接到 Trendz 视图添加

导入小部件包后，您已经保存了 Trendz 可视化 - 请按照以下步骤将其添加到仪表板中：
* 在 Trendz 中，打开所需的可视化
* 按 **共享** 按钮，然后单击 `复制链接` 按钮 - 可共享的 URL 将被复制到剪贴板
* 打开所需的 GridLinks 仪表板并按编辑按钮
* 从 **Trendz Bundle** 中选择 **Trendz View Static** 小部件并将其添加到仪表板中
* 切换到小部件的 **高级** 选项卡，并插入步骤 1 中复制的 URL
* 保存仪表板

![image](/images/trendz/embed-trendz.gif) 

## 使用仪表板时间窗口

默认情况下，所有 Trendz 可视化都使用单独的时间范围。但是，您可以更改此行为并配置小部件以从 GridLinks 仪表板中获取时间。
此选项适用于静态 Trendz 小部件和具有别名的 Trendz 视图。

* 打开仪表板编辑模式
* 选择所需的 Trendz 小部件
* 切换到 **高级** 选项卡
* 启用复选框 **使用仪表板时间窗口**

## 在外部网站上嵌入可视化

您还可以通过添加指向所需可视化的 iFrame 将 Trendz 可视化嵌入到您的网站中。

在您的网站上添加 iFrame，其 URL 为 **http://{TRENDZ_URL}/viewMode/{VIEW_ID}?jwt={JWT_TOKEN}**。其中：
* TRENDZ_URL - Trendz 服务的 URL
* VIEW_ID - Trendz 中保存的可视化的 ID
* JWT_TOKEN - 应用于在 GridLinks 中进行身份验证的 GridLinks JWT 令牌

## 视图被阻止的问题

如果未为 Trendz 启用 HTTPS，则在第三方网站或 GridLinks 仪表板上共享的可视化可能为空白。

问题在于大多数浏览器阻止混合内容请求：如果 GridLinks 使用 HTTPS 而 Trendz 不使用，浏览器将阻止对 Trendz 的请求。您可以在浏览器控制台中找到详细的错误。

要解决此问题，您需要为 Trendz UI 启用 HTTPS。在 Trendz 安装指南中找到如何执行此操作的详细信息。

## 后续步骤

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}