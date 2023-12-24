在执行初始安装之前，您可以配置与 ThingsBoard 一起使用的数据库类型。
为了设置数据库类型，请更改 `.env` 文件中 `DATABASE` 变量的值：

```bash
nano .env
```
{: .copy-code}

为以下之一：

- `postgres` - 使用 PostgreSQL 数据库；
- `hybrid` - 将 PostgreSQL 用于实体数据库，将 Cassandra 用于时序数据库；

**注意**：根据数据库类型，将部署相应的 docker 服务（有关详细信息，请参阅 `docker-compose.postgres.yml`、`docker-compose.hybrid.yml`）。