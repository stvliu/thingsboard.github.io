* TOC
{:toc}

### 故障排除工具和技巧

#### Kafka 队列：消费者组消息延迟

您可以使用下面显示的日志来识别消息处理或 TBMQ 基础设施其他部分的任何问题。
由于 Kafka 用于 MQTT 消息处理和系统的其他主要部分，例如“客户端会话”、“客户端订阅”、“保留消息”等，
您可以分析代理的整体状态。

TBMQ 提供了监控向 Kafka 生成消息的速度是否快于消费和处理消息的速度的功能。
在这种情况下，您将体验到消息处理延迟不断增加。
要启用此功能，请确保启用了 Kafka 消费者统计信息（请参阅 [配置属性](/docs/mqtt-broker/install/config/) 的 **queue.kafka.consumer-stats** 部分）。

启用 Kafka 消费者统计信息后，将生成有关消费者组偏移延迟的日志（请参阅 [故障排除](#logs)）。

以下是一个日志消息示例：

```bash
2022-11-27 02:33:23,625 [kafka-consumer-stats-1-thread-1] INFO  o.t.m.b.q.k.s.TbKafkaConsumerStatsService - [msg-all-consumer-group] Topic partitions with lag: [[topic=[tbmq.msg.all], partition=[2], lag=[5]]].
```

从这条消息中，我们可以看到有五条消息推送到 `tbmq.msg.all` 主题，但尚未处理。

通常，日志具有以下结构：

```bash
TIME [STATS_PRINTING_THREAD_NAME] INFO  o.t.m.b.q.k.s.TbKafkaConsumerStatsService - [CONSUMER_GROUP_NAME] Topic partitions with lag: [[topic=[KAFKA_TOPIC], partition=[KAFKA_TOPIC_PARTITION], lag=[LAG]],[topic=[ANOTHER_TOPIC], partition=[], lag=[]],...].
```

其中：
- `CONSUMER_GROUP_NAME` - 处理消息的消费者组的名称。
- `KAFKA_TOPIC` - 确切的 Kafka 主题的名称。
- `KAFKA_TOPIC_PARTITION` - 主题分区的编号。
- `LAG` - 未处理的消息数量。

**注意：** 仅当此消费者组存在延迟时，才会打印有关消费者延迟的日志。

#### CPU/内存使用情况

有时，由于特定服务缺乏资源而导致问题出现。
您可以通过登录到您的 `server/container/pod` 并执行 `top` Linux 命令来查看 CPU 和内存使用情况。

为了更方便地监控，最好配置 Prometheus 和 Grafana。

如果您看到某些服务有时使用 100% 的 CPU，您应该通过在集群中创建新节点来水平扩展服务，或通过增加 CPU 总量来垂直扩展服务。

### 日志

#### 读取日志

无论部署类型如何，TBMQ 日志都存储在以下目录中：

```bash
/var/log/thingsboard-mqtt-broker
```

不同的部署工具提供了不同的查看日志的方式：

{% capture contenttogglespecdeploymenttype %}
Docker-Compose 部署%,%docker-compose%,%templates/mqtt-broker/troubleshooting/logs/view-logs/docker-compose-view-logs.md%br%
Kubernetes 部署%,%kubernetes%,%templates/mqtt-broker/troubleshooting/logs/view-logs/kubernetes-view-logs.md{% endcapture %}

{% include content-toggle.html content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}

#### 启用某些日志

为了便于故障排除，TBMQ 允许用户启用或禁用系统的特定部分的日志记录。
这可以通过修改 **logback.xml** 文件来实现，该文件位于以下目录中：

```bash
/usr/share/thingsboard-mqtt-broker/conf
```

请注意，**k8s** 和 **Docker** 部署有单独的文件。

以下是一个 **logback.xml** 配置示例：

```bash
<!DOCTYPE configuration>
<configuration scan="true" scanPeriod="10 seconds">

    <appender name="fileLogAppender"
              class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/var/log/thingsboard-mqtt-broker/${TB_SERVICE_ID}/thingsboard-mqtt-broker.log</file>
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>/var/log/thingsboard-mqtt-broker/${TB_SERVICE_ID}/thingsboard-mqtt-broker.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
            <maxFileSize>100MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>3GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%d{ISO8601} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="org.thingsboard.mqtt.broker.actors.client.service.connect" level="TRACE"/>
    <logger name="org.thingsboard.mqtt.broker.actors.client.service.disconnect.DisconnectServiceImpl" level="INFO"/>
    <logger name="org.thingsboard.mqtt.broker.actors.DefaultTbActorSystem" level="OFF"/>

    <root level="INFO">
        <appender-ref ref="fileLogAppender"/>
    </root>
</configuration>
```

配置文件包含最适用于故障排除的 _loggers_，因为它们允许您启用或禁用某个类或类组的日志记录。
在上面给出的示例中，默认日志记录级别设置为 **INFO**，这意味着日志将包含一般信息、警告和错误。
但是，对于 `org.thingsboard.mqtt.broker.actors.client.service.connect` 包，启用了最详细的日志记录级别。
您还可以完全禁用系统的某个部分的日志，就像使用 **OFF** 日志级别对 `org.thingsboard.mqtt.broker.actors.DefaultTbActorSystem` 类所做的那样。

要启用或禁用系统的某个部分的日志记录，您需要添加适当的 `</logger>` 配置并等待最多 10 秒。

不同的部署工具有不同的更新日志的方式：

{% capture contenttogglespecdeploymenttype %}
Docker-Compose 部署%,%docker-compose%,%templates/mqtt-broker/troubleshooting/logs/enable-logs/docker-compose-enable-logs.md%br%
Kubernetes 部署%,%kubernetes%,%templates/mqtt-broker/troubleshooting/logs/enable-logs/kubernetes-enable-logs.md{% endcapture %}

{% include content-toggle.html content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}

### 指标

要在 TBMQ 中启用 Prometheus 指标，您必须：
- 将 `STATS_ENABLED` 环境变量设置为 `true`。
- 在配置文件中将 `METRICS_ENDPOINTS_EXPOSE` 环境变量设置为 `prometheus`。

然后可以通过以下路径访问指标：`https://<yourhostname>/actuator/prometheus`，并由 Prometheus 抓取（不需要身份验证）。

### Prometheus 指标

TBMQ 中的 Spring Actuator 可以通过 Prometheus 公开一些内部状态指标。

以下是 TBMQ 推送到 Prometheus 的指标列表：

#### TBMQ 特定指标：

- <i>incomingPublishMsg_published</i>（statsNames - <i>totalMsgs, successfulMsgs, failedMsgs</i>）：有关要保存在常规队列中的传入发布消息的统计信息。
- <i>incomingPublishMsg_consumed</i>（statsNames - <i>totalMsgs, successfulMsgs, timeoutMsgs, failedMsgs, tmpTimeout,
  tmpFailed, successfulIterations, failedIterations</i>）：有关从常规队列处理传入发布消息的统计信息。
- <i>deviceProcessor</i>（statsNames - <i>successfulMsgs, failedMsgs, tmpFailed, successfulIterations, failedIterations</i>）：
  有关设备客户端消息处理的统计信息。
  一些统计信息说明：
  - <i>failedMsgs</i>：要保存在数据库中并随后被丢弃的失败消息数
  - <i>tmpFailed</i>：要保存在数据库中并稍后重新处理的失败消息数
- <i>appProcessor</i>（statsNames - <i>successfulPublishMsgs, successfulPubRelMsgs, tmpTimeoutPublish, tmpTimeoutPubRel, timeoutPublishMsgs,
  timeoutPubRelMsgs, successfulIterations, failedIterations</i>）：有关应用程序客户端消息处理的统计信息。
  一些统计信息说明：
  - <i>tmpTimeoutPubRel</i>：超时并稍后重新处理的 PubRel 消息数
  - <i>tmpTimeoutPublish</i>：超时并稍后重新处理的发布消息数
  - <i>timeoutPubRelMsgs</i>：超时并随后被丢弃的 PubRel 消息数
  - <i>timeoutPublishMsgs</i>：超时并随后被丢弃的发布消息数
  - <i>failedIterations</i>：处理消息包的迭代次数，其中至少一条消息未成功处理
- <i>appProcessor_latency</i>（statsNames - <i>puback, pubrec, pubcomp</i>）：有关不同消息类型的应用程序处理器延迟的统计信息。
- <i>actors_processing</i>（statsNames - <i>MQTT_CONNECT_MSG, MQTT_PUBLISH_MSG, MQTT_PUBACK_MSG, etc.</i>）：
  有关不同消息类型的 actor 处理平均时间的统计信息。
- <i>clientSubscriptionsConsumer</i>（statsNames - <i>totalSubscriptions, acceptedSubscriptions, ignoredSubscriptions</i>）：
  有关代理节点从 Kafka 读取的客户端订阅的统计信息。
  一些统计信息说明：
  - <i>totalSubscriptions</i>：添加到代理集群的总新订阅数
  - <i>acceptedSubscriptions</i>：由代理节点保存的新订阅数
  - <i>ignoredSubscriptions</i>：忽略的订阅数，因为它们最初已由代理节点处理
- <i>retainedMsgConsumer</i>（statsNames - <i>totalRetainedMsgs, newRetainedMsgs, clearedRetainedMsgs</i>）：有关保留消息处理的统计信息。
- <i>subscriptionLookup</i>：有关在 trie 数据结构中查找客户端订阅的平均时间的统计信息。
- <i>retainedMsgLookup</i>：有关在 trie 数据结构中查找保留消息的平均时间的统计信息。
- <i>clientSessionsLookup</i>：有关从找到的客户端订阅中查找发布消息的客户端会话的平均时间的统计信息。
- <i>notPersistentMessagesProcessing</i>：有关处理非持久性客户端的消息传递的平均时间的统计信息。
- <i>persistentMessagesProcessing</i>：有关处理持久性客户端的消息传递的平均时间的统计信息。
- <i>delivery</i>：有关向客户端传递消息的平均时间的统计信息。
- <i>subscriptionTopicTrieSize</i>：有关 trie 数据结构中客户端订阅计数的统计信息。
- <i>subscriptionTrieNodes</i>：有关 trie 数据结构中客户端订阅节点计数的统计信息。
- <i>retainMsgTrieSize</i>：有关 trie 数据结构中保留消息计数的统计信息。
- <i>retainMsgTrieNodes</i>：有关 trie 数据结构中保留消息节点计数的统计信息。
- <i>lastWillClients</i>：有关最后遗嘱客户端计数的统计信息。
- <i>connectedSessions</i>：有关已连接会话计数的统计信息。
- <i>allClientSessions</i>：有关所有客户端会话计数的统计信息。
- <i>clientSubscriptions</i>：有关内存映射中客户端订阅计数的统计信息。
- <i>retainedMessages</i>：有关内存映射中保留消息计数的统计信息。
- <i>activeAppProcessors</i>：有关活动应用程序处理器计数的统计信息。
- <i>activeSharedAppProcessors</i>：有关共享订阅的活动应用程序处理器计数的统计信息。
- <i>runningActors</i>：有关正在运行的 actor 计数的统计信息。

#### PostgreSQL 特定指标：
- <i>sqlQueue_UpdatePacketTypeQueue_${index_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>持久化数据包的类型</b>更新到数据库的统计信息。
- <i>sqlQueue_DeletePacketQueue_${index_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关从数据库中删除<b>持久化数据包</b>的统计信息。
- <i>sqlQueue_TimeseriesQueue_${index_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关<b>历史统计信息持久化</b>到数据库的统计信息。

请注意，为了实现最大性能，**TBMQ 为上面指定的每个队列使用多个队列（线程）**。

### 获取帮助

<section id="talkToUs">
    <div id="gettingHelp">
        <a href="https://app.gitter.im/#/room/#thingsboard_chat:gitter.im">
            <span class="phrase-heading">社区聊天</span>
            <p>联系我们的工程师并与他们分享您的想法的最佳方式是通过我们的 Gitter 频道。</p>
        </a>
        <a href="https://groups.google.com/forum/#!forum/thingsboard">
            <span class="phrase-heading">问答论坛</span>
            <p>对于社区支持，我们建议访问我们的用户论坛。这是一个与其他用户联系并找到常见问题的解决方案的好地方。</p>
        </a>
        <a href="https://stackoverflow.com/questions/tagged/thingsboard">
            <span class="phrase-heading">Stack Overflow</span>
            <p>ThingsBoard 团队积极监控用户论坛上标记为“thingsboard”的帖子。如果您找不到解决您问题的现有问题，请随时提出新问题。我们的团队将很乐意为您提供帮助。</p>
        </a>
    </div>
</section>

如果您无法从上面提供的任何指南中找到问题的解决方案，请随时联系 ThingsBoard 团队以获得进一步的帮助。

<a class="button" href="/docs/contact-us/">联系我们</a>