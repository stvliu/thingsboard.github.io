{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

TCP 集成允许将使用 TCP 传输协议的数据从设备流式传输到 GridLinks，并将这些设备的有效负载转换为 GridLinks 格式。


**请注意** TCP 集成只能作为 [远程集成](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations) 启动。它可以在运行 TB 实例的同一台机器上启动，或者你可以在另一台机器上启动，该机器可以通过网络访问 TB 实例。

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/tcp-integration.svg)

## TCP 集成配置

### 前提条件

在本教程中，我们将使用：

{% if docsPrefix == "pe/" %}
 - 本地安装的 [ GridLinks专业版](https://docs.codingas.com/docs/user-guide/install/pe/installation-options/) 实例；
{% endif %}
{% if docsPrefix == "paas/" %}
 -  GridLinks专业版 实例 — [thingsboard.cloud](https://thingsboard.cloud)；
{% endif %}
 - 外部运行并连接到云 GridLinks PE 实例的 TCP 集成；
 - **echo** 命令，用于显示一行文本，并将输出重定向到 **netcat** (**nc**) 实用程序；
 - **netcat** (**nc**) 实用程序，用于建立 TCP 连接，从那里接收数据并传输数据；    

我们假设我们有一个传感器，它正在发送当前温度和湿度读数。
我们的传感器设备 **SN-002** 将其温度和湿度读数发布到 **10560** 端口上的 TCP 集成，该端口位于运行 TCP 集成的机器上。

出于演示目的，我们假设我们的设备足够智能，可以发送 3 种不同的有效负载类型的数据：
 - **文本** - 在这种情况下，有效负载为：

```text
SN-002,default,temperature,25.7\n\rSN-002,default,humidity,69
```

 - **JSON** - 在这种情况下，有效负载为：

```json
[
  {
    "deviceName": "SN-002",
    "deviceType": "default",
    "temperature": 25.7,
    "humidity": 69
  }
]
```
 - **二进制** - 在这种情况下，有效负载如下所示（十六进制字符串）：

```text
\x30\x30\x30\x30\x11\x53\x4e\x2d\x30\x30\x32\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x00\x00\x00
```

以下是此有效负载中字节的说明：
 - **0-3** 字节 - **\x30\x30\x30\x30** - 虚拟字节，用于显示如何在有效负载中跳过特定前缀字节。这些字节包含在示例中；
 - **4** 字节 - **\x11** - 有效负载长度。如果我们将其转换为十进制 - **17**。因此，在这种情况下，我们的有效负载限制为来自传入 TCP 帧的 17 个字节；
 - **5-10** 字节 - **\x53\x4e\x2d\x30\x30\x32** - 设备名称。如果我们将其转换为文本 - **SN-002**；
 - **11-17** 字节 - **\x64\x65\x66\x61\x75\x6c\x74** - 设备类型。如果我们将其转换为文本 - **default**；
 - **18-21** 字节 - **\x32\x35\x2e\x37** - 温度遥测。如果我们将其转换为文本 - **25.7**；
 - **22-24** 字节 - **\x00\x00\x00** - 虚拟字节。我们将忽略它们，因为有效负载大小为 **17** 字节 - 从 **5** 到 **21** 字节。这些字节包含在示例中；

你可以根据设备功能和业务案例选择有效负载类型。

{% capture difference %}
**请注意**
<br>
在运行 TCP 集成的机器上，必须为传入连接打开端口 **10560** - **nc** 实用程序必须能够连接到 TCP 套接字。如果你在本地运行它，它应该没有任何其他更改即可正常工作。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 上行转换器

在设置 **TCP 集成** 之前，你需要创建一个 **上行转换器**，它是一个用于解析和转换 TCP 集成接收的数据的脚本，使其成为 GridLinks 可以使用的一种格式。
**deviceName** 和 **deviceType** 是必需的，而 **attributes** 和 **telemetry** 是可选的。 **attributes** 和 **telemetry** 是扁平键值对象。不支持嵌套对象。

要创建 **上行转换器**，请转到 **数据转换器** 部分，然后单击 **添加新的数据转换器 —> 创建新的转换器**。
将其命名为 **“TCP 上行转换器”**，然后选择类型 **上行**。现在使用调试模式。

{% capture difference %}
**注意**
<br>
尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**选择设备有效负载类型以进行解码器配置：**

- **文本有效负载**

{% include templates/tbel-vs-js.md %}

{% capture tcpuplinktext %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/tcp/tcp-uplink-text-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/tcp/tcp-uplink-text-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpuplinktext" toggle-spec=tcpuplinktext %}

- **JSON 有效负载**

{% capture tcpuplinkjson %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/tcp/tcp-uplink-json-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/tcp/tcp-uplink-json-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpuplinkjson" toggle-spec=tcpuplinkjson %}

- **二进制有效负载**

{% capture tcpuplinkbinary %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/tcp/tcp-uplink-binary-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/tcp/tcp-uplink-binary-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpuplinkbinary" toggle-spec=tcpuplinkbinary %}

### TCP 集成设置

- 转到 **集成** 部分，然后单击 **添加新的集成** 按钮。将其命名为 **TCP 集成**，选择类型 **TCP**；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-1-paas.png)
{% endif %}

- 添加最近创建的 UDP 上行转换器；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-2-paas.png)
{% endif %}

- 现在，将“下行数据转换器”字段留空。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-3-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-3-paas.png)
{% endif %}

正如你提到的，**远程执行** 已选中且无法修改 - TCP 集成只能是 **远程** 类型。

默认情况下，TCP 集成将使用 **10560** 端口，但你可以在你的案例中将其更改为任何可用的端口。

请记下 **集成密钥** 和 **集成机密** - 我们将在远程 TCP 集成本身的配置中使用这些值。

我们默认保留其他选项，但这里是对它们的简要说明：
- **套接字上挂起的连接的最大数量** - 传入连接指示（连接请求）的最大队列长度设置为 backlog 参数。如果队列已满时出现连接指示，则拒绝连接；
- **入站套接字的缓冲区大小** - 套接字数据接收缓冲区的 KBytes 大小；
- **出站套接字的缓冲区大小** - 套接字数据发送缓冲区的 KBytes 大小；
- **启用在面向连接的套接字上发送保持活动消息** - 一个标志，指示应定期通过网络向对端套接字发送探测，以保持连接处于活动状态；
- **强制套接字在不缓冲的情况下发送数据（禁用 Nagle 的缓冲算法）** - 在套接字上禁用 Nagle 的算法，该算法会延迟数据传输，直到积累一定量的待处理数据。

为 **处理程序配置** 选择设备有效负载类型

{% capture handlerconfiguration %}
文本有效负载<br>%,%text%,%templates/integration/tcp/tcp-handler-configuration-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/tcp/tcp-handler-configuration-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/tcp/tcp-handler-configuration-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpintegrationhandlerconfiguration" toggle-spec=handlerconfiguration %}

单击 **添加** 以保存集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-4-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-setup-4-paas.png)
{% endif %}

#### 安装和运行外部 TCP 集成

请参阅 [远程集成指南](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations)并在本地或单独的机器上安装 TCP 集成服务。

请在你的 TCP 集成配置中使用上述部分中的 **集成密钥** 和 **集成机密**。

### 发送上行消息

创建 GridLinks TCP 集成后，TCP 服务器启动，然后等待来自设备的数据。

选择设备有效负载类型以发送上行消息

{% capture senduplink %}
文本有效负载<br>%,%text%,%templates/integration/tcp/tcp-send-uplink-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/tcp/tcp-send-uplink-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/tcp/tcp-send-uplink-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpintegrationsenduplink" toggle-spec=senduplink %}

一旦你转到 **设备组 -> 全部**，你应该找到由集成预配的 **SN-002** 设备。
单击设备，转到 **最新遥测** 选项卡以查看“温度”键及其值（25.7）。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-create-device-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-integration-create-device-1-paas.png)
{% endif %}

