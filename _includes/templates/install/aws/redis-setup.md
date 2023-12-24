您需要设置 [Amazon ElastiCache (Redis)](https://aws.amazon.com/elasticache/redis/)。GridLinks 使用缓存来提高性能并避免频繁的数据库读取。

请打开 AWS 控制台并导航至 ElastiCache->Redis->Create。

* 指定 Redis Engine 版本 6.x 和至少具有 1 GB RAM 的节点类型；
* 确保您的 Redis 集群可从 ThingsBoard 集群访问。实现此目的最简单的方法是在同一 VPC 中部署 Redis 集群。我们还建议使用专用子网。使用“eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*”安全组；
* 禁用自动备份。

{% include images-gallery.html imageCollection="redisSetup"%}

一旦 Redis 集群切换到“可用”状态，导航至“详细信息”并复制“主端点”，不带“:6379”端口后缀，即 **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT**。

{% include images-gallery.html imageCollection="redisEndpointUrl"%}

编辑“tb-redis-configmap.yml”并替换 **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT**。