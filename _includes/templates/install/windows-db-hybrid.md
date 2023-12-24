{% capture hybrid-info %}
GridLinks 团队建议，如果您计划在生产环境中拥有 100 万台以上的设备或高数据摄取率（> 5000 条消息/秒），则使用混合数据库方法。
在这种情况下，GridLinks 将把时序数据存储在 Cassandra 中，同时继续使用 PostgreSQL 作为主要实体（设备/资产/仪表板/客户）。  
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

下载安装文件（PostgreSQL 12.17 或更高版本）[此处](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)，然后按照安装说明进行操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请记住此密码。稍后会用到它。为简单起见，我们将用“postgres”替换它。

##### 创建 ThingsBoard 数据库

安装完成后，启动“pgAdmin”软件并以超级用户 (postgres) 身份登录。
打开您的服务器，并创建由所有者“postgres”拥有的数据库“thingsboard”。

##### Cassandra 安装

以下列出的说明将帮助您安装 Cassandra。

- 下载 DataStax Community Edition v3.0.9
    - [MSI 安装程序（32 位）](http://downloads.datastax.com/community/datastax-community-32bit_3.0.9.msi)
    - [MSI 安装程序（64 位）](http://downloads.datastax.com/community/datastax-community-64bit_3.0.9.msi)
- 运行下载的 MSI 包。首先会显示一个初始欢迎面板，其中标识了您的安装包：

 ![image](/images/user-guide/install/windows/windows-cassandra-1.png)
 
- 单击“下一步”将转到最终用户许可协议：
 
 ![image](/images/user-guide/install/windows/windows-cassandra-2.png)
 
- 下一个面板允许您指定要安装软件的位置：
   
 ![image](/images/user-guide/install/windows/windows-cassandra-3.png)

- 设置安装目录后，安装程序将询问您希望如何处理要安装的服务：

 ![image](/images/user-guide/install/windows/windows-cassandra-4.png)

- 下一个面板启动安装过程：

 ![image](/images/user-guide/install/windows/windows-cassandra-5.png)
 
 ![image](/images/user-guide/install/windows/windows-cassandra-6.png)

- 最后一个面板询问您是否希望在有新版本软件可用时注册以获取更新：

 ![image](/images/user-guide/install/windows/windows-cassandra-7.png)
 
- 您可以在安装程序为您创建的“DataStax Community Edition”程序组中找到已安装的界面：

 ![image](/images/user-guide/install/windows/windows-cassandra-8.png)
 
- 进入 Cassandra 的主要界面是 CQL（Cassandra 查询语言）shell 实用程序，可用于对新的 Cassandra 服务器执行 CQL 命令。

##### GridLinks 配置

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。  
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}


并找到“# SQL DAO 配置”块。别忘了用你的真实 postgres 用户密码替换“postgres”：

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
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/thingsboard}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:YOUR_POSTGRES_PASSWORD_HERE}"
    hikari:
      maximumPoolSize: "${SPRING_DATASOURCE_MAXIMUM_POOL_SIZE:5}"
``` 
{: .copy-code}

找到“DATABASE_TS_TYPE”参数。将“sql”替换为“cassandra”。

```yml
    type: "${DATABASE_TS_TYPE:cassandra}" # cassandra OR sql (for hybrid mode, only this value should be cassandra)
```

您还可以调整“cassandra”配置块中的参数。

```yml
# Cassandra driver configuration parameters
cassandra:
  # Thingsboard cluster name
  cluster_name: "${CASSANDRA_CLUSTER_NAME:Thingsboard Cluster}"
  # Thingsboard keyspace name
  keyspace_name: "${CASSANDRA_KEYSPACE_NAME:thingsboard}"
  # Specify node list
  url: "${CASSANDRA_URL:127.0.0.1:9042}"
  # Enable/disable secure connection
  ssl: "${CASSANDRA_USE_SSL:false}"
  # Enable/disable JMX
  jmx: "${CASSANDRA_USE_JMX:true}"
  # Enable/disable metrics collection.
  metrics: "${CASSANDRA_DISABLE_METRICS:true}"
  # NONE SNAPPY LZ4
  compression: "${CASSANDRA_COMPRESSION:none}"
  # Specify cassandra cluster initialization timeout in milliseconds (if no hosts available during startup)
  init_timeout_ms: "${CASSANDRA_CLUSTER_INIT_TIMEOUT_MS:300000}"
  # Specify cassandra claster initialization retry interval (if no hosts available during startup)
  init_retry_interval_ms: "${CASSANDRA_CLUSTER_INIT_RETRY_INTERVAL_MS:3000}"
  max_requests_per_connection_local: "${CASSANDRA_MAX_REQUESTS_PER_CONNECTION_LOCAL:32768}"
  max_requests_per_connection_remote: "${CASSANDRA_MAX_REQUESTS_PER_CONNECTION_REMOTE:32768}"
  # Credential parameters #
  credentials: "${CASSANDRA_USE_CREDENTIALS:false}"
  # Specify your username
  username: "${CASSANDRA_USERNAME:}"
  # Specify your password
  password: "${CASSANDRA_PASSWORD:}"
```