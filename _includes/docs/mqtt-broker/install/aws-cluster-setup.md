* TOC
{:toc}

本指南将帮助您在 AWS EKS 中设置 TBMQ。

### 前提条件

{% include templates/mqtt-broker/install/aws/eks-prerequisites.md %}

### 步骤 1. 打开 TBMQ K8S 脚本存储库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/aws
```
{: .copy-code}

### 步骤 2. 配置并创建 EKS 集群

在 `cluster.yml` 文件中，您可以找到建议的集群配置。
以下是可以根据您的需要更改的字段：
- `region` - 应该是您希望集群所在的 AWS 区域（默认值为 `us-east-1`）
- `availabilityZones` - 应指定区域可用性区域的确切 ID
  （默认值为 `[us-east-1a,us-east-1b,us-east-1c]`)
- `instanceType` - 带有 TBMQ 节点的实例类型（默认值为 `m7a.large`）

**注意**：如果您不对 `instanceType` 和 `desiredCapacity` 字段进行任何更改，EKS 将部署 2 个 m7a.large 类型的节点。

{% capture aws-eks-security %}
如果您想保护对 PostgreSQL 和 MSK 的访问，您需要配置现有的 VPC 或创建一个新的 VPC，
将其设置为 TBMQ 集群的 VPC，为 PostgreSQL 和 MSK 创建安全组，
将它们设置为 TBMQ 集群中的 `managed` 节点组，并使用另一个安全组配置从 TBMQ 集群节点到 PostgreSQL/MSK 的访问。

您可以在此处找到有关为 `eksctl` 配置 VPC 的更多信息：[here](https://eksctl.io/usage/vpc-networking/)。
{% endcapture %}
{% include templates/info-banner.md content=aws-eks-security %}

创建 AWS 集群的命令：

```bash
eksctl create cluster -f cluster.yml
```
{: .copy-code}

### 步骤 3. 创建 AWS 负载均衡器控制器

集群准备就绪后，您需要创建 AWS 负载均衡器控制器。
您可以按照[此](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)指南进行操作。
集群配置脚本将创建多个负载均衡器：

* tb-broker-http-loadbalancer - 负责 Web UI 和 REST API 的 AWS ALB；
* tb-broker-mqtt-loadbalancer - 负责 MQTT 通信的 AWS NLB。

配置 AWS 负载均衡器控制器是**非常重要的一步**，这些负载均衡器需要它才能正常工作。

### 步骤 4. Amazon PostgreSQL 数据库配置

您需要在 Amazon RDS 上设置 PostgreSQL。
执行此操作的一种方法是按照[此](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SettingUp.html)指南进行操作。

**注意**：一些建议：

* 确保您的 PostgreSQL 版本为 15.x；
* 使用“生产”模板以实现高可用性。它默认启用许多有用的设置；
* 考虑为您的 RDS 实例创建自定义参数组。这将使更改数据库参数变得更容易；
* 考虑将 RDS 实例部署到专用子网中。这样，几乎不可能意外地将其暴露给互联网。
* 您还可以更改 `username` 字段并设置或自动生成 `password` 字段（将您的 postgresql 密码保存在安全的地方）。

**注意**：确保您的数据库可以从集群访问，实现此目的的一种方法是在与 TBMQ 集群相同的 VPC 和子网中创建数据库，并使用
`eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*` 安全组。见下图。

{% include images-gallery.html imageCollection="tbmq-rds-set-up" %}

### 步骤 5. Amazon MSK 配置

您需要设置 Amazon MSK。
为此，您需要打开 AWS 控制台、MSK 子菜单，按“创建集群”按钮并选择“自定义创建”模式。
您应该看到类似的图像：

{% include images-gallery.html imageCollection="tbmq-msk-set-up" %}

**注意**：一些建议：

* Apache Kafka 版本可以安全地设置为 3.5.1 版本，因为 TBMQ 已在该版本上进行了全面测试；
* 使用 m5.large 或类似的实例类型；
* 考虑为您的 MSK 创建自定义集群配置。这将使更改 Kafka 参数变得更容易；
* 使用默认的“监控”设置或启用“增强的主题级监控”。

**注意**：确保您的 MSK 实例可以从 TBMQ 集群访问。
实现此目的的最简单方法是在同一 VPC 中部署 MSK 实例。
我们还建议使用专用子网。这样，几乎不可能意外地将其暴露给互联网；

{% include images-gallery.html imageCollection="tbmq-msk-configuration" %}

最后，仔细检查 MSK 的整个配置，然后完成集群创建。

### 步骤 6. Amazon ElastiCache（Redis）配置（可选）

或者，您可以为 Redis 设置[ElastiCache](https://aws.amazon.com/elasticache/redis/)。TBMQ 使用缓存来提高性能并避免频繁的数据库读取。

我们建议在有数千个连接到 TBMQ 的 MQTT 客户端（设备）的情况下启用此功能。当客户端在启用身份验证的情况下连接到 TBMQ 时，此功能非常有用。
对于每个连接，都会发出请求以查找可以对客户端进行身份验证的 MQTT 客户端凭据。
因此，对于大量同时连接的客户端，可能会有过多的请求需要处理。

请打开 AWS 控制台并导航至 ElastiCache->Redis 集群->创建 Redis 集群。

**注意**：一些建议：

* 指定 Redis Engine 版本 7.x 和至少具有 1 GB RAM 的节点类型；
* 确保您的 Redis 集群可以从 TBMQ 集群访问。
  实现此目的的最简单方法是在同一 VPC 中部署 Redis 集群。
  我们还建议使用专用子网。使用 `eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*` 安全组；
* 禁用自动备份。

{% include images-gallery.html imageCollection="tbmq-redis-set-up" %}

### 步骤 7. 配置到 Kafka（Amazon MSK）/Postgres/Redis 的链接

#### Amazon RDS PostgreSQL

一旦数据库切换到“可用”状态，在 AWS 控制台上获取 RDS PostgreSQL 的“端点”，并将其粘贴到
`tb-broker-db-configmap.yml` 中的 `SPRING_DATASOURCE_URL`，而不是 `RDS_URL_HERE` 部分。

{% include images-gallery.html imageCollection="tbmq-rds-link-configure" %}

此外，您需要使用相应的 PostgreSQL `username` 和 `password` 设置 `SPRING_DATASOURCE_USERNAME` 和 `SPRING_DATASOURCE_PASSWORD`。

#### Amazon MSK

一旦 MSK 集群切换到“活动”状态，要获取代理列表，请执行以下命令：
```bash
aws kafka get-bootstrap-brokers --region us-east-1 --cluster-arn $CLUSTER_ARN
```
{: .copy-code}
其中 **$CLUSTER_ARN** 是 MSK 集群的 Amazon 资源名称 (ARN)：

{% include images-gallery.html imageCollection="tbmq-msk-link-configure" %}

您需要将 `BootstrapBrokerString` 中的数据粘贴到 `tb-broker.yml` 文件中的 `TB_KAFKA_SERVERS` 环境变量。

否则，单击上图中看到的“查看客户端信息”。复制纯文本中的引导服务器信息。

#### Amazon ElastiCache

一旦 Redis 集群切换到“可用”状态，打开“集群详细信息”并复制“主端点”，不带“:6379”端口后缀，它是 **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT**。

{% include images-gallery.html imageCollection="tbmq-redis-link-configure" %}

编辑 `tb-broker-cache-configmap.yml` 并替换 **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT**。

### 步骤 8. 安装

执行以下命令运行安装：
```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

