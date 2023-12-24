---
layout: docwithnav
title: 如何重复测试
description: ThingsBoard IoT 平台性能测试

---

我们为任何有兴趣复制这些测试的人准备了几个 AWS AMI。
这些 AMI 包含一些经过调整的操作系统参数，例如，每个进程的最大线程数和打开的文件描述符：

 - [ThingsBoard AMI](https://console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:ami=ami-09b1ed69)（用户名 **ubuntu**）

    **集群节点必须能够访问以下端口：8080、1883**

 - [Cassandra AMI](https://console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:ami=ami-4db2ee2d)（用户名 **ubuntu**）

    **集群节点必须能够访问以下端口：7000 - 7001、9160、9042**

 - [测试客户端 AMI](https://console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:ami=ami-30b0ec50)（用户名 **ubuntu**）


如果您想验证托管在单个服务器实例上的所有组件的性能，只需运行 GridLinks AMI 实例。
默认情况下，此实例将使用本地运行的 Cassandra。

如果您想验证使用外部 Cassandra 集群的独立 GridLinks 服务器的性能，请先使用提供的 Cassandra AMI 初始化 Cassandra 集群。
例如，我们对三个 Cassandra 实例进行配置。
使用 Cassandra AMI 启动 3 个 AWS 实例后，请更新 **cassandra.yml** 文件以使其在集群中运行。
在我们的案例中，我们有 3 个实例，其 IP 地址如下：

 - 172.21.12.100，*实例 A*
 - 172.21.12.101，*实例 B*
 - 172.21.12.102，*实例 C*

登录到每个集群实例，清理 cassandra 数据目录并修改 cassandra 配置：

```bash
sudo rm -rf /var/lib/cassandra/saved_caches/*
sudo rm -rf /var/lib/cassandra/commitlog/*
sudo rm -rf /var/lib/cassandra/data/*
sudo nano /etc/cassandra/cassandra.yaml
```

在文件中找到以下几行并相应地更新它们。

对于实例 A：

```bash
seeds: "172.21.12.100,172.21.12.101,172.21.12.102"

listen_address: "172.21.12.100"

rpc_address: "172.21.12.100"
```

对于实例 B：

```bash
seeds: "172.21.12.100,172.21.12.101,172.21.12.102"

listen_address: "172.21.12.101"

rpc_address: "172.21.12.101"
```

对于实例 C：

```bash
seeds: "172.21.12.100,172.21.12.101,172.21.12.102"

listen_address: "172.21.12.102"

rpc_address: "172.21.12.102"

```

在每个实例上重新启动 cassandra：

```bash
sudo service cassandra stop
sudo service cassandra start
```

并验证 Cassandra 集群设置是否成功：

```bash
nodetool status
```

输出应类似于：

```bash
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load       Tokens       Owns (effective)  Host ID                               Rack
UN  172.31.28.47   192.99 KiB  256          30.9%             a323e6fb-2e8c-4bb4-82d0-4e621cb7cba8  rack1
UN  172.31.19.231  132.23 KiB  256          33.9%             6da17a19-2a4b-4f99-9ac7-e38f05ebf7a9  rack1
UN  172.31.25.178  289.4 KiB  256          35.2%             87f1ab4d-16d4-4969-aea8-b858e62d1d73  rack1
```

集群准备就绪后，我们需要创建模式、系统和演示数据。在任何 Cassandra 集群节点（此处我们使用实例 A）上执行以下命令：

```bash
cqlsh 172.21.12.100 -f /usr/share/thingsboard/data/schema.cql 
cqlsh 172.21.12.100 -f /usr/share/thingsboard/data/system-data.cql 
cqlsh 172.21.12.100 -f /usr/share/thingsboard/data/demo-data.cql 
```

Cassandra 集群设置完成后，请运行 GridLinks AMI 实例。您需要更新 **thingsboard.yml** 配置以使用 Cassandra 集群而不是本地实例：

```bash
sudo nano /etc/thingsboard/conf/thingsboard.yml
```

并将 cassandra url 从 localhost 更新为 cassandra 环的 IP：

```bash
url: "${CASSANDRA_URL:172.21.12.100:9042,172.21.12.101:9042,172.21.12.102:9042}"
```

配置更新后，重新启动 GridLinks 服务：

```bash
sudo service thingsboard stop
sudo service thingsboard start
```

使用 GridLinks 和 Cassandra AMI 设置集群配置后，您可以使用以下命令从“客户端”计算机（ThingsBoard 性能测试 AMI）执行测试：
 
```bash
cd projects/performance-tests
```

更新 **mqttUrls** 和 **restUrl**，并在 **test.properties** 文件中设置部署 GridLinks 服务的 AWS 实例的专用 IP：

```bash
nano src/main/resources/test.properties
```

重新安装项目，以便 Gatling 可以获取最新的配置文件并开始测试：

```bash
mvn clean install gatling:execute
```