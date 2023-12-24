使用 Cassandra 是一个可选步骤。
如果您计划每秒插入超过 5K 个数据点或希望优化存储空间，我们建议您使用 Cassandra。

##### 配置其他节点池

配置将托管 Cassandra 实例的其他节点池。
您可以更改机器类型。建议至少使用 4 个 vCPU 和 16GB RAM。

我们将在每个区域创建一个 **3** 个单独的节点池，每个节点 **1** 个。
由于我们计划使用区域磁盘，因此我们不希望 k8s 在相应磁盘不可用的节点上启动 Pod。
这些区域将具有相同的节点标签。我们将使用此标签来定位有状态集的部署。

因此，请为您的位置在三个区域中定义 **3** 个节点池：

```bash
az aks nodepool add --resource-group $AKS_RESOURCE_GROUP --cluster-name $TB_CLUSTER_NAME --name tbcassandra1 --node-count 1 --zones 1 --labels role=cassandra
az aks nodepool add --resource-group $AKS_RESOURCE_GROUP --cluster-name $TB_CLUSTER_NAME --name tbcassandra2 --node-count 1 --zones 2 --labels role=cassandra
az aks nodepool add --resource-group $AKS_RESOURCE_GROUP --cluster-name $TB_CLUSTER_NAME --name tbcassandra3 --node-count 1 --zones 3 --labels role=cassandra
```
{: .copy-code}

{% assign tbCassandraRegion = "dc1" %}
{% include templates/install/azure/cassandra-k8s-common.md %}