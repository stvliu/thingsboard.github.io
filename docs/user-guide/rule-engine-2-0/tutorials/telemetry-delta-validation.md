---
layout: docwithnav
title: 遥测增量计算
description: 增量验证
---

* TOC
{:toc}

## 使用案例

假设我们有一个设备，它使用温度传感器来收集和读取 GridLinks 中的温度读数。
此外，假设我们需要在最近五分钟的温度读数与最新温度读数之间的增量超过 5 度时生成警报。
请注意，这只是一个简单的理论案例，用于演示平台的功能。您可以将本教程作为更复杂场景的基础。

## 前提条件

我们假设您已完成以下指南并阅读了下面列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
  * [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 指南。

## 添加设备

在 GridLinks 中添加设备实体。它的名称是 **Thermometer**，类型是 **temperature sensor**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/add-thermometer.png)

<br>

## 消息流

在本节中，我们将解释本教程中每个节点的目的。将涉及两个规则链：

  - **根规则链** - 实际上将设备遥测数据保存到数据库中的规则链，并将消息重定向到 **温度增量验证** 链

  - **温度增量验证** - 实际上计算最近五分钟温度与最新温度读数之间的增量的规则链。
    <br> 因此，如果增量值超过 5 度，则将创建/更新警报，否则将清除警报。

以下屏幕截图显示了上述规则链应如何显示：

  - **温度增量验证：**

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/temperature-delta-validation-chain.png)

 - **根规则链：**

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/root-rule-chain.png)

<br>

下载附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/temperature_delta_validation.json) 以获取 **温度增量验证** 规则链。

如上图所示，在根规则链中创建节点 G 以将遥测数据转发到导入的规则链。
<br>
<br>

以下部分向您展示如何从头开始创建此规则链。

#### 创建新规则链（**温度增量验证**）

转到 **规则链** -> **添加新规则链**

配置：

- 名称：**温度增量验证**

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/add-temperature-delta-validation-chain.png)

创建新规则链。按 **编辑** 按钮并配置链。

###### 添加所需节点

在此规则链中，您将创建 6 个节点，如下文各节所述：

###### 节点 A：**原始遥测数据**
- 添加 **原始遥测数据** 节点，并通过关系类型 **成功** 将其连接到 **输入** 节点。
  此规则节点将所选消息发起者的选定遥测数据添加到消息元数据中，以获取所选时间范围。

规则节点有三种获取模式：

 - **FIRST**：从数据库中检索最接近时间范围开始的遥测数据

 - **LAST**：从数据库中检索最接近时间范围结束的遥测数据

 - **ALL**：从数据库中检索指定时间范围内的所有遥测数据。

我们将使用获取模式：**LAST**，时间范围从 24 小时前到 5 分钟。

 - 将名称字段输入为 **最近五分钟的旧记录**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/latest-five-minute-old-record.png)

###### 获取模式 ALL

原始遥测数据节点还支持从特定时间范围获取所有遥测数据的能力。
我们不会在本教程中使用此功能，但如果您需要计算特定键的差异或根据所选时间范围内的遥测数据变化预测遥测数据的进一步变化，则它可能很有用。

在这种情况下，您需要选择获取模式 **ALL**。它将强制规则节点从指定的时间范围内获取所有遥测数据，并将其作为数组添加到消息元数据中。
此数组将包含带有时间戳和值的 JSON 对象。

 - 出站消息的元数据将是具有以下结构的 JSON 文档：

  {% highlight javascript %}
  {
    "temperature": "[{\"ts\":1540892498884,\"value\":22.4},{\"ts\":1540892528847,\"value\":20.45},{\"ts\":1540892558845,\"value\":22.3}]"
  }{% endhighlight %}

  - 为了将数组转换为有效的 JSON 文档，您可以使用以下函数：

  {% highlight javascript %}
  var temperatureArray = JSON.parse(metadata.temperature);{% endhighlight %}

  - 温度数组将如下所示：

  {% highlight javascript %}
  {
      "temperatureArray": [{
          "ts": 1540892498884,
          "value": 22.4
      }, {
          "ts": 1540892528847,
          "value": 20.45
      }, {
          "ts": 1540892558845,
          "value": 22.3
      }]
  }{% endhighlight %}


###### 节点 B：**脚本转换**
 - 添加 **脚本转换** 节点，并通过关系类型 **成功** 将其连接到 **更改发起者** 节点。

此节点将使用以下脚本计算消息有效负载中的温度读数与消息元数据中的五分钟前温度读数之间的增量：

   {% highlight javascript %}
   var newMsg = {};

   newMsg.deltaTemperature = parseFloat(Math.abs(msg.temperature - JSON.parse(metadata.temperature)).toFixed(2));

   return {msg: newMsg, metadata: metadata, msgType: msgType};{% endhighlight %}

 - 将名称字段输入为 **计算增量**。

 ![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/calculate-delta.png)

