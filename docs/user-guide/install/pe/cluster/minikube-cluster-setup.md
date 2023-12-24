---
layout: docwithnav-pe
assignees:
- ashvayka
title:  GridLinks专业版 集群设置与 Kubernetes 和 Minikube 指南
description:  GridLinks专业版 集群设置与 Kubernetes 和 Minikube 指南

---

{% assign docsPrefix = "pe/" %}

* TOC
{:toc}

本指南将帮助您使用 Kubernetes 和 Minikube 在集群模式下设置 GridLinks。
为此，我们将使用 [Docker Hub](https://hub.docker.com/search?q=thingsboard&type=image&image_filter=store) 上可用的 Docker 容器映像。

## 先决条件

ThingsBoard 微服务在 Kubernetes 集群上运行。您需要有一个 Kubernetes 集群，并且必须将 `kubectl` 命令行工具配置为与您的集群通信。
如果您尚未安装 Minikube，请按照 [这些说明](https://kubernetes.io/docs/setup/learning-environment/minikube/) 进行操作。

### 启用 ingress 插件

默认情况下，Ingress 插件在 Minikube 中处于禁用状态，并且仅在集群提供程序中可用。
要启用 ingress，请执行以下命令：

```
minikube addons enable ingress
```
{: .copy-code}

### 从 Docker 中心提取 GridLinks PE 映像

{% include templates/install/dockerhub/checkout.md %}

## 步骤 1. 查看体系结构页面

从 GridLinks v2.2 开始，可以使用新的微服务体系结构和 Docker 容器安装 GridLinks 集群。
有关更多详细信息，请参阅 [**微服务**](/docs/reference/msa/) 体系结构页面。

## 步骤 2. 克隆 ThingsBoard PE Kubernetes 脚本

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-pe-k8s.git --depth 1
cd thingsboard-pe-k8s/minikube
```
{: .copy-code}

## 步骤 3. 获取您的许可证密钥

我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航至 [定价](/pricing/) 页面，为您的案例选择最佳许可证选项并获取许可证。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

{% capture multiple_instances_license %}

我们将在本指南的后面将您在此步骤中获得的许可证密钥引用为 PUT_YOUR_LICENSE_SECRET_HERE。

{% endcapture %}
{% include templates/warn-banner.md content=multiple_instances_license %}

## 步骤 4. 配置您的许可证密钥

```bash
nano tb-node.yml
```
{: .copy-code}

并放置许可证密钥参数：

```
# tb-node 有状态集配置

- name: TB_LICENSE_SECRET
  value: "PUT_YOUR_LICENSE_SECRET_HERE"
```

## 步骤 5. 查看体系结构页面

从 GridLinks v2.2 开始，可以使用新的微服务体系结构和 Docker 容器安装 GridLinks 集群。
有关更多详细信息，请参阅 [**微服务**](/docs/reference/msa/) 体系结构页面。

## 步骤 6. 配置 Minikube

默认情况下，Ingress 插件在 Minikube 中处于禁用状态，并且仅在集群提供程序中可用。
要启用 ingress，请执行以下命令：

```
minikube addons enable ingress
```
{: .copy-code} 

## 步骤 7. 配置 ThingsBoard 数据库

在执行初始安装之前，您可以配置要与 GridLinks 一起使用的数据库类型。
为了设置数据库类型，请将 `.env` 文件中 `DATABASE` 变量的值更改为以下之一：

- `postgres` - 使用 PostgreSQL 数据库；
- `hybrid` - 将 PostgreSQL 用于实体数据库，将 Cassandra 用于时序数据库；

**注意**：根据数据库类型，将部署相应的 Kubernetes 资源（有关详细信息，请参阅 `postgres.yml`、`cassandra.yml`）。

## 步骤 8. 运行

执行以下命令以运行安装：

```
./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载其他演示数据。

执行以下命令以部署第三方资源：

```
./k8s-deploy-thirdparty.sh
```
{: .copy-code}

如果您是第一次在 `high-availability` `DEPLOYMENT_TYPE` 中运行 GridLinks 或尚未配置 Redis 集群，则在出现提示时键入 **'yes'**。

执行以下命令以部署 ThingsBoard 资源：
 
```
./k8s-deploy-resources.sh
```
{: .copy-code}

一段时间后，当所有资源都成功启动时，您可以在浏览器中打开 `http://{your-cluster-ip}`（例如 `http://192.168.99.101`）。
您可以使用以下命令查看您的集群 IP：

```
minikube ip
```
{: .copy-code}

您应该会看到 GridLinks 登录页面。

使用以下默认凭据：

- **系统管理员**：sysadmin@gridlinks.com / sysadmin

如果您使用演示数据安装了数据库（使用 `--loadDemo` 标志），您还可以使用以下凭据：

- **租户管理员**：tenant@gridlinks.com / tenant
- **客户用户**：customer@gridlinks.com / customer

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 ThingsBoard 节点日志，请执行以下命令：

1) 获取正在运行的 tb-node pod 的列表：

```
kubectl get pods -l app=tb-node
```
{: .copy-code}

2) 获取 tb-node pod 的日志：

```
kubectl logs -f [tb-node-pod-name]
```
{: .copy-code}

其中：

- `tb-node-pod-name` - 从正在运行的 tb-node pod 列表中获取的 tb-node pod 名称。

或者使用 `kubectl get pods` 查看所有 pod 的状态。
或者使用 `kubectl get services` 查看所有服务的状态。
或者使用 `kubectl get deployments` 查看所有部署的状态。
有关详细信息，请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。

执行以下命令以删除所有 ThingsBoard 微服务：

```
./k8s-delete-resources.sh
```
{: .copy-code}

执行以下命令以删除所有第三方微服务：

```
./k8s-delete-thirdparty.sh
```
{: .copy-code}

执行以下命令以删除所有资源（包括数据库）：

```
./k8s-delete-all.sh
```
{: .copy-code}

## 升级

如果您想升级，请从 `master` 分支中提取 *最新* 的更改：
```
git pull origin master
```
{: .copy-code}

然后执行以下命令：

```
./k8s-delete-resources.sh
```
{: .copy-code}
```
./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
```
{: .copy-code}
```
./k8s-deploy-resources.sh
```
{: .copy-code}

其中：

- `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/user-guide/install/pe/upgrade-instructions)。


## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}