---
layout: docwithnav-pe-edge
title: MQTT 集成
description: MQTT 集成指南
addConverter:
    0:
        image: /images/pe/edge/integrations/mqtt/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/mqtt/add-converter-step-2.png

modifyConverter:
    0:
        image: /images/pe/edge/integrations/mqtt/modify-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/mqtt/modify-converter-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/mqtt/add-integration-template-step-1.png
    1:
        image: /images/pe/edge/integrations/mqtt/add-integration-template-step-2.png
    2:
        image: /images/pe/edge/integrations/mqtt/add-integration-template-step-3.png

assignIntegration:
    0:
        image: /images/pe/edge/integrations/mqtt/assign-integration-step-1.png
        title: '将 <b>brokerIp</b> 属性添加到 Edge 并将值设置为您的 Edge <b>broker.hivemq.com</b>'
    1:
        image: /images/pe/edge/integrations/mqtt/assign-integration-step-2.png
        title: '单击 Edge 实体的 <b>管理集成</b> 按钮'
    2:
        image: /images/pe/edge/integrations/mqtt/assign-integration-step-3.png
        title: '将集成分配给 Edge'
    3:
        image: /images/pe/edge/integrations/mqtt/assign-integration-step-4.png
        title: '登录到您的 <b>ThingsBoard Edge</b> 实例并打开集成页面 - 占位符将被属性值替换'

device:
    0:
        image: /images/pe/edge/integrations/mqtt/device.png

converterEvents:
    0:
        image: /images/pe/edge/integrations/mqtt/converter-events-step-1.png
    1:
        image: /images/pe/edge/integrations/mqtt/converter-events-step-2.png
    2:
        image: /images/pe/edge/integrations/mqtt/converter-events-step-3.png

addDownlink:
    0:
        image: /images/pe/edge/integrations/mqtt/add-downlink-step-1.png
    1:
        image: /images/pe/edge/integrations/mqtt/add-downlink-step-2.png

downlinkRule:
    0:
        image: /images/pe/edge/integrations/mqtt/downlink-rule-step-1.png
    1:
        image: /images/pe/edge/integrations/mqtt/downlink-rule-step-2.png
    2:
        image: /images/pe/edge/integrations/mqtt/downlink-rule-step-3.png

addSharedAttribute:
    0:
        image: /images/pe/edge/integrations/mqtt/add-shared-attribute.png

downlinkMessage:
    0:
        image: /images/pe/edge/integrations/mqtt/downlink-message.png

downlinkTerminal:
    0:
        image: /images/pe/edge/integrations/mqtt/downlink-terminal.png
---

* TOC
{:toc}

{% assign integrationName = "MQTT" %}
{% assign integrationUrl = "mqtt" %}
{% include templates/edge/integrations/edge-pe-reference.md %}

## 概述

MQTT 集成允许连接到外部 MQTT 代理，订阅来自这些代理的数据流，并将任何类型的有效负载从您的设备转换为 GridLinks Edge 消息格式。
每当您的设备已连接到外部 MQTT 代理或任何其他基于 MQTT 后端的 IoT 平台或连接提供程序时，通常会使用它。

请查看集成图以了解更多信息。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/mqtt-integration.svg"></object>

ThingsBoard Edge MQTT 集成充当 MQTT 客户端。
它订阅主题并将数据转换为遥测和属性更新。
在发送下行消息的情况下，MQTT 集成会将其转换为适合设备的格式并推送到外部 MQTT 代理。

**注意**：MQTT 代理应与 GridLinks Edge 实例位于同一位置或部署在云中，并具有有效的 DNS 名称或静态 IP 地址。

### 前提条件

在本教程中，我们将使用：

- MQTT 代理，GridLinks Edge 实例可访问 - broker.hivemq.com（端口 1883）；
- *mosquitto_pub* 和 *mosquitto_sub* MQTT 客户端来发送和接收消息。

我们假设我们有一个传感器正在发送当前温度读数。
我们的传感器设备 **SN-001** 将其温度读数发布到 **tb-edge/mqtt-integration-tutorial/sensors/SN-001/temperature**，并且订阅 **tb-edge/mqtt-integration-tutorial/sensors/SN-001/rx** 以接收 RPC 调用。

我们将发送一条消息，其中包含简单格式的温度读数：**`{"value":25.1}`**

## 创建转换器模板

转换器和集成模板是在 **云** 上创建的，因此请以租户管理员身份登录到云实例。

### 上行转换器模板

在创建集成模板之前，您需要在 **转换器模板** 页面中创建上行和下行转换器模板。

**上行转换器** 是一个用于解析和转换 MQTT 集成接收的数据的脚本。
**下行转换器** 解析和转换从 GridLinks 发送到现有设备的数据。

上行对于将来自设备的传入数据转换为在 GridLinks Edge 中显示它们所需的格式是必需的。
单击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

**上行转换器的示例：**

