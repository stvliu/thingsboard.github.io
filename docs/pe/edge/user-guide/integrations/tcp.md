---
layout: docwithnav-pe-edge
title: TCP 集成
description: TCP 集成指南

addConverter:
    0:
        image: /images/pe/edge/integrations/tcp/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/add-converter-step-2.png

modifyConverter:
    0:
        image: /images/pe/edge/integrations/tcp/modify-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/modify-converter-step-2.png

addDownlink:
    0:
        image: /images/pe/edge/integrations/tcp/add-downlink-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/add-downlink-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/tcp/add-integration-template-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/add-integration-template-step-2.png
    2:
        image: /images/pe/edge/integrations/tcp/add-integration-template-step-3.png

downlinkRule:
    0:
        image: /images/pe/edge/integrations/tcp/downlink-rule-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/downlink-rule-step-2.png

assignIntegration:
    0:
        image: /images/pe/edge/integrations/tcp/assign-integration-step-1.png
        title: '点击边缘实体的<b>管理集成</b>按钮'
    1:
        image: /images/pe/edge/integrations/tcp/assign-integration-step-2.png
        title: '将集成分配给边缘'
    2:
        image: /images/pe/edge/integrations/tcp/assign-integration-step-3.png
        title: '登录您的<b>ThingsBoard Edge</b>实例并打开集成页面'

sendUplink:
    0:
        image: /images/pe/edge/integrations/tcp/send-uplink-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/send-uplink-step-2.png

device:
    0:
        image: /images/pe/edge/integrations/tcp/device.png

converterEvents:
    0:
        image: /images/pe/edge/integrations/tcp/converter-events-step-1.png
    1:
        image: /images/pe/edge/integrations/tcp/converter-events-step-2.png
    2:
        image: /images/pe/edge/integrations/tcp/converter-events-step-3.png

addSharedAttribute:
    0:
        image: /images/pe/edge/integrations/tcp/add-shared-attribute.png

downlinkMessage:
    0:
        image: /images/pe/edge/integrations/tcp/downlink-message.png

downlinkTerminal:
    0:
        image: /images/pe/edge/integrations/tcp/downlink-terminal.png

---

* TOC
{:toc}

{% assign integrationName = "TCP" %}
{% assign integrationUrl = "tcp" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

## 概述

{% include templates/edge/integrations/tcp-udp/overview.md %}

{% include templates/edge/integrations/tcp-udp/remote-only.md %}

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/tcp-integration.svg)

## 先决条件

在本教程中，我们将使用：

- ThingsBoard PE Edge；
- TCP 集成，在外部运行并连接到云 ThingsBoard Edge 实例；
- **echo** 命令，用于显示一行文本，并将输出重定向到 **netcat** (**nc**) 实用程序；
- **netcat** (**nc**) 实用程序，用于建立 TCP 连接，从那里接收数据并传输数据；

我们假设我们有一个传感器，它正在发送当前温度和湿度读数。
我们的传感器设备 **SN-002** 将其温度和湿度读数发布到 **10560** 端口的 TCP 集成，该端口位于运行 TCP 集成的机器上。

出于演示目的，我们假设我们的设备足够智能，可以发送 3 种不同的有效负载类型的数据：
- **文本** - 在这种情况下，有效负载是 **SN-002,default,temperature,25.7\n\rSN-002,default,humidity,69**
- **JSON** - 在这种情况下，有效负载是

```json
[
  {
    "deviceName": "SN-002",
    "deviceType": "default",
    "temperature": 25.7,
    "humidity": 69
  }
]
```
- **二进制** - 在这种情况下，二进制有效负载是 **\x30\x30\x30\x30\x11\x53\x4e\x2d\x30\x30\x32\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x00\x00\x00**（十六进制字符串）。
  以下是此有效负载中字节的说明：
    - **0-3** 字节 - **\x30\x30\x30\x30** - 虚拟字节，用于显示如何在有效负载中跳过特定前缀字节。这些字节包含在示例中；
    - **4** 字节 - **\x11** - 有效负载长度。如果我们将其转换为十进制 - **17**。因此，在这种情况下，我们的有效负载限制为来自传入 TCP 帧的 17 个字节；
    - **5-10** 字节 - **\x53\x4e\x2d\x30\x30\x32** - 设备名称。如果我们将其转换为文本 - **SN-002**；
    - **11-17** 字节 - **\x64\x65\x66\x61\x75\x6c\x74** - 设备类型。如果我们将其转换为文本 - **default**；
    - **18-21** 字节 - **\x32\x35\x2e\x37** - 温度遥测。如果我们将其转换为文本 - **25.7**；
    - **22-24** 字节 - **\x00\x00\x00** - 虚拟字节。我们将忽略它们，因为有效负载大小为 **17** 字节 - 从 **5** 到 **21** 字节。这些字节包含在示例中；

您可以根据设备功能和业务案例选择有效负载类型。

{% assign integrationPort = "10560" %}
{% include templates/edge/integrations/tcp-udp/firewall.md %}

## 创建转换器模板

转换器和集成模板在 **云** 上创建，因此请以租户管理员身份登录云实例。

### 上行转换器模板

