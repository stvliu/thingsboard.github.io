Enrichment Nodes 用于更新传入消息的元数据。

* TOC
{:toc}

##### 计算增量

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 3.2.2 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-calculate-delta.png)

根据前一时序读数和当前读数计算“增量”，并将其添加到消息中。
增量计算在消息发起者的范围内完成，例如设备、资产或客户。
对于智能计量用例非常有用。
例如，当水表设备每天报告一次脉冲计数器的绝对值时。
要找出当前日期的消耗量，您需要将前一天的值与当前日期的值进行比较。

增量计算在消息发起者的范围内完成，例如设备、资产或客户。

配置参数：

* 输入值键（默认情况下为“pulseCounter”） - 指定用于计算增量的键。
* 输出值键（默认情况下为“delta”） - 指定将在已丰富消息中存储增量值。
* 小数 - 增量计算的精度。
* 为最新值使用缓存（默认情况下为“启用”） - 启用内存中最新值的缓存。
* 如果增量为负，则告知“失败”（默认情况下为“启用”） - 如果增量值为负，则强制消息处理失败。
* 在消息之间添加周期（默认情况下为“禁用”） - 添加当前消息与前一条消息之间的周期值。

规则节点关系：

规则节点生成具有以下关系之一的消息：

 * 成功 - 如果通过“输入值键”参数配置的键存在于传入消息中；
 * 其他 - 如果通过“输入值键”参数配置的键不存在于传入消息中；
 * 失败 - 如果设置了“如果增量为负，则告知“失败””，并且增量计算返回负值；

让我们通过示例来回顾规则节点行为。假设以下配置：

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-calculate-delta-config.png)

假设由同一设备发起的下一条消息按列出的顺序到达规则节点：

```bash
msg: {"pulseCounter": 42}, metadata: {"ts": "1616510425000"}
msg: {"pulseCounter": 73}, metadata: {"ts": "1616510485000"}
msg: {"temperature": 22}, metadata: {"ts": "1616510486000"}
msg: {"pulseCounter": 42}, metadata: {"ts": "1616510487000"}
```

输出将如下所示：

```bash
msg: {"pulseCounter": 42, "delta": 0, "periodInMs": 0}, metadata: {"ts": "1616510425000"}, relation: Success
msg: {"pulseCounter": 73, "delta": 31, "periodInMs": 60000}, metadata: {"ts": "1616510485000"}, relation: Success
msg: {"temperature": 22}, metadata: {"ts": "1616510486000"}, relation: Other
msg: {"pulseCounter": 42}, metadata: {"ts": "1616510487000"}, relation: Failure
```



##### 客户属性

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-customer-attributes.png)

节点查找消息发起者实体的客户，并将客户属性或最新遥测值添加到消息元数据中。

管理员可以配置原始属性名称和元数据属性名称之间的映射。

节点配置中有一个**最新遥测**复选框。
如果选中此复选框，节点将获取已配置键的最新遥测。否则，节点将获取服务器范围的属性。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-customer-attributes-config.png)

如果存在，出站消息元数据将包含已配置的属性。
要在其他节点中访问已获取的属性，可以使用此模板“<code>metadata.temperature</code>”。

允许以下消息发起者类型：**客户**、**用户**、**资产**、**设备**。

如果找到不受支持的发起者类型，则会引发错误。

如果发起者没有分配客户实体，则使用**失败**链，否则使用**成功**链。

**注意：**自 TB 版本 3.3.3 起，您可以将 `${metadataKey}` 用于来自元数据的值，将 `$[messageKey]` 用于来自消息正文的值。

**示例：**您具有以下元数据 `{"country": "England"}`。
此外，您有一个属性，其键是国家名称，值是首都（`{"England": "London"}`）。

目标是获取元数据中国家属性的首都，并将结果添加到元数据中，键为**“city”**。
为此，您可以将 `${country}` 用作**源属性**，将“city”用作**目标属性**。

结果将是 `{"city": "London"}`。

您可以在以下教程中看到使用此节点的实际示例：

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)

##### 设备属性

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-device-attributes.png)

节点使用已配置的查询查找消息发起者实体的相关设备，并将属性（客户端\共享\服务器范围）和最新遥测值添加到消息元数据中。

属性添加到元数据中，带有范围前缀：

- 共享属性 -> <code>shared_</code>
- 客户端属性 -> <code>cs_</code>
- 服务器属性 -> <code>ss_</code>
- 遥测 -> 不使用前缀

例如，共享属性“version”将以名称“shared_version”添加到元数据中。客户端属性将使用“cs_”前缀。
服务器属性使用“ss_”前缀。最新遥测值按原样添加到消息元数据中，不带前缀。

