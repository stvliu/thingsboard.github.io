---
layout: docwithnav
title: 向客户发送电子邮件
description: 发送电子邮件工作流

---

本教程将向您展示如何使用规则引擎向客户发送电子邮件。

* TOC
{:toc}

{% capture difference %}
**注意：**本教程基于 [报警时发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/#use-case) 教程及其用例。我们将重用上述教程中的规则链，并将添加更多规则节点以向分配设备的客户发送电子邮件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 用例

假设您的设备使用 DHT22 传感器收集并将温度读数推送到 ThingsBoard。
DHT22 传感器适用于 -40 至 80°C 的温度读数。如果温度超出正常范围，我们希望生成警报并在创建警报时发送电子邮件。

在本教程中，我们将配置 ThingsBoard 规则引擎以：

- 如果温度超出范围（即低于 -40 度和高于 80 度），则向分配设备的客户发送电子邮件。

- 将消息发起者属性添加到消息中。

- 使用来自传入消息的脚本转换节点将其他数据添加到电子邮件正文中。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
  * [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 指南。
  * [报警时发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 指南。

## 创建客户并分配设备

首先，我们需要创建客户并将设备分配给客户。以下屏幕截图向您展示如何执行此操作：

![image](/images/user-guide/rule-engine-2-0/tutorials/email/create-customer.png)

<br>

客户已创建。现在我们需要将设备 **Thermostat Home**（其创建过程在 [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#adding-the-device) 教程中进行了说明）分配给客户。<br>转到客户页面上的 **管理设备** 并选择我们的设备

![image](/images/user-guide/rule-engine-2-0/tutorials/email/manage-devices.png)
<br>

![image](/images/user-guide/rule-engine-2-0/tutorials/email/assign-device.png)
<br>

接下来，我们的客户应具有 **服务器范围** 属性 **电子邮件**。请注意，电子邮件将发送到此电子邮件，因此请写下您的电子邮件以进行测试。

![image](/images/user-guide/rule-engine-2-0/tutorials/email/customer-email.png)

<br>

我们还需要向我们的设备 **Thermostat Home** 添加服务器范围属性 - **地址**：
<br>

转到 **设备** -> **Thermostat Home** -> **属性** -> **服务器属性**，然后按 **+** 按钮添加 **地址**

![image](/images/user-guide/rule-engine-2-0/tutorials/email/add-address.png)

<br>

## 消息流

在本节中，我们将解释本教程中添加到初始规则链或修改的每个节点的用途：

- 节点 A：[**客户属性**](/docs/user-guide/rule-engine-2-0/enrichment-nodes/#customer-attributes) 节点。
  - 此节点将用于获取客户的电子邮件属性并将其保存在消息元数据属性 customerEmail 中
- 节点 B：[**发起者属性**](/docs/user-guide/rule-engine-2-0/enrichment-nodes/#originator-attributes) 节点。
  - 此节点将用于获取发起者的地址服务器范围属性（设备是传入消息的发起者）并将其保存在消息元数据中。
- 节点 C：[**发送电子邮件**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#to-email-node) 节点。
  - 此节点从配置的模板构建实际电子邮件。
- 节点 D：[**规则链**](/docs/user-guide/rule-engine-2-0/flow-nodes/#rule-chain-node) 节点。
  - 将传入消息转发到指定的规则链 **创建/清除警报并向客户发送电子邮件**。

<br>

## 配置规则链

在本教程中，我们使用了 [报警时发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程中的规则链。
我们通过添加上面 [消息流](/docs/user-guide/rule-engine-2-0/tutorials/send-email-to-customer/#message-flow) 部分中描述的节点来修改规则链 **创建/清除警报并向客户发送电子邮件**<br>
并将此规则链重命名为：**创建/清除警报并向客户发送电子邮件**。

<br>以下屏幕截图显示了上述规则链应如何显示：

  - **创建/清除警报并向客户发送电子邮件：**

![image](/images/user-guide/rule-engine-2-0/tutorials/email/send-email-to-customer-chain.png)

 - **根规则链：**

![image](/images/user-guide/rule-engine-2-0/tutorials/email/root-rule-chain.png)

<br>

下载附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/create_clear_alarm___send_email_to_customer.json) 以获取 **创建/清除警报并向客户发送电子邮件：** 规则链。
如上图所示，在根规则链中创建节点 **D** 以将遥测数据转发到导入的规则链。

以下部分向您展示如何修改此规则链，具体来说：添加规则节点 [**A**](/docs/user-guide/rule-engine-2-0/tutorials/send-email-to-customer/#node-a-customer-attributes) 和 [**B**](/docs/user-guide/rule-engine-2-0/tutorials/send-email-to-customer/#node-b-originator-attributes) 并修改节点 [**C**](/docs/user-guide/rule-engine-2-0/tutorials/send-email-to-customer/#node-c-to-email)。
<br>

## 修改 **创建和清除警报并附带详细信息：**

### 修改所需节点

在此规则链中，您将添加 2 个节点并修改 1 个节点，如下面的部分中所述：

#### 节点 A：**客户属性**
- 添加 **客户属性** 节点并将其与 **筛选脚本** 节点连接，关系类型为 **真**。<br>
  此节点将用于获取客户的 **电子邮件** 属性并将其保存在
  消息元数据属性 **customerEmail** 中

 - 使用下表所示的输入数据填写字段：

 <table style="width: 30%">
   <thead>
       <tr>
        <td>字段</td>
        <td>输入数据 </td>
       </tr>
   </thead>
   <tbody>
       <tr>
            <td>名称</td>
            <td>获取客户电子邮件</td>
       </tr>
       <tr>
            <td>源属性</td>
            <td>电子邮件</td>
       </tr>
       <tr>
            <td>目标属性</td>
            <td>customerEmail</td>
       </tr>
   </tbody>
 </table>


![image](/images/user-guide/rule-engine-2-0/tutorials/email/get-customer-email.png)

#### 节点 B：**发起者属性**
- 添加 **发起者属性** 节点并将其粘贴在节点之间：**客户属性** 和 **创建警报**，关系类型为 **成功**。<br>
  此节点将用于获取发起者 **(Thermostat Home)** 的地址服务器范围属性。此属性将保存在消息元数据属性 ss_address 中。

 - 使用下表所示的输入数据填写字段：

 <table style="width: 30%">
   <thead>
       <tr>
        <td>字段</td>
        <td>输入数据 </td>
       </tr>
   </thead>
   <tbody>
       <tr>
            <td>名称</td>
            <td>获取设备地址</td>
       </tr>
       <tr>
            <td>服务器属性</td>
            <td>地址</td>
       </tr>
   </tbody>
 </table>


![image](/images/user-guide/rule-engine-2-0/tutorials/email/get-device-address.png)

#### 节点 C：**发送电子邮件**
- 修改 **发送电子邮件** 节点。为此，我们需要更改此节点的详细信息中的一些字段，即：

    - **发送至模板**。

    - **正文模板**。

- 使用下表所示的输入数据填写字段：

<table style="width: 30%">
   <thead>
       <tr>
        <td>字段</td>
        <td>输入数据 </td>
       </tr>
   </thead>
   <tbody>
       <tr>
            <td>发送至模板</td>
            <td>${customerEmail}</td>
       </tr>
       <tr>
            <td>正文模板</td>
            <td>设备 ${deviceName} 的温度不可接受：${temperature}。设备地址 - ${ss_address}</td>
       </tr>
   </tbody>
 </table>

![image](/images/user-guide/rule-engine-2-0/tutorials/email/modify-to-email.png)


## 发布遥测数据并验证
对于发布设备遥测数据，我们将使用 Rest API，[遥测上传 API](/docs/reference/http-api/#telemetry-upload-api)。为此，我们需要
从设备 **Thermostat Home** 复制设备访问令牌。

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/copy-token.png)


让我们发布温度 = 99。应发送邮件：

{% highlight bash %}
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

**您需要将 $ACCESS_TOKEN 替换为实际设备令牌**
{% endhighlight %}

您应该明白，当警报更新时不会向电子邮件发送消息，只有在创建警报时才会发送消息。

最后，我们可以看到已收到电子邮件，其中包含正确的值。（如果您没有收到任何电子邮件，请检查您的垃圾邮件文件夹）


![image](/images/user-guide/rule-engine-2-0/tutorials/email/mail-received.png)


此外，您可以看到有关如何执行以下操作的更多信息：

- 定义警报处理的其他附加逻辑，例如，使用 Telegram Bot 向 Telegram App 发送通知。

- 配置创建和清除警报节点中的警报详细信息功能，并通过添加警报小部件来配置仪表板以可视化警报。

- 设备离线时创建警报。

请参阅 **另请参阅** 部分下的链接，了解如何执行此操作。

<br>
<br>

## 另请参阅

- [使用 Telegram Bot 在智能手机上接收通知和警报](/docs/iot-gateway/integration-with-telegram-bot/) 指南

- [创建附带详细信息的警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/) 指南。

- [设备离线时创建警报](/docs/user-guide/rule-engine-2-0/tutorials/create-inactivity-alarm/) 指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}