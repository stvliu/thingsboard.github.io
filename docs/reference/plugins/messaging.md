---
layout: docwithnav
assignees:
- ashvayka
title: 设备消息传递插件

---

{% include templates/old-guide-notice.md %}

## 概述

此 RPC 插件通过 ThingsBoard 集群实现各种 IoT 设备之间的通信。
该插件引入了基本的安全功能：设备只能在属于同一客户的情况下交换消息。
可以自定义插件实现以涵盖更复杂的安全功能。

## 配置

您可以指定以下配置参数：

- 每个客户的最大设备数量
- 默认请求超时
- 最大请求超时

## 设备 RPC API

该插件处理两种 rpc 方法：*getDevices* 和 *sendMsg*。
下面列出的示例将基于 [演示帐户](/docs/samples/demo-account/) 和 [MQTT](/docs/reference/mqtt-api/#client-side-rpc) 协议。
请注意，您可以使用其他协议 -
[CoAP](/docs/reference/coap-api/#client-side-rpc) 和 [HTTP](/docs/reference/http-api/#client-side-rpc)。

##### 获取设备列表 API

为了向其他设备发送消息，您需要知道它们的标识符。
设备可以使用 *getDevices* RPC 调用请求属于同一客户的其他设备的列表。

{% capture tabspec %}mqtt-get-device-list
A,mqtt-get-device-list.sh,shell,resources/mqtt-get-device-list.sh,/docs/reference/plugins/resources/mqtt-get-device-list.sh
B,mqtt-get-device-list.js,javascript,resources/mqtt-get-device-list.js,/docs/reference/plugins/resources/mqtt-get-device-list.js
C,response.json,javascript,resources/mqtt-get-device-list.json,/docs/reference/plugins/resources/mqtt-get-device-list.json{% endcapture %}
{% include tabs.html %}

##### 发送消息 API

设备可以使用 *sendMsg* RPC 调用向属于同一客户的其他设备发送消息。

下面的示例将尝试从设备“Test Device A1”向设备“Test Device A2”发送消息。

{% capture tabspec %}mqtt-send-msg-fail
A,mqtt-send-msg.sh,shell,resources/mqtt-send-msg.sh,/docs/reference/plugins/resources/mqtt-send-msg.sh
B,mqtt-send-msg.js,javascript,resources/mqtt-send-msg.js,/docs/reference/plugins/resources/mqtt-send-msg.js{% endcapture %}
{% include tabs.html %}

结果，您应该收到以下错误：

```json
{"error":"No active connection to the remote device!"}
```

让我们启动目标设备的模拟器并再次发送消息：
{% capture tabspec %}mqtt-receive-msg
A,mqtt-receive-msg.sh,shell,resources/mqtt-receive-msg.sh,/docs/reference/plugins/resources/mqtt-receive-msg.sh
B,mqtt-receive-msg.js,javascript,resources/mqtt-receive-msg.js,/docs/reference/plugins/resources/mqtt-receive-msg.js{% endcapture %}
{% include tabs.html %}

结果，您应该收到设备的以下响应：

```json
{"status":"ok"}
```

**注意**目标设备 ID、访问令牌、请求和响应正文都硬编码到脚本中，并对应于 [演示设备](/docs/samples/demo-account/#tenant-devices)。