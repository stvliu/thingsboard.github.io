---
layout: docwithnav
title: 创建和清除警报
description: 创建和清除警报

---

* TOC
{:toc}

## 使用案例

假设您的设备使用 DHT22 传感器收集温度读数并将其推送到 ThingsBoard。
DHT22 传感器适用于 -40 至 80°C 的温度读数。如果温度超出正常范围，我们希望生成警报。

在本教程中，我们将配置 ThingsBoard 规则引擎以

- 如果温度 > 80°C 或温度 < -40°C，则创建或更新现有警报
- 如果温度 > -40°C 且 < 80°C，则清除警报

## 先决条件

我们假设您已完成以下指南并阅读了下面列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 添加设备

在 ThingsBoard 中添加设备实体。其名称为 **Thermostat Home**，其类型为 **Thermostat**。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/add-device.png)

<br>

## 消息流

在本节中，我们将解释本教程中每个节点的目的：

- 节点 A：[**筛选脚本**](/docs/user-guide/rule-engine-2-0/filter-nodes/#check-relation-filter-node) 节点。
  - 此节点带有温度阈值检查脚本将验证：“如果温度在预期间隔内，则脚本将返回 False，否则将返回 True”。
- 节点 B：[**创建警报**](/docs/user-guide/rule-engine-2-0/action-nodes/#create-alarm-node) 节点。
  - 如果发布的温度不在预期时间范围内（筛选脚本节点返回 True），则创建或更新警报。
- 节点 C：[**清除警报**](/docs/user-guide/rule-engine-2-0/action-nodes/#clear-alarm-node) 节点。
  - 如果发布的温度在预期时间范围内（脚本节点返回 False），则清除警报（如果存在）。
- 节点 D：[**规则链**](/docs/user-guide/rule-engine-2-0/flow-nodes/#rule-chain-node) 节点。
  - 将传入消息转发到指定的规则链 **创建和清除警报**。

<br>

## 配置规则链

在本教程中，我们修改了 **根规则链**，还创建了规则链 **创建和清除警报**

<br>以下屏幕截图显示了上述规则链应如何显示：

  - **创建和清除警报：**

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/create-clear-alarm-chain.png)

 - **根规则链：**

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/root-rule-chain.png)

<br>

下载附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/create___clear_alarms.json) 以获取 **创建和清除警报** 规则链。
如上图所示，在根规则链中创建节点 D 以将遥测数据转发到导入的规则链。
<br>
<br>

以下部分向您展示如何从头开始创建此规则链。

#### 创建新的规则链（**创建和清除警报**）

转到 **规则链** -> **添加新的规则链**

配置：

- 名称：**创建和清除警报**

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/add-chain.png)

创建新的规则链。按 **编辑** 按钮并配置链。

###### 添加所需节点

在此规则链中，您将创建 3 个节点，如下文各节所述：

###### 节点 A：**筛选脚本**
- 添加 **筛选脚本** 节点，并通过关系类型 **成功** 将其连接到 **输入** 节点。
 <br>此节点将使用以下脚本验证：“如果温度在预期间隔内”：

   {% highlight javascript %}return msg.temperature < -40 || msg.temperature > 80;{% endhighlight %}

如果温度在预期间隔内，则脚本将返回 False，否则将返回 True。

- 将名称字段输入为 **低于阈值**。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/filter-alarm.png)

###### 节点 B：**创建警报**
- 添加 **创建警报** 节点，并通过关系类型 **True** 将其连接到 **筛选脚本** 节点。 <br>
  此节点加载具有消息发起者的配置警报类型的最新警报，即 **Thermostat Home**<br>如果发布的温度不在预期范围内（筛选脚本节点返回 True）。

 - 将名称字段输入为 **创建警报**，将警报类型输入为 **严重温度**。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/create-alarm.png)

###### 节点 C：**清除警报**
- 添加 **清除警报** 节点，并通过关系类型 **False** 将其连接到 **筛选脚本** 节点。 <br>
  此节点加载具有消息发起者 **Thermostat Home** 的配置警报类型的最新警报<br>如果发布的温度在预期范围内（脚本节点返回 False），则清除警报（如果存在）。

- 将名称字段输入为 **清除警报**，将警报类型输入为 **严重温度**。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/clear-alarm.png)


#### 修改根规则链

以下屏幕截图显示了初始根规则链。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/initial-chain.png)

通过添加以下节点修改了初始规则链：

###### 节点 D：**规则链**
- 添加 **规则链** 节点，并通过关系类型 **True** 将其连接到 **筛选脚本** 节点。 <br>
  此节点将传入消息转发到指定的规则链 **创建和清除警报**。

- 将名称字段输入为 **创建和清除警报**。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/add-chain-node.png)

<br>

以下屏幕截图显示了最终 **根规则链** 应如何显示：

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/root-rule-chain.png)

<br>
<br>

## 如何验证规则链和发布遥测数据

对于发布设备遥测数据，我们将使用 Rest API，[遥测数据上传 API](/docs/reference/http-api/#telemetry-upload-api)。为此，我们需要
从设备 **Thermometer** 复制设备访问令牌。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/access-token.png)

{% highlight bash %}**您需要将 $ACCESS_TOKEN 替换为实际设备令牌**{% endhighlight %}

让我们在清除警报和创建警报节点中按下调试模式按钮以验证结果。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/debug-mode-clear-alarm.png)<br>
![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/debug-mode-create-alarm.png)

发送温度 = 99。应创建警报：

{% highlight bash %}
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/alarm-created.png)

让我们发布温度 = 180。应更新警报：

{% highlight bash %}
curl -v -X POST -d '{"temperature":180}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/alarm-updated.png)

让我们发布温度 = 30。应清除警报：

{% highlight bash %}
curl -v -X POST -d '{"temperature":30}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms v2/alarm-cleared.png)

<br>

您还可以：

  - 在创建和清除警报节点中配置警报详细信息功能。

  - 通过添加警报小部件来配置仪表板以可视化警报。

  - 定义警报处理的其他逻辑，例如发送电子邮件。

请参阅从第二到第四个链接下的 **另请参阅** 部分，了解如何执行此操作。

<br>

## 另请参阅

- [验证传入遥测数据](/docs/user-guide/rule-engine-2-0/tutorials/validate-incoming-telemetry/) 教程 - 有关如何使用脚本筛选器节点验证传入遥测数据的更多信息。

- [创建和清除警报：警报详细信息：](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#modify-the-required-nodes) 指南 - 了解如何在警报节点中配置警报详细信息功能。

- [创建和清除警报：配置仪表板](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#configure-dashboard) 指南 - 了解如何将警报小部件添加到仪表板。

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}