---
layout: docwithnav
title: 发送报警电子邮件
description: 发送电子邮件工作流
---

本教程将向您展示如何使用规则引擎向用户发送电子邮件。

* TOC
{:toc}

## 使用案例

在本教程中，我们将实现以下教程中的案例：[创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#use-case)：

假设您的设备使用 DHT22 传感器收集温度读数并将其推送到 GridLinks。
DHT22 传感器适用于 -40 至 80°C 的温度读数。如果温度超出正常范围，我们希望生成警报并在创建警报时发送电子邮件。

在本教程中，我们将配置 GridLinks 规则引擎以：

- 如果温度超出范围（即低于 -40 度和高于 80 度），则向用户发送电子邮件。

- 使用脚本转换节点将当前温度添加到电子邮件正文中，以便将当前温度保存在消息元数据中。


## 前提条件

我们假设您已完成以下指南并阅读了以下文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
  * [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 指南。

## 消息流

在本节中，我们将解释本教程中每个节点的用途：

- 节点 A：[**转换脚本**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node) 节点。
  - 此节点将用于将当前温度保存在消息元数据中。
- 节点 B：[**发送电子邮件**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#to-email-node) 节点。
  - 此节点根据配置的模板构建实际电子邮件。
- 节点 C：[**发送电子邮件**](/docs/user-guide/rule-engine-2-0/external-nodes/#send-email-node) 节点。
  - 此节点将使用系统 SMTP 设置从入站消息实际发送电子邮件。

<br>

## 配置规则链

在本教程中，我们使用了 [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms) 教程中的规则链。
我们通过添加上述 [消息流](/docs/user-guide/rule-engine-2-0/tutorials/send-email/#message-flow) 部分中描述的节点来修改规则链 **创建和清除警报**<br>
并将此规则链重命名为：**创建/清除警报和发送电子邮件**。

<br>以下屏幕截图显示了上述规则链应如何显示：

  - **创建/清除警报和发送电子邮件：**

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/send-email-chain.png)

 - **根规则链：**

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/root-rule-chain.png)

<br>

下载附加的 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/create_clear_alarm___send_email.json) 以获取 **创建/清除警报和发送电子邮件** 规则链。

以下部分将向您展示如何从头开始修改此规则链。
<br>

## 修改 **创建/清除警报和发送电子邮件**

### 添加所需节点

在此规则链中，您将创建 3 个节点，如下面的部分中所述：

#### 节点 A：**转换脚本**

- 添加 **转换脚本** 节点，并将其置于 **筛选脚本** 节点之后，关系类型为 **True**，然后通过关系 **成功** 将其连接到 **创建警报** 节点。
 <br>此节点将用于使用以下脚本将当前温度从消息数据保存到消息元数据：

 {% highlight javascript %}
 metadata.temperature = msg.temperature;
 return {msg: msg, metadata: metadata, msgType: msgType};{% endhighlight %}

- 将名称字段输入为 **将温度添加到元数据**。

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/transform-script.png)

#### 节点 B：**发送电子邮件**
- 添加 **发送电子邮件** 节点，并将其连接到 **创建警报** 节点，关系类型为 **已创建**。
  <br>此节点不会发送实际电子邮件，它仅根据配置的模板构建电子邮件。
  <br>因此，您可以使用对消息元数据中存在的任何字段的引用。

- 使用下表所示的输入数据填写字段：

  <table style="width: 25%">
    <thead>
        <tr>
            <td><b>字段</b></td><td><b>输入数据</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>名称</td>
            <td>温度电子邮件</td>
        </tr>
        <tr>
            <td>来自模板</td>
            <td>info@testmail.org</td>
        </tr>
        <tr>
            <td>发送到模板</td>
            <td>**您的电子邮件**</td>
        </tr>
        <tr>
            <td>主题模板</td>
            <td>设备 ${deviceType} 温度不可接受</td>
        </tr>
        <tr>
            <td>正文模板</td>
            <td>设备 ${deviceName} 的温度不可接受：${temperature}</td>
        </tr>
     </tbody>
  </table>

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/to-email.png)

#### 节点 C：**发送电子邮件**
- 添加 **发送电子邮件** 节点，并将其连接到 **发送电子邮件** 节点，关系类型为 **成功**。 <br>
  此节点将使用系统 SMTP 设置从入站消息实际发送电子邮件。<br>

- 将名称字段输入为 **SendGrid SMTP**。

- 如果您无权访问系统管理员帐户，则需要为此节点进行自己的 SMTP 配置。

- 否则，标记字段 **使用系统 SMTP 设置**。


 请注意，在演示服务器上已将 SendGrid 提供程序配置为系统 SMTP。 <br>

以下部分将说明如何配置这些设置。

<br>

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/send-email.png)

<br>

链配置已完成，我们需要保存它。

#### 配置系统 SMTP 设置

在本节中，我们将向您解释如何配置系统 SMTP 设置并尝试发送测试电子邮件：

- 在本教程的范围内，我们将使用 **SendGrid** 作为 SMTP 提供程序，Thingsboard 将使用此提供程序发送电子邮件。您可以使用此 [链接](https://app.sendgrid.com/signup) 注册试用。

  登录 SendGrid 后，打开 SMTP 中继 [配置页面](https://app.sendgrid.com/guide/integrate/langs/smtp)。

  ![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/sendgrid-config.png)

如果您有权登录 ThingsBoard，则可以使用系统管理员帐户自定义 SMTP 设置并发送测试电子邮件。
 - 对于默认系统管理员帐户：

   - 登录 - **sysadmin@gridlinks.com**。
   - 密码 - **sysadmin**。

- 转到 **系统设置** -> **外发邮件** 并按照以下屏幕截图中的说明配置 **外发邮件设置**：

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/test-email.png)

 - 通过按 **发送测试电子邮件** 按钮验证您是否配置了 SMTP<br>


如果系统 SMTP 配置正确：您将看到一个弹出消息，如上图所示。<br>
系统 SMTP 设置配置已完成。不要忘记按 **保存** 按钮。

如果您无法访问系统管理员的帐户，则可以在节点中配置 SMTP 设置，但无法检查电子邮件是否已成功发送。

<br>

## 发布遥测并验证
对于发布设备遥测，我们将使用 Rest API，[遥测上传 API](/docs/reference/http-api/#telemetry-upload-api)。为此，我们需要
从设备 **Thermostat Home** 复制设备访问令牌。

![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/copy-token.png)


让我们发布温度 = 180。应创建警报：

{% highlight bash %}
curl -v -X POST -d '{"temperature":180}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

**您需要将 $ACCESS_TOKEN 替换为实际设备令牌**
{% endhighlight %}

您应该明白，当警报更新时，不会向电子邮件发送消息，只有在创建警报时才会发送消息。

最后，我们可以看到已收到带有正确值的电子邮件。（如果您没有收到任何电子邮件，请检查您的垃圾邮件文件夹）


![image](/images/user-guide/rule-engine-2-0/tutorials/email v2/mail-received.png)


此外，您还可以看到有关如何执行以下操作的更多信息：

 -  向设备的客户发送电子邮件。

 -  从传入消息中向电子邮件正文添加其他数据。

请参阅 **另请参阅** 部分下的第一个链接，了解如何执行此操作。

<br>
<br>

## 另请参阅

- [向客户发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email-to-customer/) 指南。

- [设备离线时创建警报](/docs/user-guide/rule-engine-2-0/tutorials/create-inactivity-alarm/) 指南。

- [创建带有详细信息的警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/) 指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}