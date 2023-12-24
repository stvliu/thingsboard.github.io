---
layout: docwithnav
title: 创建设备离线时的警报
description: 使用规则引擎在设备离线一段时间后创建警报。

---


本教程将向您展示如何使用 RuleEngine 在设备离线一段时间后创建警报。

* TOC
{:toc}


## 使用案例

我们假设以下使用案例：

- 您有一个连接到 ThingsBoard 的设备，该设备具有温度传感器来收集和推送遥测数据。

- 温度传感器可能会因任何类型的故障而停止推送遥测数据。


因此，在这种情况下，您需要配置 ThingsBoard 规则引擎以：

- 如果设备在一段时间内保持不活动状态，则创建警报。此时间段可以通过两种方式之一定义：

    - 第一种方法：通过更改不活动超时时间的全局配置参数。<br>
      此参数在 **thingsboard.yml**（state.defaultInactivityTimeoutInSec）中定义，默认设置为 10 秒。

    - 第二种方法：通过设置 **“inactivityTimeout”** 服务器端属性（值以毫秒为单位）来覆盖特定设备的此参数。<br>
      以下部分将介绍这种方法。

- 如果设备变为活动状态，则清除警报。


## 背景
ThingsBoard 设备状态服务负责监视设备连接状态并触发推送到规则引擎的设备连接事件。

ThingsBoard 支持四种类型的事件：
<table style="width: 70%">
  <thead>
      <tr>
          <td><b>事件类型</b></td><td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>连接</td>
          <td>当设备连接到 ThingsBoard 时触发。</td>
      </tr>
      <tr>
          <td>断开连接</td>
          <td>当设备从 ThingsBoard 断开连接时触发。</td>
      </tr>
      <tr>
          <td>活动</td>
          <td>当设备推送遥测、属性更新或 RPC 命令时触发。</td>
      </tr>
      <tr>
          <td>不活动</td>
          <td>当设备在一段时间内不活动时触发。</td>
      </tr>
   </tbody>
</table>

本教程将详细解释设备不活动事件，并将向您展示如何：

- 使用规则引擎创建不活动警报。

- 配置不活动超时的参数。

<br>
<br>

## 添加设备

- 在 ThingsBoard 中添加设备实体。
- 将设备名称输入为 **温度设备**，将设备类型输入为 **温度传感器**：

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/add-device.png)

<br>
<br>

## 配置设备

- 转到 **设备** -> **温度设备** -> **属性** -> **服务器属性**，然后按 **添加** 按钮；

- 设置 **“inactivityTimeout”** 属性，例如，值等于 60000 毫秒。

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/add-attribute.png)

<br>
<br>

## 配置规则链

以下屏幕截图显示了初始根规则链。请注意，不相关的规则节点已从根规则链中删除。

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/initial-chain.png)


默认规则链已通过添加以下两个操作节点进行了修改：

- **创建警报** 节点：通过关系类型 **不活动事件** 连接到 **消息类型开关** 节点；

- **清除警报** 节点：通过关系类型 **活动事件** 连接到 **消息类型开关** 节点。

以下屏幕截图显示了最终规则链应如何显示：

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/chain.png)

- 下载上面指示的规则链的附加 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/tutorial_of_inactivity_event.json) 并导入它。

- 不要忘记将新规则链标记为“根”。

此外，您可以从头开始创建新的规则链。以下部分向您展示如何创建它。

#### 创建新的规则链（**不活动事件教程**）

  - 转到 **规则链** -> **添加新规则链**

 - 将名称字段输入为 **不活动事件教程**，然后单击 **添加** 按钮。

  - 新的规则链已创建。不要忘记将其标记为“根”。

  ![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/add-chain.png)  ![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/root-chain.png)

##### 添加所需节点

在本教程中，您将创建 5 个节点，如下面的部分中所述：

###### **消息类型开关** 节点
添加 **消息类型开关** 节点并将其连接到 **输入** 节点。

此节点将根据消息类型路由传入消息，即：

  - **POST_TELEMETRY_REQUEST**；

  - **POST_ATTRIBUTES_REQUEST**；

  - **ACTIVITY_EVENT**；

  - **INACTIVITY_EVENT**。

将名称字段输入为 **消息类型开关**，然后单击 **添加** 按钮。

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/message-type-switch.png)


###### **保存时序** 节点
添加 **保存时序** 节点并通过关系类型 **发布遥测** 将其连接到 **消息类型开关** 节点。

此节点将把来自传入消息有效负载的时序数据存储到数据库中，并将其链接到由消息发起者标识的设备。

将名称字段输入为 **保存时序**。

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/save-ts.png)

###### **保存服务器属性** 节点
添加 **保存属性** 节点并通过关系类型 **发布属性** 将其连接到 **消息类型开关** 节点。

此节点将把来自传入消息有效负载的属性存储到数据库中，并将其链接到由消息发起者标识的实体。

将名称字段输入为 **保存服务器属性**。

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/save-attributes.png)

###### **创建不活动警报** 节点
添加 **创建警报** 节点并通过关系类型 **不活动事件** 将其连接到 **消息类型开关** 节点。

此节点尝试为消息发起者加载具有配置的警报类型的最新警报。如果存在未清除的警报，则将更新此警报，否则，将创建新警报。


- 将名称字段输入为 **创建不活动警报**，将警报类型输入为 **不活动超时**。


![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/create-alarm.png)


###### **清除不活动警报** 节点
添加 **清除警报** 节点并通过关系类型 **活动事件** 将其连接到 **消息类型开关** 节点。

此节点为消息发起者加载具有配置的警报类型的最新警报，并在存在警报时清除警报。

- 将名称字段输入为 **清除不活动警报**，将警报类型输入为 **不活动超时**。


![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/clear-alarm.png)

<br>

此规则链现已准备就绪，您需要保存它。

<br>
<br>

## 如何验证规则链和发布遥测

- 使用 Rest API，[遥测上传 API](/docs/reference/http-api/#telemetry-upload-api)，发布设备遥测。<br>
  请注意，您需要从设备 **温度设备** 复制设备访问令牌，如下面的屏幕截图所示。

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/access-token.png)


尝试发布温度 = 20。遥测发布后一分钟应创建警报：

{% highlight bash %}
curl -v -X POST -d '{"temperature":20}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

***您需要用实际设备令牌替换 $ACCESS_TOKEN**
{% endhighlight %}


![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/telemetry.png)

![image](/images/user-guide/rule-engine-2-0/tutorials/inactivity alarms/created-alarm.png)

<br>

您还可以：

  - 通过添加警报小部件来配置仪表板以可视化警报。
  
  - 定义警报处理的其他逻辑，例如，发送电子邮件。

请参阅 **另请参阅** 部分下的前两个链接，了解如何执行此操作。

<br>
<br>

## 另请参阅

- [创建和清除警报：配置仪表板](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#configure-device-and-dashboard) 指南 - 了解如何将警报小部件添加到仪表板。

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 指南。

- [设备连接状态](/docs/user-guide/device-connectivity-status/) 指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}