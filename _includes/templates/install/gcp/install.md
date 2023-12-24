编辑“tb-node-db-configmap.yml”并用在 [步骤 5](#步骤-5-配置-Google-Cloud-SQL-PostgreSQL-实例) 中获得的值替换 **YOUR_DB_IP_ADDRESS** 和 **YOUR_DB_PASSWORD**。

```bash
nano tb-node-db-configmap.yml
```
{: .copy-code}

执行以下命令以运行安装：

```bash
./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载其他演示数据。

此命令完成后，您应该在控制台中看到下一行：

```
Installation finished successfully!
```