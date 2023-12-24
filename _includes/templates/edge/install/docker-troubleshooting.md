### DNS 问题

{% include templates/troubleshooting/dns-issues.md %}

### 数据库问题

**注意** 如果你看到与 edge 无法连接到数据库相关的错误，例如

```bash
Caused by: org.postgresql.util.PSQLException: Connection to localhost:5432 refused. Check that the hostname and port are correct and that the postmaster is accepting TCP/IP connections.
mytbedge_1_f5648ad89a6e | 	at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:262)
mytbedge_1_f5648ad89a6e | 	at org.postgresql.core.ConnectionFactory.openConnection(ConnectionFactory.java:52)
mytbedge_1_f5648ad89a6e | 	at org.postgresql.jdbc.PgConnection.<init>(PgConnection.java:216)
mytbedge_1_f5648ad89a6e | 	at org.postgresql.Driver.makeConnection(Driver.java:404)
mytbedge_1_f5648ad89a6e | 	at org.postgresql.Driver.connect(Driver.java:272)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:358)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:206)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:477)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:560)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:115)
mytbedge_1_f5648ad89a6e | 	at com.zaxxer.hikari.HikariDataSource.getConnection(HikariDataSource.java:112)
mytbedge_1_f5648ad89a6e | 	at org.hibernate.engine.jdbc.connections.internal.DatasourceConnectionProviderImpl.getConnection(DatasourceConnectionProviderImpl.java:122)
mytbedge_1_f5648ad89a6e | 	at org.hibernate.internal.NonContextualJdbcConnectionAccess.obtainConnection(NonContextualJdbcConnectionAccess.java:38)
mytbedge_1_f5648ad89a6e | 	at org.hibernate.resource.jdbc.internal.LogicalConnectionManagedImpl.acquireConnectionIfNeeded(LogicalConnectionManagedImpl.java:108)
mytbedge_1_f5648ad89a6e | 	... 117 common frames omitted
mytbedge_1_f5648ad89a6e | Caused by: java.net.ConnectException: Connection refused (Connection refused)
mytbedge_1_f5648ad89a6e | 	at java.net.PlainSocketImpl.socketConnect(Native Method)
mytbedge_1_f5648ad89a6e | 	at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
mytbedge_1_f5648ad89a6e | 	at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
mytbedge_1_f5648ad89a6e | 	at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
mytbedge_1_f5648ad89a6e | 	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
mytbedge_1_f5648ad89a6e | 	at java.net.Socket.connect(Socket.java:607)
mytbedge_1_f5648ad89a6e | 	at org.postgresql.core.PGStream.<init>(PGStream.java:61)
mytbedge_1_f5648ad89a6e | 	at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:144)
mytbedge_1_f5648ad89a6e | 	... 131 common frames omitted
mytbedge_1_f5648ad89a6e | pg_ctl: could not send stop signal (PID: 10): No such process
```

停止并删除容器：

```bash
docker compose stop
docker compose rm
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果你仍然依赖 Docker Compose 作为 docker-compose（带连字符），以下是上述命令的列表：
<br>**docker-compose stop**
<br>**docker-compose rm**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

删除 **postmaster.pid** 文件：

```bash
sudo rm -rf ~/.mytb-edge-data/db/postmaster.pid
```
{: .copy-code}

再次启动容器：

```bash
docker compose up -d
docker compose logs -f mytbedge
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果你仍然依赖 Docker Compose 作为 docker-compose（带连字符），以下是上述命令的列表：
<br>**docker-compose up -d**
<br>**docker-compose logs -f mytbedge**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}