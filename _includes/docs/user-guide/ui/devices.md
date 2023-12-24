* TOC
{:toc}

在 GridLinks IoT 平台的上下文中，“设备”是基本的物联网对象，可以生成遥测数据并将其传输到 GridLinks 平台，以及响应远程过程调用 (RPC) 命令。

GridLinks 提供通过 Web 界面和 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 管理设备、存储来自设备的数据以及促进设备与平台其他组件之间交互的功能。

在此上下文中，设备可以指连接到网络的物理或虚拟对象，例如监控传感器、智能设备、机器、传感器等。这些设备可以收集温度、湿度、GPS 坐标等数据，并将这些数据发送到 GridLinks 平台。

设备可以组织成各种 [组](/docs/{{docsPrefix}}user-guide/groups/)。

GridLinks 平台允许您创建 [仪表板](/docs/{{docsPrefix}}user-guide/dashboards/)、跟踪和分析来自设备的数据，并根据这些数据配置规则和自动化。

简而言之，GridLinks 中的设备是 IoT 系统的核心部分，该平台提供了管理设备及其收集的数据的工具。

## 添加新设备

{% if docsPrefix == null %}
- 登录到您的 ThingsBoard 实例并导航到“实体”部分。然后转到“设备”页面；
- 单击表格右上角的“+”图标，然后选择“添加新设备”；
- 输入设备名称。例如，“我的新设备”。此时无需进行其他更改。单击“添加”；
- 设备已创建。将打开一个窗口，您可以在其中 [检查设备与 GridLinks 的连接](#check-connectivity)。此步骤是可选的。现在让我们关闭此窗口，并在下一步中更详细地返回检查连接；
- 您的第一个设备已添加。随着新设备的添加，它们将被添加到表格的顶部，因为表格默认使用创建的时间对设备进行排序。
{% endif %}

{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
- 登录到您的 ThingsBoard 实例并导航到“实体”部分。然后转到“设备”页面；
- 默认情况下，您导航到设备组“全部”。单击表格右上角的“+”图标，然后选择“添加新设备”；
- 输入设备名称。例如，“我的新设备”。此时无需进行其他更改。单击“添加”；
- 设备已创建。将打开一个窗口，您可以在其中 [检查设备与 GridLinks 的连接](#check-connectivity)。此步骤是可选的。现在让我们关闭此窗口，并在下一步中更详细地返回检查连接；
- 您的第一个设备已添加。随着新设备的添加，它们将被添加到表格的顶部，因为表格默认使用创建的时间对设备进行排序。
{% endif %}

{% include images-gallery.html imageCollection="add-device" %}

添加新设备时，您将收到通知。您可以通过单击右上角的“铃铛”图标来查看它。

{% include images-gallery.html imageCollection="add-device-notification" %}

在此处了解有关通知及其配置方式的更多信息 [here](/docs/{{docsPrefix}}user-guide/notifications/)。

{% unless docsPrefix == null %}
<br>
**创建新设备组**

每个设备可以同时属于多个组。要添加新设备组，您应该：

{% include images-gallery.html imageCollection="add-device-group-pe" showListImageTitles="true" %}

您可以在 [此处](/docs/{{docsPrefix}}user-guide/groups/) 阅读有关实体组的更多信息。
{% endunless %}

## 编辑设备

您可以更改设备名称、其设备配置文件、标签、分配固件和软件。
要编辑设备，您需要：

{% include images-gallery.html imageCollection="device-details" showListImageTitles="true" %}

## 删除设备

您可以使用以下方式之一删除设备：

第一种方式：

{% include images-gallery.html imageCollection="device-delete-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="device-delete-2" showListImageTitles="true" %}

## 设备操作

{% if docsPrefix == null %}
您可以对设备执行各种操作，例如 [公开设备](#make-device-public)、[将设备分配给客户](#assign-device-to-customer)、[管理凭据](#manage-device-credentials)、[检查连接](#check-connectivity)、[删除设备](#deletion-device)、复制 [设备 ID](#copy-device-id) 和复制 [访问令牌](#copy-device-credentials)。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
您可以对设备执行各种操作，例如 [管理凭据](#manage-device-credentials)、[管理所有者和组](#manage-owner-and-groups)、[检查连接](#check-connectivity)、[删除设备](#deletion-device)、复制 [设备 ID](#copy-device-id) 和复制 [访问令牌](#copy-device-credentials)。
{% endif %}

{% if docsPrefix == null %}
### 公开设备

公开设备及其所有数据都将公开。当您创建需要访问设备数据的公共仪表板时，这是必要的。

{% include images-gallery.html imageCollection="make-device-public" showListImageTitles="true" %}

要再次使设备变为私有，请按照以下步骤操作：

{% include images-gallery.html imageCollection="make-device-private" showListImageTitles="true" %}

### 将设备分配给客户

您可以将设备分配给某些 [客户](/docs/{{docsPrefix}}user-guide/ui/customers/)。
这将允许客户用户使用 REST API 或 Web UI 获取设备数据。

{% include images-gallery.html imageCollection="assign-device-to-customer" showListImageTitles="true" %}
{% endif %}

### 管理设备凭据

您可以管理设备凭据。当前版本支持基于 **[访问令牌](/docs/{{docsPrefix}}user-guide/access-token/)**、**[X.509 证书](/docs/{{docsPrefix}}user-guide/certificates/)** 和 **[MQTT Basic](/docs/{{docsPrefix}}user-guide/basic-mqtt/)** 的凭据。

默认情况下，使用“访问令牌”凭据。要更改设备凭据，请按照以下步骤操作：

{% include images-gallery.html imageCollection="manage-device-credentials" showListImageTitles="true" %}

{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
### 管理所有者和组

您可以在设备详细信息窗口中更改设备的所有者或将设备添加到一个或多个设备组。

{% include images-gallery.html imageCollection="manage-owner-and-groups-pe" showListImageTitles="true" %}
{% endif %}

### 检查连接

检查您的设备与 GridLinks 平台的连接：

{% include images-gallery.html imageCollection="check-connectivity" showListImageTitles="true" %}

### 复制设备 ID

使用“复制设备 ID”按钮将设备 ID 复制到剪贴板。

{% include images-gallery.html imageCollection="copy-device-id" %}

### 复制设备凭据

单击“复制访问令牌”或“复制 MQTT 凭据”按钮（取决于您选择的 [设备凭据](#manage-device-credentials) 类型）以复制设备凭据。

{% include images-gallery.html imageCollection="copy-access-token" %}

## 设备详细信息

“设备详细信息”窗口提供了允许您管理和监视设备属性（例如 [属性](#device-attributes)、[最新遥测](#device-telemetry)、[警报](#device-alarms)、[事件](#device-events)、[关系配置](#device-relations)、[审计日志](#device-audit-logs) 和 [版本控制](#version-control)）的各种选项卡。

### 设备属性

此选项卡显示设备的客户端、服务器和共享属性。例如，序列号、型号和固件版本。
[属性](/docs/{{docsPrefix}}user-guide/attributes/) 是与设备关联的静态和半静态键值对。

{% include images-gallery.html imageCollection="attributes" %}

### 设备遥测

此选项卡显示设备发送的实时遥测数据，例如传感器读数、状态和其他可测量变量。
[时序](/docs/{{docsPrefix}}user-guide/telemetry/) 数据点可用于存储、查询和可视化。例如，温度、湿度和电池电量。

{% include images-gallery.html imageCollection="telemetry" %}

**添加遥测。**
您可以使用 GridLinks UI 手动添加遥测。为此，请单击窗口右上角的“加号”图标。在新窗口中，输入键名，选择值类型并输入值。

{% include images-gallery.html imageCollection="telemetry-add-manually" %}

**删除遥测。**
要删除遥测，请单击要删除的遥测键名称旁边的“垃圾桶”图标。选择您具体要删除的内容：删除所有数据、删除除最新值之外的所有数据、删除最新值、删除一段时间内所有数据。单击“应用”按钮确认删除。

{% include images-gallery.html imageCollection="telemetry-delete" %}

### 设备警报

此选项卡显示 [警报](/docs/{{docsPrefix}}user-guide/alarms/)，这些警报可识别设备的问题。

{% include images-gallery.html imageCollection="alarms" %}

### 设备事件

此处显示与设备相关的事件，包括系统日志、错误、警告以及设备生命周期中的其他重要时刻。

{% include images-gallery.html imageCollection="events" %}

### 设备关系

[关系](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations) 是与其他实体的定向连接。此选项卡显示此设备与 ThingsBoard 系统中的其他设备、仪表板、资产和其他实体的关系。

{% include images-gallery.html imageCollection="relations" %}

### 设备审计日志

GridLinks 提供跟踪用户操作以保留审计日志的功能。
可以记录与主要实体（资产、设备、仪表板、规则等）相关的用户操作。

{% include images-gallery.html imageCollection="audit-logs" %}

### 版本控制

ThingsBoard [版本控制](/docs/{{docsPrefix}}user-guide/version-control/) 服务提供使用 Git 导出和恢复 ThingsBoard 实体的功能。

{% include images-gallery.html imageCollection="version-control" %}