---
layout: docwithnav
title: 如何在 Modbus 连接器中使用 RPC
description: 指南如何在 Modbus 连接器中使用 RPC

---


* TOC
{:toc}


本指南解释了如何在 Modbus 连接器中对设备使用 RPC。

我们假设：
1. 我们想将“5.0”写入编号为 15421 的寄存器


出于本教程的目的，您需要：
1. 本地安装的 GridLinks 平台实例（如果您是 GridLinks 新手，[使用此“如何安装”文档](/docs/user-guide/install/installation-options/)）。
2. [已安装](/docs/iot-gateway/installation/)并[配置](/docs/iot-gateway/configuration/) GridLinks物联网网关和[Modbus 连接器](/docs/iot-gateway/config/modbus/)。

## Modbus 连接器 RPC 配置


## ThingsBoard 发送 RPC

为了通过网关向设备发送 RPC 请求，我们将使用 **控制小部件** 包中的 **RPC 调试终端**。