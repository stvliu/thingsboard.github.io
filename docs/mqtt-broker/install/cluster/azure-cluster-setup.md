---
layout: docwithnav-mqtt-broker
title: 在 Microsoft Azure 基础设施上设置集群
description: 在 AKS 中使用 Kubernetes 设置 TBMQ 微服务

---

* TOC
{:toc}

本指南将帮助您在 Azure AKS 中设置 TBMQ。

### 先决条件

#### 安装并配置工具

要在 AKS 集群上部署 TBMQ，您需要安装 [kubectl](https://kubernetes.io/docs/tasks/tools/), 
[helm](https://helm.sh/docs/intro/install/), 和 [az](https://learn.microsoft.com/en-us/cli/azure/) 工具。

安装完成后，您需要使用以下命令登录到 cli。

```bash
az login
```
{: .copy-code}

### 步骤 1. 打开 TBMQ K8S 脚本存储库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/azure
```
{: .copy-code}

### 步骤 2. 定义环境变量

定义您将在本指南后面的各种命令中使用的环境变量。

我们假设您使用的是 Linux。执行以下命令：

```bash
export AKS_RESOURCE_GROUP=TBMQResources
export AKS_LOCATION=eastus
export AKS_GATEWAY=tbmq-gateway
export TB_CLUSTER_NAME=tbmq-cluster
export TB_DATABASE_NAME=tbmq-db
export TB_REDIS_NAME=tbmq-redis
echo "You variables ready to create resource group $AKS_RESOURCE_GROUP in location $AKS_LOCATION 
and cluster in it $TB_CLUSTER_NAME with database $TB_DATABASE_NAME"
```
{: .copy-code}

其中：

* TBMQResources - 部署和管理 Azure 资源的逻辑组。我们将在本指南的后面使用 **AKS_RESOURCE_GROUP** 来引用它；
* eastus - 是您要创建资源组的位置。我们将在本指南的后面使用 **AKS_LOCATION** 来引用它。您可以通过执行 `az account list-locations` 来查看所有位置列表；
* tbmq-gateway - Azure 应用程序网关的名称；
* tbmq-cluster - 集群名称。我们将在本指南的后面使用 **TB_CLUSTER_NAME** 来引用它；
* tbmq-db 是您的数据库服务器的名称。您可以输入不同的名称。我们将在本指南的后面使用 **TB_DATABASE_NAME** 来引用它。

### 步骤 3. 配置并创建 AKS 集群

在创建 AKS 集群之前，我们需要创建 Azure 资源组。为此，我们将使用 Azure CLI：

```bash
az group create --name $AKS_RESOURCE_GROUP --location $AKS_LOCATION
```
{: .copy-code}

有关 `az group` 的更多信息，请访问以下 [链接](https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest)。

创建资源组后，我们可以使用以下命令创建 AKS 集群：

```bash
az aks create --resource-group $AKS_RESOURCE_GROUP \
    --name $TB_CLUSTER_NAME \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --appgw-name $AKS_GATEWAY \
    --appgw-subnet-cidr "10.2.0.0/16" \
    --node-vm-size Standard_DS3_v2 \
    --node-count 3
```
{: .copy-code}

`az aks create` 有两个必需的参数 - `name` 和 `resource-group`（我们使用前面设置的变量），
以及许多非必需参数（如果未设置，将使用默认值）。其中一些是：

* **node-count** - Kubernetes 节点池中的节点数。创建集群后，您可以使用 `az aks scale` 更改其节点池的大小（默认值为 3）；
* **enable-addons** - 在逗号分隔的列表中启用 Kubernetes 附加组件（使用 `az aks addon list` 获取可用的附加组件列表）；
* **node-osdisk-size** - 用于给定代理池中的计算机的操作系统磁盘类型：临时或托管。在与 VM 大小和操作系统磁盘大小结合使用时，默认为“临时”。创建后可能无法更改此池；
* **node-vm-size**（或 -s） - 要创建为 Kubernetes 节点的虚拟机的规模（默认值为 Standard_DS2_v2）；
* **generate-ssh-keys** - 如果缺少，则生成 SSH 公钥和私钥文件。密钥将存储在 ~/.ssh 目录中。

从上面的命令中，我们为 [ApplicationGateway](https://learn.microsoft.com/en-us/azure/application-gateway/) 添加了 AKS 附加组件。
我们将使用此网关作为 TBMQ 的基于路径的负载均衡器。

可以在 [此处](https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az_aks_create) 找到 `az aks create` 选项的完整列表。

或者，您可以使用本 [指南](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-portal?tabs=azure-cli) 进行自定义集群设置。

### 步骤 4. 更新 kubectl 的上下文

创建集群后，我们可以使用以下命令将 kubectl 连接到它：

```bash
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

为了验证，您可以执行以下命令：

```bash
kubectl get nodes
```
{: .copy-code}

您应该会看到集群的节点列表。

### 步骤 5. 配置 PostgreSQL 数据库

您需要在 Azure 上设置 PostgreSQL。您可以按照 [本](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/quickstart-create-server-portal) 指南进行操作，
但请考虑以下要求：

* 将您的 postgresql 密码保存在安全的地方。我们将在本指南的后面使用 YOUR_AZURE_POSTGRES_PASSWORD 来引用它；
* 确保您的 Azure Database for PostgreSQL 版本为 15.x；
* 确保您的 Azure Database for PostgreSQL 实例可从 TBMQ 集群访问；
* 确保您使用“thingsboard_mqtt_broker”作为初始数据库名称。

**注意**：使用启用了“高可用性”。它默认启用许多有用的设置。

创建 Azure Database for PostgreSQL 的另一种方法是使用 az 工具（不要忘记将“POSTGRESS_USER”和“POSTGRESS_PASS”替换为您的用户名和密码）：

```bash
az postgres flexible-server create --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP \
  --name $TB_DATABASE_NAME --admin-user POSTGRESS_USER --admin-password POSTGRESS_PASS \
  --public-access 0.0.0.0 --storage-size 32 \
  --version 15 -d thingsboard_mqtt_broker
```
{: .copy-code}

`az postgres flexible-server create` 有很多参数，其中一些是：

* **location** - 位置。值来自：`az account list-locations`；
* **resource-group (or -g)** - 资源组的名称；
* **name** - 服务器的名称。名称只能包含小写字母、数字和连字符 (-) 字符。最少 3 个字符，最多 63 个字符；
* **admin-user** - 服务器的管理员用户名。一旦设置，就无法更改；
* **admin-password** - 管理员的密码。最少 8 个字符，最多 128 个字符。密码必须包含以下三类字符：英语大写字母、英语小写字母、数字和非字母数字字符；
* **public-access** - 确定公共访问。输入要包含在允许的 IP 列表中的单个或范围的 IP 地址。IP 地址范围必须用破折号分隔，并且不包含任何空格。指定 0.0.0.0 允许在 Azure 内部署的任何资源从您的服务器访问。将其设置为“无”会将服务器设置为公共访问模式，但不会创建防火墙规则；
* **storage-size** - 服务器的存储容量。最小为 32 GiB，最大为 16 TiB；
* **version** - 服务器主要版本；
* **high-availability** - 启用或禁用高可用性功能。高可用性只能在创建灵活服务器期间设置（接受的值：禁用、启用。默认值：禁用）；
* **database-name (or -d)** - 在配置数据库服务器时要创建的数据库的名称。

您可以在 [此处](https://learn.microsoft.com/en-us/cli/azure/postgres/flexible-server?view=azure-cli-latest#az_postgres_flexible_server_create) 查看完整参数列表。

响应示例：

```text
{
  "connectionString": "postgresql://postgres:postgres@$tbmq-db.postgres.database.azure.com/postgres?sslmode=require",
  "databaseName": "thingsboard_mqtt_broker",
  "firewallName": "AllowAllAzureServicesAndResourcesWithinAzureIps_2021-11-17_15-45-6",
  "host": "tbmq-db.postgres.database.azure.com",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.DBforPostgreSQL/flexibleServers/thingsboard_mqtt_broker",
  "location": "East US",
  "password": "postgres",
  "resourceGroup": "TBMQResources",
  "skuname": "Standard_D2s_v3",
  "username": "postgres",
  "version": "15"
}
```

记下命令输出中的主机值（在本例中为 **tbmq-db.postgres.database.azure.com**）。另外，记下命令中的用户名和密码（**postgres**）。

编辑数据库设置文件并将 YOUR_AZURE_POSTGRES_ENDPOINT_URL 替换为主机值，YOUR_AZURE_POSTGRES_USER 和 YOUR_AZURE_POSTGRES_PASSWORD 替换为正确的值：

```bash
nano tb-broker-db-configmap.yml
```
{: .copy-code}

### 步骤 6. Azure Cache for Redis（可选）

或者，您可以设置 Azure Cache for Redis。TBMQ 使用缓存来提高性能并避免频繁的数据库读取。

我们建议在有数千个 MQTT 客户端（设备）连接到 TBMQ 的情况下启用此功能。当客户端在启用身份验证的情况下连接到 TBMQ 时，此功能非常有用。
对于每个连接，都会发出请求以查找可以对客户端进行身份验证的 MQTT 客户端凭据。
因此，对于大量同时连接的客户端，可能需要处理过多的请求。

为了设置 Redis，请按照本 [指南](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/quickstart-create-redis) 进行操作。

另一种方法是使用 `az` 工具：

```bash
az redis create --name $TB_REDIS_NAME --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP --sku basic --vm-size C0 --enable-non-ssl-port
```
{: .copy-code}

`az redis create` 有很多选项，其中一些是必需的：

* **name**（或 -n） - Redis 缓存的名称；
* **resource-group**（或 -g） - 资源组的名称；
* **sku** - Redis 缓存的类型（接受的值：基本、高级、标准）；
* **vm-size** - 要部署的 Redis 缓存的大小。基本和标准缓存大小以 C 开头。高级缓存大小以 P 开头（接受的值：c0、c1、c2、c3、c4、c5、c6、p1、p2、p3、p4、p5）；
* **location**（或 -l） - 位置。值来自：`az account list-locations`。

要查看参数的完整列表，请转到以下 [页面](https://learn.microsoft.com/en-us/cli/azure/redis?view=azure-cli-latest)。

响应示例：

```text
{
  "accessKeys": null,
  "enableNonSslPort": true,
  "hostName": "tbmq-redis.redis.cache.windows.net",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.Cache/Redis/tbmq-redis",
  "instances": [
    {
      "isMaster": false,
      "isPrimary": false,
      "nonSslPort": 13000,
      "shardId": null,
      "sslPort": 15000,
      "zone": null
    }
  ],
  "linkedServers": [],
  "location": "East US",
  "minimumTlsVersion": null,
  "name": "tbmq-redis",
  "port": 6379,
  "privateEndpointConnections": null,
  "provisioningState": "Creating",
  "publicNetworkAccess": "Enabled",
  "redisConfiguration": {
    "maxclients": "256",
    "maxfragmentationmemory-reserved": "12",
    "maxmemory-delta": "2",
    "maxmemory-reserved": "2"
  },
  "redisVersion": "6.0.20",
  "replicasPerMaster": null,
  "replicasPerPrimary": null,
  "resourceGroup": "myResourceGroup",
  "shardCount": null,
  "sku": {
    "capacity": 0,
    "family": "C",
    "name": "Basic"
  },
  "sslPort": 6380,
  "staticIp": null,
  "subnetId": null,
  "tags": {},
  "tenantSettings": {},
  "type": "Microsoft.Cache/Redis",
  "zones": null
}
```

我们需要获取 `hostName` 参数并将 _tb-broker-cache-configmap.yml_ 文件中的 `YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT` 替换为它。

在此之后，我们需要获取连接的 redis 密钥，为此我们需要执行：

```bash
az redis list-keys --name $TB_REDIS_NAME --resource-group $AKS_RESOURCE_GROUP
```
{: .copy-code}

获取“primary”并将其粘贴到 _tb-broker-cache-configmap.yml_ 文件中，替换 `YOUR_REDIS_PASSWORD`。

有关更多信息，请参阅以下 [脚本](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/scripts/create-manage-cache#run-the-script)。

### 步骤 7. 安装

执行以下命令以运行数据库的初始设置。
此命令将启动短寿命的 TBMQ pod 来配置必要的数据库表、索引等。

```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

此命令完成后，您应该在控制台中看到以下行：

```text
INFO  o.t.m.b.i.ThingsboardMqttBrokerInstallService - Installation finished successfully!
```

{% capture aws-rds %}

否则，请检查您是否在 `tb-broker-db-configmap.yml` 中正确设置了 PostgreSQL URL 和 PostgreSQL 密码。

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}

### 步骤 8. 配置 Kafka

我们建议从 Helm 部署 Bitnami Kafka。为此，请查看 `kafka` 文件夹。

```bash
ls kafka/
```
{: .copy-code}

您可以在那里找到 _default-values-kafka.yml_ 文件 - 从 [Bitnami artifactHub](https://artifacthub.io/packages/helm/bitnami/kafka) 下载的默认值。和 _values-kafka.yml_ 文件，其中包含修改后的值。
我们建议保持第一个文件不变，只对第二个文件进行更改。这样，升级到下一个版本的流程会更加顺利，因为可以看到差异。

要添加 Bitnami helm 仓库：

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```
{: .copy-code}

要安装 Bitnami Kafka，请执行以下命令：

```bash
helm install kafka -f kafka/values-kafka.yml bitnami/kafka --version 25.3.3
```
{: .copy-code}

等待几分钟，直到 Kafka 和 Zookeeper pod 启动并运行。

### 步骤 9. 启动

执行以下命令以部署代理：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

几分钟后，您可以执行以下命令来检查所有 pod 的状态。

```bash
kubectl get pods
```
{: .copy-code}

如果一切顺利，您应该可以看到 `tb-broker-0` 和 `tb-broker-1` pod。每个 pod 都应处于 `READY` 状态。

### 步骤 10. 配置负载均衡器

#### 10.1 配置 HTTP(S) 负载均衡器

配置 HTTP(S) 负载均衡器以访问 TBMQ 实例的 Web 界面。基本上，您有 2 种可能的配置选项：

* http - 不支持 HTTPS 的负载均衡器。推荐用于 **开发**。唯一的优点是配置简单且成本最低。对于开发服务器来说可能是一个不错的选择，但绝对不适合生产环境。
* https - 支持 HTTPS 的负载均衡器。推荐用于 **生产**。充当 SSL 终止点。您可以轻松配置它来颁发和维护有效的 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。

请参阅以下链接/说明，了解如何配置每个建议的选项。

##### HTTP 负载均衡器

执行以下命令以部署纯 http 负载均衡器：

```bash
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

负载均衡器配置过程可能需要一些时间。您可以使用以下命令定期检查负载均衡器的状态：

```bash
kubectl get ingress
```
{: .copy-code}

配置完成后，您应该看到类似的输出：

```text
NAME                          CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       34.111.24.134   80      3d1h
```

##### HTTPS 负载均衡器

对于使用 ssl 证书，我们可以使用以下命令直接在 Azure ApplicationGateway 中添加我们的证书：

```bash
az network application-gateway ssl-cert create \
   --resource-group $(az aks show --name $TB_CLUSTER_NAME --resource-group $AKS_RESOURCE_GROUP --query nodeResourceGroup | tr -d '"') \
   --gateway-name $AKS_GATEWAY\
   --name TBMQHTTPSCert \
   --cert-file YOUR_CERT \
   --cert-password YOUR_CERT_PASS
```
{: .copy-code}

执行以下命令以部署纯 https 负载均衡器：

```bash
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

#### 10.2 配置 MQTT 负载均衡器

配置 MQTT 负载均衡器以能够使用 MQTT 协议连接设备。

使用以下命令创建 TCP 负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发所有针对端口 1883 和 8883 的 TCP 流量。

##### MQTT over SSL

按照 [本指南](https://thingsboard.io/docs/user-guide/mqtt-over-ssl/) 创建带有 SSL 证书的 .pem 文件。将文件存储为工作目录中的 _server.pem_。

您需要使用 PEM 文件创建一个 config-map，您可以通过调用命令来做到这一点：

```bash
kubectl create configmap tbmq-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* 其中 **YOUR_PEM_FILENAME** 是 **服务器证书文件** 的名称。
* 其中 **YOUR_PEM_KEY_FILENAME** 是 **服务器证书私钥文件** 的名称。

然后，取消注释 `tb-broker.yml` 文件中标记为“取消注释以下行以启用双向 MQTTS”的所有部分。

执行命令以应用更改：

```bash
kubectl apply -f tb-broker.yml
```
{: .copy-code}

### 步骤 11. 验证设置

现在，您可以使用负载均衡器的 DNS 名称在浏览器中打开 TBMQ Web 界面。

您可以使用以下命令获取负载均衡器的 DNS 名称：

```bash
kubectl get ingress
```
{: .copy-code}

您应该看到类似的图片：

```text
NAME                          CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       34.111.24.134   80      3d1h
```

使用 `tb-broker-http-loadbalancer` 的 `ADDRESS` 字段连接到集群。

{% include templates/mqtt-broker/login.md %}

#### 验证 MQTT 访问

要通过 MQTT 连接到集群，您需要获取相应的服务 IP。您可以使用以下命令执行此操作：

```bash
kubectl get services
```
{: .copy-code}

您应该看到类似的图片：

```text
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP              PORT(S)                         AGE
tb-broker-mqtt-loadbalancer   LoadBalancer   10.100.119.170   *******                  1883:30308/TCP,8883:31609/TCP   6m58s
```

使用负载均衡器的 `EXTERNAL-IP` 字段通过 MQTT 协议连接到集群。

#### 故障排除

如果出现任何问题，您可以检查服务日志以查找错误。例如，要查看 TBMQ 日志，请执行以下命令：

```bash
kubectl logs -f tb-broker-0
```
{: .copy-code}

使用以下命令查看所有有状态集的状态。
```bash
kubectl get statefulsets
```
{: .copy-code}

有关更多详细信息，请参阅 [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。

### 升级

如果您想升级，请从最新的发行版分支中提取最近的更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

**注意：**确保在合并过程中不会丢失您可用的自定义更改。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

之后执行以下命令：

```bash
./k8s-delete-tbmq.sh
./k8s-upgrade-tbmq.sh --fromVersion=FROM_VERSION
./k8s-deploy-tbmq.sh
```
{: .copy-code}

其中 `FROM_VERSION` - 从哪个版本开始升级。
有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/mqtt-broker/install/upgrade-instructions/)。

### 集群删除

执行以下命令以删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令以删除所有 TBMQ 节点、configmap、负载均衡器等：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令以删除 AKS 集群：

```bash
az aks delete --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}