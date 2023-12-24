然后，按“Ctrl+D”返回主用户控制台。

配置密码后，编辑 pg_hba.conf 以使用 postgres 用户的 MD5 身份验证。

编辑 pg_hba.conf 文件：

```bash
sudo nano /var/lib/pgsql/12/data/pg_hba.conf

```
{: .copy-code}

找到以下行：

```text
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
```

将 `ident` 替换为 `md5`：

```text
host    all             all             127.0.0.1/32            md5
```

最后，您应该重新启动 PostgreSQL 服务以初始化新配置：

```bash
sudo systemctl restart postgresql-12.service

```
{: .copy-code}

连接到数据库以创建 thingsboard 数据库：

```bash
psql -U postgres -d postgres -h 127.0.0.1 -W

```
{: .copy-code}

执行创建数据库语句

```bash
CREATE DATABASE gridlinks;
\q

```
{: .copy-code}