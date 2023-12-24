## 集群删除

执行以下命令以删除所有 ThingsBoard pod：

```bash
./k8s-delete-resources.sh
```
{: .copy-code}

执行以下命令以删除所有 ThingsBoard pod 和 configmap：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令以删除 EKS 集群（您应该更改集群和区域的名称）：

```bash
az aks delete --resource-group myResourceGroup --name myAKSCluster
```
{: .copy-code}