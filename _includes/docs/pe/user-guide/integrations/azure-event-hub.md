{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

Azure Event Hub 集成允许将数据从 Azure Event Hub 流式传输到 GridLinks，并将设备有效负载转换为 GridLinks 格式。

 ![image](/images/user-guide/integrations/azure-event-hub-integration.svg)
 
## 创建 Azure IoT 中心

您已在 Azure 中注册。现在，您需要创建 IoT 中心。您将在其中创建设备并执行其他操作。我们按部就班地进行：

1) 在 Azure 门户中，我们应单击 **创建资源** 按钮以创建 IoT 中心

2) 在搜索字段中，让我们编写 **Iot Hub** 并从列表中选择相同的项目

3) 接下来，让我们单击创建

4) 在此页面上，单击 **新建** 并指定资源组和 IoT 中心名称，单击 **查看 + 创建**，在下一页上单击 **创建**

5) 等待部署过程，然后单击 **转到资源**

{% include images-gallery.html imageCollection="create_eventhub" preview="false" %}

## 在 IoT 中心创建设备

第一步已完成，现在我们转到创建设备

1) 在上下文菜单中，单击 **Iot 设备** 选项卡

2) 在此处，您应单击 **新建** 按钮

3) 在弹出窗口中，只需指定 **设备 ID**，然后单击 **保存**

4) 太棒了！您拥有新的设备

{% include images-gallery.html imageCollection="create_device" preview="false" %}

## 创建上行转换器

在创建集成之前，您需要在数据转换器中创建上行转换器。上行对于将来自设备的传入数据转换为在 GridLinks 中显示它们所需的格式是必要的。单击“加号”和“创建新转换器”。要查看事件，请启用调试。在函数解码器字段中，指定一个脚本来解析和转换数据。

**注意** 尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。

{% include images-gallery.html imageCollection="uplink_converter" preview="false" %}

**您可以使用我们的上行转换器示例：**
```javascript
var data = decodeToJson(payload);
var deviceName = data.devName;
var deviceType = 'thermostat';

var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   telemetry: {
       temperature: data.msg.temp,
       humidity: data.msg.humidity
   }
};

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   var str = decodeToString(payload);
   var data = JSON.parse(str);
   return data;
}

return result;
```


## 在 Thingsboard 中创建集成

此时，我们拥有带有设备的 IoT 中心

1) 现在，您必须在 Azure 门户中选择菜单中的 **内置端点** 并复制 **与 Event Hub 兼容的端点**

2) 转到 Thingsboard 并选择菜单中的 **集成**

3) 单击 **'加号'**，在弹出窗口中，我们必须输入名称，选择类型 **Azure Event Hub**，选择上行转换器，然后粘贴到字段连接字符串中，复制 **与 Event Hub 兼容的端点**

4) [可选] 单击 **检查连接** 按钮以检查正确复制的连接字符串

5) 单击 **添加** 并查看您创建的集成

{% include images-gallery.html imageCollection="integration" preview="false" %}

## 测试一下！

现在，我们准备测试我们的集成。因此，我们必须转到规则链（Thingsboard 菜单中的选项卡），选择您的一个规则链并执行以下步骤：

1) 在字段搜索节点中键入 'gen'，并在菜单中找到 **生成器**。将其拖到画布上。在弹出窗口中，指定生成器的 **名称**、**消息数** 和生成函数，您可以使用我们的示例。接下来，单击“添加”

{% include images-gallery.html imageCollection="generator" preview="false" %}

```javascript
var msg = {
    "devName": "TB-D-01",
    "msg": {
        "temp": 42,
        "humidity": 77
    }
};
var metadata = { data: 40 };
var msgType = "POST_TELEMETRY_REQUEST";

return { msg: msg, metadata: metadata, msgType: msgType };
```

2) 现在是时候找到设备 **主密钥** 了。转到 Azure 门户，点击 **Iot 设备**，点击您的设备并查看 **主密钥** 字段。复制它

{% include images-gallery.html imageCollection="primary_key" preview="false" %}

3) 现在我们需要找到另一个规则节点。因此，在搜索节点中键入 'iot' 并选择菜单中的 **azure iot hub**。将其拖到画布上。在弹出窗口中，您需要指定一个名称，而不是 <device_id> 键入您的设备名称，相同的设备 ID，并将我们复制的主密钥添加到凭据中。此外，如果您需要查看事件，请单击调试模式。

