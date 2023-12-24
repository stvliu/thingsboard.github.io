{% include templates/install/queue-pub-sub-config.md %}

为 ThingsBoard 队列服务创建 docker compose 文件：

```text
nano docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。不要忘记用你的 **实际 Pub/Sub 项目 ID 和服务帐户（它是 json 文件中的全部数据）** 替换“YOUR_PROJECT_ID”、“YOUR_SERVICE_ACCOUNT”：

```yml
version: '3.0'
services:
  mytb:
    restart: always
    image: "thingsboard/tb-postgres"
    ports:
      - "8080:9090"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
    environment:
      TB_QUEUE_TYPE: pubsub
      TB_QUEUE_PUBSUB_PROJECT_ID: YOUR_PROJECT_ID
      TB_QUEUE_PUBSUB_SERVICE_ACCOUNT: YOUR_SERVICE_ACCOUNT

      # 这些参数影响每个队列的每个分区每秒的请求数。
      # 到特定消息队列的请求数根据以下公式计算：
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
      # 
      # 根据用例，如果消息负载较低，你可以权衡延迟并减少队列的分区/请求数。
      # 通过 UI 为规则引擎队列设置参数 - 间隔 (1000) 和分区 (1)。
      # 在“整体”部署中每秒适合 10 个请求的示例参数： 
      TB_QUEUE_CORE_POLL_INTERVAL_MS: 1000
      TB_QUEUE_CORE_PARTITIONS: 2
      TB_QUEUE_RULE_ENGINE_POLL_INTERVAL_MS: 1000
      TB_QUEUE_TRANSPORT_REQUEST_POLL_INTERVAL_MS: 1000
      TB_QUEUE_TRANSPORT_RESPONSE_POLL_INTERVAL_MS: 1000
      TB_QUEUE_TRANSPORT_NOTIFICATIONS_POLL_INTERVAL_MS: 1000
      TB_QUEUE_VC_INTERVAL_MS: 1000
      TB_QUEUE_VC_PARTITIONS: 1
    volumes:
      - ~/.mytb-data:/data
      - ~/.mytb-logs:/var/log/thingsboard
```
{: .copy-code}

你可以使用 UI 更新默认规则引擎队列配置。有关 ThingsBoard 规则引擎队列的更多信息，请参阅 [文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。