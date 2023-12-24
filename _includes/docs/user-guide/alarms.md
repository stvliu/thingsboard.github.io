* TOC
{:toc}

GridLinks 提供创建和管理与实体（设备、资产、客户等）相关的警报的功能。
例如，您可以将 GridLinks 配置为在温度传感器读数高于某个阈值时自动创建警报。
当然，这是一个非常简单的案例，而实际场景可能要复杂得多。


## 主要概念

我们来回顾一下以下警报的主要概念：

##### 触发器

警报触发器是导致警报的实体。
例如，如果 GridLinks 从设备 A 收到温度读数，并因读数超过阈值而引发“高温”警报，则设备 A 是警报的触发器。

##### 类型

警报类型有助于识别警报的根本原因。例如，“高温”和“低湿度”是两个不同的警报。

##### 严重性

每个警报都有严重性，包括严重、主要、次要、警告或不确定（按优先级降序排列）。

##### 生命周期

警报可以处于活动状态或已清除状态。当 GridLinks 创建警报时，它会保留警报的**开始**和**结束时间**。默认情况下，开始时间和结束时间相同。
如果警报触发条件重复，平台会更新结束时间。当发生与警报清除条件匹配的事件时，GridLinks 可以自动清除警报。
警报清除条件是可选的。用户可以手动清除警报。

除了活动和已清除警报状态外，GridLinks 还会跟踪是否有人确认警报。
可以通过仪表板小部件或实体详细信息选项卡确认警报。

总之，“**状态**”字段有 4 个可能的值：

* 活动未确认 (ACTIVE_UNACK) - 警报尚未清除且尚未确认；
* 活动已确认 (ACTIVE_ACK) - 警报尚未清除，但已确认；
* 已清除未确认 (CLEARED_UNACK) - 警报已清除，但尚未确认；
* 已清除已确认 (CLEARED_ACK) - 警报已清除并确认；

##### 警报唯一性

GridLinks 使用触发器、类型和开始时间的组合来识别警报。
因此，在某个时间点，只有一个具有相同触发器、类型和开始时间的活动警报。

假设您已配置警报规则，以便在温度高于 20 时创建“高温”警报。
您还配置了警报规则，以便在温度小于或等于 20 时清除“高温”警报。

假设以下事件序列：

* 12:00 - 温度等于 18
* 12:30 - 温度等于 22
* 13:00 - 温度等于 25
* 13:30 - 温度等于 18

因此，您应该创建一个开始时间 = 12:30 和结束时间 = 13:00 的“高温”警报。

##### 传播

假设您有一个拓扑，其中一个租户有 1000 个客户，每个客户有 1000 个设备。
因此，您的服务器安装中有 100 万个设备。
您可能希望设计一个仪表板，在租户和客户级别显示所有活动警报。
为了简化数据库查询并缩短加载时间，GridLinks 支持警报传播。
创建警报时，我们可以指定是否应该对父实体可见。
我们还可以选择性地指定父实体与触发器之间应该存在的关系，以便警报传播。

现在，当您了解了理论知识，我们就可以继续进行实际教程了。

## 警报常见问题解答和操作方法

### 如何创建警报？

**最简单的方法**是使用 [**警报规则**](/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules)。

另一种选择是在 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 中配置自定义逻辑，并使用
[创建警报](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#create-alarm-node) 和 [清除警报](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#clear-alarm-node) 规则节点。
您可以在 [此处](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 找到相应的示例。

### 如何查找特定设备或资产的警报？

要查找特定设备或资产的警报，您应该：
* 打开资产或设备列表；
* 选择所需的实体；
* 导航到“警报”选项卡；
* 选择警报状态和时间间隔。

{% include images-gallery.html imageCollection="entityAlarms" %}

### 如何将警报分配给用户？

要将警报分配给用户，请导航到警报选项卡，然后在“受让人”列中选择用户。

{% include images-gallery.html imageCollection="alarmAssignee" %}

### 如何查找警报评论并添加您自己的评论？

打开警报详细信息以查找特定警报的评论。

{% include images-gallery.html imageCollection="alarmComments" %}

“评论”部分中有两种类型的评论：用户评论和系统评论。
任何授权用户都可以添加、编辑和删除用户评论。系统评论是不可编辑的灰色评论，用于描述警报事件，例如严重性更改、警报受让人等。

### 如何在仪表板上可视化警报？

请参阅此 [文档](/docs/{{docsPrefix}}getting-started-guides/helloworld/#step-35-add-alarm-widget) 将警报小部件添加到仪表板。

您还可以探索数据源设置和小部件的高级设置。

数据源设置允许您：

* 使用任何 ack/unack/active/clear 组合指定状态过滤器；
* 使用任何严重性级别组合指定严重性过滤器；
* 指定警报类型列表；
* 启用或禁用传播警报的搜索（默认情况下禁用）。

{% include images-gallery.html imageCollection="alarmWidgetDataSettings" %}

### 如何在创建或清除警报时发送通知？

要在创建或清除警报时发送通知，请查看此 [文档](/docs/{{docsPrefix}}user-guide/device-profiles/#notifications-about-alarms)。

### 如何使用 REST API 查询警报？

GridLinks 提供 REST API 来管理和查询警报。有关更多详细信息，请参阅演示环境 [警报 REST API](https://gridlinks.codingas.com/swagger-ui.html#/alarm-controller) 和通用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档。