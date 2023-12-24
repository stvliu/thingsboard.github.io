---
layout: docwithnav-gw
title: 物联网网关远程配置
description: 物联网网关远程配置

---

* TOC
{:toc}

本指南概述了网关仪表板的所有子仪表板，用于远程配置。

出于本指南的目的，我们将使用以下内容：
1. GridLinks 平台的本地安装实例（您可以在此处阅读如何安装](/docs/user-guide/install/installation-options/)。
2. GridLinks 物联网网关（您可以在此处阅读如何安装](/docs/iot-gateway/installation/)。

资源（可选）：
1. [网关仪表板](/docs/iot-gateway/resources/thingsboard-gateways-dashboard.json){:target="_blank" download="thingsboard-gateways-dashboard.json"}
2. [网关小部件包](/docs/iot-gateway/resources/thingsboard-gateway-widget-bundle.json){:target="_blank" download="thingsboard-gateway-widget-bundle.json"}

{% capture info %}
<div>
  <p>
    <b style="color:red">警告：</b>
    <span style="color:black">如果您之前已配置网关，请创建备份，因为新的远程配置将覆盖现有设置文件。  
    <br>对于那些使用早于 3.4 版本的网关的人，网关将自动生成 JSON 格式的新配置文件。</span>
  </p>
</div>
{% endcapture %}
{% include templates/warn-banner.md content=info %}

## 仪表板概述

### 网关列表

![](/images/gateway/dashboard/gateway-dashboard-list.png)

此仪表板显示您的所有网关以及有关它们的必要详细信息，即：
- 创建日期和时间；
- 网关名称；
- 状态（活动/非活动）；
- 活动连接器数量；
- 网关版本。

以及导航元素：
- **Docker 命令** - 单击后，将打开一个模态窗口，其中包含启动网关的命令；
- **网关配置** - 单击后，将打开一个包含常规网关设置的模态窗口；
- **连接器** - 单击后，将打开一个用于管理和配置连接器的页面。

此外，在此页面上，您可以创建新的网关，并根据上述参数对它们进行排序。

### 网关仪表板

如果您选择一个网关并单击它，您将被转移到所选网关的仪表板。

![](/images/gateway/dashboard/gateway-dashboard.png)

仪表板由 4 个主要小部件组成：
- **常规网关信息**，包括以下卡片：
   - 状态（活动/非活动）；
   - 网关名称；
   - 网关类型；
   - 设备（活动/非活动）；
   - 连接器（活动/非活动）以及指向连接器仪表板的链接；
   - 错误计数以及指向日志仪表板的链接。

![](/images/gateway/dashboard/gateway-dashboard-cards.png)

- **设备** 是一个表格，其中包含通过网关连接的设备的基本信息：
   - 设备名称；
   - 设备类型；
   - 状态（活动/非活动）；
   - 连接器名称；
   - 连接器类型；
   - 以及过滤和搜索必要设备的元素。

![](/images/gateway/dashboard/gateway-dashboard-devices.png)

- **警报** 是一个标准警报小部件，您将在其中收到与所选网关相关的所有警报；

![](/images/gateway/dashboard/gateway-dashboard-alarms.png)

