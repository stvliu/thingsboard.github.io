- **高级配置**

有关可能的配置参数、相应的环境变量及其默认值的列表，请参阅下面的配置 yml 文件。
例如，集成中使用的集成的默认客户端 ID 为“*remote*”，可以通过设置“*RPC_CLIENT_ID*”环境变量来更改。


```bash
server:
  # 服务器绑定地址
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
  # 服务器绑定端口
  port: "${HTTP_BIND_PORT:8082}"

integration:
  routingKey: "${INTEGRATION_ROUTING_KEY:PUT_YOUR_ROUTING_KEY_HERE}"
  secret: "${INTEGRATION_SECRET:PUT_YOUR_SECRET_HERE}"
  # 允许连接到本地主机资源。例如，本地 MQTT 代理等。
  allow_local_network_hosts: "${INTEGRATION_ALLOW_LOCAL_NETWORK_HOSTS:true}"
  statistics:
    # 启用/禁用集成统计信息
    enabled: "${INTEGRATION_STATISTICS_ENABLED:true}"
    # 发送统计信息间隔。默认值是每小时一次
    persist_frequency: "${INTEGRATION_STATISTICS_PERSIST_FREQUENCY:3600000}"

storage:
  # 存储数据文件的文件夹的位置
  data_folder_path: "${INTEGRATION_STORAGE_DATA_FOLDER_PATH:./}"
  # 要维护的最大数据文件数量
  max_file_count: "${INTEGRATION_STORAGE_MAX_FILE_COUNT:100}"
  # 每个数据文件中的最大记录数
  max_records_per_file: "${INTEGRATION_STORAGE_MAX_RECORDS_PER_FILE:30}"
  # 数据文件持久化之间的最大记录数
  max_records_between_fsync: "${INTEGRATION_STORAGE_MAX_RECORDS_BETWEEN_FSYNC:100}"
  # 上传块的大小
  max_read_records_count: "${INTEGRATION_STORAGE_MAX_READ_RECORDS_COUNT:50}"
  # 没有新记录时的休眠间隔
  no_read_records_sleep: "${INTEGRATION_STORAGE_NO_READ_RECORDS_SLEEP:1000}"

executors:
  # 处理传入消息和任务的线程池大小
  thread_pool_size: "${EXECUTORS_SIZE:1}"
  # 重新连接到 ThingsBoard 的超时时间
  reconnect_timeout: "${EXECUTORS_RECONNECT_TIMEOUT:3000}" # 以毫秒为单位

rpc:
  # ThingsBoard 服务器的主机
  host: "${RPC_HOST:thingsboard.cloud}"
  # ThingsBoard 服务器的端口
  port: "${RPC_PORT:9090}"
  # 无回复超时
  timeout: "${RPC_TIMEOUT:5}" # 通道终止的超时时间（以秒为单位）
  # RPC 客户端的 ID
  client_id: "${RPC_CLIENT_ID:remote}"
  ssl:
    # SSL 启用/禁用
    enabled: "${RPC_SSL_ENABLED:false}"
    # SSL 证书
    cert: "${RPC_SSL_CERT:roots.pem}"

js:
  evaluator: "${JS_EVALUATOR:local}"
  # 内置 JVM JavaScript 环境属性
  local:
    # 使用沙盒（安全）JVM JavaScript 环境
    use_js_sandbox: "${USE_LOCAL_JS_SANDBOX:true}"
    # 为 JavaScript 沙盒资源监视器指定线程池大小
    monitor_thread_pool_size: "${LOCAL_JS_SANDBOX_MONITOR_THREAD_POOL_SIZE:4}"
    # 允许脚本执行的最大 CPU 时间（以毫秒为单位）
    max_cpu_time: "${LOCAL_JS_SANDBOX_MAX_CPU_TIME:5000}"
    # JavaScript 将被列入黑名单之前允许的最大 JavaScript 执行错误数
    max_errors: "${LOCAL_JS_SANDBOX_MAX_ERRORS:3}"

service:
  type: "${TB_SERVICE_TYPE:tb-integration}"
```