```ruby
/** Decoder **/

// decode payload to string
var payloadStr = decodeToString(payload);
var data = JSON.parse(payloadStr);
var topicPattern = 'tb-edge/mqtt-integration-tutorial/sensors/(.+)/temperature';

var deviceName =  metadata.topic.match(topicPattern)[1];
// decode payload to JSON

// Result object with device attributes/telemetry data
var result = {
   deviceName: deviceName,
   deviceType: 'default',
   attributes: {
       integrationName: metadata['integrationName'],
   },
   telemetry: {
       temperature: data.value,
   }
};

/** Helper functions **/

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   // convert payload to string.
   var str = decodeToString(payload);

   // parse string to JSON
   var data = JSON.parse(str);
   return data;
}

return result;
```
{: .copy-code}

解码器函数的目的是将传入的数据和元数据解析为 GridLinks Edge 可以使用的一种格式。
**deviceName** 和 **deviceType** 是必需的，而 **attributes** 和 **telemetry** 是可选的。
**Attributes** 和 **telemetry** 是扁平键值对象。不支持嵌套对象。

您可以在创建转换器时或创建转换器后更改解码器函数。
如果转换器已创建，请单击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数。
通过单击“复选标记”图标保存更改。

{% include images-gallery.html imageCollection="modifyConverter" %}

### 下行转换器模板

在 **转换器模板** 页面中也创建下行。要查看事件，请选择 **调试** 复选框。

{% include images-gallery.html imageCollection="addDownlink" %}

您可以根据您的配置自定义下行。
让我们考虑一个我们发送属性更新消息的示例。
下行转换器的示例：

```ruby
/** Encoder **/

// Result object with encoded downlink payload
var result = {

    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "JSON",

    // downlink data
    data: JSON.stringify(msg),

    // Optional metadata object presented in key/value format
    metadata: {
        topic: 'tb-edge/mqtt-integration-tutorial/sensors/'+metadata['originatorName']+'/rx'
    }

};

return result;
```
{: .copy-code}

## 创建集成模板

现在已经创建了上行和下行转换器模板，就可以创建集成。
转到 **集成模板** 部分并单击 **添加新集成** 按钮。将其命名为 **Edge MQTT**，选择类型 **MQTT**，打开调试模式，然后从下拉菜单中添加最近创建的上行和下行转换器。

指定主机：**$\{\{brokerIp\}\}**。端口：**1883**。最好取消选中 **Clean session** 参数。许多代理不支持粘性会话，因此如果您尝试启用此选项，代理会默默地关闭连接。

添加主题过滤器 **tb-edge/mqtt-integration-tutorial/sensors/+/temperature**。您还可以选择 MQTT QoS 级别。我们默认使用 MQTT QoS 级别 0（最多一次）。

让我们默认保留下行主题模式，这意味着集成将采用 metadata.topic 并将其用作下行主题。

单击 **添加** 以保存集成。

{% include images-gallery.html imageCollection="addIntegration" %}

## 修改 Edge 根规则链以进行下行

我们可以使用规则节点从规则链向设备发送下行消息。
为了能够通过集成发送下行，我们需要修改云上的 **“Edge 根规则链”**。
我们需要添加两个规则节点 - **发起者字段** 和 **集成下行** 节点。
将 **“已更新属性”** 链接到 **发起者字段** 并配置以将发起者名称和类型添加到消息元数据中 - 在 **下行转换器** 中，设备的名称将用于设置正确的 *下行* MQTT 主题。
然后从 **发起者字段** 节点添加 **成功** 链接到 **集成下行** 节点。
当对 Edge 上的设备属性进行更改时，下行消息将被发送到集成模板。

{% include images-gallery.html imageCollection="downlinkRule" %}

## 将集成分配给 Edge

创建转换器和集成模板后，我们可以将集成模板分配给 Edge。
因为我们在集成配置中使用占位符 **$\{\{brokerIp\}\}**，所以我们需要先将属性 **brokerIp** 添加到 Edge。
您需要提供 MQTT 代理的 **IP 地址**。我们在本教程中使用公共 URL *broker.hivemq.com*，但也可以是任何内部 IP 地址。
添加属性后，我们就可以分配集成并验证是否已添加。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

## 发送上行消息

现在让我们模拟设备向集成发送温度读数：

```ruby
mosquitto_pub -h broker.hivemq.com -p 1883 -t "tb-edge/mqtt-integration-tutorial/sensors/SN-001/temperature" -m '{"value":25.2}'
```
{: .copy-code}

可以在 Edge 上的 **设备组 -> 全部** 部分中看到具有数据的创建的设备：

{% include images-gallery.html imageCollection="device" %}

可以在上行转换器中查看接收到的数据。在事件选项卡的 **“In”** 和 **“Out”** 块中：

{% include images-gallery.html imageCollection="converterEvents" %}

## 向设备发送单向 RPC

现在让我们检查下行功能。
打开终端窗口并执行以下命令：

```ruby
mosquitto_sub -h broker.hivemq.com -p 1883 -t "tb-edge/mqtt-integration-tutorial/sensors/+/rx"
```
{: .copy-code}

请将此终端保持在后台运行 - 在此终端窗口中，您应该会收到集成稍后发送的传入消息。

让我们添加 **固件** 共享属性：

{% include images-gallery.html imageCollection="addSharedAttribute" %}

为了确保发送到集成的下行消息，您可以检查集成的“事件”选项卡：

{% include images-gallery.html imageCollection="downlinkMessage" %}

终端中来自 ThingsBoard Edge 的传入消息示例：

{% include images-gallery.html imageCollection="downlinkTerminal" %}

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}