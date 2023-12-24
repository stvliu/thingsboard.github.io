* TOC
{:toc}

TBMQ 提供了用户友好的工具，使用户能够通过 **主页** 和 **监控** 页面监控代理活动并方便地访问功能。

![image](/images/mqtt-broker/user-guide/ui/home-page.png)

### 图表

在 **主页** 页面的顶部，您会找到一组五个图表，这些图表显示了有关代理在过去 10 分钟内的活动的基本信息：
  - **传入消息。** 此图表显示 MQTT 客户端发布到代理的消息数。
  - **传出消息。** 在此处，您可以查看代理传递给订阅客户端的消息数。
  - **丢弃的消息。** 此图表指示缺少订阅者或由于网络问题、客户端断开连接或资源限制而无法传递给订阅者的消息。
  - **会话。** 此图表中显示当前 MQTT 会话数。
  - **订阅。** 此图表显示当前订阅数。

请注意，在监控页面上，用户能够更深入地研究图表数据。
他们可以放大特定部分，设置自定义日期范围来显示数据，或以全屏模式打开图表。

![image](/images/mqtt-broker/user-guide/ui/monitoring-page.png)

### 会话

会话卡提供已连接和已断开连接会话的概述。
用户可以通过访问 [会话](/docs/mqtt-broker/user-guide/ui/sessions/) 页面来访问有关这些会话的综合信息，包括其状态、持续时间和其他详细信息。

### 凭证

系统显示按两种类型分类的客户端凭证数：**设备** 和 **应用程序**。
有关不同类型凭证的更多信息，请参阅 [文档](/docs/mqtt-broker/user-guide/mqtt-client-type/)。

![image](/images/mqtt-broker/user-guide/ui/sessions-credentials-card.png)

### 配置

包含有关一些常用配置参数的信息：
  - **基本身份验证。** 默认情况下，基于用户名、密码和 clientId 的基本身份验证被禁用。要启用它，请将 `SECURITY_MQTT_BASIC_ENABLED` 环境变量设置为 `true`。
  - **X.509 证书链身份验证。** 默认情况下，X.509 证书链身份验证被禁用。要启用它，请将 `SECURITY_MQTT_SSL_ENABLED` 环境变量设置为 `true`。
  - **TCP 端口。** 默认情况下，TCP 侦听器在 `1883` 端口上启用。要修改端口，您可以设置 `LISTENER_TCP_BIND_PORT` 环境变量。
  - **TLS 端口。** 默认情况下，SSL/TLS 侦听器在端口 `8883` 上禁用。要更改默认端口，请设置 `LISTENER_SSL_BIND_PORT` 环境变量。
  - **WS 端口。** 默认情况下，WS 侦听器在 `8084` 端口上启用。要修改端口，您可以设置 `LISTENER_WS_BIND_PORT` 环境变量。
  - **WSS 端口。** 默认情况下，WSS 侦听器在端口 `8085` 上禁用。要修改端口，您可以设置 `LISTENER_WSS_BIND_PORT` 环境变量。
  - **TCP 侦听器。** 默认情况下启用。要禁用它，请将 `LISTENER_TCP_ENABLED` 环境变量设置为 `false`。
  - **TLS 侦听器。** 默认情况下禁用。要启用 SSL/TLS 侦听器，请将 `LISTENER_SSL_ENABLED` 环境变量设置为 `true`。
  - **WS 侦听器。** 默认情况下启用。要禁用它，请将 `LISTENER_WS_ENABLED` 环境变量设置为 `false`。
  - **WSS 侦听器。** 默认情况下禁用。要启用它，请将 `LISTENER_WSS_ENABLED` 环境变量设置为 `true`。
  - **TCP 侦听器最大有效负载大小。** 此参数定义 TCP 消息中有效负载的最大允许大小。默认值为 `65536` 字节。要修改它，请以字节为单位设置 `TCP_NETTY_MAX_PAYLOAD_SIZE` 环境变量。
  - **TLS 侦听器最大有效负载大小。** 与 TCP 侦听器类似，此参数指定 SSL/TLS 加密消息中有效负载的最大允许大小。默认值为 `65536` 字节。要更改它，请以字节为单位设置 `SSL_NETTY_MAX_PAYLOAD_SIZE` 环境变量。
  - **WS 侦听器最大有效负载大小。** 指定 WS 消息中有效负载的最大允许大小。默认值为 `65536` 字节。要修改它，请以字节为单位设置 `WS_NETTY_MAX_PAYLOAD_SIZE` 环境变量。
  - **WSS 侦听器最大有效负载大小。** 定义 WSS 加密消息中有效负载的最大允许大小。默认值为 `65536` 字节。要更改它，请以字节为单位设置 `WSS_NETTY_MAX_PAYLOAD_SIZE` 环境变量。

![image](/images/mqtt-broker/user-guide/ui/config-card.png)

### Kafka 代理

显示有关 Kafka 代理的基本信息：
- **地址。** Kafka 代理的地址。
- **大小。** 存储在代理上的数据大小。

![image](/images/mqtt-broker/user-guide/ui/kafka-brokers-card.png)

### Kafka 主题

显示有关 Kafka 主题的基本信息：
- **名称。** Kafka 主题的名称。
- **分区。** 主题中的分区数。
- **副本。** 主题的复制因子。
- **大小。** 主题的大小。

![image](/images/mqtt-broker/user-guide/ui/kafka-topics-card.png)

### Kafka 消费者组

显示有关 Kafka 消费者组 (CG) 的基本信息：
- **ID。** 消费者组 ID。
- **状态。** CG 的状态。可以是 `STABLE`、`PREPARING_REBALANCE`、`COMPLETING_REBALANCE`、`EMPTY`、`DEAD` 或 `UNKNOWN`。
- **成员。** CG 中的消费者数。
- **滞后。** 组内所有消费者的滞后总和。消费者滞后是消费者最后提交的偏移量与生产者的结束偏移量之间的增量。

![image](/images/mqtt-broker/user-guide/ui/kafka-consumer-groups-card.png)