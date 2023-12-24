现在，您可以使用负载均衡器的 IP 地址在浏览器中打开 ThingsBoard Web 界面。

您可以使用以下命令查看 HTTP 负载均衡器的 DNS 名称（`ADDRESS` 列）：
```
kubectl get ingress
```

您应该会看到类似的图片：

![image](/images/install/cloud/application-loadbalancers.png)

要通过 MQTT 或 COAP 连接到集群，您需要获取相应的服务，您可以使用以下命令执行此操作：

```
kubectl get service
```
{: .copy-code}

您应该会看到类似的图片：

![image](/images/install/cloud/network-loadbalancers.png)

有两个负载均衡器：
- tb-mqtt-loadbalancer - 用于 TCP（MQTT）协议
- tb-udp-loadbalancer - 用于 UDP（COAP/LwM2M）协议

使用负载均衡器的 `EXTERNAL-IP` 字段连接到集群。

使用以下默认凭据：

- **系统管理员**：sysadmin@gridlinks.com / sysadmin

如果您使用 `--loadDemo` 标志安装了包含演示数据的数据库，您还可以使用以下凭据：

- **租户管理员**：tenant@gridlinks.com / tenant
- **客户用户**：customer@gridlinks.com / customer

如果出现任何问题，您可以检查服务日志以查找错误。例如，要查看 ThingsBoard 节点日志，请执行以下命令：

```
kubectl logs -f tb-node-0
```

或者使用 `kubectl get pods` 查看 Pod 的状态。或者使用 `kubectl get services` 查看所有服务的状态。或者使用 `kubectl get deployments` 查看所有部署的状态。有关详细信息，请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。

执行以下命令删除 **tb-node** 和 **load-balancers**：

```
./k8s-delete-resources.sh
```

执行以下命令删除所有数据（包括数据库）：

```
./k8s-delete-all.sh
```