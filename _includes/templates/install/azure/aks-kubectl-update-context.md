当集群创建后，我们可以使用以下命令将 kubectl 连接到它：
```
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

为了验证，您可以执行以下命令：
```
kubectl get nodes
```
{: .copy-code}

您应该会看到集群的节点列表