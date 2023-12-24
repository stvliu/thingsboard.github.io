#### RabbitMQ 安装

要安装 RabbitMQ，请使用此 [说明](https://www.rabbitmq.com/install-windows.html)。

##### GridLinks 配置


以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}

并找到“queue:”块。确保队列类型为“rabbitmq”，不要忘记用你的 **真实用户凭据** 替换“YOUR_USERNAME”和“YOUR_PASSWORD”，用你的 **真实 RabbitMQ 主机和端口** 替换“localhost”和“5672”：

```yml
queue:
  type: "${TB_QUEUE_TYPE:rabbitmq}"
...
  rabbitmq:
    exchange_name: "${TB_QUEUE_RABBIT_MQ_EXCHANGE_NAME:}"
    host: "${TB_QUEUE_RABBIT_MQ_HOST:localhost}"
    port: "${TB_QUEUE_RABBIT_MQ_PORT:5672}"
    virtual_host: "${TB_QUEUE_RABBIT_MQ_VIRTUAL_HOST:/}"
    username: "${TB_QUEUE_RABBIT_MQ_USERNAME:YOUR_USERNAME}"
    password: "${TB_QUEUE_RABBIT_MQ_PASSWORD:YOUR_PASSWORD}"
    automatic_recovery_enabled: "${TB_QUEUE_RABBIT_MQ_AUTOMATIC_RECOVERY_ENABLED:false}"
    connection_timeout: "${TB_QUEUE_RABBIT_MQ_CONNECTION_TIMEOUT:60000}"
    handshake_timeout: "${TB_QUEUE_RABBIT_MQ_HANDSHAKE_TIMEOUT:10000}"
    queue-properties:
```