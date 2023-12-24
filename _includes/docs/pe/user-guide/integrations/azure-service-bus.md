{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

Azure Service Bus 集成允许将数据从 Azure Service Bus 流式传输到 GridLinks，并将设备有效负载转换为 GridLinks 格式。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-overview.png)

## 配置 Azure Service Bus

若要创建 ThingsBoard Service Bus 集成，您需要在 Azure 门户中创建两项内容：**主题**和**订阅**。您还需要找到并保存 Service Bus 命名空间的**连接字符串**，稍后您将需要它。
- [创建主题和对主题的订阅](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-topics-subscriptions-portal)
- [查找服务总线命名空间的连接字符串](https://azurelessons.com/azure-service-bus-connection-string/)

## 创建上行转换器

您可以在**数据转换器**部分或直接在集成中创建**上行转换器**。上行对于将来自设备的传入数据转换为在 GridLinks 中显示它们所需的格式是必需的。单击“加号”和“创建新转换器”。要查看事件，请启用调试。在函数解码器字段中，指定一个脚本来解析和转换数据。

{% capture difference %}
**注意**
<br>
尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

让我们回顾一下来自 Service Bus 主题的示例上行消息：

```json
{
   "devName": "Sensor A1",
   "msg": {
      "temp": 23,
      "humidity": 40
   }
}
```
{: .copy-code}

{% include templates/tbel-vs-js.md %}

{% capture servicebusuplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/service-bus/service-bus-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/service-bus/service-bus-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="servicebusuplinkconverterconfig" toggle-spec=servicebusuplinkconverterconfig %}

## 在 Thingsboard 中创建集成

现在我们已经在 Azure 门户中创建了一个主题，并在其中创建了一个上行转换器，就可以创建一个集成。

1) 转到**集成中心**部分 -> **集成**页面，然后单击“加号”按钮以创建新集成。将其命名为**Azure Service Bus 集成**，选择类型**Azure Service Bus**。单击“下一步”；

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-integration-1-pe.png)

2) 在此步骤中，您可以选择先前创建的或直接在此窗口中创建新的 upnlink 转换器。选择先前创建的**Service Bus 上行转换器**。单击“下一步”；

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-integration-2-pe.png)

3) 在添加下行转换器的步骤中，您还可以选择先前创建的或创建新的下行转换器。但现在，请将“下行数据转换器”字段留空。单击“跳过”；

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-integration-3-pe.png)

4) 填写 Service Bus 命名空间、**主题**和**订阅**名称的**连接字符串**；

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-integration-4-pe.png)

5) [可选] 单击**检查连接**按钮以检查与 Service Bus 主题的连接。单击**添加**按钮以创建集成。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-integration-5-pe.png)

## 测试一下！

若要发送测试消息，请使用 Azure Service Bus 的附加功能 Service Bus Explorer。

登录**Azure**门户并选择您的**命名空间**。选择要上行的**主题**。
在左侧边栏中选择“**Service Bus Explorer**”选项卡。
单击“**发送消息**”，根据上行转换器选择有效负载类型，然后发送测试消息。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-send-uplink-message-1-pe.png)

有效负载示例：
```ruby
{
    "devName": "Sensor A1",
    "msg": {
        "temp": 23,
        "humidity": 40
    }
}
```
{: .copy-code}

若要检查消息是否已到达 Service Bus 集成，请打开集成的“**事件**”选项卡。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-send-check-uplink-1-pe.png)

<br>
接收到的数据可以在上行转换器中查看。在“**事件**”选项卡的“**输入**”和“**输出**”块中：

{% include images-gallery.html imageCollection="uplink-converter-events" preview="false" %}

在您发送上行消息后，将创建一个新设备。您应该会收到有关它的通知。若要查看通知，请单击屏幕右上角的铃铛图标。
通知将包含指向已创建设备的链接。转到此设备。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-device-1-pe.png)

在这里，您将看到有关新设备的信息。以及我们发送到设备的遥测数据。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-device-2-pe.png)

在此处了解有关**通知**及其配置方式的更多信息(/docs/{{docsPrefix}}user-guide/notifications/)。

## 高级用法：下行消息传递

若要向设备发送消息，您需要配置下行设置，例如下行转换器以及有关将接收消息的 Service Bus 主题的信息。
在 Azure 门户中[创建主题](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-topics-subscriptions-portal#create-a-topic-using-the-azure-portal)以进行下行消息传递。（我们建议您还创建[订阅](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-topics-subscriptions-portal#create-subscriptions-to-the-topic)到该主题，以便您稍后可以在 Azure 门户中检查消息）。

现在，创建**下行转换器**（您需要执行与创建上行时相同的步骤，但选择下行并指定另一个函数）。

{% capture servicebusdownlinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/service-bus/service-bus-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/service-bus/service-bus-downlink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="servicebusdownlinkconverterconfig" toggle-spec=servicebusdownlinkconverterconfig %}

{% capture difference %}
**注意**
<br>
如果您使用其他设备名称（不是**Sensor A1**），则必须在下行转换器中为**deviceId**字段指定您的设备名称
{% endcapture %}
{% include templates/info-banner.md content=difference %}

转到集成并指定创建的**下行转换器**。然后打开**高级设置**以指定 Service Bus 命名空间的下行主题和下行连接字符串（如果您对下行使用相同的命名空间，请从上行设置中复制连接字符串）。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-add-downlink-converter-1-pe.png)

<br>
好的，下行转换器已准备就绪，集成已准备就绪。让我们借助下行节点的帮助来测试集成。

在发送测试上行消息后，集成已在 Thingsboard 中创建了设备。让我们检查它连接到哪个规则链。
为此，请转到 Thingsboard 菜单中的**实体** -> **设备**页面，然后找到我们在上行中使用的名称的设备。找到并导航到设备使用的**设备配置文件**。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-find-device-profile-1-pe.png)

找到设备配置文件使用的**规则链**的名称。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-find-device-profile-2-pe.png)

转到**规则链**页面。在“搜索节点”字段中键入“downlink”，然后在菜单中选择“**集成下行**”节点并将其拖动到画布上。
在弹出窗口中，您需要指定规则节点的名称并选择您的集成。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-downlink-rule-chain-1-pe.png)

然后，我们需要点击“**消息类型开关**”规则节点的右侧灰色圆圈，并将此圆圈拖动到“**集成下行**”节点的左侧，在这里选择“**发布属性**”和“**属性更新**”，点击“添加”链接并保存规则链。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-downlink-rule-chain-2-pe.png)

让我们转到“**实体**”->“**设备**”页面并选择我们的设备。切换到**属性**选项卡。在“实体属性范围”列表中选择**共享属性**。
点击“加号”以创建新属性。在弹出窗口中指定属性的键名、值类型和一些值，然后点击“添加”。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-add-downlink-attribute-1-pe.png)

转到**集成**页面以检查下行的结果。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-send-check-downlink-message-1-pe.png)

如您所见，我们有一个事件，即下行消息已由集成成功生成并发送到 Azure Service Bus。

若要在 Azure Service Bus 中检查它，您需要转到 Azure 门户，选择您用于下行和订阅该主题的主题。
选择**接收模式**，然后单击**接收消息**。在弹出窗口中，单击“**接收**”按钮。

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-send-uplink-message-2-pe.png)

<br>

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-send-uplink-message-3-pe.png)

## 结论

就是这样！祝您配置 IoT 设备和仪表板好运！

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}