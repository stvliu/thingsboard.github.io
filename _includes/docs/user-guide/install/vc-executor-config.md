####  Spring common parameters

| Parameter | Environment Variable | Default Value | Description |
|---|---|---|---|
| spring.main.web-environment | WEB_APPLICATION_ENABLE | false | If you enabled process metrics you should also enable 'web-environment'. |
| spring.main.web-application-type | WEB_APPLICATION_TYPE | none | If you enabled process metrics you should set 'web-application-type' to 'servlet' value. |
| spring.main.allow-circular-references | | "true" | Spring Boot configuration property that controls whether circular dependencies between beans are allowed. |

####  Server common parameters

| Parameter | Environment Variable | Default Value | Description |
|---|---|---|---|
| server.address | HTTP_BIND_ADDRESS | 0.0.0.0 | Server bind address (has no effect if web-environment is disabled). |
| server.port | HTTP_BIND_PORT | 8086 | Server bind port (has no effect if web-environment is disabled). |

####  Zookeeper connection parameters. Used for service discovery.

| Parameter | Environment Variable | Default Value | Description |
|---|---|---|---|
| zk.enabled | ZOOKEEPER_ENABLED | true | Enable/disable zookeeper discovery service. |
| zk.url | ZOOKEEPER_URL | localhost:2181 | Zookeeper connect string |
| zk.retry_interval_ms | ZOOKEEPER_RETRY_INTERVAL_MS | 3000 | Zookeeper retry interval in milliseconds |
| zk.connection_timeout_ms | ZOOKEEPER_CONNECTION_TIMEOUT_MS | 3000 | Zookeeper connection timeout in milliseconds |
| zk.session_timeout_ms | ZOOKEEPER_SESSION_TIMEOUT_MS | 3000 | Zookeeper session timeout in milliseconds |
| zk.zk_dir | ZOOKEEPER_NODES_DIR | /thingsboard | Name of the directory in zookeeper 'filesystem' |
| zk.recalculate_delay | ZOOKEEPER_RECALCULATE_DELAY_MS | 0 | The recalculate_delay property is recommended in a microservices architecture setup for rule-engine services.
 This property provides a pause to ensure that when a rule-engine service is restarted, other nodes don't immediately attempt to recalculate their partitions.
 The delay is recommended because the initialization of rule chain actors is time-consuming. Avoiding unnecessary recalculations during a restart can enhance system performance and stability. |

####  Queue configuration parameters

