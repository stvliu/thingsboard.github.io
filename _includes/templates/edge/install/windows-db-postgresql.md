ThingsBoard Edge 使用 PostgreSQL 数据库作为本地存储。

##### PostgreSQL 安装

下载安装文件（PostgreSQL 12.17 或更高版本）[此处](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)，然后按照安装说明进行操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请记住此密码。稍后会用到它。为简单起见，我们将用“postgres”替换它。

##### 创建 ThingsBoard Edge 数据库

安装完成后，启动“pgAdmin”软件并以超级用户 (postgres) 身份登录。
打开您的服务器并创建所有者为“postgres”的数据库 **tb_edge**。