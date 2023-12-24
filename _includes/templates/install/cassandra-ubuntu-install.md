以下列出的说明将帮助您安装 Cassandra。

```bash
# 添加 cassandra 存储库
echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee /etc/apt/sources.list.d/cassandra.sources.list
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
## Cassandra 安装
sudo apt-get install cassandra
## 工具安装
sudo apt-get install cassandra-tools
```

您可以使用 Astra DB 云，而不是安装您自己的 Cassandra。
请参阅如何将 ThingsBoard 连接到 Astra DB (/docs/user-guide/install/pe/cassandra-cloud-astra-db/)