| Parameter | Environment Variable | Default Value | Description |
|---|---|---|---|
| queue.type | TB_QUEUE_TYPE | kafka | in-memory or kafka (Apache Kafka) or aws-sqs (AWS SQS) or pubsub (PubSub) or service-bus (Azure Service Bus) or rabbitmq (RabbitMQ) |
| queue.in_memory.stats.print-interval-ms | TB_QUEUE_IN_MEMORY_STATS_PRINT_INTERVAL_MS | 60000 | For debug lvl |
| queue.kafka.bootstrap.servers | TB_KAFKA_SERVERS | localhost:9092 | Kafka Bootstrap Servers |
| queue.kafka.ssl.enabled | TB_KAFKA_SSL_ENABLED | false | Enable/Disable SSL Kafka communication |
| queue.kafka.ssl.truststore.location | TB_KAFKA_SSL_TRUSTSTORE_LOCATION | | The location of the trust store file |
| queue.kafka.ssl.truststore.password | TB_KAFKA_SSL_TRUSTSTORE_PASSWORD | | The password of trust store file if specified |
| queue.kafka.ssl.keystore.location | TB_KAFKA_SSL_KEYSTORE_LOCATION | | The location of the key store file. This is optional for the client and can be used for two-way authentication for the client |
| queue.kafka.ssl.keystore.password | TB_KAFKA_SSL_KEYSTORE_PASSWORD | | The store password for the key store file. This is optional for the client and only needed if ‘ssl.keystore.location’ is configured. Key store password is not supported for PEM format |
| queue.kafka.ssl.key.password | TB_KAFKA_SSL_KEY_PASSWORD | | The password of the private key in the key store file or the PEM key specified in ‘keystore.key’ |
| queue.kafka.acks | TB_KAFKA_ACKS | all | The number of acknowledgments the producer requires the leader to have received before considering a request complete. This controls the durability of records that are sent. The following settings are allowed:0,1 and all |
| queue.kafka.retries | TB_KAFKA_RETRIES | 1 | Number of retries. Resend any record whose send fails with a potentially transient error |
| queue.kafka.compression.type | TB_KAFKA_COMPRESSION_TYPE | none | none or gzip |
| queue.kafka.batch.size | TB_KAFKA_BATCH_SIZE | 16384 | Default batch size. This setting gives the upper bound of the batch size to be sent |
| queue.kafka.linger.ms | TB_KAFKA_LINGER_MS | 1 | This variable creates a small amount of artificial delay—that is, rather than immediately sending out a record |
| queue.kafka.max.request.size | TB_KAFKA_MAX_REQUEST_SIZE | 1048576 | The maximum size of a request in bytes. This setting will limit the number of record batches the producer will send in a single request to avoid sending huge requests |
| queue.kafka.max.in.flight.requests.per.connection | TB_KAFKA_MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION | 5 | The maximum number of unacknowledged requests the client will send on a single connection before blocking |
| queue.kafka.buffer.memory | TB_BUFFER_MEMORY | 33554432 | The total bytes of memory the producer can use to buffer records waiting to be sent to the server |
| queue.kafka.replication_factor | TB_QUEUE_KAFKA_REPLICATION_FACTOR | 1 | The multiple copies of data over the multiple brokers of Kafka |
| queue.kafka.max_poll_interval_ms | TB_QUEUE_KAFKA_MAX_POLL_INTERVAL_MS | 300000 | The maximum delay between invocations of poll() when using consumer group management. This places an upper bound on the amount of time that the consumer can be idle before fetching more records |
| queue.kafka.max_poll_records | TB_QUEUE_KAFKA_MAX_POLL_RECORDS | 8192 | The maximum number of records returned in a single call to poll() |
| queue.kafka.max_partition_fetch_bytes | TB_QUEUE_KAFKA_MAX_PARTITION_FETCH_BYTES | 16777216 | The maximum amount of data per-partition the server will return. Records are fetched in batches by the consumer |
| queue.kafka.fetch_max_bytes | TB_QUEUE_KAFKA_FETCH_MAX_BYTES | 134217728 | The maximum amount of data the server will return. Records are fetched in batches by the consumer |
| queue.kafka.request.timeout.ms | TB_QUEUE_KAFKA_REQUEST_TIMEOUT_MS | 30000 | (30 seconds) |
| queue.kafka.session.timeout.ms | TB_QUEUE_KAFKA_SESSION_TIMEOUT_MS | 10000 | (10 seconds) |
| queue.kafka.auto_offset_reset | TB_QUEUE_KAFKA_AUTO_OFFSET_RESET | earliest | earliest, latest or none |
| queue.kafka.use_confluent_cloud | TB_QUEUE_KAFKA_USE_CONFLUENT_CLOUD | false | Enable/Disable using of Confluent Cloud |
| queue.kafka.confluent.ssl.algorithm | TB_QUEUE_KAFKA_CONFLUENT_SSL_ALGORITHM | https | The endpoint identification algorithm used by clients to validate server hostname. The default value is https |
| queue.kafka.confluent.sasl.mechanism | TB_QUEUE_KAFKA_CONFLUENT_SASL_MECHANISM | PLAIN | The mechanism used to authenticate Schema Registry requests. SASL/PLAIN should only be used with TLS/SSL as a transport layer to ensure that clear passwords are not transmitted on the wire without encryption |
| queue.kafka.confluent.sasl.config | TB_QUEUE_KAFKA_CONFLUENT_SASL_JAAS_CONFIG | org.apache.kafka.common.security.plain.PlainLoginModule required username=\"CLUSTER_API_KEY\" password=\"CLUSTER_API_SECRET\"; | Using JAAS Configuration for specifying multiple SASL mechanisms on a broker |
| queue.kafka.confluent.security.protocol | TB_QUEUE_KAFKA_CONFLUENT_SECURITY_PROTOCOL | SASL_SSL | Protocol used to communicate with brokers. Valid values are: PLAINTEXT, SSL, SASL_PLAINTEXT, SASL_SSL |
| queue.kafka.consumer-properties-per-topic.tb_ota_package.key | | max.poll.records | Key-value properties for Kafka consumer per specific topic, e.g. tb_ota_package is a topic name for ota, tb_rule_engine.sq is a topic name for default SequentialByOriginator queue. Check TB_QUEUE_CORE_OTA_TOPIC and TB_QUEUE_RE_SQ_TOPIC params |
| queue.kafka.consumer-properties-per-topic.tb_ota_package.key.value | TB_QUEUE_KAFKA_OTA_MAX_POLL_RECORDS | 10 | Example of specific consumer properties value per topic |
| queue.kafka.consumer-properties-per-topic.tb_version_control.key | | max.poll.interval.ms | Example of specific consumer properties value per topic for VC |
| queue.kafka.consumer-properties-per-topic.tb_version_control.key.value | TB_QUEUE_KAFKA_VC_MAX_POLL_INTERVAL_MS | 600000 | Example of specific consumer properties value per topic for VC |
| queue.kafka.other-inline | TB_QUEUE_KAFKA_OTHER_PROPERTIES | | In this section you can specify custom parameters (semicolon separated) for Kafka consumer/producer/admin |
| queue.kafka.topic-properties.core | TB_QUEUE_KAFKA_CORE_TOPIC_PROPERTIES | retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:1;min.insync.replicas:1 | Kafka properties for Core topics |
| queue.kafka.topic-properties.notifications | TB_QUEUE_KAFKA_NOTIFICATIONS_TOPIC_PROPERTIES | retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:1;min.insync.replicas:1 | Kafka properties for Notifications topics |
| queue.kafka.topic-properties.version-control | TB_QUEUE_KAFKA_CORE_TOPIC_PROPERTIES | retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:1;min.insync.replicas:1 | Kafka properties for Core topics |
| queue.kafka.consumer-stats.enabled | TB_QUEUE_KAFKA_CONSUMER_STATS_ENABLED | true | Prints lag between consumer group offset and last messages offset in Kafka topics |
| queue.kafka.consumer-stats.print-interval-ms | TB_QUEUE_KAFKA_CONSUMER_STATS_MIN_PRINT_INTERVAL_MS | 60000 | Statistics printing interval for Kafka's consumer-groups stats |
| queue.kafka.consumer-stats.kafka-response-timeout-ms | TB_QUEUE_KAFKA_CONSUMER_STATS_RESPONSE_TIMEOUT_MS | 1000 | Time to wait for the stats-loading requests to Kafka to finis |
| queue.aws_sqs.use_default_credential_provider_chain | TB_QUEUE_AWS_SQS_USE_DEFAULT_CREDENTIAL_PROVIDER_CHAIN | false | Use the default credentials provider for AWS SQS |
| queue.aws_sqs.access_key_id | TB_QUEUE_AWS_SQS_ACCESS_KEY_ID | YOUR_KEY | Access key ID from AWS IAM user |
| queue.aws_sqs.secret_access_key | TB_QUEUE_AWS_SQS_SECRET_ACCESS_KEY | YOUR_SECRET | Secret access key from AWS IAM user |
| queue.aws_sqs.region | TB_QUEUE_AWS_SQS_REGION | YOUR_REGION | Region from AWS account |
| queue.aws_sqs.threads_per_topic | TB_QUEUE_AWS_SQS_THREADS_PER_TOPIC | 1 | Number of threads per each AWS SQS queue in consumer |
| queue.aws_sqs.queue-properties.core | TB_QUEUE_AWS_SQS_CORE_QUEUE_PROPERTIES | VisibilityTimeout:30;MaximumMessageSize:262144;MessageRetentionPeriod:604800 | AWS SQS queue properties. VisibilityTimeout in seconds;MaximumMessageSize in bytes;MessageRetentionPeriod in seconds |
| queue.aws_sqs.queue-properties.notifications | TB_QUEUE_AWS_SQS_NOTIFICATIONS_QUEUE_PROPERTIES | VisibilityTimeout:30;MaximumMessageSize:262144;MessageRetentionPeriod:604800 | AWS SQS queue properties. VisibilityTimeout in seconds;MaximumMessageSize in bytes;MessageRetentionPeriod in seconds |
| queue.aws_sqs.queue-properties.version-control | TB_QUEUE_AWS_SQS_VC_QUEUE_PROPERTIES | VisibilityTimeout:30;MaximumMessageSize:262144;MessageRetentionPeriod:604800 | VisibilityTimeout in seconds;MaximumMessageSize in bytes;MessageRetentionPeriod in seconds |
| queue.pubsub.project_id | TB_QUEUE_PUBSUB_PROJECT_ID | YOUR_PROJECT_ID | Project ID from Google Cloud |
| queue.pubsub.service_account | TB_QUEUE_PUBSUB_SERVICE_ACCOUNT | YOUR_SERVICE_ACCOUNT | API Credentials in JSON format |
| queue.pubsub.max_msg_size | TB_QUEUE_PUBSUB_MAX_MSG_SIZE | 1048576 | in bytes |
| queue.pubsub.max_messages | TB_QUEUE_PUBSUB_MAX_MESSAGES | 1000 | Number of messages per consumer |
| queue.pubsub.queue-properties.core | TB_QUEUE_PUBSUB_CORE_QUEUE_PROPERTIES | ackDeadlineInSec:30;messageRetentionInSec:604800 | Pub/Sub properties for Core subscribers, messages which will commit after ackDeadlineInSec period can be consumed again |
| queue.pubsub.queue-properties.notifications | TB_QUEUE_PUBSUB_NOTIFICATIONS_QUEUE_PROPERTIES | ackDeadlineInSec:30;messageRetentionInSec:604800 | Pub/Sub properties for Version Control subscribers, messages which will commit after ackDeadlineInSec period can be consumed again |
| queue.pubsub.queue-properties.version-control | TB_QUEUE_PUBSUB_VC_QUEUE_PROPERTIES | ackDeadlineInSec:30;messageRetentionInSec:604800 | Pub/Sub properties for Transport Api subscribers, messages which will commit after ackDeadlineInSec period can be consumed again |
| queue.service_bus.namespace_name | TB_QUEUE_SERVICE_BUS_NAMESPACE_NAME | YOUR_NAMESPACE_NAME | Azure namespace |
| queue.service_bus.sas_key_name | TB_QUEUE_SERVICE_BUS_SAS_KEY_NAME | YOUR_SAS_KEY_NAME | Azure Service Bus Shared Access Signatures key name |
| queue.service_bus.sas_key | TB_QUEUE_SERVICE_BUS_SAS_KEY | YOUR_SAS_KEY | Azure Service Bus Shared Access Signatures key |
| queue.service_bus.max_messages | TB_QUEUE_SERVICE_BUS_MAX_MESSAGES | 1000 | Number of messages per a consumer |
| queue.service_bus.queue-properties.core | TB_QUEUE_SERVICE_BUS_CORE_QUEUE_PROPERTIES | lockDurationInSec:30;maxSizeInMb:1024;messageTimeToLiveInSec:604800 | Azure Service Bus properties for Core queues |
| queue.service_bus.queue-properties.notifications | TB_QUEUE_SERVICE_BUS_NOTIFICATIONS_QUEUE_PROPERTIES | lockDurationInSec:30;maxSizeInMb:1024;messageTimeToLiveInSec:604800 | Azure Service Bus properties for Notification queues |
| queue.service_bus.queue-properties.version-control | TB_QUEUE_SERVICE_BUS_VC_QUEUE_PROPERTIES | lockDurationInSec:30;maxSizeInMb:1024;messageTimeToLiveInSec:604800 | Azure Service Bus properties for Version Control queues |
| queue.rabbitmq.exchange_name | TB_QUEUE_RABBIT_MQ_EXCHANGE_NAME | | By default empty |
| queue.rabbitmq.host | TB_QUEUE_RABBIT_MQ_HOST | localhost | RabbitMQ host used to establish connection |
| queue.rabbitmq.port | TB_QUEUE_RABBIT_MQ_PORT | 5672 | RabbitMQ host used to establish a connection |
| queue.rabbitmq.virtual_host | TB_QUEUE_RABBIT_MQ_VIRTUAL_HOST | / | Virtual hosts provide logical grouping and separation of resources |
| queue.rabbitmq.username | TB_QUEUE_RABBIT_MQ_USERNAME | YOUR_USERNAME | Username for RabbitMQ user account |
| queue.rabbitmq.password | TB_QUEUE_RABBIT_MQ_PASSWORD | YOUR_PASSWORD | User password for RabbitMQ user account |
| queue.rabbitmq.automatic_recovery_enabled | TB_QUEUE_RABBIT_MQ_AUTOMATIC_RECOVERY_ENABLED | false | Network connection between clients and RabbitMQ nodes can fail. RabbitMQ Java client supports automatic recovery of connections and topology (queues, exchanges, bindings, and consumers) |
| queue.rabbitmq.connection_timeout | TB_QUEUE_RABBIT_MQ_CONNECTION_TIMEOUT | 60000 | The connection timeout for the RabbitMQ connection factory |
| queue.rabbitmq.handshake_timeout | TB_QUEUE_RABBIT_MQ_HANDSHAKE_TIMEOUT | 10000 | RabbitMQ has a timeout for connection handshake. When clients run in heavily constrained environments, it may be necessary to increase the timeout |
| queue.rabbitmq.queue-properties.core | TB_QUEUE_RABBIT_MQ_CORE_QUEUE_PROPERTIES | x-max-length-bytes:1048576000;x-message-ttl:604800000 | RabbitMQ properties for Core queues |
| queue.rabbitmq.queue-properties.transport-api | TB_QUEUE_RABBIT_MQ_TA_QUEUE_PROPERTIES | x-max-length-bytes:1048576000;x-message-ttl:604800000 | RabbitMQ properties for Transport API queues |
| queue.rabbitmq.queue-properties.version-control | TB_QUEUE_RABBIT_MQ_VC_QUEUE_PROPERTIES | x-max-length-bytes:1048576000;x-message-ttl:604800000 | RabbitMQ properties for Version Control queues |
| queue.partitions.hash_function_name | TB_QUEUE_PARTITIONS_HASH_FUNCTION_NAME | murmur3_128 | murmur3_32, murmur3_128 or sha256 |
| queue.core.topic | TB_QUEUE_CORE_TOPIC | tb_core | Default topic name of Kafka, RabbitMQ, etc. queue |
| queue.core.poll-interval | TB_QUEUE_CORE_POLL_INTERVAL_MS | 25 | Interval in milliseconds to poll messages by Core microservices |
| queue.core.partitions | TB_QUEUE_CORE_PARTITIONS | 10 | Amount of partitions used by Core microservices |
| queue.core.pack-processing-timeout | TB_QUEUE_CORE_PACK_PROCESSING_TIMEOUT_MS | 2000 | Timeout for processing a message pack by Core microservices |
| queue.core.ota.topic | TB_QUEUE_CORE_OTA_TOPIC | tb_ota_package | Default topic name for OTA updates |
| queue.core.ota.pack-interval-ms | TB_QUEUE_CORE_OTA_PACK_INTERVAL_MS | 60000 | The interval of processing the OTA updates for devices. Used to avoid any harm to the network due to many parallel OTA updates |
| queue.core.ota.pack-size | TB_QUEUE_CORE_OTA_PACK_SIZE | 100 | The size of OTA updates notifications fetched from the queue. The queue stores pairs of firmware and device ids |
| queue.core.usage-stats-topic | TB_QUEUE_US_TOPIC | tb_usage_stats | Stats topic name for queue Kafka, RabbitMQ, etc. |
| queue.core.stats.enabled | TB_QUEUE_CORE_STATS_ENABLED | true | Enable/disable statistics for Core microservices |
| queue.core.stats.print-interval-ms | TB_QUEUE_CORE_STATS_PRINT_INTERVAL_MS | 60000 | Statistics printing interval for Core microservices |
| queue.vc.topic | TB_QUEUE_VC_TOPIC | tb_version_control | Default topic name for Kafka, RabbitMQ, etc. |
| queue.vc.partitions | TB_QUEUE_VC_PARTITIONS | 10 | Number of partitions to associate with this queue. Used for scaling the number of messages that can be processed in parallel |
| queue.vc.poll-interval | TB_QUEUE_VC_INTERVAL_MS | 25 | Interval in milliseconds between polling of the messages if no new messages arrive |
| queue.vc.pack-processing-timeout | TB_QUEUE_VC_PACK_PROCESSING_TIMEOUT_MS | 180000 | Timeout before retrying all failed and timed-out messages from the processing pack |
| queue.vc.msg-chunk-size | TB_QUEUE_VC_MSG_CHUNK_SIZE | 250000 | Queue settings for Kafka, RabbitMQ, etc. Limit for single message size |
| vc.thread_pool_size | TB_VC_POOL_SIZE | 2 | Pool size for handling export tasks |
| vc.git.io_pool_size | TB_VC_GIT_POOL_SIZE | 3 | Pool size for handling the git IO operations |
| vc.git.repositories-folder | TB_VC_GIT_REPOSITORIES_FOLDER | ${java.io.tmpdir}/repositories | Default storing repository path |
| usage.stats.report.enabled | USAGE_STATS_REPORT_ENABLED | true | Enable/Disable the collection of statistics about API usage. Collected on a system and tenant level by default |
| usage.stats.report.enabled_per_customer | USAGE_STATS_REPORT_PER_CUSTOMER_ENABLED | false | Enable/Disable collection of statistics about API usage on a customer level |
| usage.stats.report.interval | USAGE_STATS_REPORT_INTERVAL | 10 | Interval of reporting the statistics. By default, the summarized statistics are sent every 10 seconds |
| metrics.enabled | METRICS_ENABLED | false | Enable/disable actuator metrics. |
| metrics.timer.percentiles | METRICS_TIMER_PERCENTILES | 0.5 | Metrics percentiles returned by actuator for timer metrics. List of double values (divided by ,). |
| management.endpoints.web.exposure.include | | '${METRICS_ENDPOINTS_EXPOSE:info}' | Expose metrics endpoint (use value 'prometheus' to enable prometheus metrics). |
| service.type | TB_SERVICE_TYPE | tb-vc-executor | service type |
| service.id | TB_SERVICE_ID | | Unique id for this service (autogenerated if empty) |
| notification_system.rules.deduplication_durations | TB_NOTIFICATION_RULES_DEDUPLICATION_DURATIONS | RATE_LIMITS:14400000; | Semicolon-separated deduplication durations (in millis) for trigger types. Format: 'NotificationRuleTriggerType1:123;NotificationRuleTriggerType2:456' |
```