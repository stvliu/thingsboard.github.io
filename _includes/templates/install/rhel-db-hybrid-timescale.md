{% capture hybrid-timescale-info %}
ThingsBoard 团队建议仅将 Timescale 数据库用于已经在生产中使用 TimescaleDB 的公司。
在这种情况下，ThingsBoard 将把时序数据存储在 TimescaleDB Hypertable 中，同时继续使用 PostgreSQL 作为主要实体（设备/资产/仪表板/客户）。
{% endcapture %}
{% include templates/info-banner.md content=hybrid-timescale-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-rhel.md %}

{% include templates/install/create-tb-db-rhel.md %}

##### TimescaleDB 安装

{% include templates/install/timescale-rhel-install.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。不要忘记将“PUT_YOUR_POSTGRESQL_PASSWORD_HERE”**替换**为您的**真实 postgres 用户密码**：

```bash
# DB 配置
export DATABASE_TS_TYPE=timescale
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
# 指定数据块存储的时间间隔。请注意，此值只能设置一次。
export SQL_TIMESCALE_CHUNK_TIME_INTERVAL=604800000 # 毫秒数。当前值对应于一周。
```
{: .copy-code}