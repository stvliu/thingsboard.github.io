---
layout: docwithnav-edge
title: 从源代码构建
description: 从源代码构建 ThingsBoard Edge

---

* TOC
{:toc}

本指南将帮助您从源代码下载并构建 ThingsBoard Edge。以下列出的说明已在 Ubuntu 20.04 LTS 和 CentOS 7/8 上进行了测试

#### 所需工具

本节包含构建工具的安装说明。

##### Java

ThingsBoard 使用 Java 11 构建。您可以使用 [以下说明](/docs/user-guide/install/linux#java) 安装 Java 11。

##### Maven

ThingsBoard 构建需要 Maven 3.1.0+。

{% capture tabspec %}maven-installation
A,Ubuntu,shell,resources/maven-ubuntu-installation.sh,/docs/user-guide/install/resources/maven-ubuntu-installation.sh
B,CentOS,shell,resources/maven-centos-installation.sh,/docs/user-guide/install/resources/maven-centos-installation.sh{% endcapture %}
{% include tabs.html %}

**请注意**，maven 安装可能会在某些 Linux 机器上将 Java 7 设置为默认 JVM。
使用 java 安装 [说明](#java) 来修复此问题。

#### 源代码

您可以从官方 [github 仓库](https://github.com/thingsboard/thingsboard-edge) 克隆项目的源代码。

```bash
# checkout latest release branch
git clone -b {{ site.release.branch }} git@github.com:thingsboard/thingsboard-edge.git
cd thingsboard-edge
```
{: .copy-code}

#### 构建

从 thingsboard edge 文件夹运行以下命令以构建项目：

```bash
mvn clean install -DskipTests
```
{: .copy-code}

#### 构建本地 docker 镜像

确保已安装 [Docker](https://docs.docker.com/engine/install/)。

```bash
mvn clean install -DskipTests -Ddockerfile.skip=false
```
{: .copy-code}

#### 构建工件

您可以在 target 文件夹中找到 debian、rpm 和 windows 软件包：
 
```bash
application/target
```

#### 提示和技巧

在全新的干净环境中，Thingsboard Edge 从源代码构建非常容易。

以下是一些提高构建体验的提示和技巧：

- [清除 maven 缓存](https://www.baeldung.com/maven-clear-cache)
```bash
rm -rf ~/.m2/repository
```
{: .copy-code}

- 清除 gradle 缓存
```bash
rm -rf ~/.gradle/caches/
```
{: .copy-code}

- 清除 node 模块
```bash
rm -rf ui-ngx/node_modules
```
{: .copy-code}

- 并行构建、格式化头文件、构建 docker 镜像
```bash
mvn -T 0.8C license:format clean install -DskipTests -Ddockerfile.skip=false
```
{: .copy-code}