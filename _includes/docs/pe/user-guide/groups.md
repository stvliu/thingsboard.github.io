* TOC
{:toc}

## 简介

ThingsBoard 允许您配置多个自定义实体组。
您可以为设备、资产、实体视图、客户、用户、仪表板和边缘实例创建实体组
每个实体可以同时属于多个组。
特殊组“全部”始终包含属于特定租户帐户的所有实体。

对于每个实体组，GridLinks 用户可以配置不同的列来可视化特定的遥测或属性值。
ThingsBoard 用户还可以定义要为每个实体显示的自定义操作：打开仪表板或发送 RPC 调用等。
还支持删除实体、将它们添加到组或删除它们的批量操作。

## 创建新的实体组

在本教程中，我们将为设备创建一个实体组。
以下步骤对于任何实体都是相同的。

{% include images-gallery.html imageCollection="create-entity-group-1" showListImageTitles="true" %}

您可以在创建组的过程中共享实体组。让我们创建另一个组并与您的客户共享。

{% include images-gallery.html imageCollection="create-entity-group-2" showListImageTitles="true" %}

## 实体组配置

### 编辑一般信息

您可以编辑实体组的一般信息。例如，您可以更改实体组的组名称、固件和软件。

让我们看看如何做到这一点：

{% include images-gallery.html imageCollection="edit-entity-group-1" showListImageTitles="true" %}

### 列配置

您可以添加、删除、移动列，更改它们的标题和类型。
您还可以对列单元格使用特殊样式函数和内容函数。

对于此示例，我们有一个包含两个设备的设备组，这些设备会发布温度值。
此组有 4 列显示设备数据：“创建时间”、“名称”、“设备配置文件”和“标签”。

让我们**添加**一个新列，该列将显示每个设备的温度值。

{% include images-gallery.html imageCollection="column-configuration-add" showListImageTitles="true" %}

现在让我们从这个设备组中**删除**“标签”列。

{% include images-gallery.html imageCollection="column-configuration-delete" showListImageTitles="true" %}

现在让我们为“温度”列**设置样式函数**，以便当温度值大于或等于 45 时，值变为橙色，如果温度值小于 45，则值变为蓝色。

{% include images-gallery.html imageCollection="column-configuration-style function" showListImageTitles="true" %}

样式函数：

```javascript
return value >= 45 ? {
    color:'rgb(255, 106, 12)',
    fontWeight: 600
} : {
    color:'rgb(0, 132, 214)',
    fontWeight: 600
}
```
{: .copy-code}

让我们**设置内容函数**，以便在设备的温度值后显示符号“℃”。

{% include images-gallery.html imageCollection="column-configuration-content function" showListImageTitles="true" %}

内容函数：

```javascript
return value ? value + ' ℃' : '-';
```
{: .copy-code}

您还可以根据自己的喜好**移动**列。

{% include images-gallery.html imageCollection="column-configuration-move" showListImageTitles="true" %}

### 实体组显示设置

在“设置”选项卡上，您可以启用/禁用以下功能：搜索实体、添加新实体、删除实体和管理实体的凭据。
您还可以配置分页并选择将打开实体详细信息的操作。

要转到组设置，您需要：

{% include images-gallery.html imageCollection="setting" showListImageTitles="true" %}

### 实体组操作配置

操作允许快速轻松地配置导航到所选仪表板，或创建自定义操作。
例如，让我们创建一个操作以快速转到包含有关温度计的完整信息的仪表板。

{% include images-gallery.html imageCollection="action-configuration" showListImageTitles="true" %}

### 批量操作

对于组的每个实体，您可以执行以下操作：更改实体的所有者、将其移动到另一个组、将实体添加到组或从组中删除实体。

{% include images-gallery.html imageCollection="batch-operations" showListImageTitles="true" %}

## 删除实体组

您可以使用以下方式之一删除实体组及其所有实体：

第一种方式：

{% include images-gallery.html imageCollection="delete-entity-group-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-entity-group-2" showListImageTitles="true" %}

您和您的客户还可以一次删除多个实体组。

{% include images-gallery.html imageCollection="delete-entity-group-3" showListImageTitles="true" %}

## 视频教程

观看详细的视频教程，其中包含有关如何配置实体组以满足您需求的示例。

<br>
<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/RNdaEqrGhn8" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}