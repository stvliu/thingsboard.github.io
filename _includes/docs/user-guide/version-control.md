* TOC
{:toc}

{% assign sinceVersion = "3.4" %}
{% include templates/since.md %}

## 功能概述

ThingsBoard 版本控制服务提供使用 Git 导出和恢复 ThingsBoard 实体的功能。
作为租户管理员，您可以使用 UI 或 REST API 配置对 Git 存储库的访问。
作为平台用户，您可以导出单个或多个 ThingsBoard 实体，浏览版本历史记录并将实体恢复到特定版本。

当多个工程师设计相同的规则链或仪表板时，此功能可改善用户体验并简化 CI/CD。它还允许您轻松地在租户或平台实例之间克隆解决方案。

## 架构

#### 实体外部 ID

每个 ThingsBoard 实体都有“id”字段，它是特定 ThingsBoard 环境中实体的唯一标识符。
每个可导出的 ThingsBoard 实体都包含新的“externalId”字段。
该字段用于在多个环境之间导入和导出时标识相同的实体。
“id”和“externalId”字段都是 [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) 类型。

“externalId”还用于在规则链（规则节点）和仪表板（别名和窗口小部件操作）中自动替换实体 ID。
因此，如果您决定导入引用某些设备或资产的规则链，请确保您也导出了/导入了相应的设备或资产。

#### 可导出实体和设置

{% if docsPrefix == 'ce/' %}
此功能的初始版本支持以下实体：设备、资产、实体视图、客户、仪表板、窗口小部件包、规则链。
{% else %}
此功能的初始版本支持以下实体：设备、资产、实体视图、客户、仪表板、窗口小部件包、规则链、实体组、角色、转换器和集成。
{% endif %}

我们有意省略对用户实体的支持，因为用户电子邮件在平台实例的范围内是唯一的。将用户电子邮件和凭据导出到 Git 似乎是错误的。

在导出实体时，我们将实体的 JSON 表示形式存储在 Git 中。还可以导出实体属性、关系和凭据（仅限设备）。

#### 存储库结构

当您首次将实体导出到 Git 时，实体“id”用于命名 git 存储库中的文件。
然后，当您将实体从 Git 导入到 GridLinks 时，文件名中的“id”将变为实体的“externalId”。
“externalId”在租户范围内是唯一的。因此，您可以在同一平台实例的不同租户之间或不同实例之间导入/导出实体。
任何时候执行导出和导入操作时，都会使用“externalId”来查找要更新的正确实体。
请参阅下面的示例。

假设您有一个开发 ThingsBoard 实例，并导出一个名为“仪表板 1”且 ID 为“4864b750-da7d-11ec-a496-97fa2815d2fe”的仪表板。
然后，存储库将具有一个具有以下完整名称和路径的单个文件：

```bash
dashboard/4864b750-da7d-11ec-a496-97fa2815d2fe.json
```

假设您已将仪表板“D1”导入到生产 ThingsBoard 实例。“externalId”字段在您首次将实体导入到新的 ThingsBoard 实例时设置。
在这种情况下，生产环境中的仪表板实体将具有不同的 ID，但仪表板的“externalId”将设置为相同的“4864b750-da7d-11ec-a496-97fa2815d2fe”。

{% if docsPrefix != 'ce/' %}
客户层级存储在“hierarchy”文件夹中，该文件夹是递归的，类似于 UI 中的“客户层级”页面。
实体组存储在“groups”文件夹中。每个组都有一个“id.json”文件，用于存储组实体，还有一个“id_entities.json”文件，用于存储组中的实体 ID 列表。保留组“All”不包含“id_entities.json”文件，因为组“All”包含所有实体。
{% endif %}

{% include images-gallery.html imageCollection="gitRepoStructure" %}


#### 同步策略

平台支持两种导出到 Git 的同步策略：合并和覆盖。
“合并”是默认同步策略，它只是将选定的实体附加到存储库。当您想保存一个或多个文件而不删除存储库中的所有其他文件时，此策略很有用。
“覆盖”策略完全重写相应的存储库文件。当您想完全同步实例中的实体列表（例如仪表板）和 Git 存储库时，此策略很有用。
以前保存到 Git 但不在平台实例中的所有实体都将在相应的提交中从 Git 存储库中删除。


#### 可扩展性

ThingsBoard 版本控制服务可用作整体 ThingsBoard 实例的一部分，或作为单独的微服务以实现水平可扩展性。
版本控制服务的每个实例负责处理集群中租户的特定分区(s)的同步任务。
每个“提交”API 调用可能需要一些时间。不支持在同一租户范围内同时进行“提交”API 调用。
如果“提交”API 调用正在进行中并且新的“提交”API 调用到达，系统将取消“提交”API 调用。

## 用法

#### Git 设置配置

作为租户管理员，您可以导航到**系统设置 -> Git 设置**页面。该页面允许您配置 Git 存储库 URL、默认分支名称和身份验证设置。
我们希望您提供指向空 Git 存储库的 URL。

{% include images-gallery.html imageCollection="gitConfiguration" %}

#### 导出到 Git

##### 单个实体导出

导航到实体详细信息并打开“版本控制”选项卡。
规则链和仪表板具有内置的版本控制按钮和弹出窗口小部件，可用于相应的编辑器。
请参阅下面的屏幕截图。

{% include images-gallery.html imageCollection="singleEntityExport" %}

##### 多个实体导出

导航到版本控制页面。您可以选择一个或多个实体类型进行恢复。默认情况下，所有实体类型都被选中。

{% include images-gallery.html imageCollection="multipleEntityExport" %}

##### 自动提交

自动提交是一项有用的功能，可让我们通过 UI 或 REST API 调用保存实体时自动提交仪表板和规则链。
自动提交异步发生以改善 UI 体验。
当您将实体分配给客户（更改实体所有者）时，不会发生自动提交。
在这种情况下，您应该使用覆盖策略提交特定实体类型的所有实体。

{% include images-gallery.html imageCollection="autoCommitConfiguration" %}

#### 从 Git 恢复

导航到版本控制页面。选择提交并指定恢复设置。

{% include images-gallery.html imageCollection="gitRestore" %}

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}