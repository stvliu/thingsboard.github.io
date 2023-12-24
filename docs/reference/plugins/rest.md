---
layout: docwithnav
assignees:
- ashvayka
title: REST API 调用插件

---

{% include templates/old-guide-notice.md %}

## 概述

Rest API 插件负责向特定端点发送由特定规则触发的 HTTP 请求

## 配置

您可以指定以下配置参数：

- http 端点服务器主机
- http 端点服务器端口
- http 请求的基本路径
- http 身份验证方法。目前支持 *无授权* 或 *基本*
- *基本* 身份验证方法中的用户名
- *基本* 身份验证方法中的密码
- 自定义请求头

## 服务器端 API

此插件不提供任何服务器端 API。

## 示例

在此示例中，我们将演示如何配置 Rest API 调用扩展，以便每次设备的新遥测消息到达时，都能向特定 REST 端点发送 POST 或 PUT 请求。

在继续 REST API 调用扩展配置之前的前提条件：

- ThingsBoard 正在运行
- 能够接收 POST 或 PUT 请求的第三方 HTTP 服务器和特定端点正在运行

### REST API 调用插件配置

我们首先配置 REST API 调用插件。转到 *插件* 菜单，单击“+”按钮并创建新插件：

![image](/images/reference/plugins/rest-api-call/rest-api-call-plugin-config-1.png)

![image](/images/reference/plugins/rest-api-call/rest-api-call-plugin-config-2.png)

请为要将请求传输到的 REST 端点正确设置 URL、端口、路径和身份验证方法。

保存插件并单击 *“激活”* 插件按钮：

![image](/images/reference/plugins/rest-api-call/rest-api-call-activate-plugin.png)

### REST API 调用规则配置

现在是时候创建适当的规则了。

![image](/images/reference/plugins/rest-api-call/rest-api-call-rule-config.png)

为 **POST_TELEMETRY** 消息类型添加过滤器：

![image](/images/reference/plugins/rest-api-call/post-telemetry-filter.png)

单击 *“添加”* 按钮以添加过滤器。

然后在插件字段的下拉框中选择 *“REST API 调用插件”*：

![image](/images/reference/plugins/rest-api-call/rest-api-call-plugin-selection.png)

添加一个操作，将设备的温度遥测发送到特定的 REST 操作路径。在操作中，您可以提供请求类型和在成功调用时从 REST 端点预期的结果代码。

![image](/images/reference/plugins/rest-api-call/rest-api-call-rule-action-config-1.png)

![image](/images/reference/plugins/rest-api-call/rest-api-call-rule-action-config-2.png)

单击 *“添加”* 按钮，然后激活规则。

### 发送温度遥测

现在，对于您的任何设备，发送包含 *“temp”* 遥测的遥测消息：

```json
{"temp":73.4}
```

一旦您发布此消息，您应该在适当的 rest 端点中看到 **“73.4”** 作为正文请求。

以下是一个将单个遥测消息发布到本地安装的 ThingsBoard 的命令示例：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m '{"temp":73.4}'
```