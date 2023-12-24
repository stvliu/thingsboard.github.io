---
layout: docwithnav-pe-edge
title: UDP 集成
description: UDP 集成指南

addConverter:
    0:
        image: /images/pe/edge/integrations/udp/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/add-converter-step-2.png

modifyConverter:
    0:
        image: /images/pe/edge/integrations/udp/modify-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/modify-converter-step-2.png

addDownlink:
    0:
        image: /images/pe/edge/integrations/udp/add-downlink-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/add-downlink-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/udp/add-integration-template-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/add-integration-template-step-2.png
    2:
        image: /images/pe/edge/integrations/udp/add-integration-template-step-3.png

downlinkRule:
    0:
        image: /images/pe/edge/integrations/udp/downlink-rule-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/downlink-rule-step-2.png

assignIntegration:
    0:
        image: /images/pe/edge/integrations/udp/assign-integration-step-1.png
        title: '单击边缘实体的<b>管理集成</b>按钮'
    1:
        image: /images/pe/edge/integrations/udp/assign-integration-step-2.png
        title: '将集成分配给边缘'
    2:
        image: /images/pe/edge/integrations/udp/assign-integration-step-3.png
        title: '登录您的<b>ThingsBoard Edge</b>实例并打开集成页面'

sendUplink:
    0:
        image: /images/pe/edge/integrations/udp/send-uplink-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/send-uplink-step-2.png

device:
    0:
        image: /images/pe/edge/integrations/udp/device.png

converterEvents:
    0:
        image: /images/pe/edge/integrations/udp/converter-events-step-1.png
    1:
        image: /images/pe/edge/integrations/udp/converter-events-step-2.png
    2:
        image: /images/pe/edge/integrations/udp/converter-events-step-3.png

addSharedAttribute:
    0:
        image: /images/pe/edge/integrations/udp/add-shared-attribute.png

downlinkMessage:
    0:
        image: /images/pe/edge/integrations/udp/downlink-message.png

downlinkTerminal:
    0:
        image: /images/pe/edge/integrations/udp/downlink-terminal.png

---

* TOC
{:toc}

{% assign integrationName = "UDP" %}
{% assign integrationUrl = "udp" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

## 概述

{% include templates/edge/integrations/tcp-udp/overview.md %}

{% include templates/edge/integrations/tcp-udp/remote-only.md %}

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/udp-integration.svg)

## 先决条件

在本教程中，我们将使用：

- ThingsBoard PE Edge；
- UDP 集成，在外部运行并连接到 GridLinks Edge 实例；
- **echo** 命令，用于显示一行文本，并将输出重定向到 **netcat** (**nc**) 实用程序；
- **netcat** (**nc**) 实用程序，用于建立 UDP 连接，从那里接收数据并传输数据；

我们假设我们有一个传感器，它正在发送当前温度和湿度读数。
我们的传感器设备 **SN-001** 将其温度和湿度读数发布到 **11560** 端口的 UDP 集成，该端口位于运行 UDP 集成的计算机上。

出于演示目的，我们假设我们的设备足够智能，可以发送 3 种不同的有效负载类型的数据：
- **文本** - 在这种情况下，有效负载为 **SN-001,default,temperature,25.7,humidity,69**
- **JSON** - 在这种情况下，有效负载为

```json
[
  {
    "deviceName": "SN-001",
    "deviceType": "default",
    "temperature": 25.7,
    "humidity": 69
  }
]
```
- **二进制** - 在这种情况下，有效负载为：**\x53\x4e\x2d\x30\x30\x31\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x36\x39**（十六进制字符串）。
  以下是此有效负载中字节的说明：
    - **0-5** 字节 - **\x53\x4e\x2d\x30\x30\x31** - 设备名称。如果我们将其转换为文本 - **SN-001**；
    - **6-12** 字节 - **\x64\x65\x66\x61\x75\x6c\x74** - 设备类型。如果我们将其转换为文本 - **default**；
    - **13-16** 字节 - **\x32\x35\x2e\x37** - 温度遥测。如果我们将其转换为文本 - **25.7**；
    - **17-18** 字节 - **\x36\x39** - 湿度遥测。如果我们将其转换为文本 - **69**；

- **十六进制** - 在这种情况下，有效负载为十六进制字符串 **534e2d30303164656661756c7432352e373639**.
  以下是此有效负载中字节的说明：
    - **0-5** 字节 - **534e2d303031** - 设备名称。如果我们将其转换为文本 - **SN-001**；
    - **6-12** 字节 - **64656661756c74** - 设备类型。如果我们将其转换为文本 - **default**；
    - **13-16** 字节 - **32352e37** - 温度遥测。如果我们将其转换为文本：- **25.7**；
    - **17-18** 字节 - **3639** - 湿度遥测。如果我们将其转换为文本：- **69**；

您可以根据设备功能和业务案例选择有效负载类型。

{% assign integrationPort = "11560" %}
{% include templates/edge/integrations/tcp-udp/firewall.md %}

## 创建转换器模板

转换器和集成模板是在 **云** 中创建的，因此请以租户管理员身份登录到云实例。

### 上行转换器模板

在创建集成模板之前，您需要在 **转换器模板** 页面中创建上行和下行转换器模板。
上行对于将来自设备的传入数据转换为在 GridLinks Edge 中显示它们所需的格式是必要的。
单击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

根据您的设备有效负载类型选择解码器配置：

