* TOC
{:toc}

## 案例

假设您需要使用 GridLinks 规则引擎实现“计数器”逻辑。
基本上，消息处理在规则节点内异步执行。由于这个事实，在大多数情况下，逻辑“获取当前计数器值 -> 添加新计数器值 -> 保存计数器值”
由于竞争条件问题，导致最终结果不正确（与您的期望不同）。
对于所有处理过多线程编程的人来说，这是一个众所周知的问题。
您可以参考这篇 [文章](https://opensourceforgeeks.blogspot.com/2014/01/race-condition-synchronization-atomic.html)，其中很好地描述了问题和现有的解决方案。
从 ThingsBoard v2.5 开始，可以使用特殊的可配置队列来解决此处理问题。

在本教程中，我们将配置 GridLinks 规则引擎以使用具有按发起者顺序消息提交策略的队列。
尽管此场景是虚构的，但您将学习如何使用队列以顺序处理消息
并在实际应用程序中使用此知识。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  
此外，您还需要在您的环境中至少预配一个设备。

## 步骤 1：创建规则链

![image](/images/user-guide/rule-engine-2-5/tutorials/sync_rule_chain.png)

我们将添加两个生成器节点，每个节点将生成七条消息。第一个生成器将生成一条计数器值为 101 的消息。
第二个 - 值为 10。因此结果应该是 777。

![image](/images/user-guide/rule-engine-2-5/tutorials/generator1.png)
![image](/images/user-guide/rule-engine-2-5/tutorials/generator2.png)

两条消息都将放入名称为 **“SequentialByOriginator”** 的队列中。它使用称为 **“SEQUENTIAL_WITHIN_ORIGINATOR”** 的消息提交策略
{% unless docsPrefix == "paas/" %}(有关更多详细信息，请参阅 [**配置指南**](/docs/user-guide/install/{{docsPrefix}}config/)){% endunless %}，这意味着
后续消息将在前一条消息基于发起者被确认（已处理并从队列中删除）时开始处理。

![image](/images/user-guide/rule-engine-2-5/tutorials/checkpoint.png)

我们将使用 **“发起者属性”** 节点获取当前“计数器”值。
![image](/images/user-guide/rule-engine-2-5/tutorials/sync_originator_attributes.png)

计算将使用 **“计数器脚本”** 节点完成。

![image](/images/user-guide/rule-engine-2-5/tutorials/sync_counter_script.png)

最后一步是使用 **“保存属性”** 节点保存新的计数器值。

## 步骤 2：验证规则链逻辑

让我们通过保存规则链来检查我们的逻辑是否正确。生成器将自动生成 14 条消息：

![image](/images/user-guide/rule-engine-2-5/tutorials/sync_events.png)

为设备保留的最终计数器值为：

![image](/images/user-guide/rule-engine-2-5/tutorials/sync_result.png)

这意味着我们的逻辑工作正常。

## 摘要

下载并导入附加的 json [**文件**](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/resources/synchronization_rule_chain.json) 与本教程中的规则链。
别忘了用您的特定设备填充生成器节点。
 
## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}