ThingsBoard Edge 使用 PostgreSQL 数据库作为本地存储。

{% include templates/install/postgres-install-ubuntu.md %}

然后，按“Ctrl+D”返回主用户控制台并连接到数据库以创建 ThingsBoard Edge DB：

```text
psql -U postgres -d postgres -h 127.0.0.1 -W
CREATE DATABASE tb_edge;
\q
```