在“设备关系查询”配置中，管理员可以选择所需的**方向**和**关系深度级别**。
还可以使用所需**设备类型**集配置**关系类型**。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-device-attributes-config.png)

如果找到多个相关实体，**_仅使用第一个实体_**进行属性丰富，其他实体将被丢弃。

如果找不到相关实体，则使用**失败**链，否则使用**成功**链。

如果找不到属性或遥测，则不会将其添加到消息元数据中，并且仍通过**成功**链路由。

如果存在，出站消息元数据将仅包含已配置的属性。

要在其他节点中访问已获取的属性，可以使用此模板“<code>metadata.temperature</code>”。

**注意：**自 TB 版本 2.3.1 起，规则节点能够启用/禁用报告**失败**，如果出站消息中至少一个选定键不存在。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-orignator-and-device-attributes-tell-failure.png)

##### 发起者属性

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-attributes.png)

将消息发起者属性（客户端\共享\服务器范围）和最新遥测值添加到消息元数据中。

属性添加到元数据中，带有范围前缀：

- 共享属性 -> <code>shared_</code>
- 客户端属性 -> <code>cs_</code>
- 服务器属性 -> <code>ss_</code>
- 遥测 -> 不使用前缀

例如，共享属性“version”将以名称“shared_version”添加到元数据中。客户端属性将使用“cs_”前缀。
服务器属性使用“ss_”前缀。最新遥测值按原样添加到消息元数据中，不带前缀。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-attributes-config.png)

如果存在，出站消息元数据将包含已配置的属性。

要在其他节点中访问已获取的属性，可以使用此模板“<code>metadata.cs_temperature</code>”。

**注意：**自 TB 版本 2.3.1 起，规则节点能够启用/禁用报告**失败**，如果出站消息中至少一个选定键不存在。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-orignator-and-device-attributes-tell-failure.png)

您可以在以下教程中看到使用此节点的实际示例：

- [使用上一条记录转换遥测](/docs/user-guide/rule-engine-2-0/tutorials/transform-telemetry-using-previous-record/)
- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)

##### 发起者字段

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0.1 起</em></strong></td>
     </tr>
   </thead>
</table> 


![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-fields.png)

节点获取消息发起者实体的字段值，并将它们添加到消息元数据中。
管理员可以配置字段名称和元数据属性名称之间的映射。
如果指定的字段不是消息发起者实体字段的一部分，它将被忽略。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-fields-config.png)

允许以下消息发起者类型：**租户**、**客户**、**用户**、**资产**、**设备**、**警报**、**规则链**。

如果找到不受支持的发起者类型，则会引发错误。

如果找不到字段值，则不会将其添加到消息元数据中，并且仍通过**成功**链路由。

如果存在，出站消息元数据将仅包含已配置的属性。

要在其他节点中访问已获取的属性，可以使用此模板“<code>metadata.devType</code>”。

##### 相关属性

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-related-attributes.png)

节点使用已配置的查询查找消息发起者实体的相关实体，并将属性或最新遥测值添加到消息元数据中。

管理员可以配置原始属性名称和元数据属性名称之间的映射。

在“关系查询”配置中，管理员可以选择所需的**方向**和**关系深度级别**。
还可以使用所需关系类型和实体类型集配置**关系过滤器**。

节点配置中有一个**最新遥测**复选框。如果选中此复选框，节点将获取已配置键的最新遥测。否则，节点将获取服务器范围的属性。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-related-attributes-config.png)

如果找到多个相关实体，**_仅使用第一个实体_**进行属性丰富，其他实体将被丢弃。

如果找不到相关实体，则使用**失败**链，否则使用**成功**链。

如果存在，出站消息元数据将包含已配置的属性。

要在其他节点中访问已获取的属性，可以使用此模板“<code>metadata.tempo</code>”。

**注意：**自 TB 版本 3.3.3 起，您可以将 `${metadataKey}` 用于来自元数据的值，将 `$[messageKey]` 用于来自消息正文的值。

您可以在**客户属性节点**的说明中看到此功能的示例。

您可以在以下教程中看到使用此节点的实际示例：

- [回复 RPC 调用](/docs/user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial/#add-related-attributes-node)

##### 租户属性

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-tenant-attributes.png)

节点查找消息发起者实体的租户，并将租户属性或最新遥测值添加到消息元数据中。

管理员可以配置原始属性名称和元数据属性名称之间的映射。

节点配置中有一个**最新遥测**复选框。如果选中此复选框，节点将获取已配置键的最新遥测。否则，节点将获取服务器范围的属性。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-tenant-attributes-config.png)

