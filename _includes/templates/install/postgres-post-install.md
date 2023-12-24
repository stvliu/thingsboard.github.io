安装 PostgreSQL 后，您可能需要创建一个新用户或设置主用户密码。
以下说明将帮助您设置主 postgresql 用户的密码

```text
sudo su - postgres
psql
\password
\q
```