* TOC
{:toc}

## 仪表和提示的故障排除

### 消息包处理日志

您可以启用对最慢和最常调用的规则节点的日志记录。
要做到这一点，您需要使用以下<i>记录器</i>更新您的日志记录配置（＃enable-certain-logs）：

```bash
<logger name="org.thingsboard.server.service.queue.TbMsgPackProcessingContext" level="DEBUG" />
```

之后，您可以在日志中找到以下消息：

```bash
2021-03-24 17:01:21,023 [tb-rule-engine-consumer-24-thread-3] DEBUG o.t.s.s.q.TbMsgPackProcessingContext - Top Rule Nodes by max execution time:
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] DEBUG o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f740670-8cc0-11eb-bcd9-d343878c0c7f] max execution time: 1102. [RuleChain: Thermostat|RuleNode: Device Profile Node(3f740670-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] DEBUG o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f6debf0-8cc0-11eb-bcd9-d343878c0c7f] max execution time: 1. [RuleChain: Thermostat|RuleNode: Message Type Switch(3f6debf0-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - Top Rule Nodes by avg execution time:
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f740670-8cc0-11eb-bcd9-d343878c0c7f] avg execution time: 604.0. [RuleChain: Thermostat|RuleNode: Device Profile Node(3f740670-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,025 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f6debf0-8cc0-11eb-bcd9-d343878c0c7f] avg execution time: 1.0. [RuleChain: Thermostat|RuleNode: Message Type Switch(3f6debf0-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,025 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - Top Rule Nodes by execution count:
2021-03-24 17:01:21,025 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f740670-8cc0-11eb-bcd9-d343878c0c7f] execution count: 2. [RuleChain: Thermostat|RuleNode: Device Profile Node(3f740670-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,028 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f6debf0-8cc0-11eb-bcd9-d343878c0c7f] execution count: 1. [RuleChain: Thermostat|RuleNode: Message Type Switch(3f6debf0-8cc0-11eb-bcd9-d343878c0c7f)]
```

## 日志

### 读取日志

无论部署类型如何，ThingsBoard Edge 日志都存储在以下目录中：

```bash
/var/log/tb-edge
```

不同的部署工具提供了不同的查看日志的方式：

{% capture contenttogglespecdeploymenttype %}
独立部署%,%standalone%,%templates/edge/troubleshooting/logs/view-logs/standalone-view-logs.md%br%
Docker-Compose 部署%,%docker-compose%,%templates/edge/troubleshooting/logs/view-logs/docker-compose-view-logs.md{% endcapture %}

{% include content-toggle.html content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}


### 启用某些日志

GridLinks 提供了启用/禁用系统某些部分的日志记录的功能，具体取决于您需要哪些信息进行故障排除。

您可以通过修改<b>logback.xml</b>文件来做到这一点。作为日志本身，它存储在以下目录中：

```bash
/usr/share/tb-edge/conf
```

以下是<b>logback.xml</b>配置的示例：

```bash
<!DOCTYPE configuration>
<configuration scan="true" scanPeriod="10 seconds">

    <appender name="fileLogAppender"
              class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/var/log/tb-edge/tb-edge.log</file>
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>/var/log/tb-edge/tb-edge.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
            <maxFileSize>100MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>3GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%d{ISO8601} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="org.thingsboard.server" level="INFO" />
    <logger name="org.thingsboard.js.api" level="TRACE" />
    <logger name="com.microsoft.azure.servicebus.primitives.CoreMessageReceiver" level="OFF" />

    <root level="INFO">
        <appender-ref ref="fileLogAppender"/>
    </root>
</configuration>
```

配置文件中最有用的故障排除部分是<i>记录器</i>。
它们允许您启用/禁用某些类或类组的日志记录。
在上面的示例中，默认日志记录级别是<b>INFO</b>（这意味着日志将仅包含一般信息、警告和错误），但对于包<code>org.thingsboard.js.api</code>，我们启用了最详细的日志记录级别。
还可以在系统某些部分完全禁用日志，在上面的示例中，我们使用<b>OFF</b>日志级别对<code>com.microsoft.azure.servicebus.primitives.CoreMessageReceiver</code>类执行了此操作。

要启用/禁用系统某些部分的日志记录，您需要添加适当的<code></logger></code>配置并等待最多 10 秒。

不同的部署工具提供了不同的更新日志的方式：

{% capture contenttogglespecdeploymenttype %}
独立部署%,%standalone%,%templates/edge/troubleshooting/logs/enable-logs/standalone-enable-logs.md%br%
Docker-Compose 部署%,%docker-compose%,%templates/edge/troubleshooting/logs/enable-logs/docker-compose-enable-logs.md{% endcapture %}

