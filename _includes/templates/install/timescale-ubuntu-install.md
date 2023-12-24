请参阅 Ubuntu 发行版上的官方 [TimescaleDB 安装页面](https://docs.timescale.com/self-hosted/latest/install/installation-linux/)，并按照已安装 PostgreSQL 版本中的说明进行操作。

安装软件包后，您需要在 ThingsBoard 数据库中创建 TimescaleDB 扩展：
```bash
psql -U postgres -h localhost -d thingsboard
CREATE EXTENSION IF NOT EXISTS timescaledb;
\q
```