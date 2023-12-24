---
layout: docwithnav-pe-edge
title: HTTP 集成
description: HTTP 集成指南

addConverter:
    0:
        image: /images/pe/edge/integrations/http/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/http/add-converter-step-2.png

modifyConverter:
    0:
        image: /images/pe/edge/integrations/http/modify-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/http/modify-converter-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/http/add-integration-template-step-1.png
    1:
        image: /images/pe/edge/integrations/http/add-integration-template-step-2.png

assignIntegration:
    0:
        image: /images/pe/edge/integrations/http/assign-integration-step-1.png
        title: '将 <b>edgeBaseUrl</b> 属性添加到 Edge 并将值设置为您的 Edge <b>IP:port</b>'
    1:
        image: /images/pe/edge/integrations/http/assign-integration-step-2.png
        title: '单击 Edge 实体的 <b>管理集成</b> 按钮'
    2:
        image: /images/pe/edge/integrations/http/assign-integration-step-3.png
        title: '将集成分配给 Edge'
    3:
        image: /images/pe/edge/integrations/http/assign-integration-step-4.png
        title: '登录到您的 <b>ThingsBoard Edge</b> 实例并打开集成页面 - 占位符将被属性值替换'

sendUplink:
    0:
        image: /images/pe/edge/integrations/http/send-uplink-step-1.png
    1:
        image: /images/pe/edge/integrations/http/send-uplink-step-2.png

device:
    0:
        image: /images/pe/edge/integrations/http/device.png

converterEvents:
    0:
        image: /images/pe/edge/integrations/http/converter-events-step-1.png
    1:
        image: /images/pe/edge/integrations/http/converter-events-step-2.png
    2:
        image: /images/pe/edge/integrations/http/converter-events-step-3.png

addDownlink:
    0:
        image: /images/pe/edge/integrations/http/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/http/add-downlink-step-2.png

downlinkRule:
    0:
        image: /images/pe/edge/integrations/http/downlink-rule-step-1.png
    1:
        image: /images/pe/edge/integrations/http/downlink-rule-step-2.png

addSharedAttribute:
    0:
        image: /images/pe/edge/integrations/http/add-shared-attribute.png

downlinkMessage:
    0:
        image: /images/pe/edge/integrations/http/downlink-message.png

downlinkTerminal:
    0:
        image: /images/pe/edge/integrations/http/downlink-terminal.png

---

* TOC
{:toc}

