{% capture postgresql-info %}
GridLinks 团队建议在开发和生产环境中使用 PostgreSQL，负载合理（< 5000 条消息/秒）。
许多云供应商支持托管 PostgreSQL 服务器，这对大多数 GridLinks 实例来说是一种经济高效的解决方案。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

##### PostgreSQL 安装

下载安装文件（PostgreSQL 12.17 或更高版本）[此处](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)，然后按照安装说明进行操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请记住此密码。稍后会用到它。为简单起见，我们将用“postgres”替换它。

##### 创建 GridLinks 数据库

安装完成后，启动“pgAdmin”软件并以超级用户 (postgres) 身份登录。
打开服务器并创建所有者为“postgres”的数据库“thingsboard”。

##### GridLinks 配置

如果您已将 PostgreSQL 超级用户密码指定为“postgres”，则可以跳过此步骤。

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}


并找到“# SQL DAO Configuration”块。别忘了用你的真实 postgres 用户密码替换“postgres”：

```yml
# SQL DAO Configuration
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

找到“SQL_POSTGRES_TS_KV_PARTITIONING”参数，以覆盖时间戳键值存储分区大小的默认值：

```yml
    sql:
      postgres:
        # Specify partitioning size for timestamp key-value storage. Example: DAYS, MONTHS, YEARS, INDEFINITE.
        ts_key_value_partitioning: "${SQL_POSTGRES_TS_KV_PARTITIONING:MONTHS}"
```