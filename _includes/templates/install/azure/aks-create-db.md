您需要在 Azure 上设置 PostgreSQL。ThingsBoard 将使用它作为存储设备、仪表板、规则链和设备遥测的主数据库。

您可以按照[此](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/quickstart-create-server-portal)指南进行操作，但请考虑以下要求：
* 将您的 postgresql 密码保存在安全的地方。我们将在本指南的后面使用 YOUR_RDS_PASSWORD 来引用它；
* 确保您的 Azure Database for PostgreSQL 版本是最新版本 12.x，而不是 13.x；
* 确保您的 Azure Database for PostgreSQL 实例可从 ThingsBoard 集群访问；
* 确保您使用“thingsboard”作为初始数据库名称；

以及建议：
* 使用“启用高可用性”。它默认启用许多有用的设置；

创建 Azure Database for PostgreSQL 的另一种方法是使用 az 工具（别忘了用您的用户名和密码替换“POSTGRESS_USER”和“POSTGRESS_PASS”）：

```bash
az postgres flexible-server create --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP \
  --name $TB_DATABASE_NAME --admin-user POSTGRESS_USER --admin-password POSTGRESS_PASS \
  --public-access 0.0.0.0 --storage-size 32 \
  --version 12 -d thingsboard
```
{: .copy-code}

`az postgres flexible-server create` 有很多参数，其中一些是：

  - ***location*** - 位置。值来自：az account list-locations；
  - ***resource-group***（或 -g） - 资源组的名称；
  - ***name*** - 服务器的名称。名称只能包含小写字母、数字和连字符 (-) 字符。最少 3 个字符，最多 63 个字符；
  - ***admin-user*** - 服务器的管理员用户名。一旦设置，就无法更改；
  - ***admin-password*** - 管理员的密码。最少 8 个字符，最多 128 个字符。密码必须包含以下三类字符中的三种：英语大写字母、英语小写字母、数字和非字母数字字符；
  - ***public-access*** - 确定公共访问。输入要包含在允许的 IP 列表中的单个或范围的 IP 地址。IP 地址范围必须用破折号分隔，不能包含任何空格。指定 0.0.0.0 允许 Azure 中部署的任何资源公开访问您的服务器。将其设置为“无”会将服务器设置为公共访问模式，但不会创建防火墙规则；
  - ***storage-size*** - 服务器的存储容量。最小为 32 GiB，最大为 16 TiB；
  - ***version*** - 服务器主要版本。
  - ***high-availability*** - 启用或禁用高可用性功能。默认值为禁用。高可用性只能在弹性服务器创建时设置（接受的值：禁用、启用。默认值：禁用）；
  - ***database-name***（或 -d） - 在配置数据库服务器时要创建的数据库的名称。

您可以在[此处](https://docs.microsoft.com/en-us/cli/azure/postgres/flexible-server?view=azure-cli-latest#az_postgres_flexible_server_create)查看完整参数列表。

响应示例：
```
{
  "connectionString": "postgresql://postgres:postgres@$tb-db.postgres.database.azure.com/postgres?sslmode=require",
  "databaseName": "thingsboard",
  "firewallName": "AllowAllAzureServicesAndResourcesWithinAzureIps_2021-11-17_15-45-6",
  "host": "tb-db.postgres.database.azure.com",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.DBforPostgreSQL/flexibleServers/thingsboard",
  "location": "East US",
  "password": "postgres",
  "resourceGroup": "myResourceGroup",
  "skuname": "Standard_D2s_v3",
  "username": "postgres",
  "version": "12"
}
```


请注意命令输出中的 **host** 值（在本例中为 *tb-db.postgres.database.azure.com*）。还要注意命令中的用户名和密码（*postgres*）。

编辑数据库设置文件，并将 *YOUR_AZURE_POSTGRES_ENDPOINT_URL* 替换为 **host** 值，将 *YOUR_AZURE_POSTGRES_USER* 和 *YOUR_AZURE_POSTGRES_PASSWORD* 替换为正确的值：

```bash
nano tb-node-db-configmap.yml
```