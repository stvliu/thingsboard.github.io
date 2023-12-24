以下列出的说明将帮助您安装 PostgreSQL。

```bash
# 如果尚未安装，安装 **wget**：
sudo apt install -y wget

# 导入存储库签名密钥：
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# 将存储库内容添加到您的系统：
echo "deb https://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list

# 安装并启动 postgresql 服务：
sudo apt update
sudo apt -y install postgresql
sudo service postgresql start
```
{: .copy-code}

{% include templates/install/postgres-post-install.md %}