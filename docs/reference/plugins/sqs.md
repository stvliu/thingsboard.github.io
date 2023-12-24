---
layout: docwithnav
assignees:
- mp-loki
title: SQS 插件

---

{% include templates/old-guide-notice.md %}

## 概述

SQS 插件负责将消息发送到由特定规则触发的 Amazon Web Services Simple Queue Service 队列

## 配置

SQS 插件具有以下配置参数：

- *访问密钥 ID*
- *秘密访问密钥*
- *区域*

*访问密钥 ID* 和 *秘密访问密钥* 是具有编程访问权限的 AWS IAM 用户的凭据。有关 AWS 访问密钥的更多信息，请参阅[此处](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

*区域* 必须与创建 SQS 队列的区域相对应。当前的 AWS 区域列表请参阅[此处](http://docs.aws.amazon.com/general/latest/gr/rande.html)

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

在此示例中，我们将演示如何配置此扩展，以便每次设备的新遥测消息到达时，都能向 SQS 标准队列和 FIFO 队列发送消息。

在继续 Kafka 扩展配置之前，先决条件：

- 创建 AWS IAM 用户并获取访问密钥 ID/秘密访问密钥
- 创建 SQS 标准队列
- 创建 SQS FIFO 队列
- ThingsBoard 正在运行

有关如何创建 SQS 队列的信息，请参阅[此处](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-create-queue.html)

### SQS 插件配置

我们首先配置 SQS 插件。转到 *插件* 菜单并创建新插件：

![image](/images/reference/plugins/sqs/sqs-plugin-config-1.png)

![image](/images/reference/plugins/sqs/sqs-plugin-config-2.png)

确保将 <$YOUR_ACCESS_KEY_ID> 和 <$YOUR_SECRET_ACCESS_KEY> 占位符替换为实际值并设置正确的区域。

单击 *'激活'* 插件按钮：

![image](/images/reference/plugins/sqs/sqs-activate-plugin.png)

### SQS 标准队列规则配置

[SQS 标准队列](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/standard-queues.html) 不会保留消息到达的顺序，并确保 *至少一次* 消息传递。

为了创建 SQS 标准队列规则，请转到规则屏幕并单击“添加新规则”按钮。

![image](/images/reference/plugins/sqs/sqs-standard-queue-rule.png)

添加 **POST_TELEMETRY** 消息类型的过滤器：

![image](/images/reference/plugins/post-telemetry-filter.png)

单击 *'添加'* 按钮添加过滤器。

然后在插件字段的下拉框中选择 *'SQS 插件'*：

![image](/images/reference/plugins/sqs/sqs-plugin-selection.png)

添加一个操作，将设备的温度遥测发送到特定的 SQS 标准队列：

![image](/images/reference/plugins/sqs/sqs-standard-queue-action.png)

单击 *'添加'* 按钮，然后激活规则。

![image](/images/reference/plugins/sqs/sqs-standard-queue-activate-rule.png)

### 发送温度遥测

现在，您可以发送包含任何设备的 *'temp'* 遥测的遥测消息：

```json
{"temp":73.4}
```

以下是一个将单个遥测消息发布到本地安装的 GridLinks 的命令示例：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m "{'temp':73.4}"
```

现在，您应该能够通过 AWS 控制台在 SQS 标准队列中看到可用的消息：

![image](/images/reference/plugins/sqs/sqs-standard-queue-message-received.png)

### SQS FIFO 队列规则配置

[SQS FIFO 队列](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html) 按照每个消息组 ID 维护先进先出顺序，并确保只处理一次。
ThingsBoard SQS 插件在向 SQS FIFO 队列发送消息时使用设备 ID 作为消息组 ID。这意味着 FIFO 顺序将按每个设备维护。

SQS FIFO 队列规则配置与 SQS 标准队列配置非常相似，但有一些细微差别。

为了创建 SQS FIFO 队列规则，请转到规则屏幕并单击“添加新规则”按钮。

![image](/images/reference/plugins/sqs/sqs-fifo-queue-rule.png)

添加 **POST_TELEMETRY** 消息类型的过滤器：

![image](/images/reference/plugins/sqs/post-telemetry-filter.png)

单击 *'添加'* 按钮添加过滤器。

然后在插件字段的下拉框中选择 *'SQS 插件'*：

![image](/images/reference/plugins/sqs/sqs-plugin-selection.png)

添加一个操作，将设备的温度遥测发送到特定的 SQS FIFO 队列：

![image](/images/reference/plugins/sqs/sqs-fifo-queue-action.png)

单击 *'添加'* 按钮，然后激活规则。

![image](/images/reference/plugins/sqs/sqs-fifo-queue-activate-rule.png)

### 发送温度遥测

现在，您可以发送包含任何设备的 *'temp'* 遥测的遥测消息：

```json
{"temp":68.3}
```

以下是一个将单个遥测消息发布到本地安装的 GridLinks 的命令示例：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m "{'temp':68.3}"
```

现在，您应该能够通过 AWS 控制台在 SQS FIFO 队列中看到可用的消息：

![image](/images/reference/plugins/sqs/sqs-fifo-queue-message-received.png)