此命令完成后，您应该在控制台中看到下一行：

```
INFO  o.t.m.b.i.ThingsboardMqttBrokerInstallService - Installation finished successfully!
```

{% capture aws-rds %}

否则，请检查您是否正确设置了 `tb-broker-db-configmap.yml` 中的 PostgreSQL URL 和 PostgreSQL 密码。

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}

### 步骤 9. 启动

执行以下命令部署代理：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

几分钟后，您可以执行以下命令检查所有 Pod 的状态。
```bash
kubectl get pods
```
{: .copy-code}

如果一切顺利，您应该能够看到 `tb-broker-0` 和 `tb-broker-1` Pod。每个 Pod 都应处于“就绪”状态。

### 步骤 10. 配置负载均衡器

#### 10.1 配置 HTTP(S) 负载均衡器

配置 HTTP(S) 负载均衡器以访问 TBMQ 实例的 Web 界面。基本上，您有 2 个可能的配置选项：

* http - 不支持 HTTPS 的负载均衡器。推荐用于**开发**。唯一的优点是配置简单且成本最低。可能是开发服务器的不错选择，但绝对不适合生产环境。
* https - 支持 HTTPS 的负载均衡器。推荐用于**生产**。充当 SSL 终止点。您可以轻松配置它来颁发和维护有效的 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。

请参阅以下链接/说明，了解如何配置每个建议的选项。

##### HTTP 负载均衡器

