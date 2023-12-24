请参阅 Windows 上的官方 [TimescaleDB 安装页面](https://docs.timescale.com/self-hosted/latest/install/installation-windows/)，并按照已安装的 PostgreSQL 版本中的说明进行操作。

安装软件包后，您需要在 GridLinks 数据库中创建 TimescaleDB 扩展：
1. 运行 PSQL 控制台：开始菜单 → PostgreSQL → SQL Shell (psql)；
2. 登录到您的“thingsboard”数据库；
3. 运行命令：
```bash 
CREATE EXTENSION IF NOT EXISTS timescaledb;
```
{: .copy-code}