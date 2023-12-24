流程节点用于控制消息处理流程。

* TOC
{:toc}

##### 确认节点

该节点将把消息标记为已成功处理（已确认）。有关更多详细信息，请参阅[消息处理结果](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#message-processing-result)。
这向规则引擎指示消息已成功处理。

如果您不想重新处理失败的消息，这很有用。
例如，下面的规则链将仅对重要消息重新处理失败的消息。
不重要的消息的失败将被简单地忽略。

![image](/images/user-guide/rule-engine-2-0/nodes/acknowledge-failed.png)

**注意：**我们建议将“确认”规则节点作为处理链中的最后一个节点。
从理论上讲，您可以在“确认”节点之后添加其他规则节点。但是，这可能会导致 OOM 错误。
例如，后续规则节点可能会缓慢处理消息。未处理的消息将存储在内存中，并将消耗过多的 RAM

##### 检查点节点

将消息的副本发布到选定的[规则引擎队列](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。
一旦目标队列确认已发布复制的消息，原始消息将被标记为已成功处理。

如果您想将消息标记为高优先级或按消息的发送者对消息进行顺序分组，这很有用。
请参阅[默认队列](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#default-queues)或定义您自己的[队列](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。

##### 规则链节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 3.3.3 起</em></strong></td>
     </tr>
   </thead>
</table> 

将消息转发到选定的[规则链](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain)。
自 TB 版本 3.3.3 起，目标规则链还可以使用[输出节点](#output-node)输出处理结果。
输出节点支持规则链的重用，并将处理逻辑提取到模块（规则链）中。

例如，您可以创建一个验证传入消息的规则链，并分别处理有效和无效的消息。

![image](/images/user-guide/rule-engine-2-0/nodes/rule-chain-node-main.png)

消息验证的逻辑可以在其他规则链中重用。为此，我们将其提取到一个单独的规则链中。

![image](/images/user-guide/rule-engine-2-0/nodes/rule-chain-node-inner.png)

注意我们在验证规则链中使用的“输出”节点。
输出节点的名称应与主规则链中“规则链节点”的传出[关系](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection)相匹配。

##### 输出节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 3.3.3 起</em></strong></td>
     </tr>
   </thead>
</table> 

与[规则链节点](#rule-chain-node)结合使用。允许将消息处理结果发布到调用者规则链。
输出规则节点名称对应于输出消息的[关系](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-connection)类型，
它用于将消息转发到调用者规则链中的其他规则节点。
请参阅[规则链节点](#rule-chain-node)文档以获取示例。