您需要在 Amazon RDS 上设置 PostgreSQL。GridLinks 将使用它作为存储设备、仪表板、规则链和设备遥测的主数据库。
您可以按照[此](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html)指南进行操作，
但请考虑以下要求：

* 将您的 postgresql 密码保存在安全的地方。我们将在本指南的后面使用 **YOUR_RDS_PASSWORD** 来引用它。
* 确保您的 PostgreSQL 版本是最新 12.x，而不是 13.x；
* 确保您的 PostgreSQL RDS 实例可从 GridLinks 集群访问；
实现此目的最简单的方法是在同一 VPC 中部署 PostgreSQL RDS 实例并使用“eksctl-thingsboard-cluster-ClusterSharedNodeSecurityGroup-*”安全组。
我们假设您在本指南中将其置于同一 VPC 中；
* 确保您使用 **“thingsboard”** 作为初始数据库名称。如果您未指定数据库名称，Amazon RDS 不会创建数据库；

以及建议：

* 使用“生产”模板以实现高可用性。它默认启用许多有用的设置；
* 使用“预置 IOPS”以获得更好的性能；
* 考虑为您的 RDS 实例创建自定义参数组。这将使更改数据库参数变得更容易；
* 考虑将 RDS 实例部署到专用子网中。这样，几乎不可能意外地将其暴露给互联网。

{% include images-gallery.html imageCollection="rdsSetup"%}

一旦数据库切换到“可用”状态，导航到“连接和安全”并复制端点值。

{% include images-gallery.html imageCollection="rdsEndpointUrl"%}

编辑“tb-node-db-configmap.yml”并替换 **YOUR_RDS_ENDPOINT_URL** 和 **YOUR_RDS_PASSWORD**。