在创建集成模板之前，您需要在 **转换器模板** 页面中创建上行和下行转换器模板。
上行对于将来自设备的传入数据转换为在 GridLinks Edge 中显示它们所需的格式是必要的。

点击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

根据解码器配置选择设备有效负载类型：

{% capture uplinkpayload %}
文本有效负载<br>%,%text%,%templates/integration/tcp/tcp-uplink-converter-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/tcp/tcp-uplink-converter-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/tcp/tcp-uplink-converter-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpintegartionuplinkpayload" toggle-spec=uplinkpayload %}

您可以在创建转换器时或创建转换器后更改解码器函数。
如果转换器已经创建，请点击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数中。
点击“对勾”图标保存更改。

{% include images-gallery.html imageCollection="modifyConverter" %}

### 下行转换器模板

在下行转换器模板中创建下行。要查看事件，请选择 **调试** 复选框。

{% include images-gallery.html imageCollection="addDownlink" %}

您可以根据您的配置自定义下行。
让我们考虑一个发送属性更新消息的示例。
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
转到 **集成模板** 部分并点击 **添加新集成** 按钮。将其命名为 **TCP 集成**，选择类型 **TCP**，打开调试模式，并从下拉菜单中添加最近创建的上行和下行转换器。

正如您提到的，**远程执行** 已选中且无法修改 - TCP 集成只能是 **远程** 类型。

请记下 **集成密钥** 和 **集成机密** - 我们将在稍后的配置中使用这些值在远程 TCP 集成上。

默认情况下，TCP 集成将使用 **10560** 端口，但您可以在您的案例中将其更改为任何可用的端口。

我们默认保留其他选项，但这里是对它们的简要说明：
- **套接字上挂起的最大连接数** - 传入连接指示（连接请求）的最大队列长度设置为 backlog 参数。如果队列已满时出现连接指示，则拒绝连接；
- **入站套接字的缓冲区大小** - 套接字数据接收缓冲区的大小（以 KB 为单位）；
- **出站套接字的缓冲区大小** - 套接字数据发送缓冲区的大小（以 KB 为单位）；
- **启用在面向连接的套接字上发送保持活动消息** - 一个标志，指示应定期通过网络向对端套接字发送探测以保持连接处于活动状态；
- **强制套接字在不缓冲的情况下发送数据（禁用 Nagle 的缓冲算法）** - 在套接字上禁用 Nagle 的算法，该算法会延迟数据传输，直到积累了一定数量的待处理数据。

为 **处理程序配置** 选择设备有效负载类型：

{% capture handlerconfiguration %}
文本有效负载<br>%,%text%,%templates/integration/tcp/tcp-handler-configuration-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/tcp/tcp-handler-configuration-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/tcp/tcp-handler-configuration-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpintegrationhandlerconfiguration" toggle-spec=handlerconfiguration %}

点击 **添加** 保存集成。

{% include images-gallery.html imageCollection="addIntegration" %}


## 修改边缘根规则链以进行下行

我们可以使用规则节点从规则链向设备发送下行消息。
为了能够通过集成发送下行，我们需要修改云上的 **“边缘根规则链”**。
例如，创建一个 **集成下行** 节点并将 **“属性已更新”** 链接到它。
当对设备属性进行更改时，下行消息将被发送到集成。

{% include images-gallery.html imageCollection="downlinkRule" %}

## 将集成分配给边缘

一旦创建了转换器和集成模板，我们就可以将集成模板分配给边缘。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

#### 安装和运行外部 TCP 集成

请参阅 [远程集成指南](/docs/pe/edge/user-guide/integrations/remote-integrations)并在本地或单独的机器上安装 TCP 集成服务。

请在您的 TCP 集成配置中使用上述部分中的 **集成密钥** 和 **集成机密**。

## 发送上行消息

创建 ThingsBoard TCP 集成后，TCP 服务器启动，然后等待来自设备的数据。

选择设备有效负载类型以发送上行消息：

{% capture senduplink %}
文本有效负载<br>%,%text%,%templates/integration/tcp/tcp-send-uplink-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/tcp/tcp-send-uplink-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/tcp/tcp-send-uplink-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tcpintegrationsenduplink" toggle-spec=senduplink %}

{% include images-gallery.html imageCollection="sendUplink" %}

可以在边缘的 **设备组 -> 全部** 部分中看到具有数据的创建的设备：

{% include images-gallery.html imageCollection="device" %}

可以在上行转换器的事件选项卡的 **“输入”** 和 **“输出”** 块中查看接收到的数据：

{% include images-gallery.html imageCollection="converterEvents" %}

## 发送下行消息

现在让我们检查一下下行功能。让我们添加 **固件** 共享属性：

{% include images-gallery.html imageCollection="addSharedAttribute" %}

要确保下行消息已发送到集成，您可以检查集成的“事件”选项卡：

{% include images-gallery.html imageCollection="downlinkMessage" %}

现在我们需要再次向 TCP 集成发送消息并查看下行响应。
请使用之前使用的相同命令。

终端中发送的消息和来自 ThingsBoard Edge 的响应示例：

{% include images-gallery.html imageCollection="downlinkTerminal" %}

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}