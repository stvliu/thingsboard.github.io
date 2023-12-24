在创建 AKS 集群之前，我们需要创建 Azure 资源组，为此我们将使用 Azure CLI
```
az group create --name $AKS_RESOURCE_GROUP --location $AKS_LOCATION
```
{: .copy-code}

有关 `az group` 的更多信息，请使用 [此](https://docs.microsoft.com/en-us/cli/azure/group) 链接。

创建资源组后，我们可以使用以下命令在其中创建 AKS 集群：
```
az aks create --resource-group $AKS_RESOURCE_GROUP \
    --name $TB_CLUSTER_NAME \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --appgw-name $AKS_GATEWAY \
    --appgw-subnet-cidr "10.2.0.0/16" \
    --node-vm-size Standard_DS3_v2 \
    --node-count {{nodeCount}}
```
{: .copy-code}

`az aks create` 有两个必需参数 - `name` 和 `resource-group`（我们使用之前设置的变量）
以及许多非必需参数（将使用默认值），其中一些是：

  - ***node-count*** - Kubernetes 节点池中的节点数。创建集群后，可以使用 az aks scale 更改其节点池的大小（默认值为 3）；
  - ***enable-addons*** - 以逗号分隔的列表启用 Kubernetes 附加组件（使用 az aks addon list 获取可用的附加组件列表）；
  - ***node-osdisk-size*** - 用于给定代理池中的计算机的操作系统磁盘类型：临时或托管。在与 VM 大小和操作系统磁盘大小结合使用时，可能默认为“临时”。创建后可能无法更改此池；
  - ***node-vm-size (or -s)*** - 作为 Kubernetes 节点创建的虚拟机的规模（默认值为 Standard_DS2_v2）；
  - ***generate-ssh-keys*** - 如果缺少，则生成 SSH 公钥和私钥文件。密钥将存储在 ~/.ssh 目录中。

从上面的命令中，我们为 [ApplicationGateway](https://docs.microsoft.com/en-us/azure/application-gateway/) 添加了 AKS 附加组件。我们将使用此网关作为 Thingsboard 基础架构的基于路径的负载均衡器

有关 `az aks create` 选项的完整列表，请参阅 [此处](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az_aks_create)


或者，您可以使用 [此](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal) 指南进行自定义集群设置。