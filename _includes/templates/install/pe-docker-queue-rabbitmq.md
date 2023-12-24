要安装 RabbitMQ，请使用此 [说明](https://www.rabbitmq.com/install-debian.html)。

为 ThingsBoard 队列服务创建 docker compose 文件：

```text
nano docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件中。不要忘记将“YOUR_USERNAME”和“YOUR_PASSWORD”替换为您的 **真实用户凭据**，“localhost”和“5672”替换为您的 **真实 RabbitMQ 主机和端口**，并将“PUT_YOUR_LICENSE_SECRET_HERE”替换为 **您在第一步中获得的许可证密钥**：

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
      - ~/.mytbpe-data:/data
      - ~/.mytbpe-logs:/var/log/thingsboard
  postgres:
    restart: always
    image: "postgres:12"
    ports:
    - "5432"
    environment:
      POSTGRES_DB: thingsboard
      POSTGRES_PASSWORD: postgres
    volumes:
      - ~/.mytbpe-data/db:/var/lib/postgresql/data
```
{: .copy-code}