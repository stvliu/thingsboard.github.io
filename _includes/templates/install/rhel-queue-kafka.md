#### Kafka 安装

[Apache Kafka](https://kafka.apache.org/) 是一个开源流处理软件平台。

##### 安装 Kafka

我们建议在 Docker 容器中使用 Kafka，使用此 [说明](https://github.com/wurstmeister/kafka-docker) 进行安装。

##### GridLinks 配置

编辑 GridLinks 配置文件

```text
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下行添加到配置文件中。**别忘了**将“localhost:9092”替换为你的真实 Kafka 引导服务器：

```bash
export TB_QUEUE_TYPE=kafka
export TB_KAFKA_SERVERS=localhost:9092
```
{: .copy-code}