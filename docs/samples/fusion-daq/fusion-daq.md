---
layout: docwithnav
title: 将 MI-8 数据发布到 GridLinks
description: 将 MI-8 数据发布到 GridLinks 指南

---

* TOC
{:toc}

## 先决条件

在本教程中，我们将配置 FusionDAQ 设备以将其与 ThingsBoard 集成。

## 技术特性

FDQ-99900 MI-8 是一款紧凑型 24 位数据采集系统 (DAQ)，旨在测量多达十个外部传感器，然后将值本地记录到 SD 卡或通过蜂窝数据连接将数据推送到云端。高级触发功能允许 MI-8 通过仅传输感兴趣的事件来节省存储空间和网络数据。低功耗和宽工作温度范围旨在允许户外和远程安装。MI-8 可提供带外壳和不带外壳两种版本，以支持定制包装解决方案。例如，无外壳（OEM）配置通常与支持传感器和硬件一起安装到 IP-67 等级 NEMA 外壳中。

**特点：**
* 将数据推送到远程服务器或直接记录到 SD 卡
* LTE CAT-M1 和 CAT-NB 蜂窝频段
* 高级触发选项
* HTTP/MQTT 推送 API
* 多达两个通用 0-10V 模拟输入
* 多达四个 RTD 或应变仪测量
* 多达六个热电偶输入
* 接地热电偶的负共模范围处理（±2.4V）
* 支持所有主要热电偶类型（B、E、J、K、N、R、S、T）
* 14.4V 调节输出为外部传感器供电。
* 宽电源电压范围（4.8-30V）
* 适用于电池供电的安装
* 集成 GPS（GNSS）接收器

<p align="center">
   <img src="/images/samples/fusion-daq/m-8-device.png" alt="m 8 device">
</p>

## 为 GridLinks 配置设备

包含将设备连接到 GridLinks 所需的说明。

### 创建 ThingsBoard 设备

在浏览器中打开 [ThingsBoard Cloud 服务器](https://thingsboard.cloud/) 并登录。

转到“**设备组**”选项卡 -> “**全部**”，然后单击“加号”按钮以添加新设备。

输入设备名称，选择现有设备或创建新的 [设备配置文件](https://thingsboard.io/docs/user-guide/device-profiles/)，然后单击“添加”按钮。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-create-device-1.png)

您的设备已创建。打开其详细信息，然后单击“复制访问令牌”按钮复制自动生成的 **访问令牌**。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-create-device-2.png)

### 配置 MI-8

获得访问令牌后，您可以配置 MI-8。所有 MI-8 DAQ 都通过 SD 卡根目录中的一个名为 config.json 的文件进行配置。
可以从 [此链接](/docs/samples/fusion-daq/resources/config.json) 下载此 JSON 文件的示例。
[MI-8 用户手册](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf) 包含有关更改此文件的详细信息，但对于此示例，我们将重点关注名称和推送字段。
这些字段描述了如何连接到 GridLinks 或任何其他服务。

本示例中使用的 MI-8 config.json 文件：

![image](/images/samples/fusion-daq/fusion-daq-config-json.png)

此文件中的 **name** 字段是可选的。此 **name** 显示在 MI-8 OLED 屏幕上，并作为设备属性发送到 GridLinks。最佳做法是 config.json 中的名称与 GridLinks 中的设备名称匹配，但这并非必须。name 字段不用于在 MI-8 和 ThingsBoard 之间关联遥测数据。它仅用作用户的辅助工具。

**push** 字段描述了与 GridLinks 服务器的连接。在此示例中，我们使用 HTTP POST 请求（“mode”:”post”）。ThingsBoard 也支持 MQTT，但 POST 消耗的蜂窝数据更少。HTTP 请求 URL 通过 **server**、**port**、**use_ssl** 和 **path/attributes_path** 字段构建。

Things board 遥测（传感器数据）请求发送到 http://thingsboard.cloud:80/api/vi/{ACCESS_TOKEN}/telemetry

**use_ssl** 字段描述是否使用 HTTP 或 HTTPS。**server** 字段是双斜杠“//”和冒号之间的所有内容。接下来是 **port** 和一个额外的斜杠。除此之外的一切都是 **path**。

将服务器设置为“**thingsboard.cloud**”。用户名和密码应保持为空。

将 **path** 设置为“api/vi/{ACCESS_TOKEN}/telemetry”，并将 **attributes_path** 设置为“api/vi/{ACCESS_TOKEN}/attributes”。
将 **{ACCESS_TOKEN}** 替换为 GridLinks 中设备凭据页面中的访问令牌。
每个设备都有一个唯一的访问令牌。
传感器值将定期发送到 **path**，属性（名称、IMEI、ICCID 等）在 MI-8 首次启动时发送一次。

将 **push_attributes** 设置为 true，以便在每次启动时发送属性（例如 MI-8 IMEI 号码等不经常更改的内容）。

将 **port** 设置为 80，将 **use_ssl** 设置为 false 以使用不安全的 HTTP 连接将数据推送到 GridLinks。
将 **port** 设置为 443，将 **use_ssl** 设置为 true 以使用 SSL 加密（HTTPS）。支持任一协议，但每次将数据推送到服务器时，HTTPS 消耗的蜂窝数据会更多。

将 **use_json** 设置为 true。发送到 GridLinks 的所有数据都应采用 JSON 格式以简化集成。

将 **use_headers** 设置为 false。ThingsBoard 不需要 HTTP 头，并且每次推送都需要额外的蜂窝数据。

最后，将 **include_name**、**include_imei** 和 **include_iccid** 设置为 false。这些字段会导致 ICCID、IMEI 和 MI-8 名称包含在遥测推送中，这会消耗额外的蜂窝数据。由于它们在每次 MI-8 电源循环时都会通过单独的属性 HTTP 请求发送到 GridLinks，因此此处不需要包含它们。

保存 config.json，断开 PC 与 MI-8 USB 端口的连接（如果已连接并启用大容量存储），然后对 MI-8 进行电源循环，以便新设置生效。

### 在 GridLinks 中验证 MI-8 连接

此时，MI-8 应已配置好并准备好与 GridLinks 通信。
返回您的 ThingsBoard 实例，然后导航到“设备组”，然后导航到“全部”。
单击刚刚与 MI-8 关联的设备，然后导航到“最新遥测”选项卡。
一旦 MI-8 启动并能够建立蜂窝连接，所有在活动 MI-8 触发器中配置的传感器值 [参见操作手册](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf) 都应存在。
请注意，GPS 值仅在第一次 GPS 定位后才传输，具体取决于上次定位以来经过了多长时间以及 MI-8 移动了多远。
GPS 值（lat、lon 和 alt）仅在至少传输一次后才会出现在遥测窗口中。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-latest-telemetry-1.png)

现在，导航到“属性”选项卡。属性是从 MI-8 发送到 GridLinks 的其他数据，这些数据或多或少是固定的，并且不会更改，例如调制解调器 IMEI、SIM ID (ICCID) 和 MI-8 固件版本。
属性仅在每次打开 MI-8 电源时发送一次到 GridLinks。

![image](/images/samples/fusion-daq/fusion-daq-mi-8-attributes-1.png)

## 联系我们

对于其他问题，请 [联系 Fusion DAQ](https://fusiondaq.com/contact/)。

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}