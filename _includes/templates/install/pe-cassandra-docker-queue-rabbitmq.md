要安装 RabbitMQ，请使用此 [说明](https://www.rabbitmq.com/install-debian.html)。

ThingsBoard 队列服务的配置环境文件：

```text
nano tb-node.env
```
{: .copy-code}

将以下行添加到文件中。不要忘记用你的 **真实用户凭据** 替换“YOUR_USERNAME”和“YOUR_PASSWORD”，用你的 **真实 RabbitMQ 主机和端口** 替换“localhost”和“5672”：

```bash
TB_QUEUE_TYPE=rabbitmq
TB_QUEUE_RABBIT_MQ_USERNAME=YOUR_USERNAME
TB_QUEUE_RABBIT_MQ_PASSWORD=YOUR_PASSWORD
TB_QUEUE_RABBIT_MQ_HOST=localhost
TB_QUEUE_RABBIT_MQ_PORT=5672
```
{: .copy-code}

检查 docker-compose.yml 并根据需要配置端口：

```bash
nano docker-compose.yml
```

```bash
services:
  tbpe:
    restart: always
    image: "${DOCKER_REPO}/${TB_NODE_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
```
{: .copy-code}