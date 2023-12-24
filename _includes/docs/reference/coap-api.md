* TOC
{:toc}

## 入门

##### CoAP 基础知识

[CoAP](https://en.wikipedia.org/wiki/Constrained_Application_Protocol) 是适用于受限设备的轻量级 IoT 协议。您可以在 [此处](https://tools.ietf.org/html/rfc7252) 找到有关 CoAP 的更多信息。
CoAP 协议基于 UDP，但类似于 HTTP，它使用请求-响应模型。
CoAP 观察 [选项](https://tools.ietf.org/html/rfc7641) 允许订阅资源并在资源更改时接收通知。

GridLinks 服务器节点充当支持常规请求和观察请求的 CoAP 服务器。

##### 客户端库设置

您可以在网络上找到适用于不同编程语言的 CoAP 客户端库。本文中的示例将基于 [CoAP cli](https://www.npmjs.com/package/coap-cli)。
要在 Linux 或 macOS 上设置此工具，您可以使用以下命令：

```bash
npm install coap-cli -g
```
{: .copy-code}

{% capture difference %}
**注意：**
<br>
CoAP cli 不支持查询参数。如果您需要使用查询参数，则应该改用 [coap client](https://manpages.ubuntu.com/manpages/focal/man5/coap-client.5.html)。要安装 coap-client，请执行： <br>
{% endcapture %}
{% include templates/info-banner.md content=difference %}

* **Ubuntu 20.04：** ```sudo apt install libcoap2-bin```
* **Ubuntu 18.04：** ```sudo apt install libcoap1-bin```

##### CoAP 身份验证和错误代码

我们将在本文中使用 *访问令牌* 设备凭据，稍后将它们称为 **$ACCESS_TOKEN**。
应用程序需要将 **$ACCESS_TOKEN** 作为路径参数包含在每个 CoAP 请求中。
可能出现的错误代码及其原因：

* **4.00 错误的请求** - 无效的 URL、请求参数或正文。
* **4.01 未授权** - 无效的 **$ACCESS_TOKEN**。
* **4.04 未找到** - 未找到资源。

另一种身份验证选项是使用 [X.509 证书](/docs/{{docsPrefix}}user-guide/ssl/coap-x509-certificates/)。

{% include templates/api/key-value-format.md %}

但是，也可以通过 [Protocol Buffers](https://developers.google.com/protocol-buffers) 发送数据。
请参阅设备配置文件文章中的 [CoAP 传输类型](/docs/{{docsPrefix}}user-guide/device-profiles/#coap-transport-type) 配置部分以了解更多详细信息。

也可以使用自定义二进制格式或某些序列化框架。有关更多详细信息，请参阅 [协议自定义](#protocol-customization)。

## 遥测上传 API

要将遥测数据发布到 GridLinks 服务器节点，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

{% endif %}

{% if docsPrefix == "paas/" %}

```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

最简单的支持的数据格式是：

```json
{"key1":"value1", "key2":"value2"}
```

或

```json
[{"key1":"value1"}, {"key2":"value2"}]
```

{% capture difference %}
**请注意**
<br>
在这种情况下，服务器端时间戳将被分配给上传的数据！
{% endcapture %}
{% include templates/info-banner.md content=difference %}

如果您的设备能够获取客户端时间戳，则可以使用以下格式：

```json
{"ts":1451649600512, "values":{"key1":"value1", "key2":"value2"}}
```

在上面的示例中，我们假设 "1451649600512" 是具有毫秒精度的 [unix 时间戳](https://en.wikipedia.org/wiki/Unix_time)。
例如，值 '1451649600512' 对应于 'Fri, 01 Jan 2016 12:00:00.512 GMT'

{% capture tabspec %}coap-telemetry-upload
A,示例,shell,resources/coap-telemetry.sh,/docs/reference/resources/coap-telemetry.sh
B,telemetry-data-as-object.json,json,resources/telemetry-data-as-object.json,/docs/reference/resources/telemetry-data-as-object.json
C,telemetry-data-as-array.json,json,resources/telemetry-data-as-array.json,/docs/reference/resources/telemetry-data-as-array.json
D,telemetry-data-with-ts.json,json,resources/telemetry-data-with-ts.json,/docs/reference/resources/telemetry-data-with-ts.json{% endcapture %}
{% include tabs.html %}


## 属性 API

ThingsBoard 属性 API 允许设备

* 将 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性上传到服务器。
* 从服务器请求 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 和 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。
* 订阅服务器的 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。

##### 将属性更新发布到服务器

要将客户端设备属性发布到 GridLinks 服务器节点，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}

```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

{% capture tabspec %}coap-attributes-upload
A,示例,shell,resources/coap-attributes-publish.sh,/docs/reference/resources/coap-attributes-publish.sh
B,new-attributes-values.json,json,resources/new-attributes-values.json,/docs/reference/resources/new-attributes-values.json{% endcapture %}
{% include tabs.html %}

##### 从服务器请求属性值

要向 GridLinks 服务器节点请求客户端或共享设备属性，请向以下 URL 发送 GET 请求：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

{% capture difference %}
**注意：**
<br>
此示例使用 coap-client 而不是 CoAP cli，因为 CoAP cli 不支持查询参数。请参阅 [客户端库设置](#docsContent)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture tabspec %}coap-attributes-request
A,示例,shell,resources/coap-attributes-request.sh,/docs/reference/resources/coap-attributes-request.sh
B,结果,json,resources/attributes-response.json,/docs/reference/resources/attributes-response.json{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**请注意：**
<br>
客户端和共享设备属性键的交集是一种不好的做法！
但是，客户端、共享甚至服务器端属性仍然可以使用相同的键。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### 订阅服务器的属性更新

要订阅共享设备属性的更改，请向以下 URL 发送带有观察选项的 GET 请求：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

一旦共享属性被服务器端组件（REST API 或规则链）之一更改，客户端将收到以下更新：

{% capture tabspec %}coap-attributes-subscribe
A,示例,shell,resources/coap-attributes-subscribe.sh,/docs/reference/resources/coap-attributes-subscribe.sh
B,结果,json,resources/attributes-response.json,/docs/reference/resources/attributes-response.json{% endcapture %}
{% include tabs.html %}

## JSON 值支持

{% include templates/api/json.md %}

## RPC API

##### 服务器端 RPC

要订阅服务器的 RPC 命令，请向以下 URL 发送带有观察标志的 GET 请求：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

订阅后，客户端可能会收到 rpc 请求。RPC 请求正文的示例如下：

```json
{
  "id": "1",
  "method": "setGpio",
  "params": {
    "pin": "23",
    "value": 1
  }
}
```

其中

 - **id** - 请求 id，整数请求标识符；
 - **method** - RPC 方法名称，字符串；
 - **params** - RPC 方法参数，自定义 json 对象。

并可以使用 POST 请求向以下 URL 回复它们：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}

{% endif %}

其中 **$id** 是整数请求标识符。
<br>
<br>
**我们来看一个例子：**

- 使用 **RPC 调试终端** 仪表板；

- 订阅服务器的 RPC 命令。为此，在第一个终端窗口中发送带有观察标志的 GET 请求；

- 向设备发送 RPC 请求“连接”；

- 在第二个终端窗口中模拟从设备向服务器发送响应；

- 您应该收到来自设备的响应：{"result":"ok"}

{% include images-gallery.html imageCollection="server-side-rpc" %}

{% capture tabspec %}coap-rpc-command
A,示例订阅,shell,resources/coap-rpc-subscribe.sh,/docs/reference/resources/coap-rpc-subscribe.sh
B,示例回复,shell,resources/coap-rpc-reply.sh,/docs/reference/resources/coap-rpc-reply.sh
C,rpc-response.json,shell,resources/rpc-response.json,/docs/reference/resources/rpc-response.json{% endcapture %}
{% include tabs.html %}

##### 客户端 RPC

要向服务器发送 RPC 命令，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

请求和响应正文都应该是有效的 JSON 文档。文档的内容取决于将处理您请求的规则节点。
<br>
<br>
**我们来看一个例子：**

- 向规则链添加两个节点：“脚本”和“rpc 调用回复”；

- 在 **脚本** 节点中输入函数：

```shell
return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};
```
{: .copy-code}
- 向服务器发送请求；

- 您应该收到来自服务器的响应。

{% include images-gallery.html imageCollection="client-side-rpc" %}

{% capture tabspec %}coap-rpc-from-client
A,示例请求,shell,resources/coap-rpc-from-client.sh,/docs/reference/resources/coap-rpc-from-client.sh
B,rpc-client-request.json,shell,resources/rpc-client-request.json,/docs/reference/resources/rpc-client-request.json
C,响应正文,shell,resources/rpc-server-response.json,/docs/reference/resources/rpc-server-response.json{% endcapture %}
{% include tabs.html %}

## 声明设备

请参阅相应文章以获取有关 [声明设备](/docs/{{docsPrefix}}user-guide/claiming-devices) 功能的更多信息。

要启动声明设备，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

支持的数据格式为：

```json
{"secretKey":"value", "durationMs":60000}
```

{% capture difference %}
**请注意**
<br>
以上字段是可选的。如果未指定 **secretKey**，则使用空字符串作为默认值。如果未指定 **durationMs**，则使用系统参数 **device.claim.duration**（在文件 **/etc/thingsboard/conf/thingsboard.yml** 中）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 设备配置

请参阅相应文章以获取有关 [设备配置](/docs/{{docsPrefix}}user-guide/device-provisioning) 功能的更多信息。

要启动设备配置，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap://$THINGSBOARD_HOST_NAME/api/v1/provision
```
{: .copy-code}

其中 **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap://demo.thingsboard.io/api/v1/provision
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap://coap.thingsboard.cloud/api/v1/provision
```
{: .copy-code}
{% endif %}

支持的数据格式为：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "u7piawkboq8v32dmcmpp",
  "provisionDeviceSecret": "jpmwdn8ptlswmf4m29bw"
}
```

## 固件 API

CoAP 客户端必须向以下位置发出 GET 请求

{% if docsPrefix == null or docsPrefix == "pe/"%}
```shell
coap get coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 您的本地主机或平台地址；
- **$ACCESS_TOKEN** - 设备访问令牌；
- **$TITLE** - 固件标题；
- **$VERSION** - 目标固件的版本。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
coap get coap://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
coap get coap://coap.thingsboard.cloud/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

其中
- **$ACCESS_TOKEN** - 设备访问令牌；
- **$TITLE** - 固件标题；
- **$VERSION** - 目标固件的版本。

{% endif %}

## 协议定制

CoAP 传输可以通过更改相应的 [模块](https://github.com/thingsboard/thingsboard/tree/master/transport/coap) 来完全自定义以满足特定用例。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}