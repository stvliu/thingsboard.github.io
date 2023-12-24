* TOC
{:toc}

## 入门

##### MQTT 基础知识

[MQTT](https://en.wikipedia.org/wiki/MQTT) 是一种轻量级的发布-订阅消息传递协议，这可能使其成为各种物联网设备最合适的协议。
您可以在 [此处](https://mqtt.org/) 找到有关 MQTT 的更多信息。

ThingsBoard 服务器节点充当 MQTT 代理，支持 QoS 级别 0（最多一次）和 1（至少一次）以及一组 [可配置](/docs/{{docsPrefix}}user-guide/device-profiles/#mqtt-device-topic-filters) 主题。

##### 客户端库设置

您可以在网络上找到大量 MQTT 客户端库。本文中的示例将基于 Mosquitto 和 MQTT.js。
为了设置其中一个工具，您可以使用我们的 [Hello World](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南中的说明。

##### MQTT 连接

我们将在本文中使用 *访问令牌* 设备凭据，稍后将它们称为 **$ACCESS_TOKEN**。
应用程序需要发送包含 **$ACCESS_TOKEN** 的用户名 MQTT CONNECT 消息。

连接序列期间可能的返回代码及其原因：

* **0x00 已连接** - 成功连接到 ThingsBoard MQTT 服务器。
* **0x04 连接被拒绝，用户名或密码错误** - 用户名为空。
* **0x05 连接被拒绝，未授权** - 用户名包含无效的 **$ACCESS_TOKEN**。

另一种身份验证选项是使用 [X.509 证书](/docs/{{docsPrefix}}user-guide/certificates/) 或 [基本 MQTT 凭据](/docs/{{docsPrefix}}user-guide/basic-mqtt/) - 客户端 ID、用户名和密码的组合。

现在，您可以代表您的设备发布遥测数据。
我们将在本示例中使用简单的命令通过 MQTT 发布数据。选择您的操作系统：

{% capture connectdevicetogglespec %}
MQTT<small>Linux 或 macOS</small>%,%mqtt-linux%,%templates/helloworld-pe/mqtt-linux.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/helloworld-pe/mqtt-windows.md{% endcapture %}
{% include content-toggle.html content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec %}

{% include templates/api/key-value-format.md %}

但是，也可以通过 [Protocol Buffers](https://developers.google.com/protocol-buffers) 发送数据。
有关更多详细信息，请参阅设备配置文件文章中的 [MQTT 传输类型](/docs/{{docsPrefix}}user-guide/device-profiles/#mqtt-transport-type) 配置部分。

也可以使用自定义二进制格式或某些序列化框架。有关更多详细信息，请参阅 [协议自定义](#protocol-customization)。

## 遥测上传 API

为了将遥测数据发布到 ThingsBoard 服务器节点，请将 PUBLISH 消息发送到以下主题：

```shell
v1/devices/me/telemetry
```

最简单的支持的数据格式是：

```json
{"key1":"value1", "key2":"value2"}
```

或

```json
[{"key1":"value1"}, {"key2":"value2"}]
```

**请注意**，在这种情况下，服务器端时间戳将被分配给上传的数据！

如果您的设备能够获取客户端时间戳，则可以使用以下格式：


```json
{"ts":1451649600512, "values":{"key1":"value1", "key2":"value2"}}
```

在上面的示例中，我们假设 "1451649600512" 是具有毫秒精度的 [unix 时间戳](https://en.wikipedia.org/wiki/Unix_time)。
例如，值 '1451649600512' 对应于 'Fri, 01 Jan 2016 12:00:00.512 GMT'

{% capture tabspec %}mqtt-telemetry-upload
A,Mosquitto,shell,resources/mosquitto-telemetry.sh,/docs/reference/resources/mosquitto-telemetry.sh
B,MQTT.js,shell,resources/mqtt-js-telemetry.sh,/docs/reference/resources/mqtt-js-telemetry.sh
C,telemetry-data-as-object.json,json,resources/telemetry-data-as-object.json,/docs/reference/resources/telemetry-data-as-object.json
D,telemetry-data-as-array.json,json,resources/telemetry-data-as-array.json,/docs/reference/resources/telemetry-data-as-array.json
E,telemetry-data-with-ts.json,json,resources/telemetry-data-with-ts.json,/docs/reference/resources/telemetry-data-with-ts.json{% endcapture %}
{% include tabs.html %}


## 属性 API

ThingsBoard 属性 API 允许设备

* 将 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性上传到服务器。
* 从服务器请求 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 和 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。
* 订阅来自服务器的 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。

##### 将属性更新发布到服务器

为了将客户端设备属性发布到 ThingsBoard 服务器节点，请将 PUBLISH 消息发送到以下主题：

```shell
v1/devices/me/attributes
```
{: .copy-code}

{% capture tabspec %}mqtt-attributes-upload
A,Mosquitto,shell,resources/mosquitto-attributes-publish.sh,/docs/reference/resources/mosquitto-attributes-publish.sh
B,MQTT.js,shell,resources/mqtt-js-attributes-publish.sh,/docs/reference/resources/mqtt-js-attributes-publish.sh
C,new-attributes-values.json,json,resources/new-attributes-values.json,/docs/reference/resources/new-attributes-values.json{% endcapture %}
{% include tabs.html %}

##### 从服务器请求属性值

为了将客户端或共享设备属性请求到 ThingsBoard 服务器节点，请将 PUBLISH 消息发送到以下主题：

```shell
v1/devices/me/attributes/request/$request_id
```

其中 **$request_id** 是您的整数请求标识符。
在发送带有请求的 PUBLISH 消息之前，客户端需要订阅

```shell
v1/devices/me/attributes/response/+
```

以下示例用 javascript 编写，并基于 mqtt.js。
纯命令行示例不可用，因为订阅和发布需要在同一个 mqtt 会话中进行。

{% if docsPrefix == null %}
将 $ACCESS_TOKEN 替换为您的设备的访问令牌。不要忘记在 "mqtt-js-attributes-request.js" 文件中将主机名 "demo.thingsboard.io" 替换为您的主机。
在本示例中，主机名引用实时演示服务器。
{% endif %}
{% if docsPrefix == "pe/" %}
将 $ACCESS_TOKEN 替换为您的设备的访问令牌。不要忘记在 "mqtt-js-attributes-request.js" 文件中将主机名 "127.0.0.1" 替换为您的主机。
在本示例中，主机名引用您的本地安装。
{% endif %}
{% if docsPrefix == 'paas/' %}
将 $ACCESS_TOKEN 替换为您的设备的访问令牌。
{% endif %}

{% capture tabspec %}mqtt-attributes-request
A,MQTT.js,shell,resources/mqtt-js-attributes-request.sh,/docs/reference/resources/mqtt-js-attributes-request.sh
B,mqtt-js-attributes-request.js,javascript,resources/mqtt-js-attributes-request.js,/docs/reference/resources/mqtt-js-attributes-request.js
C,Result,json,resources/attributes-response.json,/docs/reference/resources/attributes-response.json{% endcapture %}
{% include tabs.html %}

**请注意**，客户端和共享设备属性键的交集是一种不好的做法！
但是，客户端、共享甚至服务器端属性仍然可以使用相同的键。

##### 订阅来自服务器的属性更新

为了订阅共享设备属性更改，请将 SUBSCRIBE 消息发送到以下主题：

```shell
v1/devices/me/attributes
```

当服务器端组件（例如 REST API 或规则链）更改共享属性时，客户端将收到以下更新：

```json
{"key1":"value1"}
```

{% capture tabspec %}mqtt-attributes-subscribe
A,Mosquitto,shell,resources/mosquitto-attributes-subscribe.sh,/docs/reference/resources/mosquitto-attributes-subscribe.sh
B,MQTT.js,shell,resources/mqtt-js-attributes-subscribe.sh,/docs/reference/resources/mqtt-js-attributes-subscribe.sh{% endcapture %}
{% include tabs.html %}

## JSON 值支持

{% include templates/api/json.md %}

## RPC API

### 服务器端 RPC

为了订阅来自服务器的 RPC 命令，请将 SUBSCRIBE 消息发送到以下主题：

```shell
v1/devices/me/rpc/request/+
```

订阅后，客户端将收到单独的命令作为 PUBLISH 消息发送到相应主题：

```shell
v1/devices/me/rpc/request/$request_id
```

其中 **$request_id** 是整数请求标识符。

客户端应将响应发布到以下主题：

```shell
v1/devices/me/rpc/response/$request_id
```

以下示例用 javascript 编写，并基于 mqtt.js。
纯命令行示例不可用，因为订阅和发布需要在同一个 mqtt 会话中进行。

{% if docsPrefix == null %}
不要忘记将 $ACCESS_TOKEN 替换为您的设备的访问令牌。不要忘记在 "mqtt-js-rpc-from-server.js" 文件中将主机名 "demo.thingsboard.io" 替换为您的主机。
在本示例中，主机名引用实时演示服务器。
{% endif %}
{% if docsPrefix == "pe/" %}
不要忘记将 $ACCESS_TOKEN 替换为您的设备的访问令牌。不要忘记在 "mqtt-js-rpc-from-server.js" 文件中将主机名 "127.0.0.1" 替换为您的主机。
在本示例中，主机名引用您的本地安装。
{% endif %}
{% if docsPrefix == 'paas/' %}
将 $ACCESS_TOKEN 替换为您的设备的访问令牌。
{% endif %}

- 使用 **RPC 调试终端** 仪表板；

- 订阅来自服务器的 RPC 命令；

- 向设备发送 RPC 请求 "connect"；

- 您应该收到来自设备的响应。

{% include images-gallery.html imageCollection="server-side-rpc" %}

{% capture tabspec %}mqtt-rpc-from-server
A,MQTT.js,shell,resources/mqtt-js-rpc-from-server.sh,/docs/reference/resources/mqtt-js-rpc-from-server.sh
B,mqtt-js-rpc-from-server.js,javascript,resources/mqtt-js-rpc-from-server.js,/docs/reference/resources/mqtt-js-rpc-from-server.js{% endcapture %}  
{% include tabs.html %}

如果您的 MQTT 设备是网关，ThingsBoard 将发送有关预配设备实体更改的服务器端 RPC（通知）。

您的 MQTT 网关设备将收到有关删除或重命名设备的服务 RPC，以 [正确解决此类事件](/docs/iot-gateway/how-device-removing-renaming-works/)。

### 客户端 RPC

为了向服务器发送 RPC 命令，请将 PUBLISH 消息发送到以下主题：

```shell
v1/devices/me/rpc/request/$request_id
```

其中 **$request_id** 是整数请求标识符。
来自服务器的响应将发布到以下主题：

```shell
v1/devices/me/rpc/response/$request_id
```

以下示例用 javascript 编写，并基于 mqtt.js。
纯命令行示例不可用，因为订阅和发布需要在同一个 mqtt 会话中进行。

{% if docsPrefix == null %}
不要忘记将 $ACCESS_TOKEN 替换为您的设备的访问令牌。不要忘记在 "mqtt-js-rpc-from-server.js" 文件中将主机名 "demo.thingsboard.io" 替换为您的主机。
在本示例中，主机名引用实时演示服务器。
{% endif %}
{% if docsPrefix == "pe/" %}
不要忘记将 $ACCESS_TOKEN 替换为您的设备的访问令牌。不要忘记在 "mqtt-js-rpc-from-server.js" 文件中将主机名 "127.0.0.1" 替换为您的主机。
在本示例中，主机名引用您的本地安装。
{% endif %}
{% if docsPrefix == 'paas/' %}
不要忘记将 $ACCESS_TOKEN 替换为您的设备的访问令牌。
{% endif %}

- 向规则链添加两个节点："脚本" 和 "rpc 调用回复"；

- 在 **脚本** 节点中输入函数：

```shell
return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};
```
{: .copy-code}

- 向服务器发送请求；

- 您应该收到来自服务器的响应。

{% include images-gallery.html imageCollection="client-side-rpc" %}

{% capture tabspec %}mqtt-rpc-from-client
A,example.sh,shell,resources/mqtt-js-rpc-from-client.sh,/docs/reference/resources/mqtt-js-rpc-from-client.sh
B,mqtt-js-rpc-from-client.js,javascript,resources/mqtt-js-rpc-from-client.js,/docs/reference/resources/mqtt-js-rpc-from-client.js{% endcapture %}
{% include tabs.html %}

## 声明设备

请参阅相应文章以获取有关 [声明设备](/docs/{{docsPrefix}}user-guide/claiming-devices) 功能的更多信息。

为了启动声明设备，请将 PUBLISH 消息发送到以下主题：

```shell
v1/devices/me/claim
```

支持的数据格式为：

```json
{"secretKey":"value", "durationMs":60000}
```

**请注意**，上述字段是可选的。如果未指定 **secretKey**，则使用空字符串作为默认值。
如果未指定 **durationMs**，则使用系统参数 **device.claim.duration**（在文件 **/etc/thingsboard/conf/thingsboard.yml** 中）。

## 设备预配

请参阅相应文章以获取有关 [设备预配](/docs/{{docsPrefix}}user-guide/device-provisioning) 功能的更多信息。

为了启动设备预配，请将预配请求发送到以下主题：

```shell
/provision
```

此外，您应将 **username** 或 **clientId** 设置为 *provision*。

支持的数据格式为：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "u7piawkboq8v32dmcmpp",
  "provisionDeviceSecret": "jpmwdn8ptlswmf4m29bw"
}
```

## 固件 API

当 ThingsBoard 启动 MQTT 设备固件更新时，它会设置 fw_title、fw_version、fw_checksum、fw_checksum_algorithm 共享属性。
为了接收共享属性更新，设备必须订阅

```bash
v1/devices/me/attributes/response/+
```
{: .copy-code}

其中

**+** 是通配符。

当 MQTT 设备收到 fw_title 和 fw_version 共享属性的更新时，它必须向

```bash
v2/fw/request/${requestId}/chunk/${chunkIndex} 
```
{: .copy-code}

发送 PUBLISH 消息。

其中

**${requestId}** - 对应于固件更新数量的数字。 ${requestId} 对于每次固件更新都必须不同。  
**${chunkIndex}** - 对应于固件块索引的数字。 ${chunkID} 从 0 开始计数。设备必须为每个请求递增块索引，直到接收到的块大小为零。  
MQTT 有效负载应为固件块的字节大小。

对于每次新的固件更新，您需要更改请求 ID 并订阅

```bash
v2/fw/response/+/chunk/+
```
{: .copy-code}

其中

**+** 是通配符。

## 协议自定义

MQTT 传输可以通过更改相应的 [模块](https://github.com/thingsboard/thingsboard/tree/master/transport/mqtt) 来针对特定用例进行完全自定义。


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}