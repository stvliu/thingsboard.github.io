### 使用 PgAdmin 监控 PostgreSQL

为了监控 PostgreSQL 数据库，我们将使用 pgadmin。以下是 [下载和安装 pgadmin](https://www.pgadmin.org/download/) 的方法。

打开 pgadmin

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-starting.png)

创建一个新的连接，如下所示。例如，我们将连接到具有 SSH 隧道功能的 AWS EC2 实例。在这种情况下，主机名是 localhost。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-database-server-connect-general.png)

默认的 PostgreSQL 用户是 thingsboard，默认密码是 postgres。请在此处输入您的凭据，而不是默认凭据。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-database-server-connect-connection.png)

要使用 SSH 隧道，请为 AWS EC2 实例输入您的 Thingsboard 实例 IP 和身份文件（与从终端连接时使用的相同）。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-database-server-connect-ssh-tunnel.png)

结果，您可以看到具有实时 PostgreSQL 指标的仪表板。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-dashboard.png)

注意：如果您在与主机网络隔离的容器中运行 PostgreSQL，您的连接将带有内部 docker IP，您应该在 [pg_hba.conf](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html) 文件中配置安全配置。