执行以下命令部署纯 HTTP 负载均衡器：

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
NAME                          CLASS    HOSTS   ADDRESS                                                                  PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       k8s-thingsbo-tbbroker-000aba1305-222186756.eu-west-1.elb.amazonaws.com   80      3d1h
```

##### HTTPS 负载均衡器

使用[AWS 证书管理器](https://aws.amazon.com/certificate-manager/)创建或导入 SSL 证书。记下您的证书 ARN。

编辑负载均衡器配置并用您的证书 ARN 替换 YOUR_HTTPS_CERTIFICATE_ARN：

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

执行以下命令部署纯 HTTPS 负载均衡器：

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

负载均衡器将转发端口 1883 和 8883 的所有 TCP 流量。

##### 单向 TLS

配置 MQTTS 的最简单方法是让您的 MQTT 负载均衡器 (AWS NLB) 充当 TLS 终止点。
这样，我们建立了单向 TLS 连接，其中您的设备和负载均衡器之间的流量是加密的，而您的负载均衡器和 TBMQ 之间的流量未加密。
由于 ALB/NLB 在您的 VPC 中运行，因此应该没有安全问题。
此选项的唯一主要缺点是您无法使用“X.509 证书”MQTT 客户端凭据，
因为有关客户端证书的信息不会从负载均衡器传输到 TBMQ。

启用单向 TLS：

使用[AWS 证书管理器](https://aws.amazon.com/certificate-manager/)创建或导入 SSL 证书。记下您的证书 ARN。

编辑负载均衡器配置并用您的证书 ARN 替换 YOUR_MQTTS_CERTIFICATE_ARN：

```bash
nano receipts/mqtts-load-balancer.yml
```
{: .copy-code}

执行以下命令部署纯 MQTTS 负载均衡器：

```bash
kubectl apply -f receipts/mqtts-load-balancer.yml
```
{: .copy-code}

##### 双向 TLS

启用 MQTTS 的更复杂方法是获取有效的（签名）TLS 证书并在 TBMQ 中配置它。
此选项的主要优点是您可以将其与“X.509 证书”MQTT 客户端凭据结合使用。

启用双向 TLS：

按照[本指南](https://docs.codingas.com/docs/user-guide/mqtt-over-ssl/)创建包含 SSL 证书的 .pem 文件。将文件存储为工作目录中的 _server.pem_。

您需要使用 PEM 文件创建一个 config-map，您可以通过调用命令来做到这一点：

```bash
kubectl create configmap tbmq-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* 其中 **YOUR_PEM_FILENAME** 是您的**服务器证书文件**的名称。
* 其中 **YOUR_PEM_KEY_FILENAME** 是您的**服务器证书私钥文件**的名称。

然后，取消注释 `tb-broker.yml` 文件中标记为“取消注释以下行以启用双向 MQTTS”的所有部分。

执行命令应用更改：

```bash
kubectl apply -f tb-broker.yml
```
{: .copy-code}

最后，部署“透明”负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
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
NAME                          CLASS    HOSTS   ADDRESS                                                                  PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       k8s-thingsbo-tbbroker-000aba1305-222186756.eu-west-1.elb.amazonaws.com   80      3d1h
```

使用 `tb-broker-http-loadbalancer` 的 `ADDRESS` 字段连接到集群。

{% include templates/mqtt-broker/login.md %}

#### 验证 MQTT 访问

要通过 MQTT 连接到集群，您需要获取相应的服务 IP。您可以使用以下命令做到这一点：

```bash
kubectl get services
```
{: .copy-code}

您应该看到类似的图片：

```text
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP                                                                     PORT(S)                         AGE
tb-broker-mqtt-loadbalancer   LoadBalancer   10.100.119.170   k8s-thingsbo-tbbroker-b9f99d1ab6-1049a98ba4e28403.elb.eu-west-1.amazonaws.com   1883:30308/TCP,8883:31609/TCP   6m58s
```

使用负载均衡器的 `EXTERNAL-IP` 字段通过 MQTT 协议连接到集群。

#### 故障排除

如果出现任何问题，您可以检查服务日志是否有错误。例如，要查看 TBMQ 日志，请执行以下命令：

```bash
kubectl logs -f tb-broker-0
```
{: .copy-code}

使用以下命令查看所有有状态集的状态。
```bash
kubectl get statefulsets
```
{: .copy-code}

有关更多详细信息，请参阅[kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)命令参考。

### 升级

如果您想升级，请从最新的发行分支中提取最近的更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

**注意**：确保在合并过程中不会丢失您现有的自定义更改（如果可用）。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

之后执行以下命令：

```bash
./k8s-upgrade-tbmq.sh --fromVersion=FROM_VERSION
```
{: .copy-code}

其中 `FROM_VERSION` - 从哪个版本开始升级。
有关有效的 `fromVersion` 值，请参阅[升级说明](/docs/mqtt-broker/install/upgrade-instructions/)。

**注意**：您可能会在运行数据库升级时选择性地停止 TBMQ Pod，方法如下命令。

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

这会导致停机，但会确保更新后数据库状态一致。大多数更新不需要停止 TBMQ。

完成后，再次部署资源。这将导致 TBMQ 使用最新版本重新启动。

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

### 删除集群

执行以下命令删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令删除所有 TBMQ 节点和 configmap：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令删除 EKS 集群（如果集群名称和区域不同，您应该更改集群名称和区域）：
```bash
eksctl delete cluster -r us-east-1 -n tbmq -w
```
{: .copy-code}

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}