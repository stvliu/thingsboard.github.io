{% capture hybrid-info %}
ThingsBoard 团队建议，如果您计划在生产环境中拥有 100 万台以上的设备或高数据摄取率（> 5000 条消息/秒），则使用混合数据库方法。
在这种情况下，ThingsBoard 将把时序数据存储在 Cassandra 中，同时继续使用 PostgreSQL 作为主要实体（设备/资产/仪表板/客户）。
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-ubuntu.md %}

{% include templates/install/create-tb-db.md %}

##### Cassandra 安装

{% include templates/install/cassandra-ubuntu-install.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。别忘了将“PUT_YOUR_POSTGRESQL_PASSWORD_HERE”**替换**为您的**真实 postgres 用户密码**：

```bash
# DB Configuration 
export DATABASE_TS_TYPE=cassandra
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
``` 
{: .copy-code}

您可以选择性地添加以下参数，以重新配置 ThingsBoard 实例以连接到外部 Cassandra 节点：

```bash
export CASSANDRA_CLUSTER_NAME=Thingsboard Cluster
export CASSANDRA_KEYSPACE_NAME=thingsboard
export CASSANDRA_URL=127.0.0.1:9042
export CASSANDRA_USE_CREDENTIALS=false
export CASSANDRA_USERNAME=
export CASSANDRA_PASSWORD=
```
{: .copy-code}