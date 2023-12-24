如果您计划将 Edge 实例连接到 ThingsBoard 服务器，请配置 Edge 负载均衡器。

要创建 TCP Edge 负载均衡器，请使用以下命令应用提供的 YAML 文件：

```bash
kubectl apply -f receipts/edge-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发端口 7070 上的所有 TCP 流量。

Edge 负载均衡器配置完成后，您可以将 Edge 实例连接到 ThingsBoard 服务器。

在连接 Edge 实例之前，您需要获取 Edge 负载均衡器的外部 IP 地址。要检索此 IP 地址，请执行以下命令：

```bash
kubectl get services | grep "EXTERNAL-IP\|tb-edge-loadbalancer"
```
{: .copy-code}

您应该会看到类似于以下内容的输出：

```text
NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
tb-edge-loadbalancer   LoadBalancer   10.44.5.255   104.154.29.225   7070:30783/TCP   85m
```

记下外部 IP 地址，并在 Edge 连接参数中将其用作 **CLOUD_RPC_HOST**。