---
layout: docwithnav-mqtt-broker
title: 从源代码构建
description: 从源代码构建 TBMQ

---

* TOC
{:toc}

本指南将帮助您从源代码下载并构建 TBMQ。以下列出的说明已在 Ubuntu 20.04 LTS 上进行了测试。

#### 所需工具

本节包含构建工具的安装说明。

##### Java

TBMQ 使用 Java 17 构建。请按照以下说明安装 OpenJDK 17：

```bash
sudo apt update
sudo apt install openjdk-17-jdk
```
{: .copy-code}

请不要忘记将您的操作系统配置为默认使用 OpenJDK 17。
您可以使用以下命令配置哪个版本是默认版本：

```bash
sudo update-alternatives --config java
```
{: .copy-code}

您可以使用以下命令检查安装情况：

```bash
java -version
```
{: .copy-code}

预期的命令输出是：

```text
openjdk version "17.0.xx"
OpenJDK Runtime Environment (...)
OpenJDK 64-Bit Server VM (build ...)
```

##### Maven

TBMQ 构建需要 Maven 3.6.3+。

```bash
sudo apt install maven
```
{: .copy-code}

**请注意**，在某些 Linux 机器上，maven 安装可能会将 Java 7 设置为默认 JVM。
使用 java 安装 [说明](#java) 来解决此问题。

#### 源代码

您可以从官方 [GitHub 仓库](https://github.com/thingsboard/tbmq) 克隆项目的源代码。

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq
```
{: .copy-code}

#### 构建

从 TBMQ 文件夹运行以下命令以构建项目：

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
cd application/target
```
{: .copy-code}

#### 运行测试

我们使用 [Docker](https://docs.docker.com/engine/install/) 来运行所有类型的集成和黑盒测试。

请将 [Docker 管理为非 root 用户](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) 以正确运行测试。

主分支和发布分支已经过测试，因此您可以跳过测试并避免安装 docker。

运行所有单元和集成测试：

```bash
mvn clean install
```
{: .copy-code}

#### 提示和技巧

在全新的干净环境中，从源代码构建 TBMQ 非常容易。

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