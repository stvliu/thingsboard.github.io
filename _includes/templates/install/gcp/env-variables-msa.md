定义环境变量，您将在本指南后面的各种命令中使用它们。

我们假设您使用的是 Linux。执行以下命令：

```bash
export GCP_PROJECT=$(gcloud config get-value project)
export GCP_REGION=us-central1
export GCP_ZONE=us-central1
export GCP_ZONE1=us-central1-a
export GCP_ZONE2=us-central1-b
export GCP_ZONE3=us-central1-c
export GCP_NETWORK=default
export TB_CLUSTER_NAME={{tbClusterName}}
export TB_DATABASE_NAME=tb-db
echo "You have selected project: $GCP_PROJECT, region: $GCP_REGION, gcp zones: $GCP_ZONE1,$GCP_ZONE2,$GCP_ZONE3, network: $GCP_NETWORK, cluster: $TB_CLUSTER_NAME and database: $TB_DATABASE_NAME"
```
{: .copy-code}

其中：

* 第一行使用 gcloud 命令获取您当前的 GCP 项目 ID。我们将在本指南的后面使用 **GCP_PROJECT** 来引用它；
* *us-central1* 是可用的计算 [区域](https://cloud.google.com/compute/docs/regions-zones#available) 之一。我们将在本指南的后面使用 **GCP_REGION** 来引用它；
* *default* 是默认的 GCP 网络名称；我们将在本指南的后面使用 **;GCP_NETWORK** 来引用它；
* *tb-ce* 是您的集群的名称。您可以输入不同的名称。我们将在本指南的后面使用 **$TB_CLUSTER_NAME** 来引用它；
* *tb-db* 是您的数据库服务器的名称。您可以输入不同的名称。我们将在本指南的后面使用 **TB_DATABASE_NAME** 来引用它；