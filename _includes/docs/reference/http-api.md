* TOC
{:toc}

## 入门

##### HTTP 基础知识

[HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) 是一种通用网络协议，可用于物联网应用。
您可以在 [此处](https://www.w3.org/Protocols/rfc2616/rfc2616.txt) 找到有关 HTTP 的更多信息。
HTTP 协议基于 TCP，并使用请求-响应模型。

ThingsBoard 服务器节点充当支持 HTTP 和 HTTPS 协议的 HTTP 服务器。

##### 客户端库设置

您可以在网络上找到适用于不同编程语言的 HTTP 客户端库。本文中的示例将基于 [curl](https://en.wikipedia.org/wiki/CURL)。
为了设置此工具，您可以使用我们的 [Hello World](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南中的说明。

##### HTTP 身份验证和错误代码

我们将在本文中使用 *访问令牌* 设备凭据，稍后将它们称为 **$ACCESS_TOKEN**。
应用程序需要在每个 HTTP 请求中将 **$ACCESS_TOKEN** 作为路径参数包含在内。
可能的错误代码及其原因：

* **400 Bad Request** - 无效的 URL、请求参数或正文。
* **401 Unauthorized** - 无效的 **$ACCESS_TOKEN**。
* **404 Not Found** - 未找到资源。

{% include templates/api/key-value-format.md %}

也可以使用自定义二进制格式或某些序列化框架。有关更多详细信息，请参阅 [协议自定义](#protocol-customization)。

## 遥测上传 API

为了将遥测数据发布到 ThingsBoard 服务器节点，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry
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

在这种情况下，服务器端时间戳将被分配给上传的数据！

如果您的设备能够获取客户端时间戳，则可以使用以下格式：

```json
{"ts":1451649600512, "values":{"key1":"value1", "key2":"value2"}}
```

在上面的示例中，我们假设 "1451649600512" 是具有毫秒精度的 [unix 时间戳](https://en.wikipedia.org/wiki/Unix_time)。
例如，值 '1451649600512' 对应于 'Fri, 01 Jan 2016 12:00:00.512 GMT'

{% capture tabspec %}http-telemetry-upload
A,示例,shell,resources/http-telemetry.sh,/docs/reference/resources/http-telemetry.sh
B,telemetry-data-as-object.json,json,resources/telemetry-data-as-object.json,/docs/reference/resources/telemetry-data-as-object.json
C,telemetry-data-as-array.json,json,resources/telemetry-data-as-array.json,/docs/reference/resources/telemetry-data-as-array.json
D,telemetry-data-with-ts.json,json,resources/telemetry-data-with-ts.json,/docs/reference/resources/telemetry-data-with-ts.json{% endcapture %}
{% include tabs.html %}

## 属性 API

ThingsBoard 属性 API 允许设备

* 将 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性上传到服务器。
* 从服务器请求 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 和 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。
* 订阅来自服务器的 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 设备属性。

##### 将属性更新发布到服务器

为了将客户端设备属性发布到 ThingsBoard 服务器节点，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

{% capture tabspec %}http-attributes-upload
A,示例,shell,resources/http-attributes-publish.sh,/docs/reference/resources/http-attributes-publish.sh
C,new-attributes-values.json,json,resources/new-attributes-values.json,/docs/reference/resources/new-attributes-values.json{% endcapture %}
{% include tabs.html %}

##### 从服务器请求属性值

为了向 ThingsBoard 服务器节点请求客户端或共享设备属性，请向以下 URL 发送 GET 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

{% capture tabspec %}http-attributes-request
A,示例,shell,resources/http-attributes-request.sh,/docs/reference/resources/http-attributes-request.sh
B,结果,json,resources/attributes-response.json,/docs/reference/resources/attributes-response.json{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**请注意**
<br>
客户端和共享设备属性键的交集是一种不好的做法！
但是，客户端、共享甚至服务器端属性仍然可以使用相同的键。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### 订阅来自服务器的属性更新

为了订阅共享设备属性的更改，请向以下 URL 发送带有可选的 "timeout" 请求参数的 GET 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes/updates
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/attributes/updates
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/attributes/updates
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

一旦共享属性被服务器端组件之一（REST API 或规则链）更改，客户端将收到以下更新：

{% capture tabspec %}http-attributes-subscribe
A,示例,shell,resources/http-attributes-subscribe.sh,/docs/reference/resources/http-attributes-subscribe.sh
B,结果,json,resources/attributes-response.json,/docs/reference/resources/attributes-response.json{% endcapture %}
{% include tabs.html %}

## JSON 值支持

{% include templates/api/json.md %}

## RPC API

### 服务器端 RPC

为了订阅来自服务器的 RPC 命令，请向以下 URL 发送带有可选的 "timeout" 请求参数的 GET 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

订阅后，客户端可能会收到 rpc 请求或超时消息（如果没有对特定设备的请求）。
RPC 请求正文的示例如下：

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

 - **id** - 请求 id，整数请求标识符
 - **method** - RPC 方法名称，字符串
 - **params** - RPC 方法参数，自定义 json 对象

并可以使用 POST 请求回复它们，网址如下：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}

{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}

{% endif %}

其中 **$id** 是整数请求标识符。
<br>
<br>
**我们来看一个例子：**

- 使用 **RPC 调试终端** 仪表板；

- 订阅来自服务器的 RPC 命令。为此，在第一个终端窗口中发送带有观察标志的 GET 请求；

- 向设备发送 RPC 请求 "connect"；

- 在第二个终端窗口中模拟从设备向服务器发送响应；

- 您应该收到来自设备的响应：{"result":"ok"}

{% include images-gallery.html imageCollection="server-side-rpc" %}

{% capture tabspec %}http-rpc-from-server
A,示例订阅,shell,resources/http-rpc-subscribe.sh,/docs/reference/resources/http-rpc-subscribe.sh
B,示例回复,shell,resources/http-rpc-reply.sh,/docs/reference/resources/http-rpc-reply.sh
C,回复正文,shell,resources/rpc-response.json,/docs/reference/resources/rpc-response.json{% endcapture %}
{% include tabs.html %}

### 客户端 RPC

为了向服务器发送 RPC 命令，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

其中 **$ACCESS_TOKEN** - 设备访问令牌。

{% endif %}

请求和响应正文都应该是有效的 JSON 文档。文档的内容取决于将处理您请求的规则节点。
<br>
<br>
**我们来看一个例子：**

- 向规则链添加两个节点："脚本" 和 "rpc 调用回复"；

- 在 **脚本** 节点中输入函数：

```shell
return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};
```
{: .copy-code}
- 向服务器发送请求；

- 您应该收到来自服务器的响应。

{% include images-gallery.html imageCollection="client-side-rpc" %}

{% capture tabspec %}http-rpc-from-client
A,示例请求,shell,resources/http-rpc-from-client.sh,/docs/reference/resources/http-rpc-from-client.sh
B,rpc-client-request.json,shell,resources/rpc-client-request.json,/docs/reference/resources/rpc-client-request.json
C,响应正文,shell,resources/rpc-server-response.json,/docs/reference/resources/rpc-server-response.json{% endcapture %}  
{% include tabs.html %}

## 声明设备

请参阅相应文章以获取有关 [声明设备](/docs/{{docsPrefix}}user-guide/claiming-devices) 功能的更多信息。

为了启动声明设备，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/claim
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
上面的字段是可选的。如果未指定 **secretKey**，则使用空字符串作为默认值。
如果未指定 **durationMs**，则使用系统参数 **device.claim.duration**（在文件 **/etc/thingsboard/conf/thingsboard.yml** 中）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 设备配置

请参阅相应文章以获取有关 [设备配置](/docs/{{docsPrefix}}user-guide/device-provisioning) 功能的更多信息。

为了启动设备配置，请向以下 URL 发送 POST 请求：

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/provision
```
{: .copy-code}

其中 **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/provision
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/provision
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

当 ThingsBoard 通过 HTTP 启动固件更新时，它会设置 fw_title、fw_version、fw_checksum、fw_checksum_algorithm 共享属性。
为了接收共享属性更新，设备必须 GET 请求

{% if docsPrefix == null or docsPrefix == "pe/" %}
```shell
http(s)://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或 IP 地址；
- **$ACCESS_TOKEN** - 设备访问令牌；  
- **$TITLE** - 固件标题；  
- **$VERSION** - 目标固件的版本。
{% endif %}
{% if docsPrefix == null %}
如果您使用实时演示服务器，则命令如下所示：

```shell
https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" %}

```shell
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

其中
- **$ACCESS_TOKEN** - 设备访问令牌；
- **$TITLE** - 固件标题；
- **$VERSION** - 目标固件的版本。

{% endif %}

## 协议定制

HTTP 传输可以通过更改相应的 [模块](https://github.com/thingsboard/thingsboard/tree/master/transport/http) 来完全定制以满足特定用例。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}