{% capture uplinkpayload %}
文本有效负载<br>%,%text%,%templates/integration/udp/udp-uplink-converter-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/udp/udp-uplink-converter-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/udp/udp-uplink-converter-binary.md%br%
十六进制有效负载<br>%,%hex%,%templates/integration/udp/udp-uplink-converter-hex.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpintegartionuplinkpayload" toggle-spec=uplinkpayload %}

您可以在创建转换器时或在创建转换器后更改解码器函数。
如果转换器已经创建，则单击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数中。
单击“复选标记”图标保存更改。

{% include images-gallery.html imageCollection="modifyConverter" %}

### 下行转换器模板

在下行转换器模板中创建下行。要查看事件，请选择 **调试** 复选框。

{% include images-gallery.html imageCollection="addDownlink" %}

您可以根据您的配置自定义下行。
让我们考虑一个示例，我们发送一个属性更新消息。
下行转换器的示例：

```ruby
// Encode downlink data from incoming Rule Engine message

// msg - JSON message payload downlink message json
// msgType - type of message, for ex. 'ATTRIBUTES_UPDATED', 'POST_TELEMETRY_REQUEST', etc.
// metadata - list of key-value pairs with additional data about the message
// integrationMetadata - list of key-value pairs with additional data defined in Integration executing this converter

var result = {

    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "JSON",

    // downlink data
    data: JSON.stringify(msg),

    // Optional metadata object presented in key/value format
    metadata: {
    }
};

return result;
```
{: .copy-code}

## 创建集成模板

现在已经创建了上行和下行转换器模板，就可以创建集成。
转到 **集成模板** 部分，然后单击 **添加新集成** 按钮。将其命名为 **UDP 集成**，选择类型 **UDP**，打开调试模式，然后从下拉菜单中添加最近创建的上行和下行转换器。

正如您提到的 **远程执行** 已选中且无法修改 - UDP 集成只能是 **远程** 类型。

请记下 **集成密钥** 和 **集成机密** - 我们将在稍后的配置中使用这些值在远程 UDP 集成本身上。

默认情况下，UDP 集成将使用 **11560** 端口，但您可以在您的情况下将其更改为任何可用的端口。

我们默认保留其他选项，但这里是对它们的简要说明：
- **启用广播 - 集成将接受广播地址数据包** - 一个标志，表示集成将接受发送到广播地址的 UDP 数据包；
- **入站套接字的缓冲区大小** - 套接字数据接收缓冲区的千字节大小；

为 **处理程序配置** 选择设备有效负载类型：

{% capture handlerconfiguration %}
文本有效负载<br>%,%text%,%templates/integration/udp/udp-handler-configuration-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/udp/udp-handler-configuration-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/udp/udp-handler-configuration-binary.md%br%
十六进制有效负载<br>%,%hex%,%templates/integration/udp/udp-handler-configuration-hex.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpintegrationhandlerconfiguration" toggle-spec=handlerconfiguration %}

单击 **添加** 以保存集成。

{% include images-gallery.html imageCollection="addIntegration" %}


## 修改边缘根规则链以进行下行

我们可以使用规则节点从规则链向设备发送下行消息。
为了能够通过集成发送下行，我们需要修改云上的 **“边缘根规则链”**。
例如，创建一个 **集成下行** 节点并将 **“属性已更新”** 链接到它。
当对设备属性进行更改时，下行消息将发送到集成。

{% include images-gallery.html imageCollection="downlinkRule" %}

## 将集成分配给边缘

一旦创建了转换器和集成模板，我们就可以将集成模板分配给边缘。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

## 安装和运行外部 UDP 集成

请参阅 [远程集成指南](/docs/pe/edge/user-guide/integrations/remote-integrations)并在本地或单独的计算机上安装 UDP 集成服务。

请在您的 UDP 集成配置中使用上述部分中的 **集成密钥** 和 **集成机密**。

## 发送上行消息

创建 ThingsBoard UDP 集成后，UDP 服务器启动，然后等待来自设备的数据。

选择设备有效负载类型以发送上行消息：

{% capture senduplink %}
文本有效负载<br>%,%text%,%templates/integration/udp/udp-send-uplink-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/udp/udp-send-uplink-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/udp/udp-send-uplink-binary.md%br%
十六进制有效负载<br>%,%hex%,%templates/integration/udp/udp-send-uplink-hex.md{% endcapture %}

{% include content-toggle.html content-toggle-id="udpintegrationsenduplink" toggle-spec=senduplink %}

{% include images-gallery.html imageCollection="sendUplink" %}

可以在边缘的 **设备组 -> 全部** 部分中看到具有数据的创建的设备：

{% include images-gallery.html imageCollection="device" %}

可以在上行转换器的事件选项卡的 **“输入”** 和 **“输出”** 块中查看接收到的数据：

{% include images-gallery.html imageCollection="converterEvents" %}

## 发送下行消息

现在让我们检查一下下行功能。

现在我们需要再次向 UDP 集成发送消息以查看下行响应。
请使用之前使用的相同命令，但将参数 **q1** 替换为 **q120**。通过这些更改，**nc** 实用程序将等待 120 秒以接收下行消息。
此外，请删除 **w1** 参数。

在发送上行命令后，您有 **120 秒** 来添加 **固件** 共享属性：

{% include images-gallery.html imageCollection="addSharedAttribute" %}

要确保已将下行消息发送到集成，您可以检查集成的“事件”选项卡：

{% include images-gallery.html imageCollection="downlinkMessage" %}

终端中发送的消息和来自 ThingsBoard Edge 的响应示例：

{% include images-gallery.html imageCollection="downlinkTerminal" %}

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}