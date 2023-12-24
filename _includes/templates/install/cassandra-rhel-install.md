以下列出的说明将帮助您安装 Cassandra。

```bash
# 添加 cassandra 存储库
cat << EOF | sudo tee /etc/yum.repos.d/cassandra.repo > /dev/null
[cassandra]
name=Apache Cassandra
baseurl=https://redhat.cassandra.apache.org/41x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.apache.org/cassandra/KEYS
EOF

# Cassandra 安装
sudo yum install cassandra
# 工具安装
sudo yum install cassandra-tools
# 启动 Cassandra
sudo service cassandra start
# 配置数据库在操作系统启动时自动启动。
sudo chkconfig cassandra on
```

您可以使用 Astra DB 云而不是安装您自己的 Cassandra。
请参阅如何将 [ThingsBoard 连接到 Astra DB](/docs/user-guide/install/pe/cassandra-cloud-astra-db/)