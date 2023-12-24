要安装 RabbitMQ，请使用此 [说明](https://www.rabbitmq.com/install-windows.html)。

为 GridLinks 队列服务创建 docker compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。别忘了用你的 **真实用户凭据**替换“YOUR_USERNAME”和“YOUR_PASSWORD”，用你的 **真实 RabbitMQ 主机和端口**替换“localhost”和“5672”，用你在第一步中获得的 **许可证密钥**替换“PUT_YOUR_LICENSE_SECRET_HERE”：

```yml
version: '3.0'
services:
  mytbpe:
    restart: always
    image: "thingsboard/tb-pe:{{ site.release.pe_full_ver }}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
    environment:
      TB_QUEUE_TYPE: rabbitmq
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/thingsboard
      TB_QUEUE_RABBIT_MQ_USERNAME: YOUR_USERNAME
      TB_QUEUE_RABBIT_MQ_PASSWORD: YOUR_PASSWORD
      TB_QUEUE_RABBIT_MQ_HOST: localhost
      TB_QUEUE_RABBIT_MQ_PORT: 5672
      TB_LICENSE_SECRET: PUT_YOUR_LICENSE_SECRET_HERE
      TB_LICENSE_INSTANCE_DATA_FILE: /data/license.data
    volumes:
      - mytbpe-data:/data
      - mytbpe-logs:/var/log/thingsboard
  postgres:
    restart: always
    image: "postgres:12"
    ports:
    - "5432"
    environment:
      POSTGRES_DB: thingsboard
      POSTGRES_PASSWORD: postgres
    volumes:
      - mytbpe-data-db:/var/lib/postgresql/data
volumes:
  mytbpe-data:
    external: true
  mytbpe-logs:
    external: true
  mytbpe-data-db:
    external: true
```
{: .copy-code}