---
layout: docwithnav-pe-edge
title: OPC-UA 集成
description: OPC-UA 集成指南
addConverter:
    0:
        image: /images/pe/edge/integrations/opc-ua/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/add-converter-step-2.png

modifyConverter:
    0:
        image: /images/pe/edge/integrations/opc-ua/modify-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/modify-converter-step-2.png

addDownlink:
    0:
        image: /images/pe/edge/integrations/opc-ua/add-downlink-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/add-downlink-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/opc-ua/add-integration-template-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/add-integration-template-step-2.png
    2:
        image: /images/pe/edge/integrations/opc-ua/add-integration-template-step-3.png
    3:
        image: /images/pe/edge/integrations/opc-ua/add-integration-template-step-4.png

downlinkRule:
    0:
        image: /images/pe/edge/integrations/opc-ua/downlink-rule-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/downlink-rule-step-2.png
    2:
        image: /images/pe/edge/integrations/opc-ua/downlink-rule-step-3.png

airconditionersDashboard:
    0:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-step-1.png
        title: '打开仪表板组并创建新的<b>空调</b>组'
    1:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-step-2.png
        title: '打开新创建的<b>空调</b>组'
    2:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-step-3.png
        title: '单击导入图标并浏览最近下载的 airconditioners_dashboard.json 文件。单击导入按钮'
    3:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-step-4.png
        title: '转到 Edge 实例并单击管理仪表板图标'
    4:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-step-5.png
        title: '将<b>空调</b>组分配给边缘'

assignIntegration:
    0:
        image: /images/pe/edge/integrations/opc-ua/assign-integration-step-1.png
        title: '将<b>endpointHost</b> 属性添加到 Edge 并将值设置为您的 Edge <b>192.168.2.153</b>'
    1:
        image: /images/pe/edge/integrations/opc-ua/assign-integration-step-2.png
        title: '单击 Edge 实体的<b>管理集成</b>按钮'
    2:
        image: /images/pe/edge/integrations/opc-ua/assign-integration-step-3.png
        title: '将集成分配给 Edge'
    3:
        image: /images/pe/edge/integrations/opc-ua/assign-integration-step-4.png
        title: '登录到您的<b>ThingsBoard Edge</b>实例并打开集成页面 - 占位符将被属性值替换'

device:
    0:
        image: /images/pe/edge/integrations/opc-ua/device.png

deviceTelemetry:
    0:
        image: /images/pe/edge/integrations/opc-ua/device-telemetry.png

airconditionersDashboardOnEdge:
    0:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-on-edge-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-dashboard-on-edge-step-2.png

airconditionersDetails:
    0:
        image: /images/pe/edge/integrations/opc-ua/airconditioners-details.png

rpcDownlink:
    0:
        image: /images/pe/edge/integrations/opc-ua/rpc-downlink-step-1.png
    1:
        image: /images/pe/edge/integrations/opc-ua/rpc-downlink-step-2.png

---

* TOC
{:toc}

