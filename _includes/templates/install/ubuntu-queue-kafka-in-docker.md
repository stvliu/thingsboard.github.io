{% include templates/install/queue-kafka-in-docker.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件

```text
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下行添加到配置文件中。不要忘记将“localhost:9092”替换为 **你的真实 Kafka 引导服务器**：

```bash
export TB_QUEUE_TYPE=kafka
export TB_KAFKA_SERVERS=localhost:9092
```