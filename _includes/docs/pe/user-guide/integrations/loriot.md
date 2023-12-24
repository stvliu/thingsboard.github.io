{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC 
{:toc}

## 概述

LORIOT 是 LoRaWAN 网络，旨在使用 LoRaWAN 堆栈连接您的设备。将 LORIOT 与 GridLinks 集成后，您可以在 GridLinks IoT 平台中连接、通信、处理和可视化设备数据。

## 创建 LORIOT 帐户

选择服务包和服务器位置。然后我们使用 LORIOT 注册一个帐户。例如，选择社区公共网络服务器。

{% include images-gallery.html imageCollection="register" %}

*LORIOT 界面将来可能会更改。*

填写注册字段。注册确认信将发送到指定的电子邮件。按照指定的链接操作。

## 创建上行转换器

在创建集成之前，您需要在 **数据转换器** 中创建一个 **上行转换器**。上行对于将来自设备的传入数据转换为在 GridLinks 中显示它们所需的格式是必需的。单击 **“加号”** 和 **“创建新转换器”。** 
要查看事件，请启用 **调试。** 在函数解码器字段中，指定一个脚本来解析和转换数据。

{% capture difference %}
**注意**
<br>
尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

让我们回顾一下来自 LORIOT 的示例上行消息：

```
{
     "cmd"  : "rx",
     "EUI"  : "BE7A000000000552",
     "ts"   : 1470850675433,
     "ack"  : false,
     "fcnt" : 1,
     "port" : 1,
     "data" : "2A3F",
     "freq" : 868500000,
     "dr"   : "SF12 BW125 4/5",
     "rssi" : -130,
     "snr"  : 1.2
 }
```
如您所见，唯一的设备 ID 到达“EUI”字段。我们将在 GridLinks 中将其用作设备名称。设备数据编码在“data”字段中。
此处的编码数据为：
```
"data": "2A3F"
```
让我们将它们转换为温度和湿度值。

**2A** 是 **温度** 的值。解码后的形式为 **42**

**3F** 是 **湿度** 的值。解码后的形式为 **63**

在转换器中，它将指示如下：

```
temperature: stringToInt(payloadJson.data.substring(0,2)),
humidity: stringToInt(payloadJson.data.substring(2,4))
```

{% include templates/tbel-vs-js.md %}

{% capture loriotuplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/loriot/loriot-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/loriot/loriot-uplink-converter-config-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="loriotuplinkconverterconfig" toggle-spec=loriotuplinkconverterconfig %}

## 创建集成

现在已经创建了上行转换器，就可以创建集成。

{% include images-gallery.html imageCollection="integration" %}

为了将数据从 LORIOT 传输到 GridLinks，您需要为 LORIOT 应用程序配置 **输出**。您可以手动执行此操作（推荐），或者 ThingsBoard 集成可以为您执行此操作（您需要向我们提供 LORIOT 帐户的登录名和密码，以便我们能够自动配置输出）。  
<br>

<div style="font-size: 20px; margin-bottom: 8px; font-weight: bold;">配置输出选项</div>

我们可以通过启用 **创建 Loriot 应用程序输出** 选项或指定“基本”凭据来使用 LORIOT 或集成创建输出。

{% capture authorizationTypes %}
LORIOT 帐户<br><small>推荐</small>%,%loriot-account%,%templates/integration/loriot/loriot-account-authorization-type.md%br%
基本凭据<br>%,%basic-credential%,%templates/integration/loriot/thingsboard-basic-credentials.md{% endcapture %}

{% include content-toggle.html content-toggle-id="loriotAuthorizationTypes" toggle-spec=authorizationTypes %}

<div style="font-size: 20px; margin-bottom: 8px; font-weight: bold;">启用安全选项</div>

如果需要，您可以指定其他参数，如果没有这些参数，数据将不会包含在集成中。为此，选中启用安全复选框，然后单击标头过滤器。指定任意值并保存更改。

{% include images-gallery.html imageCollection="enable_security" %}

还需要在 LORIOT 中指定此内容：

{% include images-gallery.html imageCollection="custom_authorization" %}

配置标头过滤器后，还需要在以下上行消息中指定它。

```
-H "authorization:secret"
```
{: .copy-code}

{% include images-gallery.html imageCollection="uplink-message" %}

## 发送测试上行消息

使用控制台而不是 LORIOT 服务器“模拟”来自设备的消息可能很有用。要发送上行消息，您需要来自集成、**端口** 和 LORIOT 中的 **EUI** 的 **HTTP 端点 URL**。

让我们转到 GridLinks 中的 **集成** 选项卡。找到您的 LORIOT 集成并单击它。您可以在其中找到 HTTP 端点 URL。单击图标复制 URL。

{% include images-gallery.html imageCollection="endpoint_url" %}

**端口** 可以是 1 到 223。**EUI** 是设备 EUI，取自 LORIOT 中的设备。

在设备已经创建的设备部分中获取 LORIOT 中的 **EUI**：

{% include images-gallery.html imageCollection="devices" %}

使用此命令发送消息。将 $YOUR_EUI_DEVICE 和 $YOUR_HTTP_ENDPOINT_URL 替换为相应的值。

```bash
curl -v -X POST -d "{\"EUI\":\"$YOUR_EUI_DEVICE\",\"deviceType\":\"temperature-sensor\",\"data\":\"2A3F\",\"port\":1,\"cmd\":\"rx\",\"dr\":\"SF12 BW125 4/5\",\"snr\":1.2,\"ack\":\"false\",\"freq\":868500000,\"fcnt\":1,\"rssi\":-130,\"ts\":1613745998000}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code}

使用 **启用安全** 选项：将 $YOUR_EUI_DEVICE、$YOUR_HTTP_ENDPOINT_URL 和 $VALUE 替换为相应的值。

```bash
curl -v -X POST -d "{\"EUI\":\"$YOUR_EUI_DEVICE\",\"deviceType\":\"temperature-sensor\",\"data\":\"2A3F\",\"port\":1,\"cmd\":\"rx\",\"dr\":\"SF12 BW125 4/5\",\"snr\":1.2,\"ack\":\"false\",\"freq\":868500000,\"fcnt\":1,\"rssi\":-130,\"ts\":1613745998000}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json" -H "$VALUE"
```
{: .copy-code}

可以在 **设备组 -> 全部** 部分中看到具有数据的已创建设备

{% include images-gallery.html imageCollection="device_groups" %}

可以在上行转换器中查看接收到的数据。在 **事件** 选项卡的 **“输入”** 和 **“输出”** 块中：

{% include images-gallery.html imageCollection="uplink_events" %}

使用仪表板处理数据。仪表板是收集和可视化数据集的现代格式。通过各种小部件实现数据演示的可见性。

ThingsBoard 有几种类型的仪表板示例，您可以使用它们。您可以在 **解决方案模板** 选项卡中找到它们。

{% include images-gallery.html imageCollection="solution_templates" %}

如何使用仪表板 [在此处阅读](/docs/{{docsPrefix}}user-guide/dashboards/)


## 高级用法：创建下行转换器

在 **数据转换器** 中创建下行。要查看事件 - 启用 **调试。**

{% include templates/tbel-vs-js.md %}

{% capture loriotdownlinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/loriot/loriot-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/loriot/loriot-downlink-converter-config-java.md{% endcapture %}
{% include content-toggle.html content-toggle-id="loriotdownlinkconverterconfig" toggle-spec=loriotdownlinkconverterconfig %}

在设备已经创建的设备部分中获取 LORIOT 中的 EUI：

{% include images-gallery.html imageCollection="devices" %}

将转换器添加到集成。
您可以在创建集成或编辑集成的阶段执行此操作。

要发送下行，请启用集成中的 **发送下行** 选项。
启用“发送下行”选项后，在字段中指定服务器、应用程序 ID、应用程序访问令牌：

{% include images-gallery.html imageCollection="send_downlink" %}

要获取此数据 - 请转到您的 LORIOT 帐户。

要填写 **服务器** 字段的数据：

{% include images-gallery.html imageCollection="downlink_server" %}

要填写 **应用程序 ID** 字段的数据：

{% include images-gallery.html imageCollection="downlink_applications" %}

之后，转到应用程序并转到 **访问令牌** 部分。找到将在集成中指定的令牌。

{% include images-gallery.html imageCollection="access_token" %}

我们可以使用规则节点从规则链向设备发送消息。对于我们的示例，我们创建 **集成下行** 节点并将 ***“属性已更新”*** 链接到它。对属性进行更改时，下行消息将发送到集成。

{% include images-gallery.html imageCollection="rule_chain" %}

我们转到 **设备组** 部分中的 **全部** 文件夹，以示例查看此内容。我们已在 **共享属性** 中指明设备的固件。现在，我们通过单击“铅笔”图标对其进行编辑。然后，我们对属性进行更改（将固件从 01052020.v1.1 更改为 01052020.v1.2）并保存数据。

{% include images-gallery.html imageCollection="shared_attributes" %}

可以在下行转换器中查看接收到的数据和发送的数据。在 **事件** 选项卡的 **“输入”** 块中，我们看到输入了哪些数据：

{% include images-gallery.html imageCollection="event_in" %}

**“输出”** 字段显示到设备的消息：

{% include images-gallery.html imageCollection="event_out" %}

可以在 **设备 -> LoRaWAN 参数** 页面最底部的 **下行队列** 字段中检查消息是否已到达 LORIOT。

{% include images-gallery.html imageCollection="parameters" %}


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}