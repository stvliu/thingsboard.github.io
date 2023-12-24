{% include templates/install/queue-service-bus-config.md %}

配置 ThingsBoard 环境文件：

```text
nano .env
```
{: .copy-code}

检查以下行：

```bash
TB_QUEUE_TYPE=service-bus
```
{: .copy-code}

为 ThingsBoard 队列服务配置 Service Bus 环境文件：

```text
nano queue-service-bus.env
```
{: .copy-code}

别忘了将“YOUR_NAMESPACE_NAME”替换为你的 **实际 Service Bus 命名空间名称**，并将“YOUR_SAS_KEY_NAME”、“YOUR_SAS_KEY”替换为你的 **实际 Service Bus 凭据。注意：“YOUR_SAS_KEY_NAME”是“SAS 策略”，“YOUR_SAS_KEY”是“SAS 策略主密钥”：**

```bash
TB_QUEUE_TYPE=service-bus
TB_QUEUE_SERVICE_BUS_NAMESPACE_NAME=YOUR_NAMESPACE_NAME
TB_QUEUE_SERVICE_BUS_SAS_KEY_NAME=YOUR_SAS_KEY_NAME
TB_QUEUE_SERVICE_BUS_SAS_KEY=YOUR_SAS_KEY

# 这些参数会影响每个队列的每个分区每秒的请求数。
# 计算到特定消息队列的请求数的公式如下：
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

# 根据用例，如果消息负载较低，你可以权衡延迟并减少队列的分区/请求数。
# 在“整体”部署中每秒适合 10 个请求的示例参数：

TB_QUEUE_CORE_POLL_INTERVAL_MS=1000
TB_QUEUE_CORE_PARTITIONS=2
TB_QUEUE_RULE_ENGINE_POLL_INTERVAL_MS=1000
TB_QUEUE_RE_MAIN_POLL_INTERVAL_MS=1000
TB_QUEUE_RE_MAIN_PARTITIONS=2
TB_QUEUE_RE_HP_POLL_INTERVAL_MS=1000
TB_QUEUE_RE_HP_PARTITIONS=1
TB_QUEUE_RE_SQ_POLL_INTERVAL_MS=1000
TB_QUEUE_RE_SQ_PARTITIONS=1
TB_QUEUE_TRANSPORT_REQUEST_POLL_INTERVAL_MS=1000
TB_QUEUE_TRANSPORT_RESPONSE_POLL_INTERVAL_MS=1000
TB_QUEU_TRANSPORT_NOTIFICATIONS_POLL_INTERVAL_MS=1000
```