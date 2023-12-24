{% capture hybrid-info %}
GridLinks 团队建议仅将 Timescale 数据库用于已经在生产中使用 TimescaleDB 的公司。
在这种情况下，GridLinks 将把时序数据存储在 TimescaleDB Hypertable 中，同时继续使用 PostgreSQL 作为主要实体（设备/资产/仪表板/客户）。  
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

下载安装文件（PostgreSQL 12.17 或更高版本）[此处](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)，然后按照安装说明进行操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请记住此密码。稍后会用到它。为简单起见，我们将用“postgres”代替它。

##### 创建 ThingsBoard 数据库

安装完成后，启动“pgAdmin”软件并以超级用户 (postgres) 身份登录。
打开服务器并创建所有者为“postgres”的数据库“thingsboard”。

##### TimescaleDB 安装

{% include templates/install/timescale-windows-install.md %}

##### GridLinks 配置

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}


并找到“# SQL DAO 配置”块。别忘了用你的真实 postgres 用户密码替换“postgres”：

```yml
# SQL DAO 配置
spring:
  data:
    jpa:
      repositories:
        enabled: "true"
  jpa:
    open-in-view: "false"
    hibernate:
      ddl-auto: "none"
  datasource:
    driverClassName: "${SPRING_DRIVER_CLASS_NAME:org.postgresql.Driver}"
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/gridlinks}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:YOUR_POSTGRES_PASSWORD_HERE}"
    hikari:
      maximumPoolSize: "${SPRING_DATASOURCE_MAXIMUM_POOL_SIZE:5}"
``` 
{: .copy-code}

找到“DATABASE_TS_TYPE”参数。将“sql”替换为“timescale”。

```yml
      ts:
        type: "${DATABASE_TS_TYPE:sql}" # cassandra, sql, or timescale (for hybrid mode, DATABASE_TS_TYPE value should be cassandra, or timescale)
    
    # 注意：timescale 仅适用于 DATABASE_ENTITIES_TYPE 的 postgreSQL 数据库。
```

您可以选择调整引用 Timescale DB 配置的参数：“sql”配置块内的“timescale”配置块。

```yml
# SQL 配置参数
sql:
    timescale:
      # 指定新数据块存储的时间间隔。
      chunk_time_interval: "${SQL_TIMESCALE_CHUNK_TIME_INTERVAL:604800000}"
```