如果你的有效负载包含 **湿度** 遥测，你应该也会在那里看到“湿度”键及其值（69）。

## 高级用法：下行转换器

在 **数据转换器** 中使用默认脚本创建 **下行转换器**。要查看事件 - 启用 **调试**。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-downlink-converter-tbel-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-downlink-converter-tbel-1-paas.png)
{% endif %}

将转换器添加到集成。你可以根据你的配置自定义下行链路。
让我们考虑一个示例，其中我们发送属性更新消息。因此，我们应该在 `//downlink data` 下的行中更改下行编码器函数中的代码

```
data: JSON.stringify(msg)
```
其中 ***msg*** 是我们接收并发送回设备的消息。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-edit-downlink-converter-tbel-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-edit-downlink-converter-tbel-1-paas.png)
{% endif %}

现在你必须将转换器添加到集成。
可以选择配置缓存大小和缓存生存时间（分钟）（仅适用于 UDP 下行链路）。

{% capture difference %}
缓存大小和生存时间 - 有助于避免在存储连接时出现内存泄漏的功能。<br>
缓存生存时间 - 存储消息的时间。<br>
缓存大小 - UDP 客户端的最大消息大小。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-add-downlink-converter-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-add-downlink-converter-paas.png)
{% endif %}

<br>


当集成配置好并可以使用时，我们需要转到规则链，选择“根规则链”，然后在这里创建规则节点 **集成下行链路**。在此处输入一些名称，选择你需要使用的集成，然后点击 **添加**。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-rule-chain-downlink-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-rule-chain-downlink-paas.png)
{% endif %}

完成这些步骤后，我们需要点击规则节点 **消息类型开关** 的右侧灰色圆圈，并将此圆圈拖动到“集成下行链路”的左侧，在这里让我们选择 **属性更新**，点击“添加”并保存规则节点。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-rule-chain-and-attributes-updated-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-rule-chain-and-attributes-updated-paas.png)
{% endif %}

### 测试下行链路

要测试下行链路，请转到 **设备组** 部分中的 **“全部”** 文件夹。在设备 **SN-002** 上创建一些 **共享属性** 并在此设备上发送一些上行消息。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-shared-add-attribute-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-shared-add-attribute-paas.png)
{% endif %}

接收的数据和发送的数据可以在下行转换器中查看。在 **事件** 选项卡的 **“In”** 块中，我们看到输入了哪些数据：

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-downlink-converter-events-in-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-downlink-converter-events-in-paas.png)
{% endif %}

**“Out”** 字段显示到设备的消息：

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-downlink-converter-events-out-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-downlink-converter-events-out-paas.png)
{% endif %}

终端中发送消息和来自 GridLinks 的响应的示例：

![image](/images/user-guide/integrations/tcp/tcp-terminal-send-downlink-message.png)

此命令将上行消息发送到 GridLinks，如果消息存在，它将在 60 秒内等待下行消息。
要了解如何发送上行消息，请 [在此处阅读](/docs/{{peDocsPrefix}}user-guide/integrations/tcp/?tcpintegrationsenduplink=text&tcpintegrationhandlerconfiguration=text&tcpintegartionuplinkpayload=json#send-uplink-message)



## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}