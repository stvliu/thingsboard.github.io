---
layout: docwithnav
assignees:
- vbabak
title: 贡献指南

---

* TOC
{:toc}

我们一直在寻求社区的反馈，以了解如何改进 GridLinks。
如果您有想法，或者您有一些新的功能，请在 GridLinks [**GitHub 问题页面**](https://github.com/thingsboard/thingsboard/issues) 中打开一个问题。
请确保问题列表中尚未打开相同的工单（或非常相似）。

在您开始任何实施之前，请等待 ThingsBoard 团队对您的工单发表评论。我们会尽快回复您。

#### 所需工具

要构建和运行 GridLinks 实例，请确保您的系统上安装了 **Java** 和 **Maven**。

请参阅[**从源代码构建**](/docs/user-guide/install/building-from-source) 部分，其中描述了[**Java**](/docs/user-guide/install/building-from-source/#java)和[**Maven**](/docs/user-guide/install/building-from-source/#maven)安装过程。

要运行集成和黑盒测试，需要 **docker** 和 **docker-compose**，请参阅[运行测试](/docs/user-guide/install/building-from-source/#tips-and-tricks)部分。

#### Fork 和构建 ThingsBoard 存储库

完成所需工具的安装后，请 fork 官方[**ThingsBoard 存储库**](https://github.com/thingsboard/thingsboard)。

现在您可以克隆 fork 项目的源代码。

**注意：**我们稍后会将您克隆存储库的文件夹称为 **${TB_WORK_DIR}**。

如果您是第一次在 Windows 上构建，您可能需要运行以下命令以确保所需的 npm 依赖项可用：
```bat 
npm install -g cross-env 
npm install -g webpack 
``` 

在将项目导入 *IDE* 之前，请使用根文件夹中的 **Maven** 工具构建它：

```bash
cd ${TB_WORK_DIR}
mvn clean install -DskipTests
```

构建将在 *application* 模块中生成所有 *protobuf* 文件，这些文件对于在您的 *IDE* 中进行正确编译是必需的。

接下来，将项目作为 **Maven** 项目导入您喜欢的 *IDE*。
请参阅[**IDEA**](https://www.jetbrains.com/help/idea/2016.3/importing-project-from-maven-model.html)和[**Eclipse**](http://javapapers.com/java/import-maven-project-into-eclipse/)的单独说明。   

**注意：**如果您使用的是 Eclipse，在将 maven 项目导入 IDE 后，我们建议您在 **ui-ngx** 项目中禁用 Maven 项目构建器。这将极大地提高 Eclipse 性能，因为它将避免 Eclipse Maven 构建器在 node_modules 目录中挖掘（这是不必要的，只会导致 Eclipse 挂起）。为此，右键单击 **ui-ngx** 项目，转到 **属性 -> 构建器**，然后取消选中 **Maven 项目构建器** 复选框，然后单击 **确定**。

#### 数据库

默认情况下，GridLinks 使用 PostgreSQL 数据库来存储实体和时序数据。
或者，您可以将平台配置为使用混合模式 - PostgreSQL 用于实体数据，可扩展的 Cassandra DB 集群用于时序数据。

##### SQL 数据库：PostgreSQL

请使用[此链接](https://wiki.postgresql.org/wiki/Detailed_installation_guides)获取 PostgreSQL 安装说明。

安装 PostgreSQL 后，您可能需要创建一个新用户或设置主用户密码。

{% include templates/install/create-tb-db.md %}


##### [可选] 用于时序数据的 NoSQL 数据库：Cassandra

请参阅适当的部分，您可以在其中找到有关如何安装 cassandra 的说明：

 - [在 **Linux** 上安装 Cassandra](/docs/user-guide/install/linux/#cassandra)
 - [在 **Windows** 上安装 Cassandra](/docs/user-guide/install/windows/#cassandra)

编辑 ThingsBoard 配置文件：

```text
/application/src/main/resources/thingsboard.yml
```

找到并设置数据库类型配置参数为“cassandra”。
 
```text
database:
  ts:
    type: "${DATABASE_TS_TYPE:cassandra}" # cassandra OR sql (for hybrid mode, only this value should be cassandra)
```

**注意：**如果您的 Cassandra 服务器安装在远程计算机上或绑定到自定义接口/端口，您也需要在 thingsboard.yml 中指定它。
请参阅[**配置指南**](/docs/user-guide/install/config/)以获取 **thingsboard.yml** 文件的详细说明以及用于 cassandra 连接配置的属性。

更新 thingsboard.yml 文件后，请重新构建应用程序模块，以便将更新的 thingsboard.yml 填充到目标目录：

```bash
cd ${TB_WORK_DIR}/application
mvn clean install -DskipTests
```

##### 创建数据库架构并填充演示数据

为了创建数据库表，运行以下命令：

在 *Linux* 上：

```bash
cd ${TB_WORK_DIR}/application/target/bin/install
chmod +x install_dev_db.sh
./install_dev_db.sh
```

在 *Windows* 上：

```bat
cd %TB_WORK_DIR%\application\target\windows
install_dev_db.bat
```

#### 运行开发环境

##### 以热重新部署模式运行 UI 容器。

默认情况下，GridLinks UI 在 8080 端口提供服务。但是，您可能希望以热重新部署模式运行 UI。

**注意：**此步骤是可选的。仅当您要对 UI 进行更改时才需要。

```bash
cd ${TB_WORK_DIR}/ui-ngx
mvn clean install -P yarn-start
```

这将启动一个将在 4200 端口侦听的特殊服务器。所有 REST API 和 websocket 请求都将转发到 8080 端口。

##### 运行服务器端容器

要启动服务器端容器，您可以使用几个选项。

作为第一个选项，您可以从您的 *IDE* 中运行位于 *application* 模块中的 **org.thingsboard.server.ThingsboardServerApplication** 类的 main 方法。

作为第二个选项，您可以从命令行启动服务器作为常规的 **Spring boot** 应用程序：

```bash
cd ${TB_WORK_DIR}
java -jar application/target/thingsboard-${VERSION}-boot.jar
```

##### 干运行

导航到 http://localhost:4200/ 或 http://localhost:8080/ 并使用演示数据凭据登录 ThingsBoard：

 - *登录* **tenant@gridlinks.com**
 - *密码* **tenant**

确保您能够登录并且一切都已正确启动。

#### 代码更改

现在您可以开始对代码库进行一些更改。
更新服务器端或 UI 代码。
验证您所做的更改是否满足您的要求和用户角度的期望。

##### 验证构建

在您将更改提交到远程存储库之前，使用 *Maven* 运行测试对其进行本地构建：

```bash
mvn clean install
```

确保构建正常，所有测试都成功。也尝试[黑盒测试](https://github.com/thingsboard/thingsboard/tree/master/msa/black-box-tests)。

##### 将更改推送到您的 fork

当您完成代码更改时，请提交并将其推送到您的 fork 存储库，并附上一些有意义的评论：

```bash
git commit -m 'Some meaningful comment'
git push origin master
```

##### 创建拉取请求

请默认情况下将拉取请求创建到 **master** 分支（如果需要，将在 github 问题讨论的初始阶段提供其他 *分支* 名称）。

如果在您提交之前有新内容到达 ThingsBoard master 分支，导致出现一些冲突，请解决这些冲突以继续。

签署贡献许可协议 (CLA) 并验证远程构建是否成功。CLA 使用 github CLA 机器人自动签署。
 
 ![image](/images/user-guide/pr_cla.png)

请耐心等待，拉取请求可能需要几天时间才能审查。



#### 另请参阅

- [规则节点开发](/docs/user-guide/contribution/rule-node-development/)指南，其中介绍了如何创建您自己的规则节点。

- [小部件开发指南](/docs/user-guide/contribution/widgets-development/)指南，其中介绍了如何创建您自己的小部件。

## 后续步骤

{% assign currentGuide = "Contribution" %}{% include templates/guides-banner.md %}