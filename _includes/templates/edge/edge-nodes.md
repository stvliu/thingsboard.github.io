## 推送到云

<table  style="width:12%">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 3.3 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/edge/nodes/push-to-cloud.png)

将消息从边缘推送到云。此节点仅用于边缘，以将消息从边缘推送到云。一旦消息到达此节点，它将被转换为云事件并保存到本地数据库。节点不会将消息直接推送到云，而是将事件存储在云队列中。
支持以下发起者类型：
- 设备
- 资产
- 实体视图
- 仪表板
- 租户
- 客户
- 边缘

此外，节点还支持以下消息类型：
- POST_TELEMETRY_REQUEST
- POST_ATTRIBUTES_REQUEST
- ATTRIBUTES_UPDATED
- ATTRIBUTES_DELETED
- ALARM

如果成功将边缘事件存储到数据库，则消息将通过 **Success** 路由进行路由。

![image](/images/edge/nodes/push-to-cloud-form.png)

在以下情况下，消息将通过 **Failure** 链进行路由：
- 节点无法将边缘事件保存到数据库
- 到达了不受支持的发起者类型
- 到达了不受支持的消息类型

## 推送到边缘

<table  style="width:12%">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 3.3 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/edge/nodes/push-to-edge.png)

将消息从云推送到边缘。消息发起者必须分配给特定边缘，或者消息发起者本身就是 **EDGE** 实体。此节点仅用于云实例，以将消息从云推送到边缘。一旦消息到达此节点，它将被转换为边缘事件并保存到数据库。节点不会将消息直接推送到边缘，而是将事件存储在边缘队列中。
支持以下发起者类型：
- 设备
- 资产
- 实体视图
- 仪表板
- 租户
- 客户
- 边缘

此外，节点还支持以下消息类型：
- POST_TELEMETRY_REQUEST
- POST_ATTRIBUTES_REQUEST
- ATTRIBUTES_UPDATED
- ATTRIBUTES_DELETED
- ALARM

如果成功将边缘事件存储到数据库，则消息将通过 **Success** 路由进行路由。

![image](/images/edge/nodes/push-to-edge-form.png)

在以下情况下，消息将通过 **Failure** 链进行路由：
- 节点无法将边缘事件保存到数据库
- 到达了不受支持的发起者类型
- 到达了不受支持的消息类型