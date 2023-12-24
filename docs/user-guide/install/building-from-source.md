---
layout: docwithnav
assignees:
- ashvayka
title: 从源代码构建
description: 从源代码构建 ThingsBoard IoT 平台

---

* TOC
{:toc}

本指南将帮助您从源代码下载并构建 ThingsBoard。以下列出的说明已在 Ubuntu 20.04 LTS 和 CentOS 7/8 上进行了测试

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

{% capture windows_line_endings %}
**注意：在 Windows 机器上构建 Docker 镜像**

要构建 Docker 镜像，某些脚本、配置文件和源（将成为 Docker 镜像的一部分）必须具有 **LF** 行尾。
因此，在克隆仓库之前，将 Git [core.autocrlf](https://git-scm.com/docs/git-config#Documentation/git-config.txt-coreautocrlf) 配置选项设置为 _input_。

例如，要全局设置 *core.autocrlf*：

`git config --global core.autocrlf input`{:.language-bash}
{% endcapture %}
{% include templates/warn-banner.md content=windows_line_endings %}

您可以从官方 [github 仓库](https://github.com/thingsboard/thingsboard) 克隆项目的源代码。

```bash
# checkout latest release branch
git clone -b {{ site.release.branch }} git@github.com:thingsboard/thingsboard.git --depth 1
cd thingsboard
```
{: .copy-code}

#### 构建

从 thingsboard 文件夹运行以下命令以构建项目：

```bash
mvn clean install -DskipTests
```
{: .copy-code}

#### 构建本地 docker 镜像

{% include templates/warn-banner.md content=windows_line_endings %}

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
{: .copy-code}

#### 运行测试

我们使用 [docker](https://docs.docker.com/engine/install/) 和 [docker-compose](https://docs.docker.com/compose/install/) 来运行各种集成和 [黑盒测试](https://github.com/thingsboard/thingsboard/tree/master/msa/black-box-tests)。

请将 [Docker 管理为非 root 用户](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) 以正确运行测试。

主分支和发布分支已经过测试，因此您可以跳过测试并避免安装 docker。

运行所有单元和集成测试：

```bash
mvn clean install
```
{: .copy-code}

要运行黑盒测试，请参阅 [黑盒测试自述文件](https://github.com/thingsboard/thingsboard/blob/master/msa/black-box-tests/README.md)。

在 AMD Ryzen 5 3600（6 核）、32GB DDR4、花哨的 SSD 和晴朗的天气下，估计时间约为 1 小时。实际时间可能会有所不同，具体取决于特定硬件性能。

#### 提示和技巧

在全新的干净环境中，Thingsboard 从源代码构建非常容易。

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

#### 构建和运行时错误

- 如果在运行本地构建的 Docker 镜像时看到此类错误，请使用 **LF** [文件结尾](https://git-scm.com/docs/git-config#Documentation/git-config.txt-coreautocrlf) 重新克隆仓库并重新构建镜像。要修复此问题，请阅读 [源代码](#source-code) 部分。

```bash
Standard_init_linux.go:175 exec user process caused no such file
```
{: .copy-code}