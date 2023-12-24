---
layout: docwithnav
assignees:
- ashvayka
title: RPC 插件

---

{% include templates/old-guide-notice.md %}

## 概述

RPC 插件负责：

- 提供 REST API，以便从服务器端应用程序向设备发送 RPC 请求；
- 通过以下可用协议之一将 RPC 请求推送到设备：[MQTT](/docs/reference/mqtt-api/#rpc-api)、[CoAP](/docs/reference/coap-api/#rpc-api) 或 [HTTP](/docs/reference/http-api/#rpc-api)；

默认情况下，此插件由系统管理员在系统级别配置。
您能够在租户级别配置您自己的插件实例。
高级用户或平台开发人员可以自定义 rpc 插件功能。

## 配置

您可以在插件配置中为插件实例指定默认 RPC 超时。

## 服务器端 API

RPC 插件 API 说明可在相应的 [rpc](/docs/user-guide/rpc/#server-side-rpc-api) 指南中找到。

## 示例

作为系统管理员，您能够在 **插件->系统 RPC 插件** 中查看插件示例。