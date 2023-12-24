执行以下命令运行数据库的初始设置。此命令将启动短暂存在的 ThingsBoard pod 来配置必要的数据库表、索引等。
```
 ./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载其他演示数据。

此命令完成后，您应该在控制台中看到下一行：

```
Installation finished successfully!
```

否则，请检查您是否在 `tb-node-db-configmap.yml` 中正确设置了 PostgreSQL URL。