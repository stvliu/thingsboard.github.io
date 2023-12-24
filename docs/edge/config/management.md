---
layout: docwithnav-edge
title: 边缘管理概述
description: 边缘管理概述
---

![image](/images/coming-soon.jpg)

### 同步架构

ThingsBoard Edge 和 ThingsBoard CE/PE 云通过 gRPC 协议进行通信。

使用 Protocol Buffers (ProtoBuf) 序列化消息。

从 ThingsBoard Edge 推送到 ThingsBoard CE/PE 云的所有消息都将存储在本地 PostgreSQL 表（**cloud_event 表**）中，然后再发送。
通过这种方式，ThingsBoard Edge 能够在没有连接到云的情况下运行。
一旦建立连接，ThingsBoard Edge 将把本地 **cloud_event** 表中的所有消息推送到云，并标记成功传输到云的消息。

从 ThingsBoard CE/PE 云推送到 ThingsBoard Edge 的所有消息都将存储在云 PostgreSQL 表（**edge_event 表**）中，然后再发送。
一旦建立连接，ThingsBoard CE/PE 云将把云 **edge_event** 表中的所有消息推送到边缘，并标记成功传输到边缘的消息。

用户可以使用 **Edge** 实体的 **下行链路** 选项卡查看从云到边缘传输的消息列表。

![image](/images/edge/sync/downlink-events.png)

##### 强制同步过程

在网络中断或其他一些通信问题的情况下，ThingsBoard Edge 可能会与云不同步。
用户可以通过单击 **同步边缘** 按钮强制执行同步过程：

![image](/images/edge/sync/sync-button.png)

### 边缘设备管理

**设备** 实体可以直接在边缘创建，并在建立连接的情况下推送到云。

如果 Edge 连接到 ThingsBoard **CE**，任何租户管理员用户都可以在边缘创建设备实体。

如果 Edge 连接到 ThingsBoard **PE**，任何具有 **DEVICE** 写操作的用户都可以在边缘创建设备实体。

在边缘创建设备后，该设备将被推送到云中进行创建。

如果 Edge 连接到 ThingsBoard **CE**，新创建的设备将自动*'分配'*给边缘。

如果 Edge 连接到 ThingsBoard **PE**，新创建的设备：
- 将在云中创建
- 将创建新的设备实体组，具有特定的名称模板：**[Edge] ${NAME_OF_EDGE} All**。
- 新创建的设备将添加到上面的组中
- 上面的组将自动*'分配'*给边缘。

### 云上的实体管理

目前，ThingsBoard Edge 除了 **Device** 实体外，还无法在本地创建任何实体。
为了能够在边缘使用其他实体，用户必须在使用前将这些实体*'分配'*给边缘。

用户可以使用 **Edge** 实体卡将特定实体*'分配'*给边缘。

一旦您将任何实体分配给特定边缘，该实体将被推送到边缘事件队列。
如果边缘和云之间的连接处于活动状态，则分配的实体将立即在边缘创建。
如果目前边缘未连接到云，则将在建立连接后创建实体。


#### 后续步骤

{% assign currentGuide = "EdgeManagementOverview" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}