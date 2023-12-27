* TOC
{:toc}

## 简介

网关是 GridLinks 中的一种特殊类型的设备，它能够充当连接到不同系统和 GridLinks 的外部设备之间的桥梁。
网关 API 提供了使用 **单个 MQTT 连接**在 **多个设备** 和平台之间交换数据的能力。
网关还充当 GridLinks 设备，并且可以利用现有的 [MQTT 设备 API](/docs/{{docsPrefix}}reference/mqtt-api/) 来报告统计信息、接收配置更新等等。

下面列出的 API 由 [**GridLinks 现代化的物联网网关**](/docs/iot-gateway/what-is-iot-gateway/) 使用。

## 基本 MQTT API

请参阅通用 [MQTT 设备 API](/docs/{{docsPrefix}}reference/mqtt-api/) 以获取有关数据格式、身份验证选项等的信息。

## 设备连接 API

为了通知 GridLinks 设备已连接到网关，需要发布以下消息：

```shell
主题：v1/gateway/connect
消息：{"device":"Device A"}
```

其中 **Device A** 是您的设备名称。

收到后，GridLinks 将查找或创建一个具有指定名称的设备。
此外，GridLinks 将向此网关发布有关特定设备的新属性更新和 RPC 命令的消息。

## 设备断开连接 API

为了通知 GridLinks 设备已从网关断开连接，需要发布以下消息：

```shell
主题：v1/gateway/disconnect
消息：{"device":"Device A"}
```

其中 **Device A** 是您的设备名称。

收到后，GridLinks 将不再向此网关发布此特定设备的更新。

## 属性 API

GridLinks 属性 API 允许设备

* 将 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性上传到服务器。
* 从服务器请求 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 和 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。
* 订阅服务器的 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。

##### 将属性更新发布到服务器

为了将客户端设备属性发布到 GridLinks 服务器节点，请将 PUBLISH 消息发送到以下主题：

```shell
主题：v1/gateway/attributes
消息：{"Device A":{"attribute1":"value1", "attribute2": 42}, "Device B":{"attribute1":"value1", "attribute2": 42}}
```

其中 **Device A** 和 **Device B** 是您的设备名称，**attribute1** 和 **attribute2** 是属性键。

##### 从服务器请求属性值

为了向 GridLinks 服务器节点请求客户端或共享设备属性，请将 PUBLISH 消息发送到以下主题：

```shell
主题：v1/gateway/attributes/request
消息：{"id": $request_id, "device": "Device A", "client": true, "key": "attribute1"}
```

其中 **$request_id** 是您的整数请求标识符，**Device A** 是您的设备名称，**client** 标识客户端或共享属性范围，**key** 是属性键。

在发送带有请求的 PUBLISH 消息之前，客户端需要订阅

```shell
主题：v1/gateway/attributes/response
```

并期望以以下格式接收结果消息：

```shell
消息：{"id": $request_id, "device": "Device A", "value": "value1"}
```

##### 订阅服务器的属性更新

为了订阅共享设备属性更改，请将 SUBSCRIBE 消息发送到以下主题：

```shell
v1/gateway/attributes
```

并期望以以下格式接收结果消息：

```shell
消息：{"device": "Device A", "data": {"attribute1": "value1", "attribute2": 42}}
```

## 遥测上传 API

为了将设备遥测发布到 GridLinks 服务器节点，请将 PUBLISH 消息发送到以下主题：

```shell
主题：v1/gateway/telemetry
```

消息：

```json
{
  "Device A": [
    {
      "ts": 1483228800000,
      "values": {
        "temperature": 42,
        "humidity": 80
      }
    },
    {
      "ts": 1483228801000,
      "values": {
        "temperature": 43,
        "humidity": 82
      }
    }
  ],
  "Device B": [
    {
      "ts": 1483228800000,
      "values": {
        "temperature": 42,
        "humidity": 80
      }
    }
  ]
}
```

其中 **Device A** 和 **Device B** 是您的设备名称，**temperature** 和 **humidity** 是遥测键，**ts** 是毫秒为单位的 Unix 时间戳。

## RPC API

### 服务器端 RPC

为了订阅来自服务器的 RPC 命令，请将 SUBSCRIBE 消息发送到以下主题：

```shell
v1/gateway/rpc
```

并期望以以下格式接收包含各个命令的消息：

```shell
{"device": "Device A", "data": {"id": $request_id, "method": "toggle_gpio", "params": {"pin":1}}}
```

一旦设备处理了命令，网关就可以使用以下格式发送回命令：

```shell
{"device": "Device A", "id": $request_id, "data": {"success": true}}
```

其中 **$request_id** 是您的整数请求标识符，**Device A** 是您的设备名称，**method** 是您的 RPC 方法名称。

## 声明设备 API

请参阅相应文章以获取有关 [声明设备](/docs/{{docsPrefix}}user-guide/claiming-devices) 功能的更多信息。

为了启动声明设备，请将 PUBLISH 消息发送到以下主题：

```shell
主题：v1/gateway/claim
```

消息：

```json
{
  "Device A": {
    "secretKey": "value_A",
    "durationMs": 60000
  },
  "Device B": {
    "secretKey": "value_B",
    "durationMs": 60000
  }
}
```

其中 **Device A** 和 **Device B** 是您的设备名称，**secretKey** 和 **durationMs** 是可选键。
如果未指定 **secretKey**，则使用空字符串作为默认值。
如果未指定 **durationMs**，则使用系统参数 **device.claim.duration**（在文件 **/etc/gridlinks/conf/gridlinks.yml** 中）。

## 协议定制

MQTT 传输可以通过更改相应的 [模块](https://github.com/thingsboard/thingsboard/tree/master/transport/mqtt) 来针对特定案例进行完全定制。


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}