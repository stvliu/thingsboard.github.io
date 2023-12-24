* TOC
{:toc}

## 概述

Telegram 提供创建 Telegram 机器人的可能性，这些机器人被视为第三方应用程序。
因此，在本教程中，我们将演示如何创建 Telegram 机器人<br>
并配置 GridLinks 规则引擎，以便能够使用 Rest API 调用扩展向 Telegram 应用发送通知。

## 使用案例

本教程基于 [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#use-case) 教程及其案例。
我们将重用上述教程中的规则链，并将添加更多规则节点以与 Telegram 集成

假设您的设备使用 DHT22 传感器将温度读数收集并推送到 GridLinks。
DHT22 传感器适用于 -40 至 80°C 的温度读数。如果温度超出正常范围，我们希望生成警报，并在创建警报时向 Telegram 应用发送通知。

在本教程中，我们将配置 GridLinks 规则引擎以：

- 如果创建了警报，则向用户发送消息通知。

- 使用脚本转换节点将当前警报类型及其发起者添加到消息正文。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  * [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 指南。

## 消息流

在本节中，我们将解释本教程中每个节点的用途：

- 节点 A：[**转换脚本**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node) 节点。
  - 此节点将用于创建 Telegram 消息通知的正文。
- 节点 B：[**REST API 调用**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/#rest-api-call-node) 节点。
  - 此节点将 Telegram 消息有效负载发送到配置的 REST 端点。在我们的例子中，它是 Telegram REST API。

## 创建 Telegram 机器人

[BotFather](https://telegram.me/botfather) 是一个主要机器人，它将帮助您[创建](https://core.telegram.org/bots#6-botfather) 新机器人并更改其设置。

完成机器人的创建后，您可以为您的新机器人生成授权令牌。
令牌是一个类似于此的字符串 - **'110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw'**，需要授权机器人。

先决条件：

- ThingsBoard 正在运行
- 创建了 Telegram 机器人

### 获取聊天 ID

在下一步中，我们需要检索聊天 ID。聊天 ID 是通过 HTTP API 发送消息所必需的。

有几种方法可以获取聊天 ID：

- 首先，您需要向您的机器人发送一些消息：

    - 在私人聊天中；

       ![image](/images/gateway/telegram-bot/private-msg-to-bot.png)    

    - 在将您的机器人添加为成员的群组中。

       ![image](/images/gateway/telegram-bot/msg-to-bot-in-chat.png)    
      
    <br>其中 **ThingsBoard_Bot** 是 Telegram 机器人的名称。

- 接下来，打开您的网络浏览器并输入以下 URL：

```bash
https://api.telegram.org/bot"YOUR_BOT_TOKEN"/getUpdates

"YOUR_BOT_TOKEN" 必须替换为您的机器人的身份验证令牌，例如：

https://api.telegram.org/bot110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw/getUpdates
```



从输出数据中，您可以找到字段 **'id'**。这就是所谓的 chat_id。

- 第一个选项：

![image](/images/gateway/telegram-bot/first-option.png)

- 第二个选项：

![image](/images/gateway/telegram-bot/second-option.png)

之后，您可以开始配置规则引擎以使用 Rest API 调用扩展。

## 配置规则链

在本教程中，我们使用了 [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/) 教程中的规则链。
我们通过添加上面 [消息流](#message-flow) 部分中描述的节点来修改规则链 **创建和清除警报**<br>
并将此规则链重命名为：**创建/清除警报并向 Telegram 发送通知**。

<br>以下屏幕截图显示了上述规则链应如何显示：

  - **创建/清除警报并向 Telegram 发送通知：**

![image](/images/gateway/telegram-bot/send-to-telegram-chain.png)

- **根规则链：**

![image](/images/gateway/telegram-bot/root-rule-chain.png)

<br>


以下部分向您展示如何从头开始修改此规则链。
<br> 

### 修改 **创建/清除警报和发送电子邮件**

#### 添加所需节点

在此规则链中，您将创建 2 个节点，如下面的部分中所述：

##### 节点 A：**转换脚本**

- 添加 **转换脚本** 节点，并使用关系类型 **已创建** 将其连接到 **创建警报** 节点。
 <br>此节点将用于创建消息通知的正文。
 <br>正文模板必须具有 2 个参数：

   - chat_id；

   -  text。

   这是一个出站消息的示例：

```json
{"chat_id" : "PUT YOUR CHOSEN CHAT_ID", "text" : "SOME MESSAGE YOU WANT TO RECEIVE"}
```

  - 为此，请使用以下脚本：

 {% highlight javascript %}
 var newMsg ={};
 newMsg.text = '"' +  msg.name + '"' + " alarm was created for device: " + '"' + metadata.deviceName + '"';
 newMsg.chat_id = 337878729; //has to be replaced by the actual chat id
 return {msg: newMsg, metadata: metadata, msgType: msgType};{% endhighlight %}
      
- 将名称字段输入为 **新电报消息**。

![image](/images/gateway/telegram-bot/transform-script.png)
   
##### 节点 B：**REST API 调用**
- 添加 **REST API 调用** 节点，并使用关系类型 **成功** 将其连接到 **转换脚本** 节点。
  <br>此节点将完整的 Message 有效负载发送到配置的 REST 端点。在我们的例子中，它是 Telegram REST API。
  <br>在本教程的范围内，我们将使用 **'/sendMessage'** 操作路径来引用 Telegram 机器人 API 以发送消息。

  
- 使用下表中所示的输入数据填写字段：

  <table style="width: 25%">
    <thead>
        <tr>
            <td><b>字段</b></td><td><b>输入数据</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>名称</td>
            <td>REST API 电报调用</td>
        </tr>
        <tr>
            <td>端点 URL 模式</td>
            <td>https://api.telegram.org/bot"YOUR_BOT_TOKEN"/sendMessage</td>
        </tr>
        <tr>
            <td>请求方法</td>
            <td>POST</td>
        </tr>
        <tr>
            <td>标题</td>
            <td>内容类型</td>
        </tr>
        <tr>
            <td>值</td>
            <td>application/json</td>
        </tr>
     </tbody>
  </table>

![image](/images/gateway/telegram-bot/rest-api-telegram-node.png)


## 发布遥测并验证

对于发布设备遥测，我们将使用 Rest API，[遥测上传 API](/docs/{{docsPrefix}}reference/http-api/#telemetry-upload-api)。为此，我们需要
从设备 **Thermostat Home** 复制设备访问令牌。

![image](/images/gateway/telegram-bot/copy-token.png)


让我们发布温度 = 99。应该创建警报：

{% highlight bash %}
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

**您需要将 $ACCESS_TOKEN 替换为实际设备令牌**
{% endhighlight %}

您应该明白，当警报更新时，不会向 Telegram 应用发送消息，只有在创建警报时才会发送消息。

最后，我们可以看到消息已收到正确的值：

- 第一个选项：

![image](/images/gateway/telegram-bot/msg-received-first-way.png)


- 第二个选项：

![image](/images/gateway/telegram-bot/msg-received-second-way.png)


您还可以：

  - 在创建和清除警报节点中配置警报详细信息功能。

  - 通过添加警报小部件来配置仪表板以可视化警报。

  - 定义警报处理的其他附加逻辑，例如发送电子邮件。

请参阅 **另请参阅** 部分下的链接，了解如何执行此操作。

<br>

## 另请参阅

- [创建和清除警报：警报详细信息：](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#step-2-createupdate-alarm) 指南 - 了解如何在警报节点中配置警报详细信息功能。

- [创建和清除警报：配置仪表板](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms-with-details/#configure-device-and-dashboard) 指南 - 了解如何将警报小部件添加到仪表板。

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程。

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/multi-project-guides-banner.md %}