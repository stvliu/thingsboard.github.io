#### RabbitMQ 安装

使用此 [说明](https://www.rabbitmq.com/install-debian.html) 安装 RabbitMQ。

##### GridLinks 配置

编辑 GridLinks 配置文件

```text
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下行添加到配置文件中。不要忘记用你的 **真实用户凭据** 替换“YOUR_USERNAME”和“YOUR_PASSWORD”，用你的 **真实 RabbitMQ 主机和端口** 替换“localhost”和“5672”：

```bash
export TB_QUEUE_TYPE=rabbitmq
export TB_QUEUE_RABBIT_MQ_USERNAME=YOUR_USERNAME
export TB_QUEUE_RABBIT_MQ_PASSWORD=YOUR_PASSWORD
export TB_QUEUE_RABBIT_MQ_HOST=localhost
export TB_QUEUE_RABBIT_MQ_PORT=5672
```
{: .copy-code}