{% include content-toggle.html content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}

## 指标

您可以通过在配置文件中将环境变量 `METRICS_ENABLED` 设置为值 `true` 和 `METRICS_ENDPOINTS_EXPOSE` 设置为值 `prometheus` 来启用 prometheus 指标。

这些指标在路径 `https://<yourhostname>/actuator/prometheus` 处公开，可以由 prometheus 抓取（无需身份验证）。

## Prometheus 指标

Spring Actuator 可以使用 Prometheus 公开一些内部状态指标。

以下是 GridLinks 推送到 Prometheus 的指标列表。

#### <b>tb-edge</b> 指标：
- <i>attributes_queue_${index_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>属性</b>写入数据库的统计信息。
  请注意，为了达到最佳性能，有几个队列（线程）用于持久化属性。
- <i>ruleEngine_${name_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs, tmpFailed, failedIterations, successfulIterations, timeoutMsgs, tmpTimeout</i>）：
  有关在规则引擎内处理消息的统计信息。它们为每个队列（例如 Main、HighPriority、SequentialByOriginator 等）持久化。
  一些统计信息说明：
    - <i>tmpFailed</i>：失败并稍后重新处理的消息数
    - <i>tmpTimeout</i>：超时并稍后重新处理的消息数
    - <i>timeoutMsgs</i>：超时并随后被丢弃的消息数
    - <i>failedIterations</i>：处理消息包的迭代次数，其中至少一条消息未成功处理
- <i>ruleEngine_${name_of_queue}_seconds</i>（对于每个现有的<i>tenantId</i>）：有关不同队列的消息处理时间统计信息。
- <i>core</i>（statsNames - <i>totalMsgs, toDevRpc, coreNfs, sessionEvents, subInfo, subToAttr, subToRpc, deviceState, getAttr, claimDevice, subMsgs</i>）：
  有关处理内部系统消息的统计信息。
  一些统计信息说明：
    - <i>toDevRpc</i>：来自传输服务的已处理 RPC 响应数
    - <i>sessionEvents</i>：来自传输服务的会话事件数
    - <i>subInfo</i>：来自传输服务的订阅信息数
    - <i>subToAttr</i>：来自传输服务的订阅属性更新数
    - <i>subToRpc</i>：来自传输服务的订阅 RPC 数
    - <i>getAttr</i>：来自传输服务的“获取属性”请求数
    - <i>claimDevice</i>：来自传输服务的设备声明数
    - <i>deviceState</i>：已处理的设备状态更改数
    - <i>subMsgs</i>：已处理的订阅数
    - <i>coreNfs</i>：已处理的特定“系统”消息数
- <i>jsInvoke</i>（statsNames - <i>requests, responses, failures</i>）：有关对 JS 执行器的总请求、成功请求和失败请求的统计信息
- <i>attributes_cache</i>（结果 - <i>hit, miss</i>）：有关有多少属性请求进入缓存的统计信息


#### <b>transport</b> 指标：
- <i>transport</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关传输从核心接收的请求的统计信息
- <i>ruleEngine_producer</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将消息从传输推送到规则引擎的统计信息。
- <i>core_producer</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将消息从传输推送到 TB 节点设备参与者的统计信息。
- <i>transport_producer</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关从传输到核心的请求的统计信息。


#### 特定于 PostgreSQL 的指标：
- <i>ts_latest_queue_${index_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>最新遥测</b>写入数据库的统计信息。
  请注意，为了达到最佳性能，有几个队列（线程）。
- <i>ts_queue_${index_of_queue}</i>（statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>遥测</b>写入数据库的统计信息。
  请注意，为了达到最佳性能，有几个队列（线程）。

## 获取帮助

<section id="talkToUs">
    <div id="gettingHelp">
        <a href="https://app.gitter.im/#/room/#thingsboard_chat:gitter.im">
            <span class="phrase-heading">社区聊天</span>
            <p>我们的 Gitter 频道是联系我们的工程师并与他们分享您的想法的最佳方式。</p>
        </a>
        <a href="https://groups.google.com/forum/#!forum/thingsboard">
            <span class="phrase-heading">问答论坛</span>
            <p>我们的用户论坛是获得社区支持的好地方。</p>
        </a>
        <a href="https://stackoverflow.com/questions/tagged/thingsboard">
            <span class="phrase-heading">Stack Overflow</span>
            <p>ThingsBoard 团队还将监控标记为 thingsboard 的帖子。如果没有现有的问题可以提供帮助，请提出一个新问题！</p>
        </a>
    </div>
</section>

如果您的问题无法通过上述任何指南来解答，请随时联系 GridLinks 团队。

<a class="button" href="/docs/contact-us/">联系我们</a>