---
layout: docwithnav-gw
title: 如何在 GridLinks物联网网关上启用远程日志记录功能
description: 如何在 GridLinks物联网网关上启用远程日志记录功能

---

* TOC
{:toc}

本指南将帮助您在 GridLinks 平台实例上启用远程日志记录并从 GridLinks物联网网关读取日志。

出于本指南的目的，我们将使用以下内容：
1. 本地安装的 GridLinks 平台实例（您可以在此处阅读如何安装：[此处](/docs/user-guide/install/installation-options/)）。
2. GridLinks物联网网关（您可以在此处阅读如何安装：[此处](/docs/iot-gateway/installation/)）。

## 步骤 1. 激活远程日志记录并设置日志记录级别

要激活并设置日志记录级别，请按照以下步骤操作：

- 在 WEB UI 中打开网关设备详细信息。
- 转到“**属性**”选项卡。
- 从**实体属性**范围列表中选择**共享属性**。
- 单击“**+**”按钮（添加新属性）。
<br>
![](/images/gateway/add-shared-attributes-gateway.png)
- 在“添加属性”窗口中，使用以下值填充字段：
    - **名称**字段必须为 **RemoteLoggingLevel**
    - **值**字段设置日志记录级别，值可以如下：
```
DEBUG
INFO
WARNING
ERROR
CRITICAL
NONE
```

![](/images/gateway/add-remote-logging-level-attribute-1.png)
- 单击**添加**
![](/images/gateway/add-remote-logging-level-attribute-2.png)
- 在您的网关未运行的情况下启动您的网关 **[可选]**。
- 打开网关设备的**最新遥测**选项卡，您将看到新的遥测键 -- **LOGS**。
<br><br>
![](/images/gateway/logs-telemetry.png)
<br>
<br>

## 步骤 2. 在仪表板上显示日志

在设备详细信息窗口中查看日志可能不方便。我们应该在仪表板上显示它们。

因此，我们将能够调查所有日志，而不仅仅是最新日志。

为此，我们使用以下步骤：

- 检查**LOGS**键并单击“**在小部件上显示**”按钮：
![](/images/gateway/show-logs-on-widget.png)

- 我们将使用默认的**卡片**小部件：
![](/images/gateway/add-logs-to-dashboard.png)

- 选择**时序表**卡片小部件并将其添加到仪表板。它可以是新的仪表板或现有仪表板。
![](/images/gateway/create-new-dashboard-for-logs.png)

- 现在，我们现在可以从 GridLinks 环境监视网关设备的状态。
![](/images/gateway/logs-dashboard.png)

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。