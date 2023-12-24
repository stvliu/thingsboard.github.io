对于 kubernetes 部署，我们使用 <b>ConfigMap</b> kubernetes 实体为 tb-brokers 提供 logback 配置。
因此，为了更新 **logback.xml**，您需要编辑 `tb-broker-configmap.yml` 并执行以下命令：

 ```bash
kubectl apply -f tb-broker-configmap.yml
 ```
{: .copy-code}

10 秒后，更改应应用于日志记录配置。