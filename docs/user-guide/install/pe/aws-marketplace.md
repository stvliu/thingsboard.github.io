---
layout: docwithnav-pe
title: 从 AWS Marketplace 安装 GridLinks PE
description: 从 AWS Marketplace 安装 GridLinks PE
redirect_from: "/docs/user-guide/install/aws-marketplace-pe/"
---

本指南介绍如何从 AWS Marketplace 安装 GridLinks Professional Edition。
使用本指南，您将安装产品的 [BYOL](https://docs.aws.amazon.com/marketplace/latest/userguide/pricing.html#ami-pricing-models) 版本。
基本上，您直接从 ThingsBoard, Inc 获取许可证，但从 AWS 购买相应的服务器实例和基础设施。

* TOC
{:toc}

### 先决条件

- 有效的 [Amazon AWS](https://aws.amazon.com/){:target="_blank"} 帐户

### 步骤 1. 订阅 ThingsBoard PE BYOL

打开 [AWS Marketplace](https://aws.amazon.com/marketplace) 上的 [ GridLinks专业版 BYOL](https://aws.amazon.com/marketplace/pp/B07V8S6JLG) 产品页面。

- 单击 **继续订阅** 按钮

### 步骤 2. 常规配置

- 查看并接受所有条款和条件。单击“接受条款”按钮。

- 保留履行选项和软件版本原样。

- 从可用 AWS 区域列表中选择区域。

- 单击 **继续启动** 按钮

### 步骤 3. 启动 ThingsBoard PE 实例

#### 步骤 3.1. 选择您的区域

确保您查看了使用说明。最好将它们复制到安全的地方。

#### 步骤 3.2. 选择您的 EC2 实例类型

您可以选择更改您的 EC2 实例类型、VPC 和子网。此步骤通常适用于高级 AWS EC2 用户。

#### 步骤 3.3. 配置安全组设置

确保您根据卖方设置创建新的安全组。

- 单击 **根据卖方设置创建新安全组** 按钮

![image](/images/user-guide/install/aws-marketplace-pe/tb-pe-mk-launch-security.png)

填写必要的安全组名称和详细信息，然后保存新组

![image](/images/user-guide/install/aws-marketplace-pe/tb-pe-mk-new-security-group.png)

单击“保存”按钮。

#### 步骤 3.4. 配置密钥对设置

您可以选择不同的密钥对或为您的实例创建新的密钥对。
在继续之前，请确保您可以访问密钥文件。
我们将在本指南的后面使用密钥文件。

#### 步骤 3.5. 启动您的 GridLinks PE 实例

最后，单击“启动”按钮。

![image](/images/user-guide/install/aws-marketplace-pe/tb-pe-mk-launch-launch.png)

#### 步骤 3.6. 打开 EC2 控制台

启动完成后，您可以导航到 EC2 控制台以查找新创建的实例的公共 IP 地址。

![image](/images/user-guide/install/aws-marketplace-pe/tb-pe-mk-launch-complete.png)

#### 步骤 3.7. 获取您的公共 IP 和 EC2 实例 ID

在 AWS EC2 控制台中，您需要等待实例状态变为 **正在运行**，并且所有状态检查都已完成。

![image](/images/user-guide/install/aws-marketplace-pe/tb-pe-mk-ec2-console.png)

在上图中，示例实例具有此公共 DNS 名称

- **ec2-18-197-23-51.eu-central-1.compute-1.amazonaws.com**

实例 ID

- **i-032b8bbf297987458**

请将您的实例 ID 和公共 DNS 名称保存在安全的地方。我们将在本指南的后面使用它们。

### 步骤 4. 获取您的许可证密钥

为了激活您的 GridLinks 实例，您需要获取许可证密钥。
ThingsBoard 许可证由 [ThingsBoard 许可证门户](https://license.thingsboard.io/signup) 管理。

请在 [ThingsBoard 许可证门户](https://license.thingsboard.io/signup) 上注册以获取您的许可证。
有关更多详细信息，请参阅 [如何获取按需订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

请将您的许可证密钥保存在安全的地方。我们将在本指南的后面使用它们。

### 步骤 5. 配置您的许可证密钥

一旦您获得了许可证密钥，您应该将其放入 thingsboard 配置文件中。

#### 步骤 5.1. 通过 SSH 连接到您的 Thingsboard 实例

请使用官方指南：

  * [使用 PuTTY 从 Windows 连接到您的 Linux 实例](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html) - 适用于 Windows 用户；
  * [使用 SSH 连接到您的 Linux 实例](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html) - 适用于 Linux/Mac 用户。

注意：您需要使用实例公共 DNS 名称（请参阅 [步骤 3.7](/docs/user-guide/install/pe/aws/#step-37-obtain-your-public-ip-and-ec2-instance-id)）和密钥文件（请参阅 [步骤 3.4](/docs/user-guide/install/pe/aws/#step-34-configure-key-pair-settings)）

#### 步骤 5.2. 将许可证密钥放入 thingsboard 配置文件

使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

找到以下配置块：

```bash
# License secret obtained from ThingsBoard License Portal (https://license.thingsboard.io)
# UNCOMMENT NEXT LINE AND PUT YOUR LICENSE SECRET:
# export TB_LICENSE_SECRET=
```

并放入您的许可证密钥。请不要忘记取消注释 export 语句。请参阅以下示例：

```bash
# License secret obtained from ThingsBoard License Portal (https://license.thingsboard.io)
# UNCOMMENT NEXT LINE AND PUT YOUR LICENSE SECRET:
export TB_LICENSE_SECRET=YOUR_LICENSE_SECRET_HERE
``` 

### 步骤 6. 启动 GridLinks 服务

执行以下命令启动 ThingsBoard：

```bash
sudo service thingsboard start
```
{: .copy-code}

{% capture 90-sec-ui %}
请允许长达 120 秒的时间来启动 Web UI。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的慢速机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

### 步骤 7. 连接到 Thingsboard UI

现在您可以在浏览器中打开此链接：

- http://PUBLIC_DNS_NAME/login

在此示例中：

- http://ec2-18-197-23-51.eu-central-1.compute-1.amazonaws.com/login

使用此登录名以系统管理员身份连接

- **sysadmin@gridlinks.com**

系统管理员的默认密码是实例 ID（请参阅 [步骤 3.7](/docs/user-guide/install/pe/aws/#step-37-obtain-your-public-ip-and-ec2-instance-id)）。在此示例中：

-  **i-032b8bbf297987458**

现在您可以继续执行后续步骤。

### 安装后步骤

**配置 HAProxy 以启用 HTTPS**

 * 步骤 1. 将有效的域名系统 (DNS) 记录分配给您的实例外部 IP 地址。
 * 步骤 2. 使用上述先前问题中的说明使用 SSH 或 PuTTY 连接到您的实例。
 * 步骤 3. 执行以下命令：
 ```bash
 sudo certbot-certonly --domain smth.yourcompany.com --email support@yourcompany.com
 sudo haproxy-refresh
 ```
    其中 **smth.yourcompany.com** 是您从第二步获得的 DNS 名称
    **support@yourcompany.com** 是您的电子邮件，用于从 [certbot](https://certbot.eff.org/) 获取通知。

### 常见问题解答

**如何启用免费试用？**

客户仍然可以使用 <a href="https://thingsboard.cloud" target="blank">ThingsBoard Cloud</a>。
30 天无缝体验和最新功能，除了白标，来自最新的源代码！
<br><br>

**我的 TB PE 实例的总拥有成本 (TCO) 是多少？**

<p>典型的总拥有成本包括：</p>
<ul>
    <li>TB 许可证费用 - 请参阅 <a href="/pricing">定价</a></li>
    <li>AWS EC2 实例价格 - 我们认为 <a href="https://www.ec2instances.info/">ec2instances.info</a> 是比较价格的便捷资源。</li>
    <li>网络流量、磁盘空间和其他可选服务（Cloud Watch 或类似服务）的额外 EC2 成本</li>
</ul>
<p>示例 A：基于 t2.micro（具有 20 GB 磁盘）的 GridLinks PE 实例与 Maker 订阅计划的价格每月约为 20.5 美元：</p>
<ul>
    <li>每月 ThingsBoard PE Maker 订阅费为 10.00 美元</li>
    <li>1 个月 t2.micro 使用费为 8.468 美元</li>
    <li>每月 20 GB EBS 卷为 2.0 美元</li>
</ul>
<p>示例 B：基于 t2.medium（具有 100 GB 磁盘）的 GridLinks PE 实例与 Prototype 订阅计划的价格每月约为 142.872 美元：</p>
<ul>
    <li>每月 ThingsBoard PE Prototype 订阅费为 99.00 美元</li>
    <li>1 个月 t2.medium 使用费为 33.872 美元</li>
    <li>每月 100 GB EBS 卷为 10.0 美元</li>
</ul>
<p>所有价格均以美元计。</p>

<br>


**如何使用 SSH 连接到我的新 ThingsBoard PE 实例？**

有关更多详细信息，请参阅 <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html">官方文档页面</a>。
<br><br>

**如何使用 PuTTY 连接到我的新 ThingsBoard PE 实例？**

有关更多详细信息，请参阅 <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html">官方文档页面</a>。
<br><br>

**如何启用 HTTPS？**

请参阅 <a href="/docs/user-guide/install/pe/aws/#post-installation-steps">安装后步骤</a>
<br><br>

**如何配置我的 TB PE 实例？**

有关更多详细信息，请参阅 <a href="/docs/user-guide/install/config/">官方文档页面</a>。

<br>

**如何为我的 TB PE 实例获取软件更新？**

一旦有新软件版本可用，您将收到电子邮件通知。
此电子邮件通知将包含指向 <a href="/docs/user-guide/install/aws-marketplace-pe-upgrade/">官方文档页面</a> 的链接，其中包含升级说明。
<br><br>

**如何备份我的数据库？**
根据您的实例类型和配置，ThingsBoard 可能会将数据存储在 SQL 或 NoSQL 数据库中。
ThingsBoard 还可以使用混合数据库模式存储数据。
请查看 <a href="/docs/reference/#sql-vs-nosql-vs-hybrid-database-approach">架构文档</a> 以获取有关可用数据库类型的更多信息。
一旦您弄清楚了您在实例中使用的数据库类型，您就可以查看官方 <a href="https://www.postgresql.org/docs/9.1/backup.html">PostgreSQL</a>
或 <a href="https://docs.datastax.com/en/cassandra/3.0/cassandra/operations/opsBackupRestore.html">Cassandra</a> 文档。
网络上还有大量文档和工具，您可以使用它们来备份和还原您的数据库。
<br><br>

**如何升级我的实例类型？**

有关更多详细信息，请参阅官方许可证服务器 <a href="/products/license-server/">文档页面</a>。
<br><br>

**我的 GridLinks 实例日志在哪里？**

ThingsBoard 日志存储在 <i>/var/log/thingsboard</i> 文件夹中。
请参阅 <a href="/docs/user-guide/install/config/#logging">配置页面</a> 以了解如何配置日志记录级别。
<br><br>

**如何获得专业支持？**

请查看 GridLinks 专业 <a href="/docs/services/support/">支持计划</a> 并 <a href="/docs/contact-us/">联系我们</a>。
<br><br>

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}