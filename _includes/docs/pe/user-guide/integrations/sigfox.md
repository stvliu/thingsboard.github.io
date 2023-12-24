{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

Sigfox 集成允许将数据从 Sigfox 后端流式传输到 ThingsBoard，并将二进制设备有效负载转换为 ThingsBoard 格式。

请查看集成图以了解更多信息。

 ![image](/images/user-guide/integrations/sigfox-integration.svg)

## 先决条件

在本教程中，我们将使用：

{% if docsPrefix == "pe/" %}
 - 本地安装的 [ThingsBoard Professional Edition](https://thingsboard.io/docs/user-guide/install/pe/installation-options/) 实例；
  {% endif %}
  {% if docsPrefix == "paas/" %}
 - ThingsBoard Professional Edition 实例 — [thingsboard.cloud](https://thingsboard.cloud)；
  {% endif %}

 - 一个 [Sigfox](https://www.sigfox.com/) 帐户；
 - 在 Sigfox 中注册的设备。

我们假设我们有一个设备 *Sigfox-2216792*。我们的传感器设备发布“温度”、“湿度”、“co2”和“co2Baseline”读数。

## SigFox 集成配置

### 创建上行转换器

您可以在数据转换器页面或直接在集成中创建上行转换器。上行转换器对于将来自设备的传入数据转换为在 ThingsBoard 中显示它们所需的格式是必要的。

转到 **集成中心** -> **数据转换器** 页面，然后单击“加号”按钮以创建新的转换器。将其命名为“**SigFox 上行转换器**”，然后选择类型 **上行**。要查看事件，请启用 **调试模式**。在函数解码器字段中，指定一个脚本来解析和转换数据。

{% capture difference %}
**注意**
<br>
虽然调试模式对于开发和故障排除非常有用，但在生产模式下启用它会显著增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在调试完成后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

让我们回顾一下来自 SigFox 设备的示例上行消息：
```json
{
  "device": "BF1327",
  "time": "1661868952",
  "data": "2502af2102462a",
  "seqNumber": "3737"
}
```
 - “*device*”负责设备的名称；
 - “*data*”是通过两个字符进行遥测连接，其中值“02af” - 温度，“21” - 湿度*，“0246” - co2，“2a” - co2Baseline。
<br><br>

{% include templates/tbel-vs-js.md %}

{% capture sigfoxuplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/sigfox/sigfox-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/sigfox/sigfox-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="sigfoxuplinkconverterconfig" toggle-spec=sigfoxuplinkconverterconfig %}

### SigFox 集成设置

 - 转到 **集成中心** -> **集成** 页面，然后单击“加号”图标以添加新的集成。将其命名为“**SigFox 集成**”，选择类型 **SigFox**；

![image](/images/user-guide/integrations/sigfox/sigfox-integration-setup-1-pe.png)

{% capture difference %}
**注意**
<br>
如果取消选中“允许创建设备或资产”复选框，则在向 thingsboard 发送带有任何设备（或资产）参数的消息时，如果不存在此类设备（资产），则不会创建设备（资产）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

 - 添加最近创建的 **SigFox 上行转换器**；

 - ![image](/images/user-guide/integrations/sigfox/sigfox-integration-setup-2-pe.png)

- 现在，将“**下行数据转换器**”字段留空；

![image](/images/user-guide/integrations/sigfox/sigfox-integration-setup-3-pe.png)

 - 指定您的 **URL**；
 - 复制 **HTTP 端点 URL** - 我们稍后会使用它；
 - 如果有必要，您可以指定其他参数，如果没有这些参数，数据将不会包含在集成中。为此，选中 **启用安全** 复选框，然后单击“添加”实体按钮。指定任意 *标头* 和 *值*；
 - 单击 **添加** 以创建集成。

![image](/images/user-guide/integrations/sigfox/sigfox-integration-setup-4-pe.png)

## SigFox 配置

现在我们需要设置一个 **Sigfox 帐户**，以便将我们设备的数据发送到 ThingsBoard 平台。

转到您的 **Sigfox 帐户** -> **设备类型** -> 进入您的设备类型编辑模式。在我的例子中，这是“**恒温器**”。

![image](/images/user-guide/integrations/sigfox/sigfox-device-edit-device-type-1-pe.png)

在“**下行数据**”部分中，指定 **回调** 下行模式。

![image](/images/user-guide/integrations/sigfox/sigfox-device-edit-device-type-2-pe.png)

然后转到 **回调** 选项卡。

**回调** 是一个自定义 http 请求，其中包含您的设备数据以及其他变量，当 Sigfox 云收到上述设备消息时，该请求将发送到给定的平台。

创建一个回调来将 Sigfox 云连接到您的 ThingsBoard 平台。在右上角，单击“**新建**”按钮，然后选择“**自定义回调**”。

![image](/images/user-guide/integrations/sigfox/sigfox-device-callbacks-2-pe.png)

![image](/images/user-guide/integrations/sigfox/sigfox-device-callbacks-4-pe.png)

指定 **自定义有效负载配置**、**标头过滤器**，并将复制的 **HTTP 端点 URL** 粘贴到 URL 模式行中。添加一个消息体，其结构与您设备中的消息匹配。单击“**确定**”以创建回调。

![image](/images/user-guide/integrations/sigfox/sigfox-device-callbacks-1-pe.png)

有效负载体：
```json
{
  "device": "{device}",
  "time": "{time}",
  "data":"{data}",
  "seqNumber": "{seqNumber}"
}
```
{: .copy-code}

激活下行回调。单击“**下行**”图标。

![image](/images/user-guide/integrations/sigfox/sigfox-device-callbacks-3-pe.png)

此后，设备已准备好向 Thingsboard 发送数据。从设备发送上行消息。

在发送上行消息后，在 Thingsboard 中创建了一个新设备。您应该会收到有关它的 **通知**。要查看通知，请单击屏幕右上角的“铃铛”图标。通知将包含由集成配置的 *Sigfox-2216792* 设备的链接（您的设备名称可能与本示例中显示的名称不同）。在此处了解有关通知及其配置方式的更多信息 [here](/docs/{{docsPrefix}}user-guide/notifications/)。

导航到此设备。

![image](/images/user-guide/integrations/sigfox/sigfox-integration-create-device-3-pe.png)

您将在此处看到有关新设备的信息。导航到 **最新遥测** 选项卡以查看键及其值。

![image](/images/user-guide/integrations/sigfox/sigfox-integration-create-device-1-pe.png)

转到“**属性**”选项卡。在那里，您会看到设备的属性及其值。

![image](/images/user-guide/integrations/sigfox/sigfox-integration-create-device-2-pe.png)

接收到的数据也可以在上行转换器中查看。在事件选项卡的“*In*”和“*Out*”块中：

![image](/images/user-guide/integrations/sigfox/sigfox-uplink-converter-events-in-pe.png)

![image](/images/user-guide/integrations/sigfox/sigfox-uplink-converter-events-out-pe.png)

## 高级用法：下行

创建一个名为“**SigFox 下行转换器**”的转换器，然后选择类型 **下行**。要查看事件 - 启用 **调试模式**。

{% capture sigfoxdownlinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/sigfox/sigfox-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/sigfox/sigfox-downlink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="sigfoxdownlinkconverterconfig" toggle-spec=sigfoxdownlinkconverterconfig %}

现在您必须将下行转换器添加到集成中。

![image](/images/user-guide/integrations/sigfox/sigfox-add-downlink-converter-pe.png)

配置集成后，我们需要转到 **规则链** 页面，选择 **根规则链**，然后在此处创建 **集成下行** 节点。在此处输入一些名称，选择您之前创建的 **SigFox 集成**，然后单击添加。

![image](/images/user-guide/integrations/sigfox/sigfox-rule-chain-downlink-1-pe.png)

完成这些步骤后，我们需要点击 **消息类型开关** 节点的右侧灰色圆圈，并将此圆圈拖动到 **集成下行** 节点的左侧。在此处选择“**属性更新**”和“**发布属性**”，点击“添加”并保存根规则链。

![image](/images/user-guide/integrations/sigfox/sigfox-rule-chain-downlink-2-pe.png)

### 测试下行

要测试下行，请在您的设备上创建一个 **共享属性**，并在该设备上发送一些上行消息。

![image](/images/user-guide/integrations/sigfox/sigfox-create-shared-attribute-pe.png)

转到您的 **Sigfox** 帐户 -> 选择您的设备 -> **消息** 选项卡。您将看到下行消息

![image](/images/user-guide/integrations/sigfox/sigfox-downlink-message-2-pe.png)

转到 **统计** 选项卡。您将在图表上看到下行消息。

![image](/images/user-guide/integrations/sigfox/sigfox-statistics-1-pe.png)

## 视频教程

请参阅下面的视频教程，了解有关如何设置 SigFox 集成的逐步说明。

<br>
<div id="video"> 
 <div id="video_wrapper">
     <iframe src="https://www.youtube.com/embed/T769XqaqeFU" frameborder="0" allowfullscreen></iframe>
 </div>
</div>

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}