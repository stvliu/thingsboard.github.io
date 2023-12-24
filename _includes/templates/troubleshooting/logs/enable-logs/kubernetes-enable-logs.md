对于 kubernetes 部署，我们使用 <b>ConfigMap</b> kubernetes 实体为 tb-nodes 提供 logback 配置。
因此，为了更新 <b>logback.xml</b>，您需要执行以下操作：

```bash
edit common/tb-node-configmap.yml
kubectl apply -f common/tb-node-configmap.yml
```

10 秒后，更改应应用于日志记录配置。