- **导航面板** 是一个导航面板，其中位于所有其他用于配置、管理和监视网关的仪表板，即：
   - 启动命令 - 一个模态窗口，其中包含用于启动网关的自动生成命令；
  
   ![](/images/gateway/dashboard/gateway-dashboard-launch-command.png)

   - [常规配置](#general-configuration) - 包含常规网关设置的仪表板；
  
   [![](/images/gateway/dashboard/gateway-dashboard-gen-conf-button.png)](#general-configuration)

   - [连接器配置](#connector-configuration) - 包含连接器管理和配置的仪表板；
  
   [![](/images/gateway/dashboard/gateway-dashboard-connectors-conf-button.png)](#connector-configuration)

   - [日志](#logs) - 包含各种类型日志的仪表板（应注意，仅当网关上启用了 **远程日志记录** 时，此按钮才处于活动状态）；
  
   [![](/images/gateway/dashboard/gateway-dashboard-logs-button.png)](#logs)

   - [统计信息](#statistics) - 包含网关的常规和自定义统计信息的仪表板；

   [![](/images/gateway/dashboard/gateway-dashboard-statistics-button.png)](#statistics)

   - [远程 Shell](#remote-shell) - 包含远程 Shell 的仪表板（应注意，仅当网关上启用了 **远程 Shell** 时，此按钮才处于活动状态）；

   [![](/images/gateway/dashboard/gateway-dashboard-remote-shell-button.png)](#remote-shell)

   - [RPC](#rpc) - 网关 RPC 发送仪表板。

   [![](/images/gateway/dashboard/gateway-dashboard-rpc-button.png)](#rpc)

### 常规配置

如果您单击导航面板中网关仪表板上的 **常规配置** 按钮，您将被转移到仪表板
网关的常规设置。

仪表板包含以下选项卡：

{% capture info %}
对于每个字段，当您将鼠标悬停在 **“i”** 图标上时，都会出现提示。
{% endcapture %}
{% include templates/info-banner.md content=info %}

{% capture gatewayconfigurationspec %}
常规%,%general-toggle%,%templates/iot-gateway/gateway-dashboard-general-conf.md%br%
日志%,%logs-toggle%,%templates/iot-gateway/gateway-dashboard-logs-conf.md%br%
存储%,%storage-toggle%,%templates/iot-gateway/gateway-dashboard-storage-conf.md%br%
GRPC%,%grpc-toggle%,%templates/iot-gateway/gateway-dashboard-grpc-conf.md%br%
统计信息%,%statistics-toggle%,%templates/iot-gateway/gateway-dashboard-statistics-conf.md%br%
其他%,%other-toggle%,%templates/iot-gateway/gateway-dashboard-other-conf.md{% endcapture %}

{% include content-toggle.html content-toggle-id="GatewayConfiguration" toggle-spec=gatewayconfigurationspec %}

### 连接器配置

如果您单击 **导航面板** 中网关仪表板上的 **连接器配置** 按钮，您将被转移到 **连接器配置仪表板**。

![](/images/gateway/dashboard/gateway-dashboard-connectors.png)

仪表板包含两个主要部分：
- 连接器列表 - 此处显示所有已创建连接器的基本信息和控制元素：
   - 启用 - 启用或禁用连接器；
   - 连接器名称；
   - 连接器类型；
   - 配置状态 - 显示远程配置是否与本地配置同步；
   - 连接器状态 - 如果为“绿色” - 没有错误，并且连接器工作正常。如果为“红色” - 连接器工作不正常；
   - 操作：
     - RPC - 用于通过网关向连接器发送 [RPC](/docs/iot-gateway/guides/how-to-use-get-set-rpc-methods/) 的仪表板；
     - 日志 - 包含连接器日志的仪表板；
     - 删除连接器。
- 连接器配置 - 此处显示用于配置连接器的字段，即：
   - 连接器名称；
   - 连接器类型；
   - 日志记录级别；
   - 配置。

### 日志

{% capture info %}
应注意，仅当网关上启用了 **远程日志记录** 时，**日志仪表板** 才处于活动状态。
{% endcapture %}
{% include templates/info-banner.md content=info %}

如果您单击 **导航面板** 中网关仪表板上的 **日志** 按钮，您将被转移到日志仪表板。

![](/images/gateway/dashboard/gateway-dashboard-logs.png)

仪表板实时显示主要网关日志信息（常规、服务、连接、存储、扩展）：
- 创建时间；
- 状态；
- 消息。

### 统计信息

如果您单击 **导航面板** 中网关仪表板上的 **统计信息** 按钮，您将被转移到统计信息仪表板。

![](/images/gateway/dashboard/gateway-dashboard-statistics.png)

仪表板包含两个小部件：
- 网关常规图表统计信息 - 此处显示常规统计信息指标，即：
  - 发送到设备 - 从网关发送到设备的总数据量；
  - 发送到 GridLinks - 从网关发送到 GridLinks 的总数据量；
  - 从 GridLinks 接收 - 从 RPC 和属性更新接收的总数据量；
  - 从设备转换 - 网关上转换的数据总数；
  - 产生的事件 - 从 GridLinks 接收的事件数；
  - 发送的事件 - 发送到 GridLinks 的事件总数；
  - 从设备接收 - 从设备接收的总数据量。
- 网关自定义统计信息 - 此处显示自定义统计信息，您可以使用选择器选择单个指标。此外，最右侧的小部件将根据数据类型更改其类型（如果整数/浮点数据是图形，则其他类型是表格）。

### 远程 Shell

{% capture info %}
应注意，仅当网关上启用了 **远程 Shell** 时，**远程 Shell 仪表板** 才处于活动状态。
{% endcapture %}
{% include templates/info-banner.md content=info %}

如果您单击 **导航面板** 中网关仪表板上的 **远程 Shell** 按钮，您将被转移到远程 Shell 仪表板。

![](/images/gateway/dashboard/gateway-dashboard-shell.png)

仪表板允许使用远程 Shell 小部件从网关控制操作系统。

### RPC

如果您单击 **导航面板** 中网关仪表板上的 **RPC** 按钮，您将被转移到网关 RPC 发送仪表板。

![](/images/gateway/dashboard/gateway-dashboard-rpc.png)

仪表板包含 3 个小部件：
- 服务 RPC - 用于发送 RPC 并查看命令执行结果：
   - 命令 - [服务网关 RPC](/docs/iot-gateway/guides/how-to-use-gateway-rpc-methods/)（Ping、统计信息、设备、更新、版本、重新启动、重新启动）；
   - 超时 - 命令执行时间；
   - 结果 - 执行发送的命令的结果。
- RPS 日志 - 在处理发送的 RPC 时显示网关日志；
- RPC 调试终端 - 用于调试网关 RPC 的小部件。

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。