---
layout: docwithnav
assignees:
- ashvayka
title: RabbitMQ 插件

---

{% include templates/old-guide-notice.md %}

## 概述

RabbitMQ 插件负责向 RabbitMQ 实例发送由特定规则触发的消息

## 配置

您可以指定以下配置参数：

- rabbitmq 实例主机
- rabbitmq 实例端口
- rabbitmq 虚拟主机
- 授权用户名
- 授权密码
- 在发生故障时启用自动化连接恢复
- 连接超时
- 握手超时
- 其他客户端属性，可用于连接到特定 rabbitmq 实例

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

在此示例中，我们将演示如何配置 RabbitMQ 扩展，以便每次设备的新遥测消息到达时都能向特定队列发送消息。

在继续 RabbitMQ 扩展配置之前的前提条件：

- ThingsBoard 已启动并正在运行
- RabbitMQ 实例已启动并正在运行

### RabbitMQ 插件配置

我们首先配置 RabbitMQ 插件。转到“插件”菜单，单击“+”按钮并创建新插件：

![image](/images/reference/plugins/rabbitmq/rabbitmq-plugin-config-1.png)

![image](/images/reference/plugins/rabbitmq/rabbitmq-plugin-config-2.png)

请正确设置主机、端口和凭据，以便扩展能够连接到 RabbitMQ 代理。

保存插件并单击“激活”插件按钮：

![image](/images/reference/plugins/rabbitmq/rabbitmq-activate-plugin.png)

### RabbitMQ 规则配置

现在是时候创建适当的规则了。

![image](/images/reference/plugins/rabbitmq/rabbitmq-rule-config.png)

为 **POST_TELEMETRY** 消息类型添加过滤器：

![image](/images/reference/plugins/rabbitmq/post-telemetry-filter.png)

单击“添加”按钮以添加过滤器。

然后在插件字段的下拉框中选择“RabbitMQ 插件”：

![image](/images/reference/plugins/rabbitmq/rabbitmq-plugin-selection.png)

添加一个操作，将设备的温度遥测发送到特定的 RabbitMQ 队列：

![image](/images/reference/plugins/rabbitmq/rabbitmq-rule-action-config.png)

单击“添加”按钮，然后激活规则。

### 发送温度遥测

现在，对于您的任何设备，发送包含“temp”遥测的遥测消息：

```json
{"temp":73.4}
```

一旦您发布此消息，您应该在相应的 RabbitMQ 队列中收到消息“73.4”。

以下是一个将单个遥测消息发布到本地安装的 GridLinks 的命令示例：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m '{"temp":73.4}'
```