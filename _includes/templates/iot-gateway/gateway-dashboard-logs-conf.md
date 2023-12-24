![](/images/gateway/dashboard/gateway-dashboard-logs-conf.png)

日志 - 用于设置本地和 [远程日志](/docs/iot-gateway/guides/how-to-enable-remote-logging/) 的选项卡，它包含 3 个主要部分：
- 常规日志设置 - 此处使用 Python [logging](https://docs.python.org/3.8/library/logging.config.html) 模块的常用设置：
  - 日期格式 - 日志消息的日期格式；
  - 日志格式 - 日志消息格式。
- 远程日志记录 - 配置远程日志：
  - 远程日志 - 启用远程日志记录和从网关读取日志；
  - 日志级别。
- 本地日志记录 - 用于配置本地记录器（服务、连接器、转换器、TB 连接、存储、扩展）：
  - 日志级别；
  - 文件路径；
  - 日志保存周期；
  - 备份计数 - 如果 **备份计数** > 0，则在执行轮换时，最多保留 **备份计数** 个文件 - 最旧的文件将被删除。