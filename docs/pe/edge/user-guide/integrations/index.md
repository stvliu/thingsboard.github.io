---
layout: docwithnav-pe-edge
title: 边缘集成
description: 边缘集成文档
converterTemplateCreation:
    0:
        image: /images/pe/edge/integrations/create-converter-step-1.png
        title: '创建转换器模板'
    1:
        image: /images/pe/edge/integrations/create-converter-step-2.png
        title: '转换器模板配置'

integrationTemplateCreation:
    0:
        image: /images/pe/edge/integrations/create-integration-step-1.png
        title: '创建集成模板'
    1:
        image: /images/pe/edge/integrations/create-integration-step-2.png
        title: '集成模板配置'

placeholderFeature:
    0:
        image: /images/pe/edge/integrations/placeholder-feature-step-1.png
        title: '向边缘添加<b>ipAddress</b>属性'
    1:
        image: /images/pe/edge/integrations/placeholder-feature-step-2.png
        title: '向集成配置中添加占位符<b>${{ipAddress}}</b>'
    2:
        image: /images/pe/edge/integrations/placeholder-feature-step-3.png
        title: '单击边缘实体的<b>管理集成</b>按钮'
    3:
        image: /images/pe/edge/integrations/placeholder-feature-step-4.png
        title: '将集成分配给边缘'
    4:
        image: /images/pe/edge/integrations/placeholder-feature-step-5.png
        title: '登录到您的<b>ThingsBoard Edge</b>实例并打开集成页面 - 占位符将被属性值替换'

missingPlaceholder:
    0:
        image: /images/pe/edge/integrations/missing-placeholder.png
        title: '向边缘添加ipAddress属性'

---

* TOC
{:toc}

{% assign sinceVersion = "3.4" %}
{% include templates/since.md %}

{% include templates/edge/integrations/edge-pe-reference.md %}

### 概述

边缘集成功能的设计方式与平台集成类似。唯一的主要区别在于集成和转换器的配置方式。

为了在多个边缘之间重用相同的集成，引入了**集成模板**和**转换器模板**方法。

集成模板在云端创建，但这些模板不是常规的平台集成，并且*未在云端启动*。
它们被分配给边缘，并在配置到边缘后*启动*。

目前，集成和转换器无法在边缘上修改 - 它们在云端修改，所有修改都会从云端自动传播到边缘。

集成配置字段（URI、密码等）可以通过占位符替换为边缘属性值。
通过这种方式，单个集成模板可以被多个边缘使用，并且集成的任何特定配置字段都可以被边缘属性值替换。

### 部署选项

ThingsBoard 集成具有两种部署选项：嵌入式和远程。请参阅下面的详细信息和架构图。

#### 嵌入式集成

嵌入式集成在主 ThingsBoard Edge 进程中运行。

优点：
* 简化新集成的部署（只需在 GridLinks UI 上单击几下）；
* 最大限度地减少消息传递的延迟；

缺点：
* 消耗分配给主 ThingsBoard Edge 进程的资源：网络连接、操作系统线程和 CPU 周期；
* 低隔离级别；

<object width="60%" data="/images/user-guide/integrations/embeded-integrations-overview.svg"></object>

#### 远程集成

可以在本地网络中安装远程集成，并通过网络将数据流式传输到边缘。

假设您在本地部署了本地 MQTT 代理或 OPC-UA 服务器。
这些代理和/或服务器没有专用的外部 IP 地址，因此 ThingsBoard Edge 无法直接连接到它们。
但是，您可以在同一本地网络中在该边缘附近安装远程集成。
此集成将连接到代理/边缘，提取数据并将其存储在本地文件系统中。
一旦网络连接可用，远程集成就会将数据流式传输到网络中部署的 GridLinks Edge。

优点：
* 支持与在本地网络中部署的服务器集成；
* 将集成过程与主 ThingsBoard Edge 进程隔离；

缺点：
* 需要安装单独的软件包；

了解如何使用[本指南](/docs/pe/edge/user-guide/integrations/remote-integrations)配置集成以远程运行。

<object width="70%" data="/images/user-guide/integrations/remote-integrations-overview.svg"></object>

### 转换器模板

转换器模板只能由租户管理员创建。
转到云端并导航到**边缘管理 -> 转换器模板**页面。
此页面允许您创建转换器模板。这些转换器模板将在以后的集成模板配置中使用。

{% include images-gallery.html imageCollection="converterTemplateCreation" %}

您无需将转换器模板分配给边缘 - 一旦集成模板分配给特定边缘，相关上行/下行转换器就会自动配置到边缘。

### 集成模板

创建转换器模板后，您可以导航到**边缘管理 -> 集成模板**页面以创建集成。
此页面允许您创建集成模板。这些集成模板将分配给边缘。

{% include images-gallery.html imageCollection="integrationTemplateCreation" %}

#### 集成配置占位符

在大多数情况下，集成对大多数边缘都有通用的配置部分，除了某些特定字段。
为了能够将相同的集成模板用于多个边缘，并在边缘之间使用一些唯一值，可以使用占位符功能。
您能够向边缘添加特定属性，然后在集成模板中使用此属性的名称。
此占位符将在分配给边缘期间替换为属性值。

让我们看一个示例，说明如何将 HTTP 集成配置为每个边缘的唯一 IP 地址值作为“基本 URL”。

{% include images-gallery.html imageCollection="placeholderFeature" showListImageTitles="true" %}

您可以将此集成模板分配给其他边缘实体，并且边缘上的每个集成都将具有其唯一的**“基本 URL”**值，该值由属性值替换。

如果特定边缘缺少占位符属性键，平台将在分配给边缘或集成配置更新期间通知它：

{% include images-gallery.html imageCollection="missingPlaceholder" %}

### 边缘限制

在当前版本中，Edge 无法创建客户、设备配置文件和实体组。
这些限制会影响上行数据转换器功能：

* 如果转换器中使用了不存在的设备类型，则将使用**“默认”**设备类型。
* 同样适用于客户 - 如果客户在边缘上不可用，则设备将分配给租户。
* 如果实体组在边缘上不存在 - 将使用“全部”组。

### 另请参阅

探索与特定集成相关的指南和视频教程：

 - [HTTP](/docs/pe/edge/user-guide/integrations/http/)
 - [MQTT](/docs/pe/edge/user-guide/integrations/mqtt/)
 - [CoAP](/docs/pe/edge/user-guide/integrations/coap/)
 - [OPC-UA](/docs/pe/edge/user-guide/integrations/opc-ua/)
 - [TCP](/docs/pe/edge/user-guide/integrations/tcp/)
 - [UDP](/docs/pe/edge/user-guide/integrations/udp/)
 
## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}