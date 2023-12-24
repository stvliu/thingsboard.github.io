---
layout: docwithnav
title: 带有 monoZ 的 LPWA GPS 追踪器
description: 配置 monoZ 遥测设备以使其能够将遥测数据发送到 GridLinks。

---

* TOC
{:toc}

## 概述

**monoZero** 是一个功能强大的开发工具包生态系统，专为蜂窝物联网项目的快速原型设计而设计。它搭载了 LTE-M/NB-IoT 蜂窝调制解调器和低功耗 STM32 MCU，它拥有 5 种不同类型的外围设备，使用户能够轻松连接和控制各种传感器或其他设备。

本指南将涵盖以下部分：

1. 使用 monoZero 的 GPS 追踪器的硬件设置；
2. 使用 monoZ SDK 通过 MQTT 读写和发送 GPS 数据的嵌入式固件；
3. monoZ Cloud OSS（基于 ThingsBoard）配置以通过 MQTT 接收 GPS 数据并在仪表板中显示。

![image](/images/samples/monoz/monoZero-01.png)

## 先决条件

**硬件组件**：

- monoZero BG96               - 1 台
- monoZero Grove 板        - 1 台
- NEO-6M GPS 模块           - 1 台
- LTE-M /NB-IoT sim           - 1 台

**软件组件**：
- monoZ SDK
- STM32CubeIDE

## 硬件设置

### monoZero BG96 板

monoZero BG96 变体搭载全球可用的 Quectel BG96 调制解调器，支持 TCP、UDP 和 PPP 等互联网服务协议。板载 STM32L4 Arm® Cortex®-M4 可以通过 SWD（串行线调试）进行编程。monoZero BG96 拥有 23 个 I/O 外围设备，带有 1 个 USB、1 个 LPUART、2 个 UART、3 个 I2C、3 个 SPI 和 1 个 CAN，用于外部通信。

可以使用 monoZ SDK 为 monoZero BG96 配置调制解调器、协议和外围设备配置。在 docs.monoz.io 上查找有关 monoZero BG96 的更多详细信息

![image](/images/samples/monoz/monoZero-04.png)

### monoZero Grove 板

monoZero Grove 板允许用户通过 grove 端口（QWICC 端口）访问基于引脚的外围设备（LPUART、SPI、I2C 等），从而简化硬件设置过程。当 Grove 板连接到 monoZero BG96 v2 或 v3 时，grove 端口 3 对应于 LPUART 外围设备。

![image](/images/samples/monoz/monoZero-05.png)

### GPS 传感器
NEO-6M GPS 模块已用于确定 GPS 数据。该模块通过 LPUART 端口进行通信，因此可以通过 LPUART grove 端口连接到 monoZero 板。

### 其他组件
- LTE-M / NB-IoT nano Sim：我们在我们的设置中使用了 1NCE 全球 sim。
- 天线：可用于 2.4GHz - 2.6GHz 高频的 RP SMA 公头天线。
- SWD 连接器：用于固件刷新的 STLink V2 调试器。

### 设置
将 GPS 追踪器连接到 grove 板，并将 grove 板堆叠在 monoZero BG96 板上。将 SMA 天线连接到主板，并通过 USB-B 电缆接通电源。

![image](/images/samples/monoz/monoZero-06.png)

## 使用 monoZ SDK 的嵌入式应用程序

monoZ SDK 是一款用户友好的工具，可减少用户在 monoZero HW 上构建嵌入式应用程序的工作量。从 [我们的 github](https://github.com/Meritech-monoZ/GPS_NEO6M) 下载使用 monoZ SDK 构建的工作项目文件，并根据您的设置进行编辑。

{% capture difference %}
**注意：**
<br>
有关 STM32CubeIDE 操作、CLI 设置、SWD 刷新，请参阅 [docs.monoz.io](https://docs.monoz.io)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

1.在 STM32CubeIDE 中打开项目文件。<br>
2.转到 Lib -> tool_gen -> MZ_GPSSensor 并根据您的设置更改 mqtt 客户端配置。

![image](/images/samples/monoz/monoZero-07.png)

<br>
3.转到 Lib -> tool_gen -> MZ_modemconfig 并根据您的设置更改 apn 设置。

![image](/images/samples/monoz/monoZero-08.png)

<br>
4.构建代码并直接刷新到我们的电路板。

5.刷新成功后预期的 CLI 屏幕。

![image](/images/samples/monoz/monoZero-09.png)

## 配置 Centra-IoT OSS / GridLinks 平台

### 登录云平台

获取 monoZ Cloud OSS 实例或 ThingsBoard 实例并登录您的帐户。

![image](/images/samples/monoz/monoZero-10.png)

### 创建设备

转到“设备组”并单击“加号”按钮以添加新设备。

![image](/images/samples/monoz/monoZero-11.png)

输入设备名称，选择现有或创建新的 [设备配置文件](https://thingsboard.io/docs/user-guide/device-profiles/)，然后单击“添加”按钮。

![image](/images/samples/monoz/monoZero-12.png)

您的设备已添加。现在单击“盾牌”图标来管理凭据。

![image](/images/samples/monoz/monoZero-13.png)

输入您的 **客户端 ID**、**用户名**和**密码**，然后单击“保存”。现在您的设备可以使用了。确保在固件的 MQTT 设置中提供了相同的设备详细信息和凭据。

![image](/images/samples/monoz/monoZero-14.png)

### 创建仪表板以可视化遥测数据

打开 monoZero 并将遥测数据发送到云端。
在 Centra-IoT OSS / GridLinks 平台中打开您的设备详细信息，**最新遥测**选项卡。
选择 **latitude** 和 **longitude** 键，然后单击“**在小部件上显示**”按钮。

![image](/images/samples/monoz/monoZero-17.png)

从“**地图**”小部件包中选择“**OpenStreetMap**”小部件。单击“**添加到仪表板**”按钮。

![image](/images/samples/monoz/monoZero-18.png)

如果您有，请选择现有 [仪表板](https://thingsboard.io/docs/pe/user-guide/dashboards)，如果您没有现有仪表板，则创建一个新的仪表板。单击“添加”按钮将小部件添加到仪表板。

![image](/images/samples/monoz/monoZero-19.png)

转到 Centra-IoT OSS / GridLinks 平台中的仪表板并打开您的仪表板。遥测数据可视化显示在工具栏上的小部件中。

![image](/images/samples/monoz/monoZero-20.png)

## 联系我们

对于有关集成的其他问题，请 [联系 monoZ](https://monoz.io)。

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}