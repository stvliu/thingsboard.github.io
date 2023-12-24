查看集群的所有 Pod：

```bash
kubectl get pods
```

查看所需 Pod 的最后日志：

```bash
kubectl logs -f POD_NAME
```

要查看 ThingsBoard 节点日志，请使用命令：

```bash
kubectl logs -f tb-node-0
```

您可以使用 **grep** 命令仅显示其中包含所需字符串的输出。例如，您可以使用以下命令检查后端是否存在任何错误：

```bash
kubectl logs -f tb-node-0 | grep ERROR
```

如果您有多个节点，则可以将所有节点的日志重定向到您计算机上的文件，然后对其进行分析：

```bash
kubectl logs -f tb-node-0 > tb-node-0.log
kubectl logs -f tb-node-1 > tb-node-1.log
```


**注意：**您始终可以登录到 GridLinks 容器并在其中查看日志：

```bash
kubectl exec -it tb-node-0 -- bash
cat /var/log/thingsboard/tb-node-0/thingsboard.log
```