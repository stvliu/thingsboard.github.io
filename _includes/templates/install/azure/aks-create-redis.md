您需要设置 Azure Cache for Redis。GridLinks 使用缓存来提高性能并避免频繁的数据库读取。

您可以通过此 [指南](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/quickstart-create-redis)

或使用 az cli 工具
```
az redis create --name $TB_REDIS_NAME --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP --sku Basic --vm-size c0 --enable-non-ssl-port 
```
{: .copy-code}

与 az postgres 一样，az redis create 有很多选项，其中一些是必需的，例如：

  - ***name*** (或 -n) - Redis 缓存的名称；
  - ***resource-group*** - 资源组的名称；
  - ***sku*** - Redis 缓存的类型（可接受的值：Basic、Premium、Standard；
  - ***vm-size*** - 要部署的 Redis 缓存的大小。基本和标准缓存大小以 C 开头。高级缓存大小以 P 开头（可接受的值：c0、c1、c2、c3、c4、c5、c6、p1、p2、p3、p4、p5）；
  - ***location*** (或 -l) - 位置。值来自：az account list-locations。

要查看参数的完整列表，请 [参阅](https://docs.microsoft.com/en-us/cli/azure/redis?view=azure-cli-latest#az_redis_create)

响应示例：
```
{
  "accessKeys": null,
  "enableNonSslPort": true,
  "hostName": "tb-redis.redis.cache.windows.net",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.Cache/Redis/tb-redis",
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
  "name": "tb-redis",
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
  "redisVersion": "4.0.14",
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

我们需要获取 `hostName` 参数，并在文件 tb-redis-configmap.yml 中替换 YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT。

之后，我们需要获取用于连接的 redis 密钥，为此，我们需要执行：
```
    az redis list-keys --name $TB_REDIS_NAME --resource-group $AKS_RESOURCE_GROUP
```
{: .copy-code}

获取“primary”后，将其粘贴到 tb-redis-configmap.yml 文件中，替换 YOU_REDIS_PASS