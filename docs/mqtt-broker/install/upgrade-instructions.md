---
layout: docwithnav-mqtt-broker
title: 升级说明
description: TBMQ 升级说明
notitle: "true"
---

* TOC
{:toc}

<div class="installation-options">
    <div class="install-options-header">
       <div class="install-options-hero">
          <div class="container">
            <div class="install-options-hero-content">
                <h1>TBMQ 升级选项</h1>
            </div>
            <div class="deployment-container one-line-deployment-container">
                <div class="deployment-div">
                    <div class="container">
                        <div class="deployment-section deployment-on-premise active" id="onPremise">
                           <div class="deployment-cards">
                                <div class="deployment-cards-container">
                                    <div class="deployment-card-block">
                                        <a href="/docs/mqtt-broker/install/docker/#upgrading">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/docker-linux-macos.svg" title="Docker (Linux 或 Mac OS)" alt="Docker (Linux 或 Mac OS)">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/mqtt-broker/install/docker-windows/#upgrading">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/docker-windows.svg" title="Docker (Windows)" alt="Docker (Windows)">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/mqtt-broker/install/cluster/docker-compose-setup/#upgrading">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cluster/docker-compose.svg" title="使用 Docker Compose 设置集群" alt="使用 Docker Compose 设置集群">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/mqtt-broker/install/cluster/minikube-cluster-setup/#upgrading">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cluster/minikube.svg" title="使用 Minikube 设置集群" alt="使用 Minikube 设置集群">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/mqtt-broker/install/cluster/aws-cluster-setup/#upgrading">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cloud/eks.svg" title="在 EKS 上设置集群" alt="AWS K8S 集群">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/mqtt-broker/install/cluster/azure-cluster-setup/#upgrading">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cloud/azure.svg" title="在 AKS 上设置集群" alt="Azure K8S 集群">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
       </div>
    </div>
</div>

### 升级到 1.2.1

{% capture difference %}
**注意**：
<br>
这些步骤适用于 1.2.0 TBMQ 版本。要升级到 1.2.1，您需要先 [升级到 1.2.0](#upgrading-to-120)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 拉取 TBMQ 镜像（可选）

根据当前安装拉取 1.2.1 版本 TBMQ 镜像。

{% capture tabspec %}tbmq-pull-1-2-1
tbmq-pull-1-2-1-single,单节点,shell,resources/1.2.1/tbmq-single-node-pull.sh,/docs/mqtt-broker/install/resources/1.2.1/tbmq-single-node-pull.sh
tbmq-pull-1-2-1-cluster,集群模式,shell,resources/1.2.1/tbmq-cluster-mode-pull.sh,/docs/mqtt-broker/install/resources/1.2.1/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### 从版本

_fromVersion_ 应设置为 **1.2.0**。

导航到相应的文档以继续执行后续升级步骤，方法是 [选择页面顶部的其中一张卡片](/docs/mqtt-broker/install/upgrade-instructions/)。

### 升级到 1.2.0

{% capture difference %}
**注意**：
<br>
这些步骤适用于 1.1.0 TBMQ 版本。要升级到 1.2.0，您需要先 [升级到 1.1.0](#upgrading-to-110)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 拉取 TBMQ 镜像（可选）

根据当前安装拉取 1.2.0 版本 TBMQ 镜像。

{% capture tabspec %}tbmq-pull-1-2-0
tbmq-pull-1-2-0-single,单节点,shell,resources/1.2.0/tbmq-single-node-pull.sh,/docs/mqtt-broker/install/resources/1.2.0/tbmq-single-node-pull.sh
tbmq-pull-1-2-0-cluster,集群模式,shell,resources/1.2.0/tbmq-cluster-mode-pull.sh,/docs/mqtt-broker/install/resources/1.2.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### 从版本

_fromVersion_ 应设置为 **1.1.0**。

导航到相应的文档以继续执行后续升级步骤，方法是 [选择页面顶部的其中一张卡片](/docs/mqtt-broker/install/upgrade-instructions/)。

### 升级到 1.1.0

{% capture difference %}
**注意**：
<br>
这些步骤适用于 1.0.0 和 1.0.1 TBMQ 版本。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 拉取 TBMQ 镜像（可选）

根据当前安装拉取 1.1.0 版本 TBMQ 镜像。

{% capture tabspec %}tbmq-pull-1-1-0
tbmq-pull-1-1-0-single,单节点,shell,resources/1.1.0/tbmq-single-node-pull.sh,/docs/mqtt-broker/install/resources/1.1.0/tbmq-single-node-pull.sh
tbmq-pull-1-1-0-cluster,集群模式,shell,resources/1.1.0/tbmq-cluster-mode-pull.sh,/docs/mqtt-broker/install/resources/1.1.0/tbmq-cluster-mode-pull.sh{% endcapture %}
{% include tabs.html %}

#### 从版本

_fromVersion_ 可以设置为 **1.0.0** 或 **1.0.1** 值。

导航到相应的文档以继续执行后续升级步骤，方法是 [选择页面顶部的其中一张卡片](/docs/mqtt-broker/install/upgrade-instructions/)。

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}