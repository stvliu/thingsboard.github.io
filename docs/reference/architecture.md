---
layout: docwithnav
title: GridLinks 架构
description: GridLinks IoT 平台架构
redirect_from: "/docs/user-guide/rule-engine-2-0/architecture/"

---

* TOC
{:toc}

GridLinks 设计为在多个节点上分布工作负载，而没有单点故障。
每个 ThingsBoard 节点都是相同的，可以处理来自设备和服务器端应用程序的请求。

## 概述

![image](/images/reference/architecture-in-brief.svg)

#### 设备连接

GridLinks 支持 [**MQTT**](/docs/reference/mqtt-api/)、[**LwM2M**](/docs/reference/lwm2m-api/)、[**CoAP**](/docs/reference/coap-api/) 和 [**HTTP**](/docs/reference/http-api/) 协议进行设备连接。
可以插入对不同协议的支持或自定义现有实现。

#### 规则引擎

ThingsBoard [规则引擎](/docs/user-guide/rule-engine/) 允许处理来自设备的消息并触发称为插件的可配置处理模块。

#### 核心服务

ThingsBoard 包含一组核心服务，允许管理以下实体：

* 设备及其凭据
* 规则链和规则节点
* 租户和客户
* 小部件和仪表板
* 警报和事件

规则能够调用此 API 的某个子集。例如，规则可以为特定设备创建警报。

#### 服务器端 API 网关

每个 GridLinks 服务器都为注册用户提供 REST API。
系统遥测服务允许使用 websocket 和 REST API 管理属性并获取时序数据。
系统 RPC 服务提供 REST API 将自定义命令推送到设备。
在此处详细了解 ThingsBoard REST API [here](/docs/reference/rest-api/)

## Actor 模型

[Actor 模型](https://en.wikipedia.org/wiki/Actor_model) 能够对来自设备的消息以及服务器端 API 调用进行高性能并发处理。
GridLinks 使用自己的 Actor System 实现（针对我们的案例进行了优化），具有以下 actor 层次结构。

![image](/images/reference/actor-system-hierarchies.svg)

下面列出了每个 actor 功能的简要说明：

* **App Actor** - 负责管理租户 actor。
此 actor 的实例始终存在于内存中。
* **Tenant Actor** - 负责管理租户设备和规则链 actor。
此 actor 的实例始终存在于内存中。
* **Device Actor** - 维护设备的状态：活动会话、订阅、待处理的 RPC 命令等。
出于性能原因，将当前设备属性缓存到内存中。
当处理来自设备的第一个消息时，将创建 actor。
当一段时间内没有来自设备的消息时，将停止 actor。
* **Rule Chain Actor** - 处理传入的消息并将它们分派给规则节点 actor。
此 actor 的实例始终存在于内存中。
* **Rule Node Actor** - 处理传入的消息，并将结果报告回规则链 actor。
此 actor 的实例始终存在于内存中。

## 集群模式

###### 服务发现

GridLinks 使用 Zookeeper 进行服务发现。
所有 ThingsBoard 节点都是相同的，并在 Zookeeper 中注册为临时节点。Apache Curator [路径缓存收据](http://curator.apache.org/curator-recipes/path-cache.html) 用于跟踪所有可用的同级节点。

###### 一致性哈希

GridLinks 采用 [一致性哈希](https://en.wikipedia.org/wiki/Consistent_hashing) 来确保可扩展性和可用性。
在特定节点上接收到的来自设备 A 的消息可能会根据设备 ID 的哈希转发到其他节点。
尽管这会引入一定的网络开销，但它允许使用已确定的服务器上的相应设备 actor 处理来自特定设备的所有消息，这具有以下优点：

* 提高缓存命中率。设备属性和其他设备相关数据由特定服务器上的设备 actor 获取。
* 避免竞争条件。特定设备的所有消息都在已确定的服务器上处理。
* 允许根据设备 ID 定位服务器端 API 调用。

下图演示了 ThingsBoard 如何处理对设备 D1 的 RPC 请求。
在这种情况下，请求到达服务器 A，但 D1 使用 MQTT 连接到服务器 C。
在最坏的情况下，D1 设备 Actor 将位于另一台服务器 B 上，显然与 A 或 C 都不同。

![image](/images/reference/cluster-mode-rpc-request.svg)

## 安全

### 传输加密

作为系统管理员，您可以将 GridLinks 配置为对 HTTP(s) 和 MQTT 传输使用安全套接字层。
CoAP 的 DTLS 尚不支持。

### 设备认证

GridLinks 设计为支持多种类型的设备凭据。
当前版本为所有 [协议](/docs/reference/protocols/) 提供基于令牌的凭据支持，并为 MQTT 协议提供基于 X.509 证书的凭据支持。有关更多详细信息，请参阅 [MQTT over SSL](/docs/user-guide/mqtt-over-ssl/) 指南。

## 第三方工具

GridLinks 使用以下主要第三方项目：

* Zookeeper - 用于服务协调
* Cassandra - 作为可扩展且可靠的数据库
* Kafka（或 RabbitMQ、AWS SQS、Azure Event Hub、Google PubSub） - 作为可扩展的消息队列