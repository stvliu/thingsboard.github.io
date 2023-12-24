#### RabbitMQ 安装

要安装 RabbitMQ，请使用此 [说明](https://www.rabbitmq.com/install-windows.html)。

为 ThingsBoard 队列服务创建 docker compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。不要忘记将“YOUR_USERNAME”和“YOUR_PASSWORD”替换为您的 **真实用户凭据**，“localhost”和“5672”替换为您的 **真实 RabbitMQ 主机和端口**：

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
      TB_QUEUE_TYPE: rabbitmq
      TB_QUEUE_RABBIT_MQ_USERNAME: YOUR_USERNAME
      TB_QUEUE_RABBIT_MQ_PASSWORD: YOUR_PASSWORD
      TB_QUEUE_RABBIT_MQ_HOST: localhost
      TB_QUEUE_RABBIT_MQ_PORT: 5672
    volumes:
      - mytb-data:/data
      - mytb-logs:/var/log/thingsboard
volumes:
  mytb-data:
    external: true
  mytb-logs:
    external: true
```
{: .copy-code}