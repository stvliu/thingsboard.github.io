---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 从别名应用过滤器
description: 从别名应用过滤器

---

在本指南中，我们将介绍如何将位于仪表板上的标准 ThingsBoard 小部件与 Trendz 视图连接。
您可以使用 GridLinks 仪表板别名和 **Trendz 小部件包** 中的 **Trendz 视图 - 带过滤器别名** 来执行此操作。

**示例**：我们在 GridLinks 中有 10 个 **Machine** 设备。我们希望创建一个仪表板，其中会以列表形式显示所有 **Machine** 设备，并且一旦选择设备，仪表板上的其他小部件应显示所选设备的详细信息。总而言之，仪表板上将有 2 个小部件：
* 实体列表 - 将显示设备列表
* Trendz 视图 - 将显示所选设备温度的折线图

在 GridLinks 方面，我们设置了一个仪表板并添加了 2 个小部件。有关如何执行此操作的详细说明不属于本教程的一部分，因此这里提供简要步骤：
* 创建 **all_devices** 别名，该别名解析所有类型为 **Machine** 的设备
* 创建类型为 **实体表单仪表板状态** 的 **selected_device** 别名 - 此别名保存对所选设备的引用

![image](/images/trendz/embed-tb-alias.png)

* 添加 **实体列表** 小部件，并使用 **all_devices** 别名作为数据源
* 配置 **单击行** 操作，该操作会将所选设备保存到 **selected_device** 别名
* 保存仪表板

在 **Trendz 视图** 方面：
* 在 Trendz 中打开视图
* 将 **Machine** 字段添加到过滤器部分 - 它将允许我们按名称过滤机器
* 保存视图
* 复制此视图的链接

返回 GridLinks 仪表板：
* 编辑仪表板
* 将 **Trendz 小部件包** 中的 **Trendz 视图 - 带过滤器别名** 添加到仪表板
* 将 **selected_device** 设置为 Trendz 视图的数据源
* 使用别名中的 **name** 作为键

![image](/images/trendz/embed-trndz-alias.png)

* 切换到 **高级** 选项卡
* 将视图链接插入 **视图 URL**
* 将 **Machine** 插入 **过滤器名称** - 此字段的内容应与 Trendz 视图过滤器中键入的内容相同
* 保存仪表板

![image](/images/trendz/embed-trndz-filter-name.png)
![image](/images/trendz/embed-tb-filter-name.png)

现在，每当 **selected_device** 别名更新时，其实体名称的值都会插入 Trendz 视图过滤器。

如果在 Trendz 视图中配置了多个过滤器，系统将按名称匹配所需的过滤器。

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/embed-trndz-alias.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-alias-connect.webm" type="video/webm">                 
        </video> 
    </div>
</div>

## 后续步骤

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}