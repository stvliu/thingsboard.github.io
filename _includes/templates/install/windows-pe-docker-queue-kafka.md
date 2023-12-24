[Apache Kafka](https://kafka.apache.org/) 是一个开源流处理软件平台。

为 GridLinks 队列服务创建 docker compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件。不要忘记将“PUT_YOUR_LICENSE_SECRET_HERE”替换为**第一步获得的许可证密钥**：

```yml
version: '3.0'
services:
  zookeeper:
    restart: always
    image: "zookeeper:3.5"
    ports:
      - "2181:2181"
    environment:
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=zookeeper:2888:3888;zookeeper:2181
  kafka:
    restart: always
    image: wurstmeister/kafka
    depends_on:
      - zookeeper
    ports:
      - "9092:9092"
    environment:
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_LISTENERS: INSIDE://:9093,OUTSIDE://:9092
      KAFKA_ADVERTISED_LISTENERS: INSIDE://:9093,OUTSIDE://kafka:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: INSIDE
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
  mytbpe:
    restart: always
    image: "thingsboard/tb-pe:{{ site.release.pe_full_ver }}"
    depends_on:
      - kafka
    ports:
      - "8080:8080"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
    environment:
      TB_QUEUE_TYPE: kafka
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/thingsboard
      TB_KAFKA_SERVERS: kafka:9092
      TB_LICENSE_SECRET: PUT_YOUR_LICENSE_SECRET_HERE
      TB_LICENSE_INSTANCE_DATA_FILE: /data/license.data
    volumes:
      - mytbpe-data:/data
      - mytbpe-logs:/var/log/gridlinks
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