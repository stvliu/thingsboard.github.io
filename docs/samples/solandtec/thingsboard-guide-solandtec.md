---
layout: docwithnav
title: ADAM-6717 与 ThingsBoard Cloud 的连接指南，解锁无缝的物联网连接
description: ADAM-6717 与 ThingsBoard Cloud 的连接指南，解锁无缝的物联网连接
---

* TOC
{:toc}

## 概述

在本综合指南中，我们将引导您完成在 ADAM-6717 和 ThingsBoard Cloud 之间建立无缝连接的过程。
通过遵循这些分步说明，您将能够将 ThingsBoard Cloud 的强大功能与您的 ADAM-6717 模块集成并利用。

## 第 1 步：在 ThingsBoard Cloud 平台上创建新设备

要在 ADAM-6717 模块和 ThingsBoard Cloud 平台之间建立连接，第一步是创建一个新设备。
按照以下说明进行操作：

- 登录到您的 Thingsboard 实例。
- 在左侧菜单中，转到“设备”页面。
- 单击“加号”图标以创建新设备。

![image](/images/samples/solandtec/Imagen1.png)

- 系统将提示您输入新设备的详细信息，例如其名称、标签和其他相关信息。输入有关设备的信息后，单击“下一步：凭据”按钮。这将带您进入凭据配置页面。

![image](/images/samples/solandtec/Imagen2.png)

- 在凭据配置页面上，找到“凭据类型”选项，然后从可用选项中选择“MQTT 基本”。这可确保在您的 ADAM-6717 模块和平台之间使用 MQTT 协议进行通信。
- 在“客户端 ID”字段下，输入一个唯一名称，该名称将用作设备的标识符。
- 为了增强安全性，强烈建议您为设备设置“用户名”和“密码”。
这可确保只有经过授权的设备才能与平台建立连接。为用户名和密码选择一个强而独特的组合。

![image](/images/samples/solandtec/Imagen3.png)

- 输入所有必要详细信息后，单击“添加”按钮以创建新设备。

通过创建新设备，您正在准备一个目的地，您的 ADAM-6717 模块中的数据将被发送到该目的地，以便在 ThingsBoard Cloud 平台内存储和可视化。

## 第 2 步：配置 ADAM-6717 模块以实现连接

在开始之前。

ADAM-6700 系列网关具有两个 MAC ID，它们列在设备侧面的标签上。这些端口的默认 IP 地址为 10.0.0.1 (Eth0) 和 11.0.0.1 (Eth1)。

![image](/images/samples/solandtec/internet-image.png)

要通过 Node-RED 访问图形编程工具，请按照以下说明进行操作：
- 打开您喜欢的网络浏览器，然后输入您选择的 ADAM-6717 模块端口的 IP 地址。按 Enter 键访问模块的网络界面。
- 查找“Node-RED 的图形编程工具”链接并单击它。

![image](/images/samples/solandtec/Imagen4.png)

- 在单击“Node-RED 的图形编程工具”链接后显示的弹出窗口中，输入默认用户名和密码。

      **默认用户名**：root

      **默认密码**：00000000

![image](/images/samples/solandtec/Imagen5.png)

成功登录 Node-RED 图形编程工具后，您将看到一个界面，该界面由三个主要部分组成。以下是简要概述：
- 节点菜单（左侧）
- 编程区域（中间）
- 调试区域（右侧）

![image](/images/samples/solandtec/Imagen6.png)

## 第 3 步：配置 NodeRED 以与 ThingsBoard Cloud 集成

此配置设置了一个流，其中数据将由注入节点注入并使用 MQTT 输出节点发送到 ThingsBoard Cloud。
- 将“注入”节点从 Node-RED 调色板拖放到工作区。同样，从调色板中拖放一个“MQTT 输出”节点。
- 通过单击并拖动它们之间的连接器，将注入节点的输出连接到 MQTT 输出节点的输入。
- 注入节点：Thingsboard 以 JSON 格式获取数据，该格式使用“键”和“值”。通过将注入节点配置为使用键值对以 JSON 格式发送数据，您可以确保数据与 ThingsBoard 的数据结构兼容。
- 双击 MQTT 输出节点以打开其配置设置。

![image](/images/samples/solandtec/Imagen7.png)

在 MQTT 服务器设置中，您需要配置以下信息：

- **MQTT 代理**：提供 MQTT 代理的地址或主机名。这通常是 ThingsBoard Cloud 为 MQTT 通信提供的 URL。
- **端口**：指定 MQTT 代理的端口号。MQTT 的默认端口是 1883，但请咨询 ThingsBoard Cloud 以了解任何特定端口要求。
- **客户端 ID**：输入连接到 MQTT 代理的客户端的唯一标识符。这有助于在 ThingsBoard Cloud 平台中识别您的 Node-RED 实例。
- **主题**：指定您要发布数据的 MQTT 主题。此主题应与 ThingsBoard Cloud 中定义的主题结构一致。
- **QoS**：选择消息传递的服务质量级别。建议使用 QoS 级别 1 来确保可靠的消息传递。
- **保留**：选择 MQTT 消息是否应由代理保留。保留的消息保留在代理上，并在连接时发送给新订阅者。

输入所需的 MQTT 服务器信息后，单击“完成”按钮保存配置

![image](/images/samples/solandtec/Imagen8.png)

![image](/images/samples/solandtec/Imagen9.png)

![image](/images/samples/solandtec/Imagen10.png)

按照前面步骤中提到的配置注入节点和 MQTT 输出节点后，您就可以发送数据了。
- 在您的 Node-RED 工作区中找到“注入”节点。
- 单击“注入”按钮以触发将数据发送到 ThingsBoard Cloud 中的设备。
- 单击“注入”按钮后，Node-RED 将生成数据有效负载并将其发送到 MQTT 输出节点，然后该节点将数据发布到 ThingsBoard Cloud 平台上指定的主题。

![image](/images/samples/solandtec/Imagen11.png)

<br>
恭喜！您现在已成功将数据从 Node-RED 发送到 ThingsBoard Cloud 中的设备。

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}