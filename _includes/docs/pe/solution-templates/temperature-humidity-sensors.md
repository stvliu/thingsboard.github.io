* TOC
{:toc}

{% include templates/solution-templates.md %}

温度和湿度传感器模板表示适用于多种应用的通用监控解决方案。
使用此模板，您可以获得一个交互式仪表板，能够管理传感器和用户友好的警报配置。

解决方案会自动创建一个客户和两个客户用户。
这些用户将被分配仪表板，并且用户将以全屏模式查看仪表板。

{% include images-gallery.html imageCollection="solution-highlights" %}

### 仪表板

作为此解决方案的一部分，我们创建了“温度和湿度”仪表板，该仪表板显示来自多个传感器的数据。您可以使用仪表板来：

* 添加新传感器；
* 更改传感器的放置位置；
* 配置警报阈值；
* 浏览历史数据。

仪表板有两种状态。主状态显示传感器列表、它们在地图上的位置以及它们的警报列表。
您可以通过单击表格行来向下钻取到传感器详细信息状态。传感器详细信息状态允许浏览温度和湿度历史记录、更改传感器设置和位置。

您始终可以使用仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义“温度和湿度”仪表板。

### 设备

我们已经创建了两个传感器并为它们加载了一些演示数据。有关创建的设备及其凭据的列表，请参阅解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。

解决方案期望传感器设备上传“温度”和“湿度”值。
预期有效负载的最简单示例采用 JSON 格式：

```json
{"temperature":  42, "humidity":  73}
```
{: .copy-code}

您可以在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中找到代表创建的设备发送数据的准确命令。
有关连接真实设备的各种连接选项，请参阅[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

### 警报

警报是使用“温度传感器”[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)中的两个警报规则生成的。
用户可以通过“温度和湿度”仪表板使用“编辑传感器”表单来打开和关闭警报以及配置警报阈值。

{% include images-gallery.html imageCollection="solution-alarms" %}

### 客户

“传感器 C1”被分配给新创建的客户“客户 A”。
您可能会注意到“客户 A”有两个用户，“温度和湿度”仪表板对这些用户可访问。
您可以通过管理 UI 创建更多[客户](/docs/{{docsPrefix}}user-guide/ui/customers/)和更多[用户](/docs/{{docsPrefix}}user-guide/ui/users/)。

### 基于角色的访问控制 (RBAC)

我们为“客户 A”客户创建了两个用户。有关创建的用户及其密码的列表，请参阅解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。
这些用户是“客户管理员”组的成员。因此，他们可以访问客户的所有实体，包括设备“传感器 C1”。
设备“传感器 T1”未分配给“客户 A”。因此，它仅对租户管理员（您）可用。

我们的想法是为多个客户的所有用户提供一个“温度和湿度”仪表板。客户用户应该能够浏览，但不应该能够编辑仪表板。
为了实现这一点，我们创建了“客户仪表板”组，该组使用“只读”角色与客户用户共享。此组包含“温度和湿度”仪表板。
如果您想与相同用户共享更多仪表板，可以将其他仪表板添加到此组。有关更多信息，请参阅[物联网的高级 RBAC](/docs/{{docsPrefix}}user-guide/rbac/)。