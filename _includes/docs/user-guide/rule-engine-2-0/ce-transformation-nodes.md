转换节点用于更改传入的消息字段，如发起者、消息类型、有效负载和元数据。

* TOC
{:toc}


## 更改发起者

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/transformation-change-originator.png)

Thingsboard 中的所有传入消息都有发起者字段，该字段标识提交消息的实体。
它可以是设备、资产、客户、租户等。

在将提交的消息作为来自另一个实体的消息处理时，使用此节点。
例如，设备提交遥测，遥测应复制到更高级别的资产或客户。
在这种情况下，管理员应在此节点之前添加 [**保存时序**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#save-timeseries-node) 节点。

发起者可以更改为：

- 发起者的客户
- 发起者的租户
- 由关系查询识别的相关实体

在“关系查询”配置中，管理员可以选择所需的 **方向** 和 **关系深度级别**。
还可以使用所需的关联类型和实体类型配置一组 **关联过滤器**。

![image](/images/user-guide/rule-engine-2-0/nodes/transformation-change-originator-config.png)

如果找到多个相关实体，**_仅使用第一个实体作为_** 新发起者，其他实体将被丢弃。

如果没有找到相关实体/客户/租户，则使用 **失败** 链，否则使用 **成功** 链。

出站消息将具有新的发起者 ID。

<br>

## 脚本转换节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/transformation-script.png)

使用配置的 JavaScript 函数更改消息有效负载、元数据或消息类型。

JavaScript 函数接收 3 个输入参数：

- `msg` - 是消息有效负载。
- `metadata` - 是消息元数据。
- `msgType` - 是消息类型。

脚本应返回以下结构：
{% highlight java %}
{   
    msg: new payload,
    metadata: new metadata,
    msgType: new msgType 
}
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/nodes/transformation-script-config.png)

结果对象中的所有字段都是可选的，如果未指定，将从原始消息中获取。

此节点的出站消息将使用配置的 JavaScript 函数构建的新消息。

可以使用 [测试 JavaScript 函数](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#test-script-functions) 验证 JavaScript 转换函数。

<br>
**示例**

节点接收带有 **有效负载** 的消息：
{% highlight java %}
{
    "temperature": 22.4,
    "humidity": 78
}
{% endhighlight %}

原始 **元数据**：
{% highlight java %}
{ "sensorType" : "temperature" }
{% endhighlight %}


原始 **消息类型** - POST_TELEMETRY_REQUEST
<br>

应执行以下修改：

- 将消息类型更改为“CUSTOM_UPDATE”
- 在有效负载中添加附加属性 **_version_**，其值为 **_v1.1_**
- 将元数据中的 **_**sensorType**_** 属性值更改为 **_roomTemp_**

以下转换函数将执行所有必要的修改：
{% highlight java %}
var newType = "CUSTOM_UPDATE";
msg.version = "v1.1";
metadata.sensorType = "roomTemp"
return {msg: msg, metadata: metadata, msgType: newType};
{% endhighlight %}

您可以在以下教程中看到如何使用此节点的真实示例：

- [转换传入遥测](/docs/user-guide/rule-engine-2-0/tutorials/transform-incoming-telemetry/)
- [回复 RPC 调用](/docs/user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial#add-transform-script-node)

## 至电子邮件节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.0 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/nodes/transformation-to-email.png)

通过使用从消息元数据派生的值填充电子邮件字段，将消息转换为电子邮件消息。
设置可以稍后被 [**发送电子邮件节点**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/#send-email-node) 接受的“SEND_EMAIL”输出消息类型。
所有电子邮件字段都可以配置为使用元数据中的值。支持发送 HTML 页面和图像。
  
![image](/images/user-guide/rule-engine-2-0/nodes/transformation-to-email-config.png)

例如，传入消息在元数据中具有 **deviceName** 字段，电子邮件正文应包含其值。

在这种情况下，**deviceName** 的值可以引用为 <code>${deviceName}</code>，如下例所示：

 ```
 设备 ${deviceName} 温度过高
 ```
 
<br>

如果您想发送 html 或图像，您必须在 **邮件正文类型** 字段中选择 **HTML** 或 **动态**。请参阅 [在电子邮件中发送 HTML 或图像](/docs/user-guide/rule-engine-2-0/tutorials/send-email-html)
示例。

此外，如果传入消息元数据包含对存储在数据库中的文件的引用的 **attachments** 字段，此节点可以准备电子邮件附件。
**注意**：这是 [ThingsBoard 专业版](/products/thingsboard-pe/) 支持的 [文件存储](/docs/{{docsPrefix}}user-guide/file-storage/) 功能的一部分。

<br>

您可以在以下教程中看到使用此节点的真实示例：

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)
- [在电子邮件中发送 HTML 或图像](/docs/user-guide/rule-engine-2-0/tutorials/send-email-html)