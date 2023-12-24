{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

OPC UA 集成允许您将数据从 OPC UA 服务器流式传输到 ThingsBoard，并将设备有效负载转换为 ThingsBoard 格式。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/opc-ua-integration.svg"></object>


## OPC-UA 集成教程

在本教程中，我们将配置 ThingsBoard 和 OPC-UA 之间的集成，以从 [OPC UA C++ 演示服务器](https://www.unified-automation.com/downloads/opc-ua-servers.html)获取空调数据，并允许用户使用集成下行链路功能开关任何空调。

## 先决条件

{% include templates/integration/opc-ua/opc-ua-server-setup-steps.md %}

## ThingsBoard 设置

### 上行数据转换器

首先，我们需要创建上行数据转换器，该转换器将用于接收来自 OPC UA 服务器的消息。转换器应将传入有效负载转换为所需的消息格式。
消息必须包含 *deviceName* 和 *deviceType*。这些字段用于将数据提交给正确的设备。如果找不到设备，则将创建新设备。
以下是 OPC UA 集成中的有效负载的外观：

有效负载：
{% highlight json %}
{
    "temperature": "72.15819999999641"
}
{% endhighlight %}

元数据：
{% highlight json %}
{
    "opcUaNode_namespaceIndex": "3",
    "opcUaNode_name": "AirConditioner_1",
    "integrationName": "OPC-UA Airconditioners",
    "opcUaNode_identifier": "AirConditioner_1",
    "opcUaNode_fqn": "Objects.BuildingAutomation.AirConditioner_1"
}
{% endhighlight %}

我们将获取 *opcUaNode_name* 元数据值并将其映射到 *deviceName*，并将 *deviceType* 设置为 *airconditioner*。

但是，您可以在特定用例中使用其他映射。

此外，我们将检索 *temperature*、*humidity* 和 *powerConsumption* 字段的值，并将它们用作设备遥测。

<br>
转到 **集成中心** 部分 -> **数据转换器** 页面并创建新的上行转换器

{% include templates/tbel-vs-js.md %}

{% capture opcuauplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/opc-ua/opc-ua-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/opc-ua/opc-ua-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="opcuauplinkconverterconfig" toggle-spec=opcuauplinkconverterconfig %}

### 下行数据转换器

要从 Thingsboard 向 OPC UA 节点发送下行消息，我们需要定义一个下行转换器。

通常，下行转换器的输出应具有以下结构：

{% highlight json %}
[{
    "contentType": "JSON",
    "data": "{\"writeValues\":[],\"callMethods\":[{\"objectId\":\"ns=3;s=AirConditioner_1\",\"methodId\":\"ns=3;s=AirConditioner_1.Stop\",\"args\":[]}]}",
    "metadata": {}
}]
{% endhighlight %}

- *contentType* - 定义如何对数据进行编码 {TEXT \| JSON \| BINARY}。对于 OPC UA 集成，默认使用 JSON。
- *data* - OPC UA 集成将处理并发送到目标 OPC UA 节点的实际数据：
    - *writeValues* - 写入值方法的数组：
        - *nodeId* - 目标节点，格式为 [OPC UA NodeId 格式](https://documentation.unified-automation.com/uasdkhp/1.4.1/html/_l2_ua_node_ids.html) (`ns=<namespaceIndex>;<identifiertype>=<identifier>`)
        - *value* - 要写入的值
    - *callMethods* - 调用方法的数组：
        - *objectId* - 目标对象，格式为 [OPC UA NodeId 格式](https://documentation.unified-automation.com/uasdkhp/1.4.1/html/_l2_ua_node_ids.html)
        - *methodId* - 目标方法，格式为 [OPC UA NodeId 格式](https://documentation.unified-automation.com/uasdkhp/1.4.1/html/_l2_ua_node_ids.html)
        - *args* - 方法输入值数组
- *metadata* - 在 OPC UA 集成中未使用，可以为空。

<br>
转到 **集成中心** 部分 -> **数据转换器** 页面并创建新的下行转换器。

{% include templates/tbel-vs-js.md %}

{% capture opcuadownlinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/opc-ua/opc-ua-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/opc-ua/opc-ua-downlink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="opcuadownlinkconverterconfig" toggle-spec=opcuadownlinkconverterconfig %}

此转换器将使用 *setState* 方法和布尔 *params* 值处理对设备的 RPC 命令，以调用空调的“启动”或“停止”方法。

目标节点使用传入消息元数据的 *deviceName* 字段检测。

### OPC-UA 集成

- 打开 **集成中心** 部分 -> **集成** 页面，然后单击“加号”按钮以创建新集成。
将其命名为 **OPC-UA 集成**，选择类型 **OPC-UA**。单击“下一步”；

![image](/images/user-guide/integrations/opc-ua/opc-ua-create-integration-1.png)

- 下一步是添加最近创建的上行和下行转换器；

![image](/images/user-guide/integrations/opc-ua/opc-ua-create-integration-2.png)

![image](/images/user-guide/integrations/opc-ua/opc-ua-create-integration-3.png)

- 指定主机：**端点主机**（请参阅 [先决条件](#prerequisites)）；
- 指定端口：**端点端口**（请参阅 [先决条件](#prerequisites)）；
- 安全性：**无**（可以是 *Basic128Rsa15* / *Basic256* / *Basic256Sha256* / *None*）；
- 身份：**匿名**（可以是 *匿名* / *用户名*）。

![image](/images/user-guide/integrations/opc-ua/opc-ua-create-integration-4.png)

- 映射：
     - 映射类型：**完全限定名称**（可以是 *完全限定名称* / *ID*）
     - 设备节点模式：**Objects\.BuildingAutomation\.AirConditioner_\d+$**（用于匹配扫描的 OPC UA 节点 FQN/ID 与设备名称的正则表达式。
  在此示例中，OPC UA Explorer 上的路径为 `Objects/BuildingAutomation/AirConditioner_X`，其中 X 是 1 到 N 之间的数字。
  这就是我们使用 `Objects\.BuildingAutomation\.AirConditioner_\d+$` 作为正则表达式的原因，因为 `\d+` 表示 1 到 *N* 之间的任何数字，而 `$` 表示字符串的末尾）
     - 订阅标签（要订阅的节点标签（**路径**）列表，以及映射到输出消息中使用的键（**键**））：
        - *state* - 状态；
        - *temperature* - 温度；
        - *humidity* - 湿度；
        - *powerConsumption* - 功耗。

![image](/images/user-guide/integrations/opc-ua/opc-ua-create-integration-5.png)

### 设备

创建 OPC-UA 集成后，转到 **实体** 部分 -> **设备** 页面。您将看到集成创建的 10 个设备。

![image](/images/user-guide/integrations/opc-ua/opc-ua-devices-1.png)

打开任何空调的详细信息并导航到 **最新遥测** 选项卡。
您将看到遥测值经常更新。

![image](/images/user-guide/integrations/opc-ua/opc-ua-devices-2.png)

### 空调规则链

为了演示 OPC-UA 集成和规则引擎功能，我们将创建一个单独的规则链来处理与 OPC-UA 集成相关的上行和下行消息。

让我们创建 **空调** 规则链。

- 下载 [**airconditioners.json**](/docs/user-guide/resources/airconditioners.json) 文件；
- 转到 **规则链** 页面。要导入此 JSON 文件，请单击 **规则链** 页面右上角的 `+` 按钮，然后单击“**导入规则链**”；
- 将下载的 JSON 文件拖放到 **导入规则链** 窗口。单击“导入”；
- **空调** 规则链将打开。双击 **集成下行** 节点并在集成字段中指定 **OPC-UA 集成**；
- 保存所有更改。

{% include images-gallery.html imageCollection="create_rule_chain" %}

- 打开并编辑 **根规则链**；
- 找到 **规则链** 节点，将其拖放到规则链节点。将其命名为 Airconditioners，指定 **Airconditioners** 规则链，然后单击“添加”；
- 点击 **消息类型开关** 节点的右侧灰色圆圈，并将此圆圈拖动到 **规则链** 节点的左侧，这里让我们选择 **属性已更新**、**发布遥测** 和 **RPC 请求到设备**；
- 点击“添加”并保存规则链。

{% include images-gallery.html imageCollection="create_rule_chain_2" %}

### 空调仪表板

为了可视化空调数据并测试 RPC 命令，我们将创建 **空调** 仪表板。

- 下载 [**airconditioners_dashboard.json**](/docs/user-guide/resources/airconditioners_dashboard.json) 文件；
- 转到 **仪表板** 页面；
- 要导入此 JSON 文件，请单击 **仪表板** 页面右上角的 `+` 按钮，然后选择“**导入仪表板**”。
- 将下载的 JSON 文件拖放到 **导入仪表板** 窗口。单击“导入”。

![image](/images/user-guide/integrations/opc-ua/opc-ua-dashboard-1.png)

- 打开 **空调** 仪表板；
- 您将看到来自所有 10 个空调的最后一分钟遥测；
- 通过单击实体小部件中的详细信息按钮，打开任何空调详细信息页面；

![image](/images/user-guide/integrations/opc-ua/opc-ua-dashboard-2.png)

- 您会发现空调状态灯为浅绿色。尝试通过单击 **开/关圆形开关** 来关闭空调；

![image](/images/user-guide/integrations/opc-ua/opc-ua-dashboard-4.png)

- 空调状态灯将变为灰色，温度将开始上升，湿度将开始增加，功耗将停止。

![image](/images/user-guide/integrations/opc-ua/opc-ua-dashboard-5.png)

## 视频教程

请参阅下面的视频教程，了解如何设置 OPC-UA 集成。

<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/KK0gXGXFQ0E" frameborder="0" allowfullscreen></iframe>
    </div>
</div> 

<br>

## 另请参阅

- [集成概述](/docs/{{peDocsPrefix}}user-guide/integrations/)
- [上行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#uplink-data-converter)
- [下行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#downlink-data-converter)
- [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)

  
## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}