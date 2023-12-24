{% include templates/install/queue-pub-sub-config.md %}

##### ThingsBoard 配置

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}

并找到“queue:”块。确保队列类型为“pubsub”，不要忘记用你的 **实际 Pub/Sub 项目 ID 和服务帐户（它是 json 文件中的全部数据）** 替换“YOUR_PROJECT_ID”、“YOUR_SERVICE_ACCOUNT”。

```yml
queue:
  type: "${TB_QUEUE_TYPE:pubsub}"
...
  pubsub:
    project_id: "${TB_QUEUE_PUBSUB_PROJECT_ID:YOUR_PROJECT_ID}"
    service_account: "${TB_QUEUE_PUBSUB_SERVICE_ACCOUNT:YOUR_SERVICE_ACCOUNT}"
    max_msg_size: "${TB_QUEUE_PUBSUB_MAX_MSG_SIZE:1048576}" #in bytes
    max_messages: "${TB_QUEUE_PUBSUB_MAX_MESSAGES:1000}"
```

**这些参数会影响每个队列的每个分区每秒的请求数。**

根据以下公式计算特定消息队列的请求数：

((规则引擎和核心队列数) * (每个队列的分区数) + 
(传输队列数) + (微服务数) + (JS 执行器数)) * 1000 / POLL_INTERVAL_MS

例如，基于默认参数的请求数为：

规则引擎队列：

主 **10** 个分区 + 高优先级 **10** 个分区 + 按发起者顺序 **10** 个分区 = **30**

核心队列 **10** 个分区

传输请求队列 + 响应队列 = **2**

规则引擎传输通知队列 + 核心传输通知队列 = **2**

总计 = **44**

每秒请求数 = **44 * 1000 / 25 = 1760** 个请求

根据案例，如果消息负载较低，你可以权衡延迟并减少队列的分区/请求数。

通过 UI 设置规则引擎队列的参数 - 间隔 (1000) 和分区 (1)。

在“整体”部署中每秒适合 **10** 个请求的示例参数：

```yml
queue:
...
  transport_api:
    request_poll_interval: "${TB_QUEUE_TRANSPORT_REQUEST_POLL_INTERVAL_MS:1000}"
    response_poll_interval: "${TB_QUEUE_TRANSPORT_RESPONSE_POLL_INTERVAL_MS:1000}"
...
  core:
    poll-interval: "${TB_QUEUE_CORE_POLL_INTERVAL_MS:1000}"
    partitions: "${TB_QUEUE_CORE_PARTITIONS:2}"
...
  vc:
    partitions: "${TB_QUEUE_VC_PARTITIONS:1}"
    poll-interval: "${TB_QUEUE_VC_INTERVAL_MS:1000}"
...
  js:
    response_poll_interval: "${REMOTE_JS_RESPONSE_POLL_INTERVAL_MS:1000}"
...
  rule-engine:
    poll-interval: "${TB_QUEUE_RULE_ENGINE_POLL_INTERVAL_MS:1000}"
...
  transport:
    poll_interval: "${TB_QUEUE_TRANSPORT_NOTIFICATIONS_POLL_INTERVAL_MS:1000}"
```

你可以使用 UI 更新默认规则引擎队列配置。有关 GridLinks 规则引擎队列的更多信息，请参阅 [文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。