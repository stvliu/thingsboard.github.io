#### 5.1 先决条件

启用服务网络，以允许 K8S 集群连接到数据库实例：

```bash
gcloud services enable servicenetworking.googleapis.com --project=$GCP_PROJECT

gcloud compute addresses create google-managed-services-$GCP_NETWORK \
--global \
--purpose=VPC_PEERING \
--prefix-length=16 \
--network=projects/$GCP_PROJECT/global/networks/$GCP_NETWORK

gcloud services vpc-peerings connect \
--service=servicenetworking.googleapis.com \
--ranges=google-managed-services-$GCP_NETWORK \
--network=$GCP_NETWORK \
--project=$GCP_PROJECT
    
```
{: .copy-code}

#### 5.2 创建数据库服务器实例

使用数据库版本“**PostgreSQL 12**”和以下建议创建 PostgreSQL 实例：

* 使用 K8S 集群 **GCP_REGION** 所在的同一区域；
* 使用 K8S 集群 **GCP_REGION** 所在的同一 VPC 网络；
* 使用专用 IP 地址连接到实例并禁用公共 IP 地址；
* 使用高可用性数据库实例进行生产，使用单一区域实例进行开发集群；
* 使用至少 2 个 vCPU 和 7.5 GB RAM，这足以满足大多数工作负载。如果需要，您以后可以扩展它；

执行以下命令：

```bash

gcloud beta sql instances create $TB_DATABASE_NAME \
--database-version=POSTGRES_12 \
--region=$GCP_REGION --availability-type=regional \
--no-assign-ip --network=projects/$GCP_PROJECT/global/networks/$GCP_NETWORK \
--cpu=2 --memory=7680MB
```
{: .copy-code}

或者，您可以按照[此](https://cloud.google.com/sql/docs/postgres/create-instance)指南配置数据库。

从命令输出中记下您的 IP 地址 (**YOUR_DB_IP_ADDRESS**) 。成功的命令输出应类似于以下内容：

```text
Created [https://sqladmin.googleapis.com/sql/v1beta4/projects/YOUR_PROJECT_ID/instances/thingsboard-db].
NAME            DATABASE_VERSION  LOCATION       TIER              PRIMARY_ADDRESS  PRIVATE_ADDRESS  STATUS
tb-db           POSTGRES_12       us-central1-f  db-custom-2-7680  35.192.189.68    -                RUNNABLE
```

#### 5.3 设置数据库密码

为您的新数据库服务器实例设置密码：

```bash
gcloud sql users set-password postgres \
--instance=$TB_DATABASE_NAME \
--password=secret
```
{: .copy-code}

其中：

* *thingsboard* 是您的数据库的名称。您可以输入不同的名称。我们将在本指南的后面使用 **YOUR_DB_NAME** 来引用它；
* *secret* 是密码。您**应该**输入不同的密码。我们将在本指南的后面使用 **YOUR_DB_PASSWORD** 来引用它；

#### 5.4 创建数据库

在您的 postgres 数据库服务器实例中创建“thingsboard”数据库：

```bash
gcloud sql databases create thingsboard --instance=$TB_DATABASE_NAME
```
{: .copy-code}