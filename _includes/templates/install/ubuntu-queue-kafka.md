#### Kafka 安装

[Apache Kafka](https://kafka.apache.org/) 是一个开源流处理软件平台。

##### 安装 ZooKeeper

Kafka 使用 [ZooKeeper](https://zookeeper.apache.org/)，因此您需要首先安装 ZooKeeper 服务器：

```text
sudo apt-get install zookeeper
```
{: .copy-code}

##### 安装 Kafka

```text
wget https://archive.apache.org/dist/kafka/2.6.0/kafka_2.13-2.6.0.tgz

tar xzf kafka_2.13-2.6.0.tgz

sudo mv kafka_2.13-2.6.0 /usr/local/kafka
```
{: .copy-code}

##### 设置 ZooKeeper Systemd 单元文件

为 Zookeeper 创建 systemd 单元文件：
```text
sudo nano /etc/systemd/system/zookeeper.service
```
{: .copy-code}

添加以下内容：
```bash
[Unit]
Description=Apache Zookeeper server
Documentation=http://zookeeper.apache.org
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
ExecStart=/usr/local/kafka/bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties
ExecStop=/usr/local/kafka/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
```
{: .copy-code}

##### 设置 Kafka Systemd 单元文件

为 Kafka 创建 systemd 单元文件：
```text
sudo nano /etc/systemd/system/kafka.service
```
{: .copy-code}

添加以下内容。确保将“PUT_YOUR_JAVA_PATH”**替换**为系统上安装的 Java 的**真实 JAVA_HOME 路径**，默认情况下为“/usr/lib/jvm/java-11-openjdk-xxx”：
```bash
[Unit]
Description=Apache Kafka Server
Documentation=http://kafka.apache.org/documentation.html
Requires=zookeeper.service

[Service]
Type=simple
Environment="JAVA_HOME=PUT_YOUR_JAVA_PATH"
ExecStart=/usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties
ExecStop=/usr/local/kafka/bin/kafka-server-stop.sh

[Install]
WantedBy=multi-user.target
```
{: .copy-code}
##### 启动 ZooKeeper 和 Kafka：

```text
sudo systemctl start zookeeper

sudo systemctl start kafka
```
{: .copy-code}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件

```text
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下行添加到配置文件中。**不要忘记**将“localhost:9092”替换为您的真实 Kafka 引导服务器：

```bash
export TB_QUEUE_TYPE=kafka
export TB_KAFKA_SERVERS=localhost:9092
```
{: .copy-code}