---
layout: docwithnav
assignees:
- ashvayka
title: 使用 OpenShift 进行集群设置
description: ThingsBoard IoT 平台集群设置，附带 Kubernetes 和 OpenShift 指南

---

* TOC
{:toc}

本指南将帮助您使用 OpenShift 在集群模式下设置 ThingsBoard。

## 先决条件

ThingsBoard 微服务在 Kubernetes 集群上运行。要本地部署 OpenShift 集群，您需要 Docker CE 来运行 OpenShift 容器和 OpenShift Origin 本身。
请按照 [这些说明](https://www.techrepublic.com/article/how-to-install-openshift-origin-on-ubuntu-18-04/) 安装所有必需的软件。


### 登录 OpenShift 集群

要访问 OpenShift 集群，您必须先登录。默认情况下，您可以作为 `developer` 用户登录：

```
oc login -u developer -p developer
``` 
{: .copy-code}

### 创建项目

在首次启动时，您应该创建 `thingsboard` 项目。
要创建它，请执行以下命令：

```
oc new-project thingsboard
``` 
{: .copy-code}


## 步骤 1. 查看架构页面

从 ThingsBoard v2.2 开始，可以使用新的微服务架构和 docker 容器安装 ThingsBoard 集群。
有关更多详细信息，请参阅 [**微服务**](/docs/reference/msa/) 架构页面。

## 步骤 2. 克隆 ThingsBoard CE Kubernetes 脚本存储库

```bash
git clone -b release-{{ site.release.ver }} https://github.com/thingsboard/thingsboard-ce-k8s.git --depth 1
cd thingsboard-ce-k8s/openshift
```
{: .copy-code}

## 步骤 3. 配置 ThingsBoard 数据库

在执行初始安装之前，您可以配置要与 ThingsBoard 一起使用的数据库类型。
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

## 步骤 5. 运行

执行以下命令运行安装：

```
./k8s-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载其他演示数据。

执行以下命令部署第三方资源：

```
./k8s-deploy-thirdparty.sh
```
{: .copy-code}

如果您是第一次在 `high-availability` `DEPLOYMENT_TYPE` 中运行 ThingsBoard 或没有配置 Redis 集群，则在出现提示时键入 **'yes'**。


执行以下命令部署 ThingsBoard 资源：

```
./k8s-deploy-resources.sh
```
{: .copy-code}

要了解如何在集群上访问您的 ThingsBoard 应用程序，请以 ***developer*** 用户身份登录（默认密码也是 ***developer***），打开 `thingsboard` 项目，然后转到 `Application -> Routes` 菜单，您将看到所有配置的路由。
*根* 路由应类似于 `https://tb-route-node-root-thingsboard.127.0.0.1.nip.io/`。

当您打开它时，您应该会看到 ThingsBoard 登录页面。

使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin

如果您使用 `--loadDemo` 标志安装了带有演示数据的数据库，您还可以使用以下凭据：

- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 ThingsBoard 节点日志，请执行以下命令：

1) 获取正在运行的 tb-node pod 列表：

```
oc get pods -l app=tb-node
```
{: .copy-code}

2) 获取 tb-node pod 的日志：

```
oc logs -f [tb-node-pod-name]
```
{: .copy-code}

其中：

- `tb-node-pod-name` - 从正在运行的 tb-node pod 列表中获取的 tb-node pod 名称。

或者使用 `oc get pods` 查看所有 pod 的状态。
或者使用 `oc get services` 查看所有服务的状态。
或者使用 `oc get deployments` 查看所有部署的状态。
有关详细信息，请参阅 [oc 速查表](https://design.jboss.org/redhatdeveloper/marketing/openshift_cheatsheet/cheatsheet/images/openshift_cheat_sheet_r1v1.pdf) 命令参考。

执行以下命令删除所有 ThingsBoard 微服务：

```
./k8s-delete-resources.sh
```
{: .copy-code}

执行以下命令删除所有第三方微服务：

```
./k8s-delete-thirdparty.sh
```
{: .copy-code}

执行以下命令删除所有资源（包括数据库）：

```
./k8s-delete-all.sh
```
{: .copy-code}

## 升级

如果需要数据库升级，请执行以下命令：

```
./k8s-delete-resources.sh
./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
./k8s-deploy-resources.sh
```
{: .copy-code}

其中：

- `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/user-guide/install/upgrade-instructions)。

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}