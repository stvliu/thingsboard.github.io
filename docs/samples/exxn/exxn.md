---
layout: docwithnav
title: EXXN IoT 网关
description: EXXN IoT 网关集成指南

---

* TOC
{:toc}

## 简介

EXXN IoT 网关是一款多功能设备，配备 ARM 处理器，可适应各种用例，包括监测环境传感器、能耗、氡气水平、海洋环境和边缘计算。

本指南概述了将 EXXN IoT 网关与 ThingsBoard 平台集成的过程，以实现对设备的远程监控和管理。

<br>
使用 ThingsBoard 开发的仪表板示例，显示 EXXN IoT 网关捕获的指标。

![image](/images/samples/exxn/ennx-dashboard.png)

## 先决条件

在本教程中，我们将配置 EXXN IoT 网关，通过 MQTT API 将其与 ThingsBoard 集成。为此，我们将使用：

- EXXN IoT 网关“Cell 1024”；
- 我们必须连接到设备，并且设备必须通过以太网、调制解调器或 Wi-Fi 连接到互联网。

## 技术特性
本指南中使用的 EXXN IoT 网关“Cell 1024”的技术规格如下：
* ARM Cortex-A53 四核 64 位处理器
* GPU Mali 470
* 2GB DDR4
* 8GB eMMC
* 10/100 Mbit/s 以太网
* Wi-Fi 802.11 b/g/n/AC
* 蓝牙 4.2
* PoE
* 硬件开发的可能性，以实现自定义功能

<p align="center">
   <img src="/images/samples/exxn/cell_1024.jpg" alt="cell 1024">
</p>

## 为 Thingsboard 配置设备

包含将设备连接到 ThingsBoard 所需的说明。

### 创建设备

在浏览器中打开平台实例或 ThingsBoard [云](https://thingsboard.cloud/)，并以租户管理员身份登录。

转到“**设备组**”选项卡 -> “**全部**”，然后单击“加号”按钮添加新设备。

输入设备名称，选择现有设备或创建新的 [设备配置文件](https://thingsboard.io/docs/user-guide/device-profiles/)，然后单击“添加”按钮。

![image](/images/samples/exxn/exxn-create-device-cell-1.png)

您的设备已创建。打开其详细信息，然后单击“复制访问令牌”按钮，复制自动生成的 **访问令牌**。

![image](/images/samples/exxn/exxn-create-device-cell-2.png)

### 设备配置

使用此 URL：https://[IP_DEVICE] 打开浏览器访问 Cell 1024 的管理网页，然后转到“云”选项卡：
<br>
<br>
  <img src="/images/samples/exxn/conn1.png" alt="conn1">

激活云控件，并配置所有参数，通过 MQTT 将设备连接到特定的 ThingsBoard 平台：

<img src="/images/samples/exxn/conn2.png" alt="conn2">

配置参数：
- **云平台**：选择 ThingsBoard。
- **MQTT 代理 URL**：我们要集成的服务器的代理 URL。
- **MQTT 代理端口**：服务器使用的端口号。
- **TLS**：如果服务器使用传输层安全协议，请选择 true。
- **连接类型**：选择“访问令牌”选项。我们将使用之前在 ThingsBoard 中创建的访问令牌。
- **访问令牌**：指明之前在 ThingsBoard 中复制的访问令牌。

{% capture domain_owner_note %}
**注意**

目前，IoT EXXN 网关使用“访问令牌”集成方法。我们正在开发一种预配置集成方法，该方法将无需在设备上复制此访问令牌。

{% endcapture %}
{% include templates/info-banner.md content=domain_owner_note %}

单击“保存配置”按钮。

<img src="/images/samples/exxn/conn3.png" alt="conn3">

<br>
要验证设备是否已正确连接到 ThingsBoard，请转到 **设备组** 菜单 -> **全部** 设备，选择您的设备。在 **设备详细信息** 中选择 **客户端属性** 选项卡，然后检查客户端属性是否已传达给设备。

如果您一切操作正确，我们将看到客户端属性，如 *serial_number*、*last_rebbot*、*device_model* 等。

![image](/images/samples/exxn/exxn-client-attributes-device-1.png)

## ThingsBoard 配置

EXXN IoT 网关将使用 MQTT API 连接到 ThingsBoard。 <br>
我们之前已经介绍了如何配置设备以连接到 ThingsBoard。现在，我们将展示在 ThingsBoard 中配置设备的步骤，以便监控数据和管理设备。

为了配置 EXXN IoT 网关的数据记录器选项，我们必须为设备创建一个新的 JSON“共享”属性，其键为“config”。

- 转到设备详细信息中的 **属性** 选项卡。添加一个新的“**共享**”属性，其键为“config”，类型为 **JSON**。

![image](/images/samples/exxn/exxn-shared-attributes-device-1.png)

- 将属性的内容展开为全屏，以便轻松编写。将设备配置文件的内容粘贴到属性值中。

![image](/images/samples/exxn/ennx-config-json.png)

可以从 [此链接](/docs/samples/exxn/resources/config.json) 下载此 JSON 文件的示例。

可以在 EXXN IoT 网关手册中找到通过此 JSON 文件正确配置设备的所有信息。

- 单击“添加”属性。

![image](/images/samples/exxn/exxn-shared-attributes-device-2.png)

### 数据可视化

创建一个 [仪表板](https://thingsboard.io/docs/pe/user-guide/dashboards/)，以在小部件中可视化遥测值。

- 转到 **仪表板组** 选项卡 -> **全部**。通过单击仪表板页面右上角的“加号”按钮创建新仪表板。输入仪表板名称，然后单击“添加”按钮。

![image](/images/samples/exxn/exxn-create-dashboard-1.png)

- 从 **模拟仪表** 捆绑包中创建 **径向仪表** 小部件。在 [本指南](https://thingsboard.io/docs/pe/user-guide/dashboards/#widgets) 中详细了解小部件及其创建。

在设备的 JSON 配置文件中“启用”的所有度量都将作为指标找到，名称在同一文件中指定。

![image](/images/samples/exxn/exxn-create-dashboard-2.png)

<br>
![image](/images/samples/exxn/exxn-create-dashboard-3.png)

### RPC 命令

可以向设备发送命令来执行某些任务。方法的参数必须采用 JSON 格式。

![image](/images/samples/exxn/exxn-rpc-button.png)

可以在 EXXN IoT 网关手册中了解可以发送到设备的所有命令。

## 其他信息

### 故障排除
- 集成过程中最常见的问题是无法连接到 MQTT 代理。确保设备已连接到互联网，并且能够与 ThingsBoard 代理通信。
- 另一个常见问题是未设置正确的访问令牌。检查提供的访问令牌是否已在 ThingsBoard 中为设备配置。

<br>

### 反馈和联系我们以进行集成

有关更多信息，请访问我们的网站 [EXXN Engineering](http://exxn.es/en/)。
<br>
如果您有任何问题或疑问，请随时通过以下方式与我们联系：[troubleshooting@exxn.es](mailto://troubleshooting@exxn.es)

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}