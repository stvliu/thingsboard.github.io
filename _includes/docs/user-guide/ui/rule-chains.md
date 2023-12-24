* TOC
{:toc}

## 简介

规则链 - 节点通过关系相互连接，因此规则节点的出站消息将发送到下一个连接的规则节点。

规则链页面显示已配置租户规则链的表格。
您可以创建、导出/导入、删除并标记所需的规则链作为根。

有关更多详细信息，请参阅[**规则引擎**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)文档。

### 创建新规则链

要添加新规则链，您应该：

{% include images-gallery.html imageCollection="create-rule-chain" showListImageTitles="true" %}

### 编辑规则链

您可以编辑名称和描述行，以及启用/禁用调试模式。

{% include images-gallery.html imageCollection="edit-rule-chain" showListImageTitles="true" %}

### 导出/导入规则链

您可以将规则链[导出](#export-rule-chain)到 JSON 文件，并将其[导入](#import-rule-chain)到相同或其他 ThingsBoard 实例。

#### 导出规则链

要导出规则链，您应该：

{% include images-gallery.html imageCollection="export-rule-chain" showListImageTitles="true" %}

#### 导入规则链

要从 JSON 文件导入规则链，您应该：

{% include images-gallery.html imageCollection="import-rule-chain" showListImageTitles="true" %}

{% capture difference %}
**注意 1：**
<br>
所有导入的规则链**不是根**规则链。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture difference %}
**注意 2：**
<br>
如果导入的规则链包含对其他规则链的引用（通过**规则链**节点），那么您需要在保存规则链之前更新这些引用。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 使规则链成为根

要使规则链成为根，您应该：

{% include images-gallery.html imageCollection="make-rule-chain-as-root" showListImageTitles="true" %}

### 删除规则链

您可以使用以下方法之一删除规则链：

第一种方法：

{% include images-gallery.html imageCollection="delete-rule-chain-1" showListImageTitles="true" %}

第二种方法：

{% include images-gallery.html imageCollection="delete-rule-chain-2" showListImageTitles="true" %}

您还可以一次删除多个规则链。

{% include images-gallery.html imageCollection="delete-rule-chain-3" showListImageTitles="true" %}

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}