---
layout: docwithnav-pe-edge
title: CoAP 集成
description: CoAP 集成指南

addConverter:
    0:
        image: /images/pe/edge/integrations/coap/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/coap/add-converter-step-2.png

modifyConverter:
    0:
        image: /images/pe/edge/integrations/coap/modify-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/coap/modify-converter-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/coap/add-integration-template-step-1.png
        title: '转到 <b>集成模板</b> 部分，然后单击 <b>添加新集成</b> 按钮。'
    1:
        image: /images/pe/edge/integrations/coap/add-integration-template-step-2.png
        title: '将其命名为 <b>CoAP 集成</b>，选择类型 <b>CoAP</b>，打开调试模式，然后从下拉菜单中添加最近创建的上行转换器。将基本 URL 设置为 <b>${{edgeIP}}</b>。请记下 <b>CoAP 端点 URL</b> 值 - 我们将在稍后的 <b>coap-client</b> 中使用它来测试 CoAP 集成。'

assignIntegration:
    0:
        image: /images/pe/edge/integrations/coap/assign-integration-step-1.png
        title: '将 <b>edgeIP</b> 属性添加到 Edge，并将值设置为您的 Edge IP <b>192.168.1.15</b>。请使用您的 Edge 实例的 <b>您的</b> IP 地址！'
    1:
        image: /images/pe/edge/integrations/coap/assign-integration-step-2.png
        title: '单击 Edge 实体的 <b>管理集成</b> 按钮'
    2:
        image: /images/pe/edge/integrations/coap/assign-integration-step-3.png
        title: '将集成分配给 Edge'
    3:
        image: /images/pe/edge/integrations/coap/assign-integration-step-4.png
        title: '登录到您的 <b>ThingsBoard Edge</b> 实例并打开集成页面 - 占位符将被属性值替换'

sendUplink:
    0:
        image: /images/pe/edge/integrations/coap/send-uplink-step-1.png
    1:
        image: /images/pe/edge/integrations/coap/send-uplink-step-2.png

device:
    0:
        image: /images/pe/edge/integrations/coap/device.png

converterEvents:
    0:
        image: /images/pe/edge/integrations/coap/converter-events-step-1.png
    1:
        image: /images/pe/edge/integrations/coap/converter-events-step-2.png
    2:
        image: /images/pe/edge/integrations/coap/converter-events-step-3.png

---

* TOC
{:toc}

{% assign integrationName = "CoAP" %}
{% assign integrationUrl = "coap" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

## 概述

CoAP 集成允许从使用 CoAP 协议连接到 GridLinks Edge 的设备流式传输数据，并将这些设备的有效负载转换为 GridLinks Edge 格式。

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/coap-integration.svg)

## 前提条件

在本教程中，我们将向您展示如何配置具有 **无安全** 安全模式的 CoAP 集成。

要模拟 CoAP 设备，请安装 [coap-client](http://manpages.ubuntu.com/manpages/focal/man5/coap-client.5.html) - 该实用程序旨在模拟将连接到 CoAP 集成的 CoAP 客户端。

假设我们有一个传感器，它将当前温度和湿度读数发送到 **coap://192.168.1.15** URL 上的 CoAP 集成 - *192.168.1.15* 是本地网络中 ThingsBoard Edge 的 IP 地址。在您的具体案例中，请使用 **您的** 边缘实例的 IP 地址。

出于演示目的，我们假设我们的设备足够智能，可以发送 3 种不同有效负载类型的数据：
- **文本** - 在这种情况下，有效负载为：**SN-001,default,temperature,25.7,humidity,69**
- **JSON** - 在这种情况下，有效负载为：

```json
{
  "deviceName": "SN-001",
  "deviceType": "default",
  "temperature": 25.7,
  "humidity": 69
}
```

- **二进制** - 在这种情况下，有效负载为：**\x53\x4e\x2d\x30\x30\x31\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x36\x39**（以 HEX 字符串表示）。
  以下是此有效负载中字节的说明：
    - **0-5** 字节 - **\x53\x4e\x2d\x30\x30\x31** - 设备名称。如果我们将其转换为文本 - **SN-001**；
    - **6-12** 字节 - **\x64\x65\x66\x61\x75\x6c\x74** - 设备类型。如果我们将其转换为文本 - **default**；
    - **13-16** 字节 - **\x32\x35\x2e\x37** - 温度遥测。如果我们将其转换为文本 - **25.7**；
    - **17-18** 字节 - **\x36\x39** - 湿度遥测。如果我们将其转换为文本 - **69**；

您可以根据设备功能和业务案例使用有效负载类型。

## 创建转换器模板

转换器和集成模板是在 **云** 上创建的，因此请以租户管理员身份登录到云实例。

### 上行转换器模板

在创建集成模板之前，您需要在 **转换器模板** 页面中创建一个上行转换器模板。
上行对于将来自设备的传入数据转换为在 GridLinks Edge 中显示它们所需的格式是必要的。
单击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

选择设备有效负载类型以进行解码器配置：

{% capture uplinkpayload %}
文本有效负载<br>%,%text%,%templates/integration/coap/coap-uplink-converter-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/coap/coap-uplink-converter-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/coap/coap-uplink-converter-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="coapintegartionuplinkpayload" toggle-spec=uplinkpayload %}

您可以在创建转换器时或创建转换器后更改解码器函数。
如果转换器已经创建，则单击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数中。
单击“复选标记”图标保存更改。

{% include images-gallery.html imageCollection="modifyConverter" %}

## 创建集成模板

现在已经创建了上行转换器模板，就可以创建集成。

{% include images-gallery.html imageCollection="addIntegration" showListImageTitles="true" %}

## 将集成分配给 Edge

创建转换器和集成模板后，我们可以将集成模板分配给 Edge。
因为我们在集成配置中使用占位符 **$\{\{edgeIP\}\}**，所以我们需要先将属性 **edgeIP** 添加到 Edge。
您需要将 *Edge* 实例的 **IP 地址** 提供为 **edgeIP** 属性。
添加属性后，我们就可以分配集成并验证是否已添加。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

## 发送上行消息

创建 CoAP 集成后，CoAP 服务器会注册相应的资源，然后等待来自设备的数据。
让我们登录 ThingsBoard **Edge** 并转到 **集成** 页面。找到您的 CoAP 集成并单击它。您可以在其中找到 CoAP 端点 URL。单击图标复制 URL。

选择设备有效负载类型以发送上行消息（将 **$YOUR_COAP_ENDPOINT_URL** 替换为相应的值）：

{% capture senduplink %}
文本有效负载<br>%,%text%,%templates/edge/integrations/coap/coap-send-uplink-text.md%br%
JSON 有效负载<br>%,%json%,%templates/edge/integrations/coap/coap-send-uplink-json.md%br%
二进制有效负载<br>%,%binary%,%templates/edge/integrations/coap/coap-send-uplink-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="coapintegrationsenduplink" toggle-spec=senduplink %}

{% include images-gallery.html imageCollection="sendUplink" %}

可以在 Edge 上的 **设备组 -> 全部** 部分中看到具有数据的已创建设备：

{% include images-gallery.html imageCollection="device" %}

可以在上行转换器中查看接收到的数据。在事件选项卡的 **“输入”** 和 **“输出”** 块中：

{% include images-gallery.html imageCollection="converterEvents" %}

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}