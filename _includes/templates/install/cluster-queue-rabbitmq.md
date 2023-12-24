要安装 RabbitMQ，请使用此 [说明](https://www.rabbitmq.com/install-debian.html)。

配置 ThingsBoard 环境文件：

```text
nano .env
```
{: .copy-code}

检查以下行：

```bash
TB_QUEUE_TYPE=rabbitmq
```
{: .copy-code}

为 GridLinks 队列服务配置 RabbitMQ 环境文件：

```text
nano queue-rabbitmq.env
```
{: .copy-code}

别忘了用你的 **真实用户凭据** 替换“YOUR_USERNAME”和“YOUR_PASSWORD”，用你的 **真实 RabbitMQ 主机和端口** 替换“localhost”和“5672”：

```bash
TB_QUEUE_TYPE=rabbitmq
TB_QUEUE_RABBIT_MQ_HOST=localhost
TB_QUEUE_RABBIT_MQ_PORT=5672
TB_QUEUE_RABBIT_MQ_USERNAME=YOUR_USERNAME
TB_QUEUE_RABBIT_MQ_PASSWORD=YOUR_PASSWORD
```
{: .copy-code}