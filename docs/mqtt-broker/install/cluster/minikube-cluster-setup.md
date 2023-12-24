---
layout: docwithnav-mqtt-broker
title: 使用 Minikube 进行集群设置
description: 使用 Kubernetes 和 Minikube 指南设置 TBMQ 集群

---

* TOC
{:toc}

本指南将帮助您使用 Minikube 在集群模式下设置 TBMQ。

### 先决条件

您需要有一个 Kubernetes 集群，并且必须将 `kubectl` 命令行工具配置为与您的集群通信。
如果您尚未安装 Minikube，请按照 [这些说明](https://kubernetes.io/docs/setup/learning-environment/minikube/) 进行操作。
此外，您还需要安装 [helm](https://helm.sh/docs/intro/install/)。

### 步骤 1. 克隆 TBMQ 存储库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/minikube
```
{: .copy-code}

### 步骤 2. 安装

要安装 TBMQ，请执行以下命令：

```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

### 步骤 3. 运行

执行以下命令以部署 TBMQ：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

一段时间后，当所有资源都成功启动时，您可以在浏览器中打开 `http://{your-cluster-ip}:30001`（例如 **http://192.168.49.2:30001**）。
您可以使用以下命令检查您的集群 IP：
```bash
minikube ip
```
{: .copy-code}

{% include templates/mqtt-broker/login.md %}

### 步骤 4. 日志、删除有状态集和服务

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 TBMQ 节点日志，请执行以下命令：

1) 获取正在运行的 tb-broker pod 列表：

```bash
kubectl get pods -l app=tb-broker
```
{: .copy-code}

2) 获取 tb-broker pod 的日志：

```bash
kubectl logs -f TB_BROKER_POD_NAME
```
{: .copy-code}

其中：

- `TB_BROKER_POD_NAME` - 从正在运行的 tb-broker pod 列表中获取的 tb-broker pod 名称。

或者使用以下命令查看所有 pod 的状态。
```bash
kubectl get pods
```
{: .copy-code}

使用以下命令查看所有服务的状态。
```bash
kubectl get services
```
{: .copy-code}

使用以下命令查看所有部署的状态。
```bash
kubectl get deployments
```
{: .copy-code}

使用以下命令查看所有有状态集的状态。
```bash
kubectl get statefulsets
```
{: .copy-code}

有关更多详细信息，请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 命令参考。

执行以下命令以删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令以删除所有资源（包括数据库）：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

### 升级

{% include templates/mqtt-broker/install/migration.md %}

如果您想升级，请从最新的发布分支中提取最近的更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

**注意**：确保在合并过程中不会丢失您可用的自定义更改。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

之后执行以下命令：

```bash
./k8s-delete-tbmq.sh
./k8s-upgrade-tbmq.sh --fromVersion=FROM_VERSION
./k8s-deploy-tbmq.sh
```
{: .copy-code}

其中 `FROM_VERSION` - 从哪个版本开始升级。
有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/mqtt-broker/install/upgrade-instructions/)。

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}