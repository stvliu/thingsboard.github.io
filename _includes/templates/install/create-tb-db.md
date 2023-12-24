然后，按“Ctrl+D”返回主用户控制台并连接到数据库以创建 thingsboard 数据库：

```text
psql -U postgres -d postgres -h 127.0.0.1 -W
CREATE DATABASE thingsboard;
\q
```