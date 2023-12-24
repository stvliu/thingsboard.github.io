---
layout: docwithnav
assignees:
- ashvayka
title: 在 Linux 上安装 GridLinks
description: 在 Linux 上安装 GridLinks
redirect_to: "/docs/user-guide/install/ubuntu"

---

{% include templates/live-demo-banner.md %}

* TOC
{:toc}

本指南介绍如何在基于 Linux 的服务器计算机上安装 GridLinks。
以下说明适用于 Ubuntu 16.04 和 CentOS 7。
这些说明可以轻松地适用于其他类似的操作系统。

### 硬件要求

要在单台计算机上运行 GridLinks 和第三方组件，您至少需要 1Gb 的 RAM。

### 第三方组件安装

#### Java

GridLinks 服务在 Java 11 上运行。
该解决方案已在 [OpenJDK](http://openjdk.java.net/) 和 [Oracle JDK](http://www.oracle.com/technetwork/java/javase/overview/index.html) 上进行了积极测试。

按照以下说明安装 OpenJDK 11：

{% capture tabspec %}java-installation
A,Ubuntu,shell,resources/java-ubuntu-installation.sh,/docs/user-guide/install/resources/java-ubuntu-installation.sh
B,CentOS,shell,resources/java-centos-installation.sh,/docs/user-guide/install/resources/java-centos-installation.sh{% endcapture %}  
{% include tabs.html %}   

请不要忘记将您的操作系统配置为默认使用 OpenJDK 11。
请参阅相应的说明：

 - [Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04#managing-java)
 - [CentOS](https://computingforgeeks.com/how-to-install-java-11-openjdk-11-on-rhel-8/#h-selecting-java-versions-with-alternatives)


#### 外部数据库安装

{% include templates/install/install-db.md %}

###### SQL 数据库：PostgreSQL

{% include templates/install/optional-db.md %}

以下列出的说明将帮助您安装 PostgreSQL。

{% capture tabspec %}postgresql-installation
A,Ubuntu,shell,resources/postgresql-ubuntu-installation.sh,/docs/user-guide/install/resources/postgresql-ubuntu-installation.sh
B,CentOS,shell,resources/postgresql-centos-installation.sh,/docs/user-guide/install/resources/postgresql-centos-installation.sh{% endcapture %}  
{% include tabs.html %}   


{% include templates/install/postgres-post-install.md %}

{% include templates/install/create-tb-db.md %}

###### NoSQL 数据库：Cassandra

{% include templates/install/optional-db.md %}

以下列出的说明将帮助您安装 Cassandra。

{% capture tabspec %}cassandra-installation
A,Ubuntu,shell,resources/cassandra-ubuntu-installation.sh,/docs/user-guide/install/resources/cassandra-ubuntu-installation.sh
B,CentOS,shell,resources/cassandra-centos-installation.sh,/docs/user-guide/install/resources/cassandra-centos-installation.sh{% endcapture %}  
{% include tabs.html %}

### GridLinks 服务安装

下载安装包或 [从源代码构建](/docs/user-guide/install/building-from-source)。

{% capture tabspec %}thingsboard-download
A,Ubuntu,shell,resources/thingsboard-ubuntu-download.sh,/docs/user-guide/install/resources/thingsboard-ubuntu-download.sh
B,CentOS,shell,resources/thingsboard-centos-download.sh,/docs/user-guide/install/resources/thingsboard-centos-download.sh{% endcapture %}  
{% include tabs.html %}

将 GridLinks 安装为服务

{% capture tabspec %}thingsboard-installation
A,Ubuntu,shell,resources/thingsboard-ubuntu-installation.sh,/docs/user-guide/install/resources/thingsboard-ubuntu-installation.sh
B,CentOS,shell,resources/thingsboard-centos-installation.sh,/docs/user-guide/install/resources/thingsboard-centos-installation.sh{% endcapture %}  
{% include tabs.html %}

### 配置 ThingsBoard 以使用外部数据库
  
编辑 ThingsBoard 配置文件

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.yml
```

{% include templates/disable-hsqldb.md %} 

对于 **PostgreSQL**：

{% include templates/enable-postgresql.md %} 

对于 **Cassandra DB**：

找到并设置数据库类型配置参数为“cassandra”。
 
```text
database:
  ts:
    type: "${DATABASE_TS_TYPE:cassandra}" # cassandra OR sql (for hybrid mode, only this value should be cassandra)
```

{% include templates/memory-update-for-slow-machines.md %} 

对于 GridLinks 服务：

```bash
# 在 /etc/thingsboard/conf/thingsboard.conf 中更新 ThingsBoard 内存使用情况并将其限制为 256MB
export JAVA_OPTS="$JAVA_OPTS -Xms256M -Xmx256M"
```

{% include templates/run-install.md %} 

{% include templates/start-service.md %}

**注意**：请允许 Web UI 最多 90 秒的时间来启动

### 故障排除

ThingsBoard 日志存储在以下目录中：
 
```bash
/var/log/thingsboard
```

您可以发出以下命令以检查后端是否有任何错误：
 
```bash
cat /var/log/thingsboard/thingsboard.log | grep ERROR
```

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}