使用 **1** 个 **e2-standard-4** 机器类型的节点创建区域集群。

执行以下命令（推荐）：

```bash
gcloud container clusters create $TB_CLUSTER_NAME \
--release-channel stable \
--zone $GCP_ZONE \
--node-locations $GCP_ZONE \
--network=$GCP_NETWORK \
--enable-ip-alias \
--num-nodes=1 \
--node-labels=role=main \
--machine-type=e2-standard-4
```
{: .copy-code}

或者，您可以使用 [此](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster) 指南进行自定义集群设置。