###### 节点 C：**保存时序**
 - 添加 **保存时序** 节点，并通过关系类型 **成功** 将其连接到 **脚本转换** 节点。
   此节点将从传入消息有效负载中保存时序数据到数据库，并将其链接到被识别为消息发起者的设备。

 - 将名称字段输入为 **保存时序**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/save-timeseries.png)

###### 节点 D：**筛选脚本**
 - 添加 **筛选脚本** 节点，并通过关系类型 **成功** 将其连接到 **保存时序** 节点。
 <br>此节点将验证最新温度读数与五分钟前温度读数之间计算的增量值是否没有超过 5 度，方法是使用以下脚本：

   {% highlight javascript %}
   return msg.deltaTemperature > 5;{% endhighlight %}

 - 将名称字段输入为 **验证增量**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/validate-delta.png)


###### 节点 E：**创建警报**
 - 添加 **创建警报** 节点，并通过关系类型 **真** 将其连接到 **筛选脚本** 节点。 <br>
  此节点加载具有消息发起者配置警报类型的最新警报，即 **Thermometer**<br>，如果发布的增量温度不在预期范围内（筛选脚本节点返回真）。

 - 将名称字段输入为 **创建警报**，将警报类型输入为 **常规警报**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/create-alarm.png)

###### 节点 F：**清除警报**
 - 添加 **清除警报** 节点，并通过关系类型 **假** 将其连接到 **筛选脚本** 节点。 <br>
  此节点加载具有消息发起者 **Thermometer** 配置警报类型的最新警报<br>，如果发布的温度增量在预期范围内（脚本节点返回假），则清除警报。

 - 将名称字段输入为 **清除警报**，将警报类型输入为 **常规警报**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/clear-alarm.png)

#### 修改根规则链

通过添加以下节点修改了初始根规则链：

###### 节点 G：**规则链**
- 添加 **规则链** 节点，并通过关系类型 **成功** 将其连接到 **保存时序** 节点。 <br>
  此节点将传入消息转发到指定的规则链 **温度增量验证**。

- 选择规则链字段：**温度增量验证**。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/add-rule-chain-node.png)

<br>

以下屏幕截图显示了最终的 **根规则链** 应如何显示：

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/root-rule-chain.png)

- 下载附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/root_rule_chain_delta_calculation.json) 以获取上面指示的规则链并导入它。
- 不要忘记将新规则链标记为 **根**。  

<br>
<br>

## 如何验证规则链和发布遥测数据

对于发布设备遥测数据，我们将使用 Rest API，[遥测数据上传 API](/docs/reference/http-api/#telemetry-upload-api)。为此，我们需要
从设备 **Thermometer** 复制设备访问令牌。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/access-token.png)

{% highlight bash %}**您需要将 $ACCESS_TOKEN 替换为实际设备令牌**{% endhighlight %}

为了验证规则链按预期工作，我们需要为同一设备发布遥测数据两次，间隔时间不小于 5 分钟，不大于 24 小时。
<br>此外，让我们在 **创建警报** 节点中按下调试模式按钮，以验证在第二次发布遥测数据请求后将创建警报。

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/debug-mode-create-alarm.png)<br>

发送温度 = 20。

{% highlight bash %}
curl -v -X POST -d '{"temperature":20}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/first-post-telemetry.png)

延迟 5 分钟后，让我们发送例如温度 = 26

{% highlight bash %}
curl -v -X POST -d '{"temperature":26}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
{% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/second-post-telemetry.png)

应创建警报：

![image](/images/user-guide/rule-engine-2-0/tutorials/delta-validation/alarm-created.png)

<br>

您还可以：

  - 在创建和清除警报节点中配置警报详细信息函数。

  - 通过添加警报小部件来配置仪表板，以可视化警报。

  - 定义警报处理的其他逻辑，例如发送电子邮件。

请参阅 **另请参阅** 部分下的第二到第四个链接，了解如何执行此操作。

<br>

## 另请参阅

- [验证传入遥测数据](/docs/user-guide/rule-engine-2-0/tutorials/validate-incoming-telemetry/) 教程 - 有关如何使用脚本筛选器节点验证传入遥测数据的更多信息。

- [创建和清除警报：警报详细信息：](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#modify-the-required-nodes) 指南 - 了解如何在警报节点中配置警报详细信息函数。

- [创建和清除警报：配置仪表板](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#configure-dashboard) 指南 - 了解如何将警报小部件添加到仪表板。

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}