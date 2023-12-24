使用 Cassandra 是一个可选步骤。
如果您计划每秒插入超过 5K 个数据点或希望优化存储空间，我们建议您使用 Cassandra。

##### 配置其他节点组

配置将托管 Cassandra 实例的其他节点组。
您可以更改机器类型。建议至少使用 4 个 vCPU 和 16GB RAM。

我们将创建 **3** 个单独的节点池，每个可用区 **1** 个节点。
由于我们计划使用 ebs 磁盘，我们不希望 k8s 在相应磁盘不可用的可用区中启动 pod。
这些可用区将具有相同的节点标签。我们将使用此标签来定位有状态集的部署。

在不同的可用区中部署 **3** 个 **m5.xlarge** 类型的节点。您可以更改可用区以对应您的区域：

```bash
eksctl create nodegroup --config-file=<path> --include='cassandra-*'
```
{: .copy-code}

{% assign tbCassandraRegionComments = ". 别忘了将 *YOUR_AWS_REGION* 替换为您的 AWS 区域的名称。 " %}
{% assign tbCassandraRegion = "YOUR_AWS_REGION" %}
{% include templates/install/cassandra-k8s-common.md %}