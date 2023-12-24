* TOC
{:toc}

## 可能的性能问题

此处我们将描述可能出错的不同可能场景。

{% capture contenttogglespecscenario %}
无消息处理%,%no-message-processing%,%templates/troubleshooting/scenarios/no-message-processing.md%br%
消息延迟增加%,%growing-latency%,%templates/troubleshooting/scenarios/growing-latency.md{% endcapture %}

{% include content-toggle.html content-toggle-id="scenario" toggle-spec=contenttogglespecscenario %}

## 故障排除工具和提示

### 规则引擎统计信息仪表板
您可以查看在处理规则链期间是否存在任何故障、超时或异常。您可以在 [此处](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics) 找到更详细的信息。

### Kafka 队列的消费者组消息延迟

**注意：** 仅当选择 Kafka 作为队列时，才能使用此方法。

使用此日志，您可以确定是否在处理消息时出现问题（由于队列用于系统内的所有消息传递，因此您不仅可以分析规则引擎队列，还可以分析<b>传输</b>、<b>核心</b>等）。
有关使用消费者组延迟对规则引擎处理进行故障排除的更多详细信息，请点击 [此处](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#troubleshooting)。

### CPU/内存使用情况

有时问题在于您没有足够的资源来使用某些服务。您可以通过登录服务器/容器/pod 并执行 `top` Linux 命令来查看 CPU 和内存使用情况。

为了更方便地进行监控，最好配置 Prometheus 和 Grafana。

如果您看到某些服务有时使用 100% 的 CPU，则应通过在集群中创建新节点来水平扩展服务，或通过增加 CPU 总量来垂直扩展服务。

### 消息包处理日志

您可以启用对最慢和最常调用的规则节点的日志记录。
为此，您需要使用以下<i>logger</i>来[更新日志记录配置](#enable-certain-logs)：

```bash
<logger name="org.thingsboard.server.service.queue.TbMsgPackProcessingContext" level="DEBUG" />
```

之后，您可以在 [日志](#logs) 中找到以下消息：

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

### 清除 Redis 缓存

**注意：** 仅当选择 Redis 作为缓存时，才能使用此方法。

缓存中的数据可能已损坏。无论出于何种原因，清除缓存始终是安全的，ThingsBoard 只会在运行时重新填充缓存。
要清除 Redis 缓存，您需要登录包含 Redis 的服务器/容器/pod，并调用 `redis-cli FLUSHALL` 命令。要在 Redis Sentinel 模式下清除缓存，请访问主容器并执行清除缓存命令。

因此，如果您难以确定某些问题的根源，您可以安全地清除 Redis 缓存，以确保它不是问题的原因。


## 日志

### 读取日志

无论部署类型如何，ThingsBoard 日志都与 ThingsBoard Server/Node 本身存储在同一服务器/容器中，目录如下：

```bash
/var/log/thingsboard
```

不同的部署工具提供了不同的查看日志的方式：

{% capture contenttogglespecdeploymenttype %}
独立部署%,%standalone%,%templates/troubleshooting/logs/view-logs/standalone-view-logs.md%br%
Docker-Compose 部署%,%docker-compose%,%templates/troubleshooting/logs/view-logs/docker-compose-view-logs.md%br%
Kubernetes 部署%,%kubernetes%,%templates/troubleshooting/logs/view-logs/kubernetes-view-logs.md{% endcapture %}

{% include content-toggle.html content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}


### 启用某些日志

GridLinks 提供了根据您需要哪些信息进行故障排除来启用/禁用系统某些部分的日志记录的功能。

您可以通过修改<b>logback.xml</b> 文件来执行此操作。与日志本身一样，它与 ThingsBoard Server/Node 存储在同一服务器/容器中，目录如下：

```bash
/usr/share/thingsboard/conf
```

以下是一个<b>logback.xml</b> 配置示例：

```bash
<!DOCTYPE configuration>
<configuration scan="true" scanPeriod="10 seconds">

    <appender name="fileLogAppender"
              class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/var/log/thingsboard/thingsboard.log</file>
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>/var/log/thingsboard/thingsboard.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
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

配置文件中最有用的故障排除部分是<i>loggers</i>。
它们允许您启用/禁用某些类或类组的日志记录。
在上面的示例中，默认日志记录级别是<b>INFO</b>（这意味着日志将仅包含一般信息、警告和错误），但对于包<code>org.thingsboard.js.api</code>，我们启用了最详细的日志记录级别。
还可以完全禁用系统某些部分的日志记录，在上面的示例中，我们使用<b>OFF</b> 日志级别对<code>com.microsoft.azure.servicebus.primitives.CoreMessageReceiver</code> 类执行了此操作。

要启用/禁用系统某些部分的日志记录，您需要添加适当的<code></logger></code> 配置并等待最多 10 秒。

不同的部署工具提供了不同的更新日志的方式：

{% capture contenttogglespecdeploymenttype %}
独立部署%,%standalone%,%templates/troubleshooting/logs/enable-logs/standalone-enable-logs.md%br%
Docker-Compose 部署%,%docker-compose%,%templates/troubleshooting/logs/enable-logs/docker-compose-enable-logs.md%br%
Kubernetes 部署%,%kubernetes%,%templates/troubleshooting/logs/enable-logs/kubernetes-enable-logs.md{% endcapture %}

{% include content-toggle.html content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}


## 指标

您可以通过在配置文件中将环境变量 `METRICS_ENABLED` 设置为 `true` 和 `METRICS_ENDPOINTS_EXPOSE` 设置为 `prometheus` 来启用 prometheus 指标。
如果您将 GridLinks 作为微服务运行，并为 MQTT 和 COAP 传输提供单独的服务，那么您还需要将环境变量 `WEB_APPLICATION_ENABLE` 设置为 `true`，`WEB_APPLICATION_TYPE` 设置为 `servlet`，`HTTP_BIND_PORT` 设置为 `8081`，以便为 MQTT 和 COAP 服务启用带有 Prometheus 指标的 Web 服务器。

这些指标在以下路径公开：`https://<yourhostname>/actuator/prometheus`，prometheus 可以抓取该路径（无需身份验证）。

## Prometheus 指标

Spring Actuator 可以使用 Prometheus 公开一些内部状态指标。

以下是 GridLinks 推送到 Prometheus 的指标列表。

#### <b>tb-node</b> 指标
- <i>attributes_queue_${index_of_queue}</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>属性</b>写入数据库的统计信息。
请注意，为了达到最佳性能，有多个队列（线程）用于持久化属性。
- <i>ruleEngine_${name_of_queue}</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs, tmpFailed, failedIterations, successfulIterations, timeoutMsgs, tmpTimeout</i>）：
  有关在规则引擎内处理消息的统计信息。它们为每个队列（例如 Main、HighPriority、SequentialByOriginator 等）持久化。
  一些统计描述：
  - <i>tmpFailed</i>：失败并稍后重新处理的消息数
  - <i>tmpTimeout</i>：超时并稍后重新处理的消息数
  - <i>timeoutMsgs</i>：超时并随后丢弃的消息数
  - <i>failedIterations</i>：处理消息包的迭代次数，其中至少一条消息未成功处理
- <i>ruleEngine_${name_of_queue}_seconds</i>（对于每个现有的<i>tenantId</i>）：有关不同队列的消息处理时间统计信息。
- <i>core</i>（统计名称 - <i>totalMsgs, toDevRpc, coreNfs, sessionEvents, subInfo, subToAttr, subToRpc, deviceState, getAttr, claimDevice, subMsgs</i>）：
  有关处理内部系统消息的统计信息。
  一些统计描述：
  - <i>toDevRpc</i>：从传输服务处理的 RPC 响应数
  - <i>sessionEvents</i>：来自传输服务会话事件数
  - <i>subInfo</i>：来自传输服务的订阅信息数
  - <i>subToAttr</i>：来自传输服务的订阅属性更新数
  - <i>subToRpc</i>：来自传输服务的订阅 RPC 数
  - <i>getAttr</i>：来自传输服务的“获取属性”请求数
  - <i>claimDevice</i>：来自传输服务的设备声明数
  - <i>deviceState</i>：处理的设备状态更改数
  - <i>subMsgs</i>：处理的订阅数
  - <i>coreNfs</i>：处理的特定“系统”消息数
- <i>jsInvoke</i>（统计名称 - <i>requests, responses, failures</i>）：有关对 JS 执行器的总请求数、成功请求数和失败请求数的统计信息
- <i>attributes_cache</i>（结果 - <i>hit, miss</i>）：有关有多少属性请求进入缓存的统计信息


#### <b>transport</b> 指标
- <i>transport</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关 TB 节点接收的传输请求的统计信息
- <i>ruleEngine_producer</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关从传输到规则引擎推送消息的统计信息。
- <i>core_producer</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关从传输到 TB 节点设备参与者推送消息的统计信息。
- <i>transport_producer</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关从传输到 TB 的请求的统计信息。


<b>某些指标取决于您用于持久化时序数据类型的数据库。</b>

#### 特定于 PostgreSQL 的指标
- <i>ts_latest_queue_${index_of_queue}</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>最新遥测</b>写入数据库的统计信息。
请注意，为了达到最佳性能，有多个队列（线程）。
- <i>ts_queue_${index_of_queue}</i>（统计名称 - <i>totalMsgs, failedMsgs, successfulMsgs</i>）：有关将<b>遥测</b>写入数据库的统计信息。
请注意，为了达到最佳性能，有多个队列（线程）。

#### 特定于 Cassandra 的指标
- <i>rateExecutor_currBuffer</i>：当前正在 Cassandra 内持久化的消息数。
- <i>rateExecutor_tenant</i>（对于每个现有的<i>tenantId</i>）：受到速率限制的请求数
- <i>rateExecutor</i>（统计名称 - <i>totalAdded, totalRejected, totalLaunched, totalReleased, totalFailed, totalExpired, totalRateLimited</i>）
统计描述：
    - <i>totalAdded</i>：提交持久化的消息数
    - <i>totalRejected</i>：尝试提交持久化时被拒绝的消息数
    - <i>totalLaunched</i>：发送到 Cassandra 的消息数
    - <i>totalReleased</i>：成功持久化的消息数
    - <i>totalFailed</i>：未持久化的消息数
    - <i>totalExpired</i>：未发送到 Cassandra 的过期消息数
    - <i>totalRateLimited</i>：由于租户的速率限制而未处理的消息数
    
## Grafana 仪表盘

您可以从 [此处](https://github.com/thingsboard/thingsboard/tree/master/docker/monitoring/grafana/provisioning/dashboards) 导入预配置的 Grafana 仪表盘。
**注意：**根据集群配置，您可能需要对仪表盘进行更改。

此外，您可以在部署 ThingsBoards docker-compose 集群配置后查看 Grafana 仪表盘（有关更多信息，请遵循 [此指南](/docs/user-guide/install/{{docsPrefix}}cluster/docker-compose-setup/)）。
确保将 `MONITORING_ENABLED` 环境变量设置为 `true`。
部署后，您将能够在 `http://localhost:9090` 访问 Prometheus，在 `http://localhost:3000` 访问 Grafana（默认登录名为 `admin`，密码为 `foobar`）。

以下是默认预配置 Grafana 仪表盘的屏幕截图：

{% include images-gallery.html imageCollection="metrics-dashboards" %}


## OAuth2

有时在配置 OAuth 后，您看不到使用 OAuth 提供程序登录的按钮。当“域名”和“重定向 URI 模板”包含错误的值时，就会发生这种情况，它们需要与您用于访问 ThingsBoard 网页的值相同。

示例：

| 基本 URL |  域名     |  重定向 URI 模板                    |
|-----------------|----------------- |----------------------------------         |
|http://mycompany.com:8080    |mycompany.com:8080     | http://mycompany.com:8080/login/oauth2/code  |
|https://mycompany.com          |mycompany.com          | https://mycompany.com/login/oauth2/code       |

“主页”部分中的基本 URL 不应包含“/”或其他字符。

> 以系统管理员身份转到您的 GridLinks。检查常规设置 -> 基本 URL 不应在末尾包含“/”（例如，“https://mycompany.com”而不是“https://mycompany.com/”）。

有关 OAuth2 配置，请 [单击此处](/docs/{{docsPrefix}}user-guide/oauth-2-support/)。

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

如果上述任何指南都没有回答您的问题，请随时联系 ThingsBoard 团队。

<a class="button" href="/docs/contact-us/">联系我们</a>