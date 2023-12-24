{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

UDP 集成允许将使用 UDP 协议的设备的数据流式传输到 ThingsBoard，并将这些设备的有效负载转换为 ThingsBoard 格式。

**请注意** UDP 集成只能作为 [远程集成](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations) 启动。它可以在运行 TB 实例的同一台机器上启动，或者你可以在另一台机器上启动，该机器可以通过网络访问 TB 实例。

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/udp-integration.svg)

## UDP 集成配置

### 先决条件

在本教程中，我们将使用：

{% if docsPrefix == "pe/" %}
- 本地安装的 [ThingsBoard Professional Edition](https://thingsboard.io/docs/user-guide/install/pe/installation-options/) 实例；
  {% endif %}
  {% if docsPrefix == "paas/" %}
- ThingsBoard Professional Edition 实例 — [thingsboard.cloud](https://thingsboard.cloud)；
  {% endif %}
- 外部运行并连接到云 ThingsBoard PE 实例的 UDP 集成；
- **echo** 命令，用于显示一行文本，并将输出重定向到 **netcat** (**nc**) 实用程序；
- **netcat** (**nc**) 实用程序，用于建立 UDP 连接，从那里接收数据并传输数据；

我们假设我们有一个传感器，它正在发送当前温度和湿度读数。
我们的传感器设备 **SN-001** 将其温度和湿度读数发布到 **11560** 端口的 UDP 集成，该端口位于运行 UDP 集成的机器上。

出于演示目的，我们假设我们的设备足够智能，可以发送 4 种不同的有效负载类型的数据：
- **文本** - 在这种情况下，有效负载为：

```text
SN-001,default,temperature,25.7,humidity,69
```

- **JSON** - 在这种情况下，有效负载为：

```json
{
  "deviceName": "SN-001",
  "deviceType": "default",
  "temperature": 25.7,
  "humidity": 69
}

```

- **二进制** - 在这种情况下，有效负载如下所示（以 HEX 字符串表示）：

```text
\x53\x4e\x2d\x30\x30\x31\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x36\x39
``` 

以下是此有效负载中字节的说明：
- **0-5** 字节 - **\x53\x4e\x2d\x30\x30\x31** - 设备名称。如果我们将其转换为文本 - **SN-001**；
- **6-12** 字节 - **\x64\x65\x66\x61\x75\x6c\x74** - 设备类型。如果我们将其转换为文本 - **default**；
- **13-16** 字节 - **\x32\x35\x2e\x37** - 温度遥测。如果我们将其转换为文本 - **25.7**；
- **17-18** 字节 - **\x36\x39** - 湿度遥测。如果我们将其转换为文本 - **69**。
<br>
- **十六进制** - 在这种情况下，有效负载是十六进制字符串：

```text
534e2d30303164656661756c7432352e373639
``` 

以下是此有效负载中字节的说明：
  - **0-5** 字节 - **534e2d303031** - 设备名称。如果我们将其转换为文本 - **SN-001**；
  - **6-12** 字节 - **64656661756c74** - 设备类型。如果我们将其转换为文本 - **default**；
  - **13-16** 字节 - **32352e37** - 温度遥测。如果我们将其转换为文本：- **25.7**；
  - **17-18** 字节 - **3639** - 湿度遥测。如果我们将其转换为文本：- **69**。

你可以根据你的设备功能和业务案例选择有效负载类型。

{% capture difference %}
**请注意**
<br>
在运行 UDP 集成的机器上，必须为传入连接打开 **11560** 端口 - **nc** 实用程序必须能够连接到 UDP 套接字。如果你在本地运行它，它应该没有任何其他更改即可正常工作。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 上行转换器

在设置 **UDP 集成** 之前，你需要创建一个 **上行转换器**，它是一个用于解析和转换 UDP 集成接收的数据的脚本，以供 ThingsBoard 使用的格式。
**deviceName** 和 **deviceType** 是必需的，而属性和遥测是可选的。属性和遥测是扁平的键值对象。不支持嵌套对象。

要创建 **上行转换器**，请转到 **数据转换器** 部分，然后单击 **添加新的数据转换器 —> 创建新的转换器**。
将其命名为 **“UDP 上行转换器”**，然后选择类型 **上行**。现在使用调试模式。

{% capture difference %}
**注意**
<br>
尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**选择设备有效负载类型以进行解码器配置：**

- **文本有效负载**

{% include templates/tbel-vs-js.md %}

{% capture udpuplinktext %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/udp/udp-uplink-text-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/udp/udp-uplink-text-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpuplinktext" toggle-spec=udpuplinktext %}

- **JSON 有效负载**

{% capture udpuplinkjson %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/udp/udp-uplink-json-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/udp/udp-uplink-json-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpuplinkjson" toggle-spec=udpuplinkjson %}

- **二进制有效负载**

{% capture udpuplinkbinary %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/udp/udp-uplink-binary-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/udp/udp-uplink-binary-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpuplinkbinary" toggle-spec=udpuplinkbinary %}

- **十六进制有效负载**

{% capture udpuplinkhex %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/udp/udp-uplink-hex-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/udp/udp-uplink-hex-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpuplinkhex" toggle-spec=udpuplinkhex %}

### UDP 集成设置

- 转到 **集成** 部分，然后单击 **添加新集成** 按钮。将其命名为 **UDP 集成**，选择类型 **UDP**；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-1-paas.png)
{% endif %}

- 添加最近创建的 UDP 上行转换器；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-2-paas.png)
{% endif %}

- 现在，将“下行数据转换器”字段留空。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-3-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-3-paas.png)
{% endif %}

正如你提到的，**远程执行** 已选中且无法修改 - UDP 集成只能是 **远程** 类型。

默认情况下，UDP 集成将使用 **11560** 端口，但你可以根据你的情况将其更改为任何可用的端口。

请记下 **集成密钥** 和 **集成机密** - 我们将在稍后的远程 UDP 集成本身的配置中使用这些值。

我们默认保留其他选项，但这里是对它们的简要说明：
- **启用广播 - 集成将接受广播地址数据包** - 一个标志，表示集成将接受发送到广播地址的 UDP 数据包；
- **入站套接字的缓冲区大小** - 套接字数据接收缓冲区的 KBytes 大小；

为 **处理程序配置** 选择设备有效负载类型

{% capture handlerconfiguration %}
文本有效负载<br>%,%text%,%templates/integration/udp/udp-handler-configuration-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/udp/udp-handler-configuration-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/udp/udp-handler-configuration-binary.md%br%
十六进制有效负载<br>%,%hex%,%templates/integration/udp/udp-handler-configuration-hex.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpintegrationhandlerconfiguration" toggle-spec=handlerconfiguration %}

单击 **添加** 以保存集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-4-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-integration-setup-4-paas.png)
{% endif %}

#### 安装和运行外部 UDP 集成

请参阅 [远程集成指南](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations)并在本地或单独的机器上安装 UDP 集成服务。

请在 UDP 集成配置中使用上述部分中的 **集成密钥** 和 **集成机密**。

### 发送上行消息

创建 ThingsBoard UDP 集成后，UDP 服务器启动，然后等待来自设备的数据。

选择设备有效负载类型以发送上行消息

{% capture senduplink %}
文本有效负载<br>%,%text%,%templates/integration/udp/udp-send-uplink-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/udp/udp-send-uplink-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/udp/udp-send-uplink-binary.md%br%
十六进制有效负载<br>%,%hex%,%templates/integration/udp/udp-send-uplink-hex.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpintegrationsenduplink" toggle-spec=senduplink %}

一旦你转到 **设备组 -> 全部**，你应该找到由集成配置的 **SN-001** 设备。
单击设备，转到 **最新遥测** 选项卡以查看“温度”键及其值 (25.7) 以及“湿度”键及其值 (69)。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-integration-create-device-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-integration-create-device-paas.png)
{% endif %}

## 高级用法：下行

在 **数据转换器** 中创建下行转换器。要查看事件 - 启用调试。

{% capture udpdownlink %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/udp/udp-downlink-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/udp/udp-downlink-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpdownlink" toggle-spec=udpdownlink %}

现在，你必须将转换器添加到集成中，可以选择配置缓存大小和缓存生存时间（仅适用于 UDP 下行）。

{% capture difference %}
缓存大小和生存时间 - 有助于避免在存储连接时发生内存泄漏的功能。<br>
缓存生存时间 - 存储消息的时间。<br>
缓存大小 - UDP 客户端的最大消息大小。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-add-downlink-converter-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-add-downlink-converter-paas.png)
{% endif %}

<br>
当集成配置好并可以使用时，我们需要转到规则链，选择“根规则链”，然后在这里创建规则节点
**集成下行**。在这里输入一些名称，选择你需要使用的集成，然后点击 **添加**。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/rule-chain-downlink-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/rule-chain-downlink-paas.png)
{% endif %}

