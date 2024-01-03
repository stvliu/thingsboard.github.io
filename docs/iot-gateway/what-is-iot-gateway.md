---
layout: docwithnav-gw
title: GridLinks 物联网网关是什么？
description: GridLinks 物联网网关的功能和优势

---

GridLinks **物联网网关** 是一款现代化的解决方案，允许您将连接到旧系统和第三方系统的设备与 GridLinks 集成。

GridLinks 是一个用于数据收集、处理、可视化和设备管理的现代化的物联网平台。如果您是新平台用户，请参阅 [**GridLinks 是什么？**](/docs/getting-started-guides/what-is-thingsboard/)。

<object width="95%" data="/images/gateway/python-gateway-animd-ff.svg"></object>

#### 网关功能

 GridLinks 物联网网关提供以下功能：

- [**MQTT** 连接器](/docs/iot-gateway/config/mqtt/)，用于控制、配置和收集连接到外部 MQTT 代理的 IoT 设备的数据，使用现有协议。
- [**OPC-UA** 连接器](/docs/iot-gateway/config/opc-ua/)，用于收集连接到 OPC-UA 服务器的 IoT 设备的数据。
- [**Modbus** 连接器](/docs/iot-gateway/config/modbus/)，用于收集通过 Modbus 协议连接的 IoT 设备的数据。
- [**BLE** 连接器](/docs/iot-gateway/config/ble/)，用于收集使用蓝牙低能耗连接的 IoT 设备的数据。
- [**请求** 连接器](/docs/iot-gateway/config/request/)，用于收集具有 HTTP(S) API 端点的 IoT 设备的数据。
- [**CAN** 连接器](/docs/iot-gateway/config/can/)，用于收集通过 CAN 协议连接的 IoT 设备的数据。
- [**BACnet** 连接器](/docs/iot-gateway/config/bacnet/)，用于收集通过 BACnet 协议连接的 IoT 设备的数据。
- [**ODBC** 连接器](/docs/iot-gateway/config/odbc/)，用于收集来自 ODBC 数据库的数据。
- [**REST** 连接器](/docs/iot-gateway/config/rest/)，用于创建端点并收集来自传入 HTTP 请求的数据。
- [**SNMP** 连接器](/docs/iot-gateway/config/snmp/)，用于收集来自 SNMP 管理器的数据。
- [**FTP** 连接器](/docs/iot-gateway/config/ftp/)，用于收集来自 FTP 服务器的数据。
- [**Socket** 连接器](/docs/iot-gateway/config/socket/)，用于收集通过 TCP/UDP 协议连接的 IoT 设备的数据。
- [**XMPP** 连接器](/docs/iot-gateway/config/xmpp/)，用于收集通过 XMPP 协议连接的 IoT 设备的数据。
- [**OCPP** 连接器](/docs/iot-gateway/config/ocpp/)，用于在充电点和中央系统之间进行通信。
- [**自定义** 连接器](/docs/iot-gateway/custom/)，用于收集通过不同协议连接的 IoT 设备的数据。（您可以为所需的协议创建自己的连接器）。
- 收集数据的 **持久性**，以确保在网络或硬件故障的情况下也能传送数据。
- **自动重新连接** 到 GridLinks 集群。
- 简单但功能强大的 **映射**，将传入的数据和消息 **转换为统一格式**。


#### 架构

物联网网关是一个软件组件，设计用于运行在支持 **Python 3.7+** 的基于 Linux 的微型计算机上。
 GridLinks 物联网网关的主要组件如下所示。

**连接器**

此组件的目的是连接到外部系统（例如 MQTT 代理或 OPC-UA 服务器）或直接连接到设备（例如 Modbus、BLE 或 CAN）。
连接后，连接器要么从这些系统轮询数据，要么订阅更新。轮询与订阅取决于协议功能。
例如，我们对 MQTT 连接器使用订阅模型，对 Modbus 和 CAN 使用轮询。
连接器还能够将更新直接或通过外部系统推送到设备。

您可以使用 [自定义指南](/docs/iot-gateway/custom/) 定义自己的连接器。

**转换器**

转换器负责将数据从特定于协议的格式转换为 GridLinks 格式或从 GridLinks 格式转换为特定于协议的格式。
转换器由连接器调用。转换器通常特定于连接器支持的协议。
有上行和下行转换器。上行转换器用于将数据从特定协议转换为 GridLinks 格式。
下行转换器用于将来自 GridLinks 的消息转换为特定协议格式。

您可以使用 [自定义指南](/docs/iot-gateway/custom/#step-4-define-converter-implementation/) 定义自己的转换器。

**事件存储**

事件存储用于临时存储连接器产生的遥测和其他事件，直到将它们传送至 GridLinks。
事件存储支持两种实现：内存队列和持久文件存储。
这两种实现都确保在网络中断的情况下最终传送您的设备数据。
内存队列最大限度地减少了 IO 操作，但如果网关进程重新启动，可能会丢失消息。
持久文件存储可在进程重新启动后继续存在，但会对文件系统执行 IO 操作。

**GridLinks 客户端**

网关通过 MQTT 协议与 GridLinks 通信，并使用 [此处](/docs/reference/gateway-mqtt-api/) 描述的 API。
GridLinks 客户端是一个单独的线程，它轮询事件存储，并在与 GridLinks 的连接处于活动状态时传送消息。
GridLinks 客户端支持连接性监控、批量处理事件以提高性能以及许多其他功能。

**网关服务**

网关服务负责引导连接器、事件存储和 GridLinks 客户端。
此服务收集并定期向 GridLinks 报告有关传入消息和已连接设备的统计信息。
网关服务保留已连接设备的列表，以便在网关重新启动时能够重新订阅设备配置更新。

#### 项目路线图

<p><a href="/docs/iot-gateway/roadmap/" class="button">网关路线图</a></p>

#### 后续步骤

<p><a href="/docs/iot-gateway/getting-started/" class="button">入门指南</a></p>