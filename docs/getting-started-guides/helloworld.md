---

* TOC
{:toc}

此教程的目的是演示 ThingsBoard 最受欢迎功能的基本用法。您将学习如何：

- 将设备连接到 ThingsBoard；
- 将数据从设备推送到 ThingsBoard；
- 构建实时最终用户仪表板；
- 定义阈值并触发警报；
- 通过电子邮件、短信或其他系统设置有关新警报的推送通知。

**在本指南中，我们将连接和可视化温度传感器的数据，以保持简单。**

{% include templates/prerequisites.md %}

## 第 1 步。预置设备

例如，让我们添加一个设备，该设备将以下数据传输到 ThingsBoard 平台：设备的名称和温度读数作为遥测。

要添加新设备，请按照以下步骤操作：

{% include images-gallery.html imageCollection="step1" showListImageTitles="true" %}

<br>
添加新设备时，您将收到通知。您可以通过单击右上角的“铃铛”图标来查看它。

{% include images-gallery.html imageCollection="step11" %}

在此处了解有关 **通知** 及其配置方式的更多信息（请参阅 [步骤 6 - 警报通知](#step-6-alarm-notifications)）。

<br>
您还可以使用：
* [批量预置](/docs/user-guide/bulk-provisioning/) 使用 UI 从 CSV 文件预置多个设备；
* [设备预置](/docs/user-guide/device-provisioning/) 允许设备固件自动预置设备，因此您无需手动配置每个设备；
* [REST API](/docs/api/) 以编程方式预置设备和其他实体；

## 第 2 步。连接设备

现在，让我们检查我们的设备与 ThingsBoard 平台的连接。
为此，请使用“检查连接”功能代表您的设备发布遥测数据（例如，温度读数）。您可以在添加设备时和之后执行此操作。

{% include images-gallery.html imageCollection="step2" showListImageTitles="true" %}

<br>
您还可以使用 [ThingsBoard API 参考](/docs/{{docsPrefix}}api)。在这里，您可以找到有关设备连接支持的所有协议的更详细信息。

## 第 3 步。创建仪表板

ThingsBoard 中的仪表板允许用户可视化和监控从物联网设备收集的数据。

让我们创建一个仪表板并在其中添加三个小部件，以便显示实体列表及其最新值，以及显示与指定实体相关的警报信号。

### 第 3.1 步 创建一个空仪表板

要创建新仪表板，请按照以下步骤操作：

{% include images-gallery.html imageCollection="step31" showListImageTitles="true" %}

### 第 3.2 步 添加实体表小部件

“实体表”小部件显示实体列表及其最新值。
实体列表对应于选定的设备或其他实体，以及具有附加全文搜索和分页选项的过滤器。

要添加表小部件，我们需要从小部件库中选择它。小部件被分组到小部件包中。
每个小部件都有一个数据源。这就是小部件“知道”要显示什么数据的方式。
要查看我们在步骤 2 中发送的“温度”数据的最新值，我们应该配置数据源。

让我们添加您的第一个小部件：

{% include images-gallery.html imageCollection="step32" showListImageTitles="true" %}

恭喜！您已添加您的第一个小部件。

在“实体表”小部件中，有两列。
第一列显示设备的名称，第二列显示“温度”键（设备遥测）的值。
因此，每列对应于一个添加的键。

现在，您可以发送新的遥测读数（如 [步骤 1](#step-1-provision-device) 中所示），它将立即显示在表中。

### 第 3.3 步 添加图表小部件

图表小部件允许您使用可自定义的折线图和条形图显示时间序列数据。

要添加图表小部件，我们需要从小部件库中选择它。
图表小部件显示同一数据键（在本例中为“温度”）的多个历史值。
我们还应该配置时间窗口以使用图表小部件。

{% include images-gallery.html imageCollection="step33" showListImageTitles="true" %}

恭喜！您已添加图表小部件。现在，您可以发送新的遥测读数，它将立即显示在图表中。

### 第 3.4 步 添加警报表小部件

警报表小部件显示在特定时间窗口内与指定实体相关的警报。
警报小部件通过指定实体作为警报源和相应的警报字段来配置。

{% include images-gallery.html imageCollection="step34" showListImageTitles="true" %}

恭喜！您已添加警报小部件。现在是时候配置警报规则并发出一些警报了。

**注意：**在本说明中，我们使用单个设备作为小部件的数据源。
要使用动态实体（例如，特定类型或与特定资产相关的设备）作为数据源，您应该使用别名。
别名是对小部件中使用的单个实体或实体组的引用。
您可以在此处了解有关 [不同别名的更多信息](/docs/{{docsPrefix}}user-guide/ui/aliases/)。

## 第 4 步。配置警报规则

我们将使用 [警报规则](/docs/user-guide/device-profiles/#alarm-rules) 功能在温度读数大于 25 度时发出警报。
为此，我们应该编辑设备配置文件并添加新的警报规则。
“我的新设备”正在使用“默认”设备配置文件。
我们建议为每种相应的设备类型创建专用的 [设备配置文件](/docs/user-guide/device-profiles/)，但为了简单起见，我们将跳过此步骤。

{% include images-gallery.html imageCollection="step4" showListImageTitles="true" %}

## 第 5 步。创建警报

现在，我们的警报规则处于活动状态（请参阅 [步骤 4](/docs/getting-started-guides/helloworld/#step-4-configure-alarm-rules)），
我们应该代表设备发送新的遥测（请参阅 [步骤 2](/docs/getting-started-guides/helloworld/#step-2-connect-device)）以触发警报。
请注意，温度值应为 26 或更高才能触发警报。一旦我们发送新的温度读数，我们应该立即在我们的仪表板上看到一个新的警报。

{% include images-gallery.html imageCollection="step5" showListImageTitles="true" %}

## 第 6 步。警报通知

使用 **通知中心** 设置通知非常容易。ThingsBoard 通知中心允许您向最终用户发送通知。
在此处了解有关通知及其配置方式的更多信息（请参阅 [此处](/docs/{{docsPrefix}}user-guide/notifications/)）。

我们还建议查看警报规则 [示例](/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules) 和有关 [警报通知](/docs/{{docsPrefix}}user-guide/device-profiles/#notifications-about-alarms) 的文档。

## 第 7 步。将设备和仪表板分配给客户

ThingsBoard 最重要的功能之一是将仪表板分配给客户的能力。
您可以将不同的设备分配给不同的客户。然后，您可以创建一个或多个仪表板并将其分配给多个客户。
每个客户用户都将看到自己的设备，并且无法看到属于其他客户的设备或任何其他数据。

我们已经创建了一个设备（请参阅 [步骤 1](#step-1-provision-device)）和一个仪表板（请参阅 [步骤 3](#step-3-create-dashboard)）。
现在是时候创建一个客户和一个客户用户，并确保他们可以访问设备数据和仪表板。

### 第 7.1 步 创建客户

让我们创建一个标题为“我的新客户”的客户。请参阅以下说明：

{% include images-gallery.html imageCollection="step71" showListImageTitles="true" %}

### 第 7.2 步 将设备分配给客户

让我们将设备分配给客户。客户用户将能够读取和写入遥测数据并向设备发送命令。

{% include images-gallery.html imageCollection="step72" showListImageTitles="true" %}

确保设备已分配给您的客户。

{% include images-gallery.html imageCollection="step72_1" showListImageTitles="true" %}

您可以在创建设备期间使客户成为设备的所有者。

{% include images-gallery.html imageCollection="step72_2" showListImageTitles="true" %}

### 第 7.3 步 将仪表板分配给客户

让我们与客户分享我们的仪表板。客户用户将具有对仪表板的只读访问权限。

{% include images-gallery.html imageCollection="step73" showListImageTitles="true" %}

### 第 7.4 步 创建客户用户

最后，让我们创建一个属于客户的用户，该用户将具有对仪表板和设备的 `read-only` 访问权限。
您还可以选择配置仪表板，以便在用户登录到平台 Web UI 后立即显示。

{% include images-gallery.html imageCollection="step74" showListImageTitles="true" %}

### 第 7.5 步 激活客户用户

{% include images-gallery.html imageCollection="step75" showListImageTitles="true" %}

## 后续步骤

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/guides-banner.md %}

## 您的反馈

不要犹豫，在 **[github](https://github.com/thingsboard/thingsboard)** 上为 ThingsBoard 加星，以帮助我们传播信息。
如果您对本示例有任何疑问，请将其发布在 **[论坛](https://groups.google.com/forum/#!forum/thingsboard)** 上。