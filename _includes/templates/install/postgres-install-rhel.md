以下列出的说明将帮助您安装 PostgreSQL。

```bash
# 更新您的系统
sudo yum update
```
{: .copy-code}

**适用于 CentOS/RHEL 7：**

```bash
# 安装存储库 RPM：
sudo yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
# 安装软件包
sudo yum -y install epel-release yum-utils
sudo yum-config-manager --enable pgdg12
sudo yum install postgresql12-server postgresql12
# 初始化您的 PostgreSQL 数据库
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl start postgresql-12
# 可选：配置 PostgreSQL 在启动时启动
sudo systemctl enable --now postgresql-12

```
{: .copy-code}

**适用于 RHEL 8 及其衍生版本（Alma、Rocky、Oracle）：**

```bash
# 安装存储库 RPM：
sudo yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
# 安装软件包
sudo dnf -qy module disable postgresql
sudo dnf -y install postgresql12 postgresql12-server
# 初始化您的 PostgreSQL 数据库
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl start postgresql-12
# 可选：配置 PostgreSQL 在启动时启动
sudo systemctl enable --now postgresql-12

```
{: .copy-code}

{% include templates/install/postgres-post-install.md %}