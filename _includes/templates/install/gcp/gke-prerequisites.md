#### 安装和配置工具

要在 GKE 集群上部署 ThingsBoard，您需要安装 [`kubectl`](https://kubernetes.io/docs/tasks/tools/) 和 [`gcloud`](https://cloud.google.com/sdk/downloads) 工具。有关更多信息，请参阅 [在开始之前](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster#before_you_begin) 指南。

创建新的 Google Cloud Platform 项目（推荐）或选择现有项目。

通过执行以下命令确保您已选择正确的项目：

```bash
gcloud init
```
{: .copy-code}

#### 启用 GCP 服务

通过执行以下命令为您的项目启用 GKE 和 SQL 服务：

```bash
gcloud services enable container.googleapis.com sql-component.googleapis.com sqladmin.googleapis.com
```
{: .copy-code}