{% include templates/install/queue-confluent-cloud-config.md %}

为 ThingsBoard 队列服务创建 docker compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。别忘了用你的真实 Confluent Cloud 引导服务器替换“CLUSTER_API_KEY”、“CLUSTER_API_SECRET”和“localhost:9092”：

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
      TB_QUEUE_TYPE: kafka
      TB_KAFKA_SERVERS: localhost:9092
      TB_QUEUE_KAFKA_REPLICATION_FACTOR: 3
      TB_QUEUE_KAFKA_USE_CONFLUENT_CLOUD: true
      TB_QUEUE_KAFKA_CONFLUENT_SASL_JAAS_CONFIG: org.apache.kafka.common.security.plain.PlainLoginModule required username="CLUSTER_API_KEY" password="CLUSTER_API_SECRET";}

      # 这些参数影响每个分区每秒从每个队列发出的请求数。
      # 特定消息队列的请求数根据以下公式计算：
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
      # 根据用例，如果消息负载较低，你可以权衡延迟并减少分区/请求到队列的数量。
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
      - mytb-data:/data
      - mytb-logs:/var/log/thingsboard
volumes:
  mytb-data:
    external: true
  mytb-logs:
    external: true
```
{: .copy-code}\

你可以使用 UI 更新默认规则引擎队列配置。有关 ThingsBoard 规则引擎队列的更多信息，请参阅[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)。