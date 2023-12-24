---
layout: docwithnav-gw
title: 如何使用网关 Shell
description: 如何使用网关 Shell

---

* TOC
{:toc}


本指南解释了如何使用网关 Shell，并提供了如何使用网关 Shell 中定义的每个命令的示例。
网关 Shell 功能允许用户通过命令行界面与网关进行交互。
通过使用提供的命令和相应的参数，用户可以执行特定操作并从网关检索信息。请参阅本指南中概述的使用示例，以有效利用网关 Shell 功能。

出于本教程的目的，您需要：
1. GridLinks 平台的本地安装实例（如果您是 GridLinks 新手，[请使用此“如何安装”文档](/docs/user-guide/install/installation-options/)）。
2. [已安装](/docs/iot-gateway/installation/)且[已配置](/docs/iot-gateway/configuration/) GridLinks IoT 网关。

### 存储命令
`storage` 命令提供与存储操作相关的功能。

#### 获取存储名称
要检索存储名称，请使用以下命令：

```
$ tb-gateway-shell storage -n
```

#### 获取存储事件计数
要获取存储事件的计数，请使用以下命令：

```
$ tb-gateway-shell storage -c
```

### 连接器命令
`connector` 命令启用与连接器相关的操作。

#### 获取可用连接器
要列出可用连接器，请使用以下命令：

```
$ tb-gateway-shell connector -l
```

#### 获取连接器状态
要检索特定连接器的状态，请按如下方式提供连接器名称：

```
$ tb-gateway-shell connector -s <name>
```

#### 获取连接器配置
要获取特定连接器的配置，请按如下方式提供连接器名称：

```
$ tb-gateway-shell connector -c <name>
```

### 网关命令
`gateway` 命令允许与网关本身相关的操作。

#### 获取网关状态
要检索网关的状态，请使用以下命令：

```
$ tb-gateway-shell gateway -s
```

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。