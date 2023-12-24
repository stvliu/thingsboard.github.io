---
layout: docwithnav-edge
title: 在边缘创建设备并配置到云端
description: 在边缘创建设备并配置到云端

---

![image](/images/coming-soon.jpg)

### 边缘设备管理

**设备**实体可以直接在边缘创建，并在建立连接后推送到云端。

如果边缘连接到 ThingsBoard **CE**，任何租户管理员用户都可以在边缘创建设备实体。

如果边缘连接到 ThingsBoard **PE**，任何具有 **DEVICE** 写入操作的用户都可以在边缘创建设备实体。

在边缘创建设备后，该设备将被推送到云端进行创建。

如果边缘连接到 ThingsBoard **CE**，新创建的设备将自动*'分配'*给边缘。

如果边缘连接到 ThingsBoard **PE**，新创建的设备：
- 将在云端创建
- 将创建新的设备实体组，具有特定的名称模板：**[Edge] ${NAME_OF_EDGE} All**。
- 新创建的设备将被添加到上述组中
- 上述组将自动*'分配'*给边缘。


### 后续步骤

{% assign currentGuide = "CreateDeviceOnEdgeAndProvisionToCloud" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}