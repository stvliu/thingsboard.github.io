---
layout: docwithnav-gw
title: 如何使用远程转换器更新
description: 如何使用远程转换器更新

---

* TOC
{:toc}

“远程转换器更新”允许您通过利用共享属性来远程更新转换器的配置。本指南将帮助您使用此功能来远程更新转换器配置。

出于本教程的目的，您需要：
1. GridLinks 平台的本地安装实例（如果您是 GridLinks 新手，[请使用此“如何安装”文档](/docs/user-guide/install/installation-options/)）。
2. [已安装](/docs/iot-gateway/installation/)且[已配置](/docs/iot-gateway/configuration/) ThingsBoard IoT 网关。

## 步骤 1 在网关设备上创建共享属性

您必须使用以下格式在网关设备上创建共享属性，即以“<Connector Name>:<Converter Class Name>”作为键，并将转换器配置写为值。

例如：
![](/images/gateway/remote-converter-update-create-shared-attr.png)

在上面的屏幕截图中，我们为远程更新 MQTT 默认 JSON 转换器配置创建了共享属性。

## 步骤 2 更新提供的共享属性

要获取新的转换器配置更新，您必须提供具有新配置的共享属性。
例如：
![](/images/gateway/remote-converter-update-shared-attr.png)

## 步骤 3 日志

如果上述步骤完成得很好，您将看到以下网关日志：
![](/images/gateway/remote-converter-update-logs.png)

## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎来分析来自设备的数据。