---
layout: docwithnav
title: 报警详细信息处理
description: 创建并清除带有详细信息的报警

---

* TOC
{:toc}

## 使用案例

本教程基于 [创建和清除报警](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#use-case) 教程及其案例。
我们将重用上述教程中的规则链，并在创建和清除报警节点中配置报警详细信息功能。
假设您的设备使用 DHT22 传感器收集并将温度读数推送到 GridLinks。
DHT22 传感器适用于 -40 至 80°C 的温度读数。如果温度超出正常范围，我们希望生成报警。

在本教程中，我们将配置 GridLinks 规则引擎以：

- 统计每个设备的关键温度更新次数，并将此信息保存在报警详细信息中。
- 将最新的关键温度值保存在报警详细信息中。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
  * [创建和清除报警](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 指南。

## 消息流

在本节中，我们将解释本教程中每个节点的用途：

- 节点 A：[**创建报警**](/docs/user-guide/rule-engine-2-0/action-nodes/#create-alarm-node) 节点。
  - 如果发布的温度不在预期的时段范围内（筛选脚本节点返回 True），则创建或更新报警。
- 节点 B：[**清除报警**](/docs/user-guide/rule-engine-2-0/action-nodes/#clear-alarm-node) 节点。
  - 如果发布的温度在预期时段范围内（脚本节点返回 False），则清除报警（如果存在）。
- 节点 C：[**规则链**](/docs/user-guide/rule-engine-2-0/flow-nodes/#rule-chain-node) 节点。
  - 将传入消息转发到指定的规则链 **带有详细信息的创建和清除报警**。

<br>

## 配置规则链

在本教程中，我们仅修改了 **创建和清除报警** 规则链，即在上述 [消息流](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#message-flow) 部分中描述的节点中配置了报警详细信息功能<br>此外，我们将此规则链重命名为 **带有详细信息的创建和清除报警**。

<br>以下屏幕截图显示了上述规则链应如何显示：

  - **带有详细信息的创建和清除报警：**

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/create-clear-alarm-chain.png)

  - **根规则链：**

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/root-rule-chain.png)

<br>

下载附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/create___clear_alarms_with_details.json) 以获取 **带有详细信息的创建和清除报警：** 规则链。
如上图所示，在根规则链中创建节点 **C**，以将遥测数据转发到导入的规则链。
<br>
<br>

以下部分向您展示如何修改此规则链，具体来说是：规则节点 [**A**](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#node-a-create-alarm) 和 [**B**](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#node-b-clear-alarm)。


## 修改 **带有详细信息的创建和清除报警：**

### 修改所需节点

在此规则链中，您将修改 2 个节点，如下面的部分中所述：

#### 节点 A：**创建报警**

如果发布的温度**不在**预期时段范围内（**脚本**节点返回 **True**），我们希望创建报警。
我们希望将当前**温度**添加到报警详细信息字段中。
此外，如果报警已存在，我们希望增加报警详细信息中的**计数**字段，否则将计数设置为 1。

为了实现此目的，我们将覆盖 **详细信息** 功能：

**详细信息** 功能：
{% highlight javascript %}
var details = {};
details.temperature = msg.temperature;

if (metadata.prevAlarmDetails) {
    var prevDetails = JSON.parse(metadata.prevAlarmDetails);
    details.count = prevDetails.count + 1;
} else {
    details.count = 1;
}

return details;
{% endhighlight %}

**详细信息** 功能创建具有初始参数的所需 **详细信息** 对象。然后，在 **if** 语句中，我们验证这是一个新报警还是报警已存在。
如果存在 - 获取先前的 **计数** 字段并增加它。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/create-alarm.png)

如果在 **创建报警** 节点中创建了新报警，则它将通过关系 **已创建** 传递给其他节点（如果存在）。
如果更新了报警 - 它将通过关系 **已更新** 传递给其他节点（如果存在）。

#### 节点 B：**清除报警**

如果发布的温度**在**预期时段范围内（**脚本**节点返回 **False**），我们希望清除现有报警。
此外，在清除期间，我们希望将最新的**温度**添加到现有的报警详细信息中。

为了实现此目的，我们将覆盖 **报警详细信息** 功能：

**报警详细信息** 功能：
{% highlight javascript %}
var details = {};
if (metadata.prevAlarmDetails) {
    details = JSON.parse(metadata.prevAlarmDetails);
}
details.clearedTemperature = msg.temperature;

return details;
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/clear-alarm.png)

如果 **清除报警** 节点找不到现有报警，则不会更改任何内容，并且原始消息将通过关系 **False** 传递给其他节点（如果存在）。
如果报警确实存在 - 它将被清除并通过关系 **已清除** 传递给其他节点。


链配置已完成，我们需要 **保存它**。

<br>

## 配置仪表盘

下载此教程中指示的仪表盘的附加 json [**文件**](/docs/user-guide/resources/thermostat_dashboard.json) 并导入它。

- 转到 **仪表盘** -> **添加新仪表盘** -> **导入仪表盘** 并拖放下载的 json 文件。

您还可以从头开始创建仪表盘，以下部分向您展示如何执行此操作：

## 创建仪表盘

我们将为所有 **恒温器** 设备创建仪表盘并在其上添加报警小部件。创建新仪表盘：

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/add-dashboard.png)

按 **编辑** 仪表盘并 **添加别名**，该别名将解析为类型为 **恒温器** 的所有设备：

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/add-alias.png)

将 **报警小部件** 添加到仪表盘（添加新小部件 -> 报警小部件包 -> 报警）。选择配置的别名 **实体报警源**。
此外，添加其他 **报警字段**。

- details.temperature.
- details.count.
- details.clearedTemperature.

并通过按字段上的 **编辑** 按钮重命名每个字段的标签：

 - 从：-> 到：

   - details.temperature        -> 事件温度。
   - details.count              -> 事件计数。
   - details.clearedTemperature -> 清除温度。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/alarm-widget-config.png)

## 发布遥测数据并验证

为了发布设备遥测数据，我们将使用 Rest API ([链接](/docs/reference/http-api/#telemetry-upload-api/)）。为此，我们需要
从设备 **恒温器主页** 复制设备访问令牌。

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/copy-access-token.png)

***您需要将 $ACCESS_TOKEN 替换为实际设备令牌**

让我们发布温度 = 99。应该创建报警：

{% highlight bash %}
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/alarm-created.png)

让我们发布温度 = 180。应该更新报警并增加计数字段：

{% highlight bash %}
curl -v -X POST -d '{"temperature":180}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/alarm-updated.png)

让我们发布温度 = 30。应该清除报警并显示清除的温度：

{% highlight bash %}
curl -v -X POST -d '{"temperature":30}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/alarms/alarm-cleared.png)

此外，您可以了解如何：

 - 定义报警处理的其他逻辑，例如，发送电子邮件或向 Telegram 应用程序发送通知。

请参阅 **另请参阅** 部分下的链接以了解如何执行此操作。

<br>

## 另请参阅

 - [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 指南。

 - [使用 Telegram 机器人对智能手机上的通知和报警](/docs/iot-gateway/integration-with-telegram-bot/) 指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}