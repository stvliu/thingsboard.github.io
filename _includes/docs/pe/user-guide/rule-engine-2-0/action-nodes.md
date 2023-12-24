{% include docs/user-guide/rule-engine-2-0/ce-action-nodes.md %}

{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

## 添加到组节点

{% assign feature = "PE 操作节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0.2 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-add-to-group.png)

将消息发起者实体添加到 [实体组](/docs/{{peDocsPrefix}}user-guide/groups/)。

允许以下消息发起者类型：**客户**、**资产**、**设备**。

按组名模式查找目标实体组，然后将发起者实体添加到此组。
如果实体组不存在且 **如果不存在则创建新组** 设置为 true，则将创建新的实体组。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-add-to-group-config.png)

- **组名模式** - 可以设置直接组名，也可以使用模式，该模式将使用消息元数据解析为实际组名。
- **如果不存在则创建新组** - 如果选中，则在实体组不存在时创建新的实体组。
- **组缓存过期时间** - 指定允许存储已找到的实体组记录的最大时间间隔（以秒为单位）。0 值表示记录永不过期。

在以下情况下，消息将通过 **失败** 链路路由：

- 当发起者实体类型不受支持时。
- 目标实体组不存在且 **如果不存在则创建新组** 未选中。

在其他情况下，消息将通过 **成功** 链路路由。

<br>

## 从组中移除节点

{% assign feature = "PE 操作节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0.2 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-remove-from-group.png)

从 [实体组](/docs/{{peDocsPrefix}}user-guide/groups/)中移除消息发起者实体。

允许以下消息发起者类型：**客户**、**资产**、**设备**。

按组名模式查找目标实体组，然后从此组中移除发起者实体。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-remove-from-group-config.png)

- **组名模式** - 可以设置直接组名，也可以使用模式，该模式将使用消息元数据解析为实际组名。
- **组缓存过期时间** - 指定允许存储已找到的实体组记录的最大时间间隔（以秒为单位）。0 值表示记录永不过期。

在以下情况下，消息将通过 **失败** 链路路由：

- 当发起者实体类型不受支持时。
- 目标实体组不存在。

在其他情况下，消息将通过 **成功** 链路路由。

<br>

## 生成报告节点

{% assign feature = "PE 操作节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-generate-report.png)

通过捕获具有特定配置的目标仪表板来生成报告文件。

可以将此节点配置为使用特定的报告配置或从传入的消息正文中获取报告配置。

通常在消息由 [**生成报告** 调度程序事件](/docs/{{peDocsPrefix}}user-guide/scheduler/#generate-report) 生成时使用从消息正文获取报告配置的模式。

生成报告节点调用 [报告服务器](/docs/{{peDocsPrefix}}user-guide/reporting/#reports-server) 以使用指定的仪表板生成报告文件。

生成的报告文件使用 [文件存储](/docs/{{peDocsPrefix}}user-guide/file-storage/) 功能存储在数据库中，对该文件的引用存储在输出消息元数据的 **attachments** 字段中。

其他规则节点可以使用 **attachments** 元数据字段从数据库获取实际文件。
例如，[**发送至电子邮件节点**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/transformation-nodes/#to-email-node) 检测此字段的存在并准备电子邮件附件，[**发送电子邮件节点**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/#send-email-node) 使用这些附件发送带有附件的电子邮件。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-generate-report-config.png)

- **使用系统报告服务器** - 如果设置，[报告服务器](/docs/{{peDocsPrefix}}user-guide/reporting/#reports-server) 端点 URL 将从系统配置（**thingsboard.yml**）获取。
- **报告服务器端点 URL** - [报告服务器](/docs/{{peDocsPrefix}}user-guide/reporting/#reports-server) 的端点 URL。
- **从消息中使用报告配置** - 如果设置，报告生成配置将从传入的消息正文中获取。
- **基本 URL** - ThingsBoard UI 的基本 URL，报告服务器应可访问该 URL。
- **仪表板** - 将用于生成报告的仪表板。
- **仪表板状态参数值** - 用于指定报告生成的仪表板目标状态。可以通过单击字段最右侧的按钮并调用 **选择仪表板状态** 对话框自动设置。
- **时区** - 目标仪表板将在报告中显示的时区。
- **使用仪表板时间窗口** - 如果设置，报告生成期间将使用目标仪表板中配置的时间窗口。
- **时间窗口** - 报告生成期间将使用的特定仪表板时间窗口。
- **报告名称模式** - 生成的报告的文件名模式，可以包含 `%d{date-time pattern}` 形式的日期时间模式。有关日期时间模式的详细信息，请参阅 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 文档。
- **报告类型** - 报告文件类型，可以是 *PDF \| PNG \| JPEG*。
- **使用当前用户凭据** - 如果设置，将使用创建此报告配置的用户凭据在报告生成期间打开仪表板 UI。
- **客户用户凭据** - 目标客户用户，其凭据将在报告生成期间用于打开仪表板 UI。

**生成测试报告** 按钮用于测试目的。它使用提供的配置调用报告生成过程。如果报告生成成功，生成的报告文件将自动下载。

在以下情况下，消息将通过 **失败** 链路路由：

- 当设置 **从消息中使用报告配置** 且传入消息不包含有效的报告配置 JSON 对象时。
- 当 [报告服务器](/docs/{{peDocsPrefix}}user-guide/reporting/#reports-server) 在指定的端点 URL 处不可用时。
- 当 [报告服务器](/docs/{{peDocsPrefix}}user-guide/reporting/#reports-server) 无法生成报告并返回相应的错误消息时。

在其他情况下，消息将通过 **成功** 链路路由。

<br>

## 集成下行链路节点

{% assign feature = "PE 操作节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0.2 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-integration-downlink.png)

将消息转发到选定的 [集成](/docs/{{peDocsPrefix}}user-guide/integrations/) 作为下行链路消息。

消息将推送到选定的集成下行链路队列。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-integration-downlink-config.png)

- **集成** - 用于下行链路消息处理的目标集成。

如果消息推送到集成失败，则使用 **失败** 链路，否则使用 **成功** 链路。

<br>

## REST 调用回复节点

{% assign feature = "PE 操作节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-rest-call-reply.png)

向最初发送到规则引擎的 REST API 调用发送回复。

期望具有任何消息类型的消息。将传入消息作为回复转发到发送到规则引擎的 REST API 调用。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-rest-call-reply-config.png)

<br>

## 更改所有者节点

{% assign feature = "PE 操作节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.3.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-change-owner-node.png)

将发起者实体的所有者更改为按类型选定的所有者：

- 租户

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-change-owner-node-tenent-config.png)

- 客户

![image](/images/user-guide/rule-engine-2-0/pe/nodes/action-change-owner-node-customer-config.png)

规则节点按所有者名称模式查找目标所有者，然后更改发起者实体的所有者。

- **所有者名称模式** - 可以设置直接客户名称，也可以使用模式，该模式将使用消息元数据解析为实际客户名称。
- **如果不存在则创建新所有者** - 如果选中，如果不存在，将创建新所有者（客户）。
- **所有者缓存过期时间** - 指定允许存储找到的所有者（客户）记录的最大时间间隔（以秒为单位）。0 值表示记录永不过期。

如果实体已经属于此所有者或实体所有者已成功更改 - 通过 **成功** 链路发送消息，否则，将使用 **失败** 链路。

<br>