{% include images-gallery.html imageCollection="iot_rule_node" preview="false" %}

4) 如果它看起来像照片 - 不错。单击 **添加** 并继续

5) 最后一步：将 **生成器** 连接到 **azure iot hub**。单击 **生成器** 的灰色圆圈，然后将其拖动到 **azure iot hub** 的左侧灰色圆圈。在弹出菜单中，您需要选择“成功”，单击添加并微笑

6) 一切就绪，让我们保存画布并转到集成。

{% include images-gallery.html imageCollection="generator_iot_rule_chain" preview="false" %}

如果您在集成的“事件”中看到类型“上行”以及我们键入的消息看起来与此处相同，那就太好了

{% include images-gallery.html imageCollection="event_uplink" preview="false" %}

使用仪表板处理数据。仪表板是收集和可视化数据集的现代格式。通过各种小部件实现数据呈现的可见性。

ThingsBoard 有几种类型的仪表板示例，您可以使用它们。您可以在 **解决方案模板** 选项卡中找到它们。

{% include images-gallery.html imageCollection="solution_templates" %}

## 高级用法：创建下行转换器

下行用于向设备发送消息。例如，设备消息已接收到的信息

1) 首先，让我们找到 IoT 中心名称。您可以转到 Azure 门户，选择 **内置端点** 并复制 **与 Event Hub 兼容的名称** 的值 - 这里有 **IoT 中心名称**

2) 您需要执行与创建上行时相同的步骤，但选择下行并指定另一个函数。完成下行转换器后，您应该转到集成并指定此 **转换器**，并将 **IoT 中心** 的名称添加到相应字段

{% include images-gallery.html imageCollection="downlink_first_part" preview="false" %}

下行转换器的简单示例：
```javascript
var result = {

    contentType: "JSON",

    data: JSON.stringify(msg),

    metadata: {
            deviceId: 'TB-D-01'
    }

};

return result;
```
**注意** *如果您使用了其他设备名称（不是 TB-D-01），则必须在下行转换器中为 **deviceId** 字段指定您的设备名称*

**好的，下行转换器已准备就绪，集成已准备就绪，让我们测试一下：**

1) 在测试上行后，集成已在 Thingsboard 中创建了设备，我们需要知道它连接了哪个规则链。
只需转到 Thingsboard 菜单中的设备组，选择 **全部**，然后找到我们在上行中使用的名称的设备。

{% include images-gallery.html imageCollection="device_groups_all" preview="false" %}

2) 在 Thingsboard 菜单的规则链选项卡中找到必要的规则链的名称。

3) 在“搜索节点”字段中键入“down”，然后在菜单中选择 **集成下行**，将其拖动到画布上。在弹出窗口中，您需要指定规则节点的名称并选择我们的集成

4) 单击 **消息类型开关** 节点的左侧灰色圆圈，然后将其拖动到我们的下行规则节点的灰色圆圈。在此处选择 **属性更新**，然后单击“添加”

{% include images-gallery.html imageCollection="downlink_rule_node" preview="false" %}

5) 太棒了。保存画布，让我们转到“设备组”->“全部”，然后选择我们的设备。切换到“实体属性范围”列表中的 **属性**，选择 **共享属性**。
   点击“加号”创建新的。在弹出窗口中指定属性的键、值类型和一些值。

6) 点击“添加”，然后转到集成以检查下行的结果。

{% include images-gallery.html imageCollection="device_last_part" preview="false" %}

如您所见，我们收到一条消息，表明集成已成功接收下行并发送到 Azure Event Hub。要在 Azure IoT 中心中检查它，我们需要转到 Azure 门户，选择 **IoT 设备** 菜单选项卡并查看 **云到设备消息计数** 编号。

{% include images-gallery.html imageCollection="downlink_result" preview="false" %}

## 高级用法：使用 Azure IoT Hub 集成检查下行

有一个简单的解释说明如何在 Azure IoT Hub 集成中查看您的下行。
只需查看这些图像即可了解我们如何对 Azure Event Hub 执行简单下行检查

{% include images-gallery.html imageCollection="advanced_testing" preview="false" %}

*您可以使用以下链接熟悉 Azure Iot Hub：* [Azure IoT Hub 集成](/docs/{{peDocsPrefix}}user-guide/integrations/azure-iot-hub)

## 结论

**就是这样！祝您配置 IoT 设备和仪表板好运！**

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}