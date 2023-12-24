---
layout: docwithnav
assignees:
- ashvayka
title: Kafka 插件

---

{% include templates/old-guide-notice.md %}

## 概述

Kafka 插件负责向由特定规则触发的 Kafka 代理发送消息

## 配置

您可以指定以下配置参数：

- *引导服务器* - Kafka 代理列表
- *如果连接失败，重新连接到 Kafka 的尝试次数*
- *在客户端上将消息单元化到批次中的数量*
- *在发送到 Kafka 代理之前在本地缓冲的时间（以毫秒为单位）*
- *客户端上的缓冲区最大大小*
- *必须确认写入的最小副本数*
- 默认情况下，主题键序列化程序 - org.apache.kafka.common.serialization.StringSerializer
- 默认情况下，主题值序列化程序 - org.apache.kafka.common.serialization.StringSerializer
- 可以为 Kafka 代理连接提供任何其他附加属性

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

在此示例中，我们将演示如何配置此扩展，以便每次设备的新遥测消息到达时都能向 Kafka 主题发送消息。

在继续 Kafka 扩展配置之前的前提条件：

- Kafka 代理正在运行
- 创建了适当的 Kafka 主题
- ThingsBoard 正在运行

### Kafka 插件配置

让我们首先配置 Kafka 插件。转到 *插件* 菜单并创建新插件：

![image](/images/reference/plugins/kafka/kafka-plugin-config-1.png)

![image](/images/reference/plugins/kafka/kafka-plugin-config-2.png)

请正确设置 Kafka 引导服务器 URL 和插件配置部分中适合您的情况的任何其他参数，以便 Kafka 扩展能够连接到 Kafka 代理。

单击 *“激活”* 插件按钮：

![image](/images/reference/plugins/kafka/kafka-activate-plugin.png)

### Kafka 规则配置

现在是时候创建适当的规则了。

![image](/images/reference/plugins/kafka/kafka-rule-config.png)

为 **POST_TELEMETRY** 消息类型添加过滤器：

![image](/images/reference/plugins/post-telemetry-filter.png)

单击 *“添加”* 按钮以添加过滤器。

然后在插件字段的下拉框中选择 *“Kafka 插件”*：

![image](/images/reference/plugins/kafka/kafka-plugin-selection.png)

添加一个操作，将设备的温度遥测发送到特定 Kafka 主题：

![image](/images/reference/plugins/kafka/send-temp-telemetry.png)

单击 *“添加”* 按钮，然后激活规则。

### 发送温度遥测

现在，您可以发送包含任何设备的 *“temp”* 遥测的遥测消息：

```json
{"temp":73.4}
```

一旦您发布此消息，您应该在适当的 Kafka 主题中看到 **“73.4”** 消息。

以下是一个将单个遥测消息发布到本地安装的 ThingsBoard 的命令示例：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m '{"temp":73.4}'
```