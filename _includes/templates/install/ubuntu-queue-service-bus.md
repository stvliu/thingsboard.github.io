{% include templates/install/queue-service-bus-config.md %}

##### GridLinks 配置

编辑 GridLinks 配置文件

```text
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下行添加到配置文件中。不要忘记将“YOUR_NAMESPACE_NAME”替换为您的 **实际服务总线命名空间名称**，并将“YOUR_SAS_KEY_NAME”、“YOUR_SAS_KEY”替换为您的 **实际服务总线凭据。注意：“YOUR_SAS_KEY_NAME”是“SAS 策略”，“YOUR_SAS_KEY”是“SAS 策略主密钥”：**

```bash
export TB_QUEUE_TYPE=service-bus
export TB_QUEUE_SERVICE_BUS_NAMESPACE_NAME=YOUR_NAMESPACE_NAME
export TB_QUEUE_SERVICE_BUS_SAS_KEY_NAME=YOUR_SAS_KEY_NAME
export TB_QUEUE_SERVICE_BUS_SAS_KEY=YOUR_SAS_KEY

# 这些参数影响每个队列的每个分区每秒的请求数。
# 计算到特定消息队列的请求数的公式为：
# ((规则引擎和核心队列数) * (每个队列的分区数) + (传输队列数)
#  + (微服务数) + (JS 执行器数)) * 1000 / POLL_INTERVAL_MS
# 例如，基于默认参数的请求数为：

# 规则引擎队列：
# 主 10 个分区 + 高优先级 10 个分区 + 按发起者顺序 10 个分区 = 30
# 核心队列 10 个分区
# 传输请求队列 + 响应队列 = 2
# 规则引擎传输通知队列 + 核心传输通知队列 = 2
# 总计 = 44
# 每秒请求数 = 44 * 1000 / 25 = 1760 个请求

# 根据案例，如果消息负载较低，您可以降低延迟并减少队列的分区/请求数。
# 通过 UI 设置规则引擎队列的参数 - 间隔 (1000) 和分区 (1)。
# 在“整体”部署中每秒适合 10 个请求的示例参数：

export TB_QUEUE_CORE_POLL_INTERVAL_MS=1000
export TB_QUEUE_CORE_PARTITIONS=2
export TB_QUEUE_RULE_ENGINE_POLL_INTERVAL_MS=1000
export TB_QUEUE_TRANSPORT_REQUEST_POLL_INTERVAL_MS=1000
export TB_QUEUE_TRANSPORT_RESPONSE_POLL_INTERVAL_MS=1000
export TB_QUEUE_TRANSPORT_NOTIFICATIONS_POLL_INTERVAL_MS=1000
export TB_QUEUE_VC_INTERVAL_MS=1000
export TB_QUEUE_VC_PARTITIONS=1
```
{: .copy-code}

您可以使用 UI 更新默认规则引擎队列配置（轮询间隔和分区）。有关 GridLinks 规则引擎队列的更多信息，请参阅 [文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。