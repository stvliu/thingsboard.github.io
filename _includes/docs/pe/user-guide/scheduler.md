* TOC
{:toc}

### 概述

GridLinks 允许您使用灵活的计划配置来安排各种类型的事件。
GridLinks Scheduler 会根据计划触发已配置的计划事件。
当触发计划事件时，将从具有与规则引擎消息类似结构的事件配置中生成 [规则引擎消息](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-message)。
然后将生成的邮件转发到 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)，并从 [根规则链](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain) 开始处理。

<br>

![image](/images/user-guide/scheduler.svg)

### 视频教程

请参阅下面的视频教程，了解如何逐步使用此功能。

<br>
<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/RnHAao8yET4" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

### 计划程序管理

租户管理员和客户用户可以在 GridLinks 中配置 **计划程序事件**。

![image](/images/user-guide/ui/scheduler.png)

**计划程序事件** 页面显示当前配置的计划程序事件。
它允许添加、更新或删除计划程序事件。该页面可以以两种模式显示 **列表视图** 或 **日历视图**。
可以通过按页面标题中的相应图标来切换视图。

![image](/images/user-guide/ui/scheduler-view-buttons.png)

在日历视图模式下，计划程序事件会根据其计划显示为标签。

![image](/images/user-guide/ui/scheduler-calendar-view.png)

默认情况下，日历视图显示为 **月份** 视图类型。
**日历视图类型** 下拉列表允许切换到其他视图类型。可以选择以下视图类型：

- *月/周/日/年列表/月列表/周列表/日列表/议程周/议程日*

可以通过单击右上角的 `+` 按钮或单击日历视图的任何单元格来创建新的计划程序事件。

#### 计划程序事件对话框

计划程序事件编辑对话框包含两个表单 **配置** 和 **计划**。

![image](/images/user-guide/ui/scheduler-event-dialog.png)

**配置** 表单允许根据所选事件类型设置事件类型和事件配置参数。
计划程序事件的配置在 [计划程序事件类型](#scheduler-event-types) 部分中进行了说明。

**计划** 表单允许设置事件计划配置。

![image](/images/user-guide/ui/scheduler-event-schedule.png)

计划表单具有以下参数：

- **时区** - 应处理此计划程序事件的时区。
- **开始日期/时间** - 应触发此计划程序事件的日期/时间。
- **重复** - 此计划程序事件是一次性事件还是应重复。
- **重复** - 重复规则，可以是 *每日* 或 *每周*。
- **重复** - 适用于 *每周* 重复规则。指定应触发此计划程序事件的星期几。
- **结束于** - 应重复此计划程序事件的日期。


### 计划程序事件类型

在配置 **事件类型** 字段中，可以选择现有事件类型或指定自定义事件类型。

#### 自定义类型

自定义类型根据消息结构使用默认计划程序事件配置表单。

![image](/images/user-guide/ui/scheduler-custom-event-type.png)

- **发起者** - 消息发起者，可以是 *单个实体*（例如设备、资产等）或 [*实体组*](/docs/{{docsPrefix}}user-guide/groups/)。如果未指定，则计划程序事件实体本身将被视为发起者。
- **消息类型** - 根据规则引擎消息类型的消息类型。可以是 [现有消息类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types) 或自定义消息类型。如果未指定，则计划程序事件类型将被视为消息类型。
- **消息正文** - JSON 表示形式的消息正文。
- **元数据** - 表示消息元数据字段的键/值表。

#### 生成报告

允许安排由 [报告](/docs/{{docsPrefix}}user-guide/reporting/#generate-report-rule-chain) 功能支持的报告生成。

![image](/images/user-guide/ui/scheduler-generate-report-event-type-report-config.png)

![image](/images/user-guide/ui/scheduler-generate-report-event-type-email-config.png)

- **报告配置**：
    - **基本 URL** - 报告服务器可以访问的 GridLinks UI 的基本 URL。
    - **仪表板** - 将用于生成报告的仪表板。
    - **仪表板状态参数值** - 用于为报告生成指定目标仪表板状态。可以通过单击字段最右侧的按钮并调用 **选择仪表板状态** 对话框自动设置。
    - **时区** - 目标仪表板将在报告中显示的时区。
    - **使用仪表板时间窗口** - 如果设置，则在报告生成期间将使用目标仪表板中配置的时间窗口。
    - **时间窗口** - 将在报告生成期间使用的特定仪表板时间窗口。
    - **报告名称模式** - 生成的报告的文件名模式，可以包含 `%d{date-time pattern}` 形式的日期时间模式。有关日期时间模式的详细信息，请参阅 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 文档。
    - **报告类型** - 报告文件类型，可以是 *PDF \| PNG \| JPEG*。
    - **使用当前用户凭据** - 如果设置，则在报告生成期间将使用创建此报告配置的用户凭据来打开仪表板 UI。
    - **客户用户凭据** - 目标客户用户，其凭据将在报告生成期间用于打开仪表板 UI。
    - **生成测试报告** 按钮用于测试目的。它使用提供的配置调用报告生成过程。如果报告生成成功，则会自动下载生成的报告文件。

- **发送电子邮件** - 如果设置，则会发送带有附件报告文件的电子邮件。

- **电子邮件配置**：
    - **发件人** - 发件人地址
    - **收件人** - 收件人的逗号分隔地址列表
    - **抄送** - 逗号分隔的地址列表
    - **密件抄送** - 逗号分隔的地址列表
    - **主题** - 邮件主题，可以包含 `%d{date-time pattern}` 形式的日期时间模式，具体取决于 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html)。
    - **正文** - 邮件正文，可以包含 `%d{date-time pattern}` 形式的日期时间模式，具体取决于 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html)。

