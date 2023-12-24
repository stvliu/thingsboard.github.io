使用 Cassandra 是一个可选步骤。
如果您计划每秒插入超过 5K 个数据点或希望优化存储空间，我们建议使用 Cassandra。

##### 配置其他节点组

配置将托管 Cassandra 实例的其他节点组。
您可以更改机器类型。建议至少使用 4 个 vCPU 和 16GB RAM。

我们将创建 **3** 个单独的节点池，每个可用区 **1** 个节点。
由于我们计划使用区域磁盘，因此我们不希望 k8s 在相应磁盘不可用的节点上启动 Pod。
这些可用区将具有相同的节点标签。我们将使用此标签来定位有状态集的部署。

```bash
gcloud container node-pools create cassandra1 --cluster=$TB_CLUSTER_NAME --zone=$GCP_ZONE --node-locations=$GCP_ZONE1 \
--node-labels=role=cassandra --num-nodes=1 --min-nodes=1 --max-nodes=1 --machine-type=e2-standard-4
gcloud container node-pools create cassandra2 --cluster=$TB_CLUSTER_NAME --zone=$GCP_ZONE --node-locations=$GCP_ZONE2 \
--node-labels=role=cassandra --num-nodes=1 --min-nodes=1 --max-nodes=1 --machine-type=e2-standard-4
gcloud container node-pools create cassandra3 --cluster=$TB_CLUSTER_NAME --zone=$GCP_ZONE --node-locations=$GCP_ZONE3 \
--node-labels=role=cassandra --num-nodes=1 --min-nodes=1 --max-nodes=1 --machine-type=e2-standard-4
```
{: .copy-code}

{% assign tbCassandraRegion = "$GCP_REGION" tbCassandraRegionComments = ": " %}
{% assign tbGcpCassandraRegion = "us-central1" %}
{% include templates/install/gcp/cassandra-k8s-common.md %}