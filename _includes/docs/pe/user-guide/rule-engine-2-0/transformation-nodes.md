{% include docs/user-guide/rule-engine-2-0/ce-transformation-nodes.md %}

{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

## 复制到组节点

{% assign feature = "PE 转换节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/transformation-duplicate-to-group.png)

将消息复制到属于特定 [实体组](/docs/{{peDocsPrefix}}user-guide/groups/) 的所有实体。

根据配置检测到的实体组获取实体。

可以指定实体组，也可以指定消息发起者实体本身。

对于组中的每个实体，都会创建一个新消息，其中实体作为发起者，消息参数从原始消息复制。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/transformation-duplicate-to-group-config.png)

- **实体组是消息发起者** - 如果设置，则消息发起者将被视为用于获取实体的实体组。
  在这种情况下，如果消息发起者类型不是实体组，则传入消息将通过 **失败** 链路路由。
- **目标实体组** - 用于获取实体的特定目标实体组。

如果成功检测到目标实体组并且其中至少包含一个实体，则新消息将复制到组实体并通过 **成功** 链路转发。
否则，原始消息将通过 **失败** 链路转发。

<br>

## 复制到相关节点

{% assign feature = "PE 转换节点" %}{% include templates/pe-feature-banner.md %}

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/transformation-duplicate-to-related.png)

将消息复制到通过关系查询获取的相关实体。

使用配置的关系方向和关系类型找到相关实体。

对于每个找到的相关实体，都会创建一个新消息，其中相关实体作为发起者，消息参数从原始消息复制。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/transformation-duplicate-to-related-config.png)

- **关系查询** - 用于从传入消息发起者开始查找新实体的查询。
  在“关系查询”配置中，管理员可以选择所需的 **方向** 和 **关系深度级别**。还可以使用所需的关系类型和实体类型配置一组 **关系过滤器**。

如果使用关系查询至少找到一个实体，则新消息将复制到找到的实体并通过 **成功** 链路转发。
否则，原始消息将通过 **失败** 链路转发。

<br>