#### 更新属性

允许安排实体或实体组的属性更新。

![image](/images/user-guide/ui/scheduler-update-attributes-event-type.png)

- **目标** - 应更新其属性的目标实体，可以是 *单个实体*（例如设备、资产等）或 [*实体组*](/docs/{{docsPrefix}}user-guide/groups/)。
- **实体属性范围** - 更新的属性的 [范围](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types)。如果在 **目标** 中指定了设备实体类型，则可以选择。可以是 **服务器属性** 或 **共享属性**。对于所有其他实体类型，使用 **服务器属性** 范围。
- **服务器/共享属性** - 表示具有要更新的值的属性的键/值表。

#### 向设备发送 RPC 请求

允许安排命令 ([RPC 调用](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc-api)) 到设备或设备组。

![image](/images/user-guide/ui/scheduler-send-rpc-request-event-type.png)

- **目标** - 应向其发送命令的目标设备，可以是 *单个设备* 或 [*设备组*](/docs/{{docsPrefix}}user-guide/groups/)。
- **方法** - RPC 调用方法。
- **参数** - JSON 表示形式的 RPC 调用参数。

### 计划程序小部件

GridLinks 提供了通过 **计划程序事件** 或 **报告计划** 小部件（属于 **计划** 小部件包的一部分）管理计划程序事件的功能。

![image](/images/user-guide/ui/scheduler-scheduler-events-widget.png)

**计划程序事件** 小部件具有与 [**计划程序事件** 页面](#scheduler-administration) 相同的功能。
此外，它还可以使用自定义计划程序事件类型的预定义表单进行自定义。
这可以通过在小部件配置的 **高级** 选项卡中配置 **自定义事件类型** 列表来实现。

![image](/images/user-guide/ui/scheduler-scheduler-events-widget-custom-types.png)

- **显示名称** - 自定义事件类型的显示名称。
- **类型名称** - 自定义事件的内部名称。
- **显示发起者实体选择** - 是否允许在计划程序事件配置表单中选择发起者。
- **显示消息类型选择** - 是否允许在计划程序事件配置表单中选择消息类型。
- **显示消息元数据表** - 是否在计划程序事件配置表单中显示元数据表。
- **配置 HTML 模板** - 用于生成用于编辑事件配置对象的自定义事件配置表单的 HTML 代码。

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}