{% assign integrationName = "HTTP" %}
{% assign integrationUrl = "http" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

## 概述

HTTP 集成允许将现有协议和有效负载格式转换为 ThingsBoard Edge 消息格式，并且在多种部署场景中很有用：

- 将设备和/或资产数据从外部系统、物联网平台或连接提供商后端流式传输回 ThingsBoard Edge。
- 从在云中运行的自定义应用程序流式传输设备和/或资产数据。
- 将具有基于 HTTP 的自定义协议的现有设备连接到 ThingsBoard Edge。

## 创建转换器模板

转换器和集成模板在 **云** 上创建，因此请以租户管理员身份登录云实例。

### 上行转换器模板

在创建集成模板之前，您需要在 **转换器模板** 页面中创建上行和下行转换器模板。
上行对于将来自设备的传入数据转换为在 ThingsBoard Edge 中显示它们所需的格式是必要的。
单击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

**上行转换器的示例：**

```ruby
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - 键/值对象
/** 解码器 **/
// 将有效负载解码为字符串
// var payloadStr = decodeToString(payload);
// 将有效负载解码为 JSON
var data = decodeToJson(payload);
var deviceName = data.deviceName;
// 具有设备属性/遥测数据的 Result 对象
var result = {
   deviceName: deviceName,
   deviceType: 'default',
   attributes: {
       model: data.model,
   },
   telemetry: {
       temperature: data.temperature
   }
};
/** 帮助器函数 **/
function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}
function decodeToJson(payload) {
   // 将有效负载转换为字符串。
   var str = decodeToString(payload);
   // 将字符串解析为 JSON
   var data = JSON.parse(str);
   return data;
}
return result;
```
{: .copy-code}

您可以在创建转换器时或在创建转换器后更改解码器函数。
如果转换器已经创建，则单击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数。
通过单击“复选标记”图标保存更改。

{% include images-gallery.html imageCollection="modifyConverter" %}

### 下行转换器模板

同样在 **转换器模板** 页面中创建下行。要查看事件，请选择 **调试** 复选框。

{% include images-gallery.html imageCollection="addDownlink" %}

您可以根据您的配置自定义下行。
让我们考虑一个我们发送属性更新消息的示例。
下行转换器的示例：

```ruby
// 从传入的规则引擎消息对下行数据进行编码

// msg - JSON 消息有效负载下行消息 json
// msgType - 消息类型，例如 'ATTRIBUTES_UPDATED'、'POST_TELEMETRY_REQUEST' 等。
// metadata - 包含有关消息的其他数据的键值对列表
// integrationMetadata - 在执行此转换器的集成中定义的其他数据的键值对列表

var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(msg),

    // 以键/值格式显示的可选元数据对象
    metadata: {
    }
};

return result;
```
{: .copy-code}

## 创建集成模板

现在已经创建了上行和下行转换器模板，就可以创建集成。

{% include images-gallery.html imageCollection="addIntegration" %}


## 修改下行的 Edge 根规则链

我们可以使用规则节点从规则链向设备发送下行消息。
为了能够通过集成发送下行，我们需要修改云上的 **“Edge 根规则链”**。
例如，创建一个 **集成下行** 节点并将 **“属性已更新”** 链接到它。
当对设备属性进行更改时，下行消息将被发送到集成。

{% include images-gallery.html imageCollection="downlinkRule" %}

## 将集成分配给 Edge

一旦创建了转换器和集成模板，我们就可以将集成模板分配给 Edge。
因为我们在集成配置中使用占位符 **$\{\{edgeBaseUrl\}\}**，所以我们需要首先将属性 **edgeBaseUrl** 添加到 Edge。
您需要提供您的 *Edge* 实例的 **IP 地址** 和 **端口** 作为 **edgeBaseUrl** 属性。
添加属性后，我们就可以分配集成并验证是否已添加。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

## 发送上行消息

要发送上行消息，您需要来自集成的 HTTP 端点 URL。
让我们登录 ThingsBoard **Edge** 并转到 **集成** 页面。找到您的 HTTP 集成并单击它。您可以在其中找到 HTTP 端点 URL。单击图标复制 URL。

使用此命令发送消息。用相应的数值替换 $DEVICE_NAME 和 $YOUR_HTTP_ENDPOINT_URL。

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICE_NAME\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code}

{% include images-gallery.html imageCollection="sendUplink" %}

可以在 Edge 上的 **设备组 -> 全部** 部分中看到具有数据的已创建设备：

{% include images-gallery.html imageCollection="device" %}

可以在上行转换器中查看接收到的数据。在事件选项卡的 **“输入”** 和 **“输出”** 块中：

{% include images-gallery.html imageCollection="converterEvents" %}

## 发送下行消息

现在让我们检查一下下行功能。让我们添加 **固件** 共享属性：

{% include images-gallery.html imageCollection="addSharedAttribute" %}

要确保发送到集成的下行消息，您可以检查集成的“事件”选项卡：

{% include images-gallery.html imageCollection="downlinkMessage" %}

现在我们需要再次向 HTTP 集成发送消息并查看下行响应。
请使用之前使用过的命令（用相应的数值替换 $DEVICE_NAME 和 $YOUR_HTTP_ENDPOINT_URL）：

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICE_NAME\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code}

终端中发送的消息和来自 ThingsBoard Edge 的响应示例：

{% include images-gallery.html imageCollection="downlinkTerminal" %}

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}