{% assign integrationName = "OPC-UA" %}
{% assign integrationUrl = "opc-ua" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

## 概述

OPC UA 集成允许您将数据从 OPC UA 服务器流式传输到 GridLinks Edge，并将设备有效负载转换为 GridLinks Edge 格式。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/opc-ua-integration.svg"></object>

在本教程中，我们将配置 ThingsBoard Edge 和 OPC-UA 之间的集成，以从 [OPC UA C++ 演示服务器](https://www.unified-automation.com/downloads/opc-ua-servers.html) 获取空调数据，并允许用户使用集成下行链路功能打开/关闭任何空调。

### 先决条件

{% include templates/integration/opc-ua/opc-ua-server-setup-steps.md %}

## 创建转换器模板

转换器和集成模板是在 **云** 上创建的，因此请以租户管理员身份登录到云实例。

### 上行转换器模板

在创建集成模板之前，您需要在 **转换器模板** 页面中创建上行和下行转换器模板。

**上行转换器** 是用于解析和转换 OPC UA 集成接收的数据的脚本。**下行转换器** 解析和转换从 ThingsBoard Edge 发送到现有设备的格式的数据。

首先，我们需要创建上行数据转换器，该转换器将用于接收来自 OPC UA 服务器的消息。转换器应将传入有效负载转换为所需的消息格式。结果消息必须包含 **deviceName** 和 **deviceType**。这些字段用于将数据提交给正确的设备。如果找不到设备，则会创建一个新设备。以下是来自 OPC UA 服务器的有效负载示例：

有效负载：
```ruby
{
    "temperature": "72.15819999999641"
}
```

元数据：
```ruby
{
    "opcUaNode_namespaceIndex": "3",
    "opcUaNode_name": "AirConditioner_1",
    "integrationName": "OPC-UA Airconditioners",
    "opcUaNode_identifier": "AirConditioner_1",
    "opcUaNode_fqn": "Objects.BuildingAutomation.AirConditioner_1"
}
```

我们将采用 **opcUaNode_name** 元数据值并将其映射到 **deviceName**，并将 **deviceType** 设置为 **default**。

但是，您可以在您的特定用例中使用其他映射。

此外，我们将检索 **temperature**、**humidity** 和 **powerConsumption** 字段的值，并将它们用作设备遥测。

单击“加号”和“创建新转换器”。要查看事件，请启用调试。在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

**上行转换器的示例：**

```ruby
/** Decoder **/

var data = decodeToJson(payload);
var deviceName = metadata['opcUaNode_name'];
var deviceType = 'default';

var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   telemetry: {
   },
   attributes: {
   }
};

if (data.temperature) {
    result.telemetry.temperature = Number(Number(data.temperature).toFixed(2));
}

if (data.humidity) {
    result.telemetry.humidity = Number(Number(data.humidity).toFixed(2));
}

if (data.powerConsumption) {
    result.telemetry.powerConsumption = Number(Number(data.powerConsumption).toFixed(2));
}

if (data.state !== undefined) {
    result.attributes.state = data.state === '1' ? true : false;
}

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
{: .copy-code}

解码器函数的目的是将传入的数据和元数据解析为 GridLinks Edge 可以使用的一种格式。**deviceName** 和 **deviceType** 是必需的，而 **attributes** 和 **telemetry** 是可选的。**Attributes** 和 **telemetry** 是扁平键值对象。不支持嵌套对象。

您可以在创建转换器时或在创建转换器后更改解码器函数。如果转换器已经创建，则单击“铅笔”图标进行编辑。复制转换器的配置示例（或您自己的配置）并将其插入解码器函数。通过单击“对勾”图标保存更改。

{% include images-gallery.html imageCollection="modifyConverter" %}

### 下行转换器模板

要从 ThingsBoard Edge 向 OPC UA 节点发送下行链路消息，我们需要定义一个下行链路转换器。

通常，下行转换器的输出应具有以下结构：

```ruby
[{
"contentType": "JSON",
"data": "{\"writeValues\":[],\"callMethods\":[{\"objectId\":\"ns=3;s=AirConditioner_1\",\"methodId\":\"ns=3;s=AirConditioner_1.Stop\",\"args\":[]}]}",
"metadata": {}
}]
```

- **contentType** - 定义数据将如何编码 {TEXT \| JSON \| BINARY}。在 OPC UA 集成的情况下，默认使用 JSON。
- **data** - OPC UA 集成将处理并发送到目标 OPC UA 节点的实际数据：
    - **writeValues** - 写入值方法的数组 [OPC UA 写入值格式](https://documentation.unified-automation.com/uasdkc/1.9.3/html/structOpcUa__WriteValue.html)：
        - **nodeId** - 目标节点 (`ns=<namespaceIndex>;<identifiertype>=<identifier>`)
        - **value** - 要写入的值
    - **callMethods** - 调用方法的数组 [OPC UA 调用方法格式](https://documentation.unified-automation.com/uasdkc/1.9.3/html/structOpcUa__CallMethodRequest.html)：
        - **objectId** - 目标对象
        - **methodId** - 目标方法
        - **args** - 方法输入值数组
- **metadata** - 在 OPC UA 集成中未使用，可以为空。


您可以根据您的配置自定义下行链路。
此转换器将使用 **setState** 方法和布尔值 **params** 来处理设备的 RPC 命令，以调用空调的“启动”或“停止”方法。目标节点是使用传入消息元数据的 **deviceName** 字段检测到的。

在下 **转换器模板** 页面中创建下行链路。要查看事件，请选择 **调试** 复选框。

{% include images-gallery.html imageCollection="addDownlink" %}

下行转换器的示例：

```ruby
/** Encoder **/

var data = {
    writeValues: [],
    callMethods: []
};

if (msgType === 'RPC_CALL_FROM_SERVER_TO_DEVICE') {
    if (msg.method === 'setState') {
        var targetMethod = msg.params === 'true' ? 'Start' : 'Stop';
        var callMethod = {
            objectId: 'ns=3;s=' + metadata['deviceName'],
            methodId: 'ns=3;s=' +metadata['deviceName']+'.'+targetMethod,
            args: []
        };
        data.callMethods.push(callMethod);
    }
}

var result = {
    contentType: "JSON",
    data: JSON.stringify(data),
    metadata: {}
};

return result;
```
{: .copy-code}

## 创建集成模板

现在已经创建了上行和下行转换器模板，就可以创建集成。转到 **集成模板** 部分，然后单击 **添加新集成** 按钮。将其命名为 **OPC-UA Airconditioners**，选择类型 **OPC-UA**，打开调试模式，然后从下拉菜单中添加最近创建的上行和下行转换器。

以下是其他集成字段值：
- 应用程序名称：\<empty\>（客户端应用程序名称）
- 应用程序 uri：\<empty\>（客户端应用程序 uri）
- 主机：**$\{\{endpointHost\}\}**（我们将在接下来的步骤中添加边缘属性 **endpointHost**）
- 端口：**端点端口**（请参阅 [先决条件](#prerequisites)）
- 扫描周期（以秒为单位）：10（重新扫描 OPC UA 节点的频率）
- 超时（以毫秒为单位）：5000（在向 OPC UA 服务器发出请求之前失败的超时时间）
- 安全性：无（可以是 *Basic128Rsa15 / Basic256 / Basic256Sha256 / 无*）
- 标识：匿名（可以是 *匿名 / 用户名*）
- 映射：
    - 映射类型：完全限定名称（可以是 *完全限定名称* / *ID*）
    - 设备节点模式：`Objects\.BuildingAutomation\.AirConditioner_\d+$`（用于将扫描的 OPC UA 节点 FQN/ID 与设备名称匹配的正则表达式。
  在此示例中，OPC UA Explorer 上的路径为 `Objects/BuildingAutomation/AirConditioner_X`，其中 X 是 1 到 *N* 之间的数字。
  这就是我们使用 `Objects\.BuildingAutomation\.AirConditioner_\d+$` 作为正则表达式的原因，因为 `\d+` 表示 1 到 *N* 之间的任何数字，而 `$` 表示字符串的末尾）
    - 订阅标签（要订阅的节点标签（**路径**）列表，以及映射到输出消息中使用的键（**键**））：
        - 状态 - 状态
        - 温度 - 温度
        - 湿度 - 湿度
        - 功率消耗 - 功率消耗

单击 **添加** 以保存集成。

{% include images-gallery.html imageCollection="addIntegration" %}

## 修改边缘根规则链以进行下行链路

我们可以使用规则节点从规则链向设备发送下行链路消息。
为了能够通过集成发送下行链路，我们需要修改云上的 **“边缘根规则链”**。
我们需要添加两个规则节点 - **发起者字段** 和 **集成下行链路** 节点。
将 **“向设备发送 RPC 请求”** 链接设置为 **发起者字段**，并配置以将发起者名称和类型添加到消息元数据 - 在 **下行链路转换器** 中，设备的名称将用于设置正确的 *OPC-UA* 节点。
然后从 **发起者字段** 节点添加 **成功** 链接到 **集成下行链路** 节点。
当 RPC 请求将被触发到边缘上的设备时，下行链路消息将被发送到集成。

{% include images-gallery.html imageCollection="downlinkRule" %}

## 空调仪表板

为了可视化空调仪表板数据并测试 RPC 命令，我们将创建 **空调仪表板** 并将其分配给边缘。
首先，请下载 [**airconditioners_dashboard.json**](/docs/pe/edge/user-guide/resources/airconditioners_dashboard.json) 文件。

{% include images-gallery.html imageCollection="airconditionersDashboard" showListImageTitles="true" %}

## 将集成分配给边缘

创建转换器和集成模板后，我们可以将集成模板分配给边缘。
因为我们在集成配置中使用了占位符 **$\{\{endpointHost\}\}**，所以我们需要先将属性 **endpointHost** 添加到边缘。
您需要提供 OPC-UA 服务器的 **端点主机**（请参阅 [先决条件](#prerequisites)）。添加属性后，我们就可以分配集成并验证是否已添加。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

## 验证

让我们验证集成是否已在边缘上成功启动，并且已建立与 OPC-UA 演示服务器的连接。

- 转到 **设备组** 页面。您将看到 **空调仪表板** 组。
- 当您打开此组时，您将看到 10 个空调仪表板设备。

{% include images-gallery.html imageCollection="device" %}

- 打开其中一个空调仪表板的详细信息，然后选择 **最新遥测** 选项卡。
- 您将看到遥测值经常更新。

{% include images-gallery.html imageCollection="deviceTelemetry" %}

- 转到 **仪表板** 并打开 **空调仪表板**。
- 您将看到来自所有 10 个空调仪表板的遥测数据，直到最后一分钟。

{% include images-gallery.html imageCollection="airconditionersDashboardOnEdge" %}

- 通过单击实体小部件中的详细信息按钮打开空调仪表板详细信息页面。

{% include images-gallery.html imageCollection="airconditionersDetails" %}

- 您会发现空调仪表板状态灯为浅绿色。
- 尝试通过单击 **开/关圆形开关** 来关闭空调仪表板。
- 空调仪表板状态灯将变为灰色，温度将开始上升，湿度将开始增加，功耗将停止。

{% include images-gallery.html imageCollection="rpcDownlink" %}

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}