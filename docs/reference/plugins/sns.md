---
layout: docwithnav
assignees:
- mp-loki
title: SNS 插件

---

{% include templates/old-guide-notice.md %}

## 概述

SNS 插件负责向由特定规则触发的 Amazon Web Services 简单通知服务主题发送消息

## 配置

SNS 插件具有以下配置参数：

- *访问密钥 ID*
- *秘密访问密钥*
- *区域*

*访问密钥 ID* 和 *秘密访问密钥* 是具有编程访问权限的 AWS IAM 用户的凭据。有关 AWS 访问密钥的更多信息，请参阅[此处](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

*区域* 必须与创建 SNS 队列的区域相对应。当前的 AWS 区域列表请参阅[此处](http://docs.aws.amazon.com/general/latest/gr/rande.html)

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

在此示例中，我们将演示如何配置此扩展，以便每次设备的新遥测消息到达时都能向 SNS 主题发送消息。

在继续 Kafka 扩展配置之前的前提条件：

- 创建 AWS IAM 用户并获取访问密钥 ID/秘密访问密钥
- 创建 SNS 主题
- ThingsBoard 正在运行

有关如何创建 SNS 主题的信息，请参阅[此处](http://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html)

### SNS 插件配置

我们首先配置 SNS 插件。转到 *插件* 菜单并创建新插件：

![image](/images/reference/plugins/sns/sns-plugin-config-1.png)

![image](/images/reference/plugins/sns/sns-plugin-config-2.png)

确保用实际值替换 <$YOUR_ACCESS_KEY_ID> 和 <$YOUR_SECRET_ACCESS_KEY> 占位符，并设置正确的区域。

单击 *'激活'* 插件按钮：

![image](/images/reference/plugins/sns/sns-activate-plugin.png)

### SNS 规则配置

要创建 SNS 规则，请转到规则屏幕并单击“添加新规则”按钮。

![image](/images/reference/plugins/sns/sns-rule.png)

添加 **POST_TELEMETRY** 消息类型的过滤器：

![image](/images/reference/plugins/post-telemetry-filter.png)

单击 *'添加'* 按钮以添加过滤器。

然后在插件字段的下拉框中选择 *'SNS 插件'*：

![image](/images/reference/plugins/sns/sns-plugin-selection.png)

添加一个操作，将设备的温度遥测发送到特定的 SNS 主题：

![image](/images/reference/plugins/sns/sns-topic-action.png)

单击 *'添加'* 按钮，然后激活规则。

![image](/images/reference/plugins/sns/sns-activate-rule.png)

### 创建电子邮件 SNS 订阅

SNS 是一种基于推送的服务，因此我们需要创建一个订阅才能接收来自它的消息。
在 AWS 控制台的 SNS 仪表板下，转到 **主题**，选择您的主题，然后单击 **操作 -> 订阅主题**。
在出现的窗口中，选择协议：电子邮件，并输入您的电子邮件地址：

![image](/images/reference/plugins/sns/sns-create-subscription.png)

### 发送温度遥测

现在，您可以发送包含任何设备的 *'temp'* 遥测的遥测消息：

```json
{"temp":88.2}
```

以下是一个将单个遥测消息发布到本地安装的 ThingsBoard 的命令示例：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m "{'temp':88.2}"
```

现在，您应该在邮箱中收到一封包含遥测数据的电子邮件：

![image](/images/reference/plugins/sns/sns-email-delivery.png)