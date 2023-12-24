{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

HTTP 集成允许将现有协议和有效负载格式转换为 ThingsBoard 消息格式，并且在多种部署场景中很有用：

- 从外部系统、物联网平台或连接提供商后端流式传输设备和/或资产数据。
- 从在云中运行的自定义应用程序流式传输设备和/或资产数据。
- 将具有基于 HTTP 的自定义协议的现有设备连接到 ThingsBoard。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/http-integration.svg"></object>

## 创建上行转换器

在创建集成之前，您需要在数据转换器中创建一个上行转换器。上行对于将来自设备的传入数据转换为在 ThingsBoard 中显示它们所需的格式是必需的。
单击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% capture difference %}
**注意**
<br>
虽然调试模式对于开发和故障排除非常有用，但在生产模式下启用它会显著增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在调试完成后关闭调试模式。  
{% endcapture %}
{% include templates/info-banner.md content=difference %}


{% include templates/tbel-vs-js.md %}

{% capture httpuplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/http/http-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/http/http-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="httpuplinkconverterconfig" toggle-spec=httpuplinkconverterconfig %}

现在已经创建了上行转换器，就可以创建集成。

## 创建集成

- 转到 **集成中心** 部分 -> **集成** 页面，然后单击“加号”按钮以创建新集成。将其命名为 **HTTP 集成**，选择类型 **HTTP**。单击“下一步”；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-1-pe.png)
{% endif %}

- 在此步骤中，您可以选择先前创建的或在此窗口中创建新的 upnlink 转换器。选择先前创建的 **HTTP 上行转换器**。单击“下一步”；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-2-pe.png)
{% endif %}

- 在添加下行转换器的步骤中，您还可以选择先前创建的或创建新的下行转换器。但现在，将“下行数据转换器”字段留空。单击“跳过”；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-3-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-3-pe.png)
{% endif %}

- 在此步骤中，指定您的 **基本 URL**；

- 请记下 **HTTP 端点 URL**，我们稍后将使用此值；

- 在 **高级设置** 中启用“**将响应状态从“无内容”替换为“确定”**”；

- 单击 **添加** 按钮以保存集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-4-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-4-pe.png)
{% endif %}

## 发送上行消息

要发送上行消息，您需要先前从集成中复制的 **HTTP 端点 URL**。

使用此命令发送消息。将 $DEVICEname、$DEVICEtype 和 $YOUR_HTTP_ENDPOINT_URL 替换为相应的值。

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICEname\",\"deviceType\":\"$DEVICEtype\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-send-uplink-message-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/send-uplink-message-1-pe.png)
{% endif %}

<br>
转到 HTTP 集成中的 **事件** 选项卡。如果您已正确完成所有操作，您应该会看到一个状态为“确定”的事件。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-send-uplink-message-3-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/send-uplink-message-3-pe.png)
{% endif %}

{% if docsPrefix == "pe/" %}
<br>
当您发送消息时，将创建一个新设备。您应该会收到有关它的通知。要查看通知，请单击屏幕右上角的钟形图标。
通知将包含一个操作按钮，单击该按钮，您可以转到新设备的详细信息。单击此按钮。

![image](/images/user-guide/integrations/http/http-device-2-pe.png)

<br>
在这里，您将看到有关新设备的信息。以及我们发送到设备的遥测数据。

![image](/images/user-guide/integrations/http/http-device-1-pe.png)

<br>
在此处了解有关 **通知** 及其配置方式的更多信息 [here](/docs/{{docsPrefix}}user-guide/notifications/)。

{% endif %}

{% if docsPrefix == "paas/" %}
<br>
创建的数据设备可以在 **设备组 -> 全部** 部分中看到。

![image](/images/user-guide/integrations/http/device-1-pe.png)

{% endif %}

{% capture difference %}
**注意**
<br>
如果取消选中“允许创建设备或资产”复选框，则在向 thingsboard 发送带有任何设备（或资产）参数的消息时，如果不存在此类设备（资产），则不会创建设备（资产）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

此外，已发送和接收的数据可以在上行转换器中查看。在事件选项卡的 **“In”** 和 **“Out”** 块中

{% include images-gallery.html imageCollection="send-uplink-1" %}

<br>
使用 [仪表板](/docs/{{docsPrefix}}user-guide/dashboards/) 来处理数据。仪表板是收集和可视化数据集的现代格式。通过各种小部件实现数据演示的可见性。
ThingsBoard 有几种类型的仪表板示例，您可以使用它们。在此处了解有关 **解决方案模板** 的更多信息 [here](/docs/{{docsPrefix}}solution-templates/overview/)。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-solution-templates.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/solution-templates.png)
{% endif %}

#### 启用安全选项

如果需要，您可以指定其他参数，如果没有这些参数，数据将不会包含在集成中。
为此，选中启用安全复选框，然后单击标头过滤器。指定任意值并保存更改。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-enable-security-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/security-1-pe.png)
{% endif %}

配置标头过滤器后，还需要在上行消息中指定它，如下所示：

```ruby
-H "test-header:secret"
```

使用此命令发送带有启用安全选项的消息。将 $DEVICEname、$DEVICEtype、$YOUR_HTTP_ENDPOINT_URL 和 $VALUE 替换为相应的值。

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICEname\",\"deviceType\":\"$DEVICEtype\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json" -H "$VALUE"
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-enable-security-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/security-2-pe.png)
{% endif %}

## 下行转换器

在数据转换器中创建下行。要查看事件，请启用调试。

{% include templates/tbel-vs-js.md %}

{% capture httpdownlinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/http/http-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/http/http-downlink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="httpdownlinkconverterconfig" toggle-spec=httpdownlinkconverterconfig %}

现在，您需要将创建的下行转换器添加到集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-downlink-converter-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/http-add-downlink-converter-1-pe.png)
{% endif %}

<br>
当集成配置好并可以使用时，我们可以使用规则节点从规则链向设备发送消息。
创建一个 **集成下行** 节点。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-downlink-rule-chain-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/downlink-rule-chain-1-pe.png)
{% endif %}

<br>
将“**已更新的属性**”和“**发布属性**”链接到它。
当创建属性或对属性进行更改时，下行消息将发送到集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-downlink-rule-chain-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/downlink-rule-chain-2-pe.png)
{% endif %}

<br>
为了通过示例了解这一点，我们转到 **设备** 页面。选择您的设备并导航到 **属性** 选项卡。选择 **共享属性**，然后单击“加号”图标以创建新属性。
然后设置属性名称、其值（例如，键名为固件，值为：01052020.v1.1）并保存数据。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-downlink-add-attribute-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/downlink-add-attribute-1-pe.png)
{% endif %}

<br>
再次发送上行消息。我们将在终端中收到来自 ThingsBoard 的响应：

{% include images-gallery.html imageCollection="downlink-terminal" %}

接收的数据和发送的数据可以在下行转换器中查看。在事件选项卡的“In”块中，我们看到输入了哪些数据，在“Out”字段中，显示了发送到设备的消息：

{% include images-gallery.html imageCollection="downlink-message" %}


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}