如果存在，出站消息元数据将包含已配置的属性。要在其他节点中访问已获取的属性，可以使用此模板“<code>metadata.tempo</code>”。

允许以下消息发起者类型：**租户**、**客户**、**用户**、**资产**、**设备**、**警报**、**规则链**。

如果找到不受支持的发起者类型，则会引发错误。

如果发起者没有分配租户实体，则使用**失败**链，否则使用**成功**链。

**注意：**自 TB 版本 3.3.3 起，您可以将 `${metadataKey}` 用于来自元数据的值，将 `$[messageKey]` 用于来自消息正文的值。

您可以在**客户属性节点**的说明中看到此功能的示例。

##### 发起者遥测

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-telemetry.png)

将从节点配置中选择的特定时间范围内的消息发起者遥测值添加到消息元数据中。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-telemetry-config.png)

遥测值添加到消息元数据中，不带前缀。

规则节点具有三种获取模式：

 - FIRST：从数据库中检索最接近时间范围开始的遥测

 - LAST：从数据库中检索最接近时间范围结束的遥测

 - ALL：从数据库中检索指定时间范围内的所有遥测。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-telemetry-fetch-mode.png)

如果选择了获取模式**FIRST**或**LAST**，出站消息元数据将包含 JSON 元素（键/值）。

否则，如果选择了获取模式**ALL**，遥测将作为数组获取。

<table  style="width: 60%">
   <thead>
     <tr>
	 <td><strong><em>注意：</em></strong></td>
     </tr>
   </thead>
   <tbody>
     <tr>
	<td>
	<p>规则节点可以将限制大小的记录提取到数组中：1000 条记录</p>
	</td>
     </tr>
   </tbody>
</table>

此数组将包含带有时间戳和值的 JSON 对象。

<table  style="width: 60%">
   <thead>
     <tr>
	 <td><strong><em>注意：</em></strong></td>
     </tr>
   </thead>
   <tbody>
     <tr>
	<td>
	<p>间隔的结束时间必须始终小于间隔的开始时间。</p>
	</td>
     </tr>
   </tbody>
</table>

如果选中复选框：**使用元数据间隔模式**，规则节点将使用元数据中的开始间隔和结束间隔模式。

模式单位以毫秒为单位，自 UNIX 纪元（1970 年 1 月 1 日 00:00:00 UTC）开始。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-telemetry-patterns.png)

 - 如果消息元数据中缺少任何模式，出站消息将通过**失败**链路由。

 - 此外，如果任何模式具有无效的数据类型，出站消息也将通过**失败**链路由。

如果存在，出站消息元数据将包含已配置的遥测字段。

如果找不到属性或遥测，则不会将其添加到消息元数据中，并且仍通过**成功**链路由。

要在其他节点中访问已获取的遥测，可以使用以下模板：`JSON.parse(metadata.temperature)`。

**注意：**自 TB 版本 2.3 起，当选择获取模式：**ALL** 时，规则节点可以选择遥测采样顺序。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-originator-telemetry-order-by.png)

您可以在以下教程中看到使用此节点的实际示例：

- [遥测增量计算](/docs/user-guide/rule-engine-2-0/tutorials/telemetry-delta-validation/)

##### 租户详细信息

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.3.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-tenant-details.png)

规则节点将租户详细信息字段添加到消息正文或元数据中。

节点配置中有一个**将选定的详细信息添加到消息元数据**复选框。如果选中此复选框，现有字段将添加到消息元数据而不是消息数据中。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-tenant-details-config.png)

选定的详细信息以前缀添加到元数据中：**tenant_**。如果存在，出站消息将包含已配置的详细信息。

要在其他节点中访问已获取的详细信息，可以使用以下模板之一：

- `metadata.tenant_address`

- `msg.tenant_address`

如果发起者没有分配租户实体，则使用**失败**链，否则使用**成功**链。

##### 客户详细信息

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.3.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-customer-details.png)

规则节点将客户详细信息字段添加到消息正文或元数据中。

节点配置中有一个**将选定的详细信息添加到消息元数据**复选框。如果选中此复选框，现有字段将添加到消息元数据而不是消息数据中。

![image](/images/user-guide/rule-engine-2-0/nodes/enrichment-customer-details-config.png)

选定的详细信息以前缀添加到元数据中：**customer_**。如果存在，出站消息将包含已配置的详细信息。

要在其他节点中访问已获取的详细信息，可以使用以下模板之一：

- `metadata.customer_email`

- `msg.customer_email`

允许以下消息发起者类型：**资产**、**设备**、**实体视图**。

如果找到不受支持的发起者类型，则会引发错误。

如果发起者没有分配客户实体，则使用**失败**链，否则使用**成功**链。