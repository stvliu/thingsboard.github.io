定义您将在本指南后面的各种命令中使用的环境变量。

我们假设您使用的是 Linux。执行以下命令：

```bash
export AKS_RESOURCE_GROUP=ThingsBoardResources
export AKS_LOCATION=eastus
export AKS_GATEWAY=tb-gateway
export TB_CLUSTER_NAME=tb-cluster
export TB_DATABASE_NAME=tb-db
export TB_REDIS_NAME=tb-redis
echo "You variables ready to create resource group $AKS_RESOURCE_GROUP in location $AKS_LOCATION 
and cluster in it $TB_CLUSTER_NAME with database $TB_DATABASE_NAME"
```
{: .copy-code}

其中：
   - myResourceGroup - 部署和管理 Azure 资源的逻辑组。我们将在本指南的后面使用 ***AKS_RESOURCE_GROUP*** 来引用它；
   - *eastus* - 是您想要创建资源组的位置。我们将在本指南的后面使用 ***AKS_LOCATION*** 来引用它；
    您可以通过执行 *az account list-locations* 来查看所有位置列表；
   - *tb-gateway* - Azure 应用程序网关的名称；
   - *tb-cluster* - 集群名称。我们将在本指南的后面使用 ***TB_CLUSTER_NAME*** 来引用它；
   - *tb-db* 是您的数据库服务器的名称。您可以输入不同的名称。我们将在本指南的后面使用 TB_DATABASE_NAME 来引用它；