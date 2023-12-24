使用 **3** 个 **e2-standard-4** 机器类型的节点创建区域集群。

执行以下命令（推荐）：

```bash
gcloud container clusters create $TB_CLUSTER_NAME \
--release-channel stable \
--region $GCP_REGION \
--network=$GCP_NETWORK \
--node-locations $GCP_ZONE1,$GCP_ZONE2,$GCP_ZONE3 \
--enable-ip-alias \
--num-nodes=1 \
--node-labels=role=main \
--machine-type=e2-standard-4
```
{: .copy-code}

或者，您可以使用 [此](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-regional-cluster) 指南进行自定义集群设置。