下载安装包：

```bash
wget https://dist.docs.codingas.com/tb-azure-integration-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

将集成安装为服务：

```bash
sudo rpm -Uvh tb-azure-integration-{{ site.release.pe_ver }}.rpm
```
{: .copy-code}

使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/tb-azure-integration/conf/tb-azure-integration.conf
``` 
{: .copy-code}

找到以下配置块：

```bash
# UNCOMMENT NEXT LINES AND PUT YOUR CONNECTION PARAMETERS:
# export RPC_HOST=thingsboard.cloud
# export RPC_PORT=9090
# export INTEGRATION_ROUTING_KEY=YOUR_INTEGRATION_KEY
# export INTEGRATION_SECRET=YOUR_INTEGRATION_SECRET
```

并输入您的配置参数。请不要忘记取消注释 export 语句。请参阅以下示例：

```bash
# UNCOMMENT NEXT LINES AND PUT YOUR CONNECTION PARAMETERS:
export RPC_HOST=thingsboard.cloud
export RPC_PORT=9090
export INTEGRATION_ROUTING_KEY=b75**************************34d
export INTEGRATION_SECRET=vna**************mik
```

执行以下命令启动 ThingsBoard：

```bash
sudo service tb-azure-integration start
```
{: .copy-code}

- **高级配置**

可以在 yml 配置文件中查找其他配置参数。

使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/tb-azure-integration/conf/tb-azure-integration.conf
``` 
{: .copy-code} 

执行此命令后，您可以打开位于此处 `/var/log/tb-azure-integration/` 的日志。您应该会看到一些 INFO 日志消息，其中包含从服务器收到的最新集成配置。