完成这些步骤后，我们需要点击规则节点 **消息类型开关** 的右侧灰色圆圈，并将此圆圈拖动到“集成下行”的左侧，
在这里让我们选择 **属性更新**，点击“添加”并保存规则节点。就这样！

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/rule-chain-and-attributes-updated-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/rule-chain-and-attributes-updated-paas.png)
{% endif %}

### 测试下行

要测试下行，请在你的设备上创建一些 **共享属性** 并在此设备上发送一些上行消息。你将看到下行消息。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-add-shared-add-attribute-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-add-shared-add-attribute-paas.png)
{% endif %}

![image](/images/user-guide/integrations/udp/terminal-add-attribute.png)

此外，你可以为上行命令设置选项 `-q`，例如 120 秒。此选项设置你将等待响应的时间。
如果连接时间结束 - 你将在下一个上行中收到此消息。请参阅以下示例：

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-update-shared-attributes-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-update-shared-attributes-paas.png)
{% endif %}

![image](/images/user-guide/integrations/udp/terminal-update-attribute.png)

{% capture difference %}
**注意**
<br>
当你使用 UDP 集成并且你的连接建立很长时间时，你将只收到一条下行消息。所有其他消息都将保存在服务器端，并在下一个上行中发送。
{% endcapture %}
{% include templates/info-banner.md content=difference %}


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/guides-banner.md %}