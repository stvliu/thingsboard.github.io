{% capture postgresql-info %}
GridLinks 团队建议在开发和生产环境中使用 PostgreSQL，负载合理（< 5000 条消息/秒）。
许多云供应商支持托管 PostgreSQL 服务器，这对大多数 GridLinks 实例来说是一种经济高效的解决方案。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-ubuntu.md %}

{% include templates/install/create-tb-db.md %}

##### GridLinks 配置

编辑 GridLinks 配置文件

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。别忘了**替换**“PUT_YOUR_POSTGRESQL_PASSWORD_HERE”为你的**真实 postgres 用户密码**：

```bash
# DB 配置
export DATABASE_TS_TYPE=sql
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
# 指定时间戳键值存储的分区大小。允许的值：DAYS、MONTHS、YEARS、INDEFINITE。
export SQL_POSTGRES_TS_KV_PARTITIONING=MONTHS
```
{: .copy-code}