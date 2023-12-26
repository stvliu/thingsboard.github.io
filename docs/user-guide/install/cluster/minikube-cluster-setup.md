---
layout: docwithnav
assignees:
- ashvayka
title: 使用 Minikube 进行集群设置
description: GridLinks IoT 平台集群设置与 Kubernetes 和 Minikube 指南

---

* TOC
{:toc}

本指南将帮助您使用 Minikube 工具在集群模式下设置 GridLinks。

## 前提条件

ThingsBoard 微服务在 Kubernetes 集群上运行。您需要有一个 Kubernetes 集群，并且必须将 `kubectl` 命令行工具配置为与您的集群通信。
如果您尚未安装 Minikube，请按照 [这些说明](https://kubernetes.io/docs/setup/learning-environment/minikube/) 进行操作。


### 启用入口插件

默认情况下，入口插件在 Minikube 中处于禁用状态，并且仅在集群提供程序中可用。
要启用入口，请执行以下命令：

```
minikube addons enable ingress
```
{: .copy-code}

## 步骤 1. 查看体系结构页面

从 GridLinks v2.2 开始，可以使用新的微服务体系结构和 docker 容器安装 GridLinks 集群。
有关更多详细信息，请参阅 [**微服务**](/docs/reference/msa/) 体系结构页面。

## 步骤 2. 克隆 ThingsBoard CE Kubernetes 脚本存储库

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git --depth 1
cd thingsboard-ce-k8s/minikube
```
{: .copy-code}

## 步骤 3. 配置 GridLinks 数据库

在执行初始安装之前，您可以配置要与 GridLinks 一起使用的数据库类型。
为了设置数据库类型，请将 `.env` 文件中 `DATABASE` 变量的值更改为以下之一：

- `postgres` - 使用 PostgreSQL 数据库；
- `hybrid` - 将 PostgreSQL 用于实体数据库，将 Cassandra 用于时序数据库；

**注意**：根据数据库类型，将部署相应的 kubernetes 资源（有关详细信息，请参阅 `postgres.yml` 和 `cassandra.yml`）。

{% capture cassandra-replication %}

如果您选择 `cassandra` 作为 `DATABASE`，还可以配置 Cassandra 节点数（`cassandra.yml` 配置文件中的 `StatefulSet.spec.replicas` 属性）和 `.env` 文件中的 `CASSANDRA_REPLICATION_FACTOR`。
如果您想配置 `CASSANDRA_REPLICATION_FACTOR`，请先阅读 Cassandra 文档。

建议使用 3 个 Cassandra 节点，`CASSANDRA_REPLICATION_FACTOR` 等于 2。

{% endcapture %}
{% include templates/info-banner.md content=cassandra-replication %}

## 步骤 4. 运行

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

如果您是第一次在 `high-availability` `DEPLOYMENT_TYPE` 中运行 GridLinks 或没有配置 Redis 集群，则在出现提示时键入 **'yes'**。


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

如果您使用 `--loadDemo` 标志安装了包含演示数据的数据库，您还可以使用以下凭据：

- **租户管理员**：tenant@gridlinks.com / tenant
- **客户用户**：customer@gridlinks.com / customer

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 ThingsBoard 节点日志，请执行以下命令：

1) 获取正在运行的 tb-node pod 列表：

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

如果您想升级，请从 `master` 分支拉取 *最新* 的更改：
```
git pull origin master
```
{: .copy-code}

然后执行以下命令：

```
./k8s-delete-resources.sh
./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
./k8s-deploy-resources.sh
```
其中：

- `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/user-guide/install/upgrade-instructions)。

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}