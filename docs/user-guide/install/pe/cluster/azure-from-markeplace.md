---
layout: docwithnav-pe
title: 从 Azure Marketplace 安装 GridLinks PE
description: 从 Azure Marketplace 安装 GridLinks PE

---

本指南介绍如何从 Azure Marketplace 安装 GridLinks Professional Edition。
使用本指南，您将安装产品的 [BYOL](https://docs.microsoft.com/en-us/azure/marketplace/marketplace-faq-publisher-guide#pricing-and-payment) 版本。
基本上，您可以直接从 ThingsBoard, Inc 获取许可证，但从 Azure 购买相应的服务器实例和基础设施。

* TOC
{:toc}

### 先决条件

- 有效的 [Microsoft Azure](https://azure.microsoft.com){:target="_blank"} 帐户。

### 步骤 1. 订阅 ThingsBoard PE BYOL

从 Azure Marketplace 打开 [ GridLinks专业版 BYOL](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/things-board.tb-pe-byol) 产品页面。

- 单击 **立即获取** 按钮

![image](/images/user-guide/install/azure-marketplace/get-it-now.png)

- 查看并接受使用条款和隐私政策。单击“继续”按钮。

![image](/images/user-guide/install/azure-marketplace/continue.png)

- 您将被重定向到 Azure 门户。单击“创建”按钮以部署您的实例。

![image](/images/user-guide/install/azure-marketplace/create.png)

### 步骤 2. 常规配置

- 您将被重定向到“创建虚拟机”对话框，其中包含大量设置。
不用担心，我们将保留其中大多数的默认值。

###### 步骤 2.1 基础知识

- 创建新的“资源组”，例如“thingsboard”；
- 添加可识别的虚拟机名称，例如“ThingsBoardPE-PROD”；
- 从可用区域列表中选择区域；
- 将“管理员帐户”配置为“SSH 公钥”。用户名 **必须** 为 ubuntu；请参阅 [Azure 官方文档](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows) 以了解如何生成密钥。
- 单击“下一步：磁盘”按钮。

![image](/images/user-guide/install/azure-marketplace/config-basics.png)

###### 步骤 2.2 磁盘

- 我们建议保持原样，但您也可以在此处添加新磁盘；
- 单击“下一步：网络”按钮。

![image](/images/user-guide/install/azure-marketplace/config-disks.png)

###### 步骤 2.3 网络

- 保留所有设置不变；
- 确保此虚拟机使用预配置的网络安全组；
- 单击“下一步：管理”按钮。

![image](/images/user-guide/install/azure-marketplace/config-networking.png)

###### 步骤 2.3 管理、高级、标签

- 在所有三个选项卡上保留所有设置不变；
- 单击“下一步”按钮，直到到达“查看 + 创建”选项卡。

###### 步骤 2.4 查看 + 创建

- 查看最终产品详细信息；
- 确保您的姓名、电子邮件地址和电话号码正确无误；
- 单击“创建”按钮以开始部署。

![image](/images/user-guide/install/azure-marketplace/config-review.png)

- 部署启动后，可能需要长达 30 分钟（但通常不到 5 分钟）才能完成；

![image](/images/user-guide/install/azure-marketplace/launch-progress.png)

- 部署完成后，单击“转到资源”按钮。

![image](/images/user-guide/install/azure-marketplace/launch-completed.png)

### 步骤 3. 查看创建的资源

您将导航到资源概览页面。
我们应该使用此页面复制实例的外部 IP 地址。
请将此 IP 地址复制到安全的地方。
我们将在后续步骤中使用它。

**例如**，在下图中，IP 地址突出显示并设置为“40.121.179.240”

![image](/images/user-guide/install/azure-marketplace/resource-overview.png)

### 步骤 4. 获取许可证密钥

为了激活您的 GridLinks 实例，您需要获取许可证密钥。
ThingsBoard 许可证由 [ThingsBoard 许可证门户](https://license.thingsboard.io/signup) 管理。

请在 [ThingsBoard 许可证门户](https://license.thingsboard.io/signup) 上注册以获取许可证。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

请将您的许可证密钥保存到安全的地方。我们将在本指南的后面部分使用它们。

### 步骤 5. 配置许可证密钥

获取许可证密钥后，您应该将其放入 thingsboard 配置文件中。

#### 步骤 5.1. 通过 SSH 连接到您的 Thingsboard 实例

请使用 [Azure 官方指南](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows) 了解如何使用 SSH 密钥连接到 Azure VM。

注意：您需要使用实例公共 IP（请参阅 [步骤 3](/docs/user-guide/install/pe/cluster/azure-from-markeplace/#step-3-review-created-resource)）和密钥文件（请参阅 [步骤 2.1](/docs/user-guide/install/pe/cluster/azure-from-markeplace/#step-21-basics)）

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

- http://PUBLIC_IP_ADDRESS/login

在此示例中：

- http://40.121.179.240/login

使用此登录名以系统管理员身份连接

- **sysadmin@gridlinks.com**

系统管理员的默认密码是：

- **sysadmin**

现在您可以继续执行后续步骤。

### 安装后步骤

**配置 HAProxy 以启用 HTTPS**

* 步骤 1. 将有效的域名系统 (DNS) 记录分配给您的实例外部 IP 地址。
* 步骤 2. 使用上述先前问题中的说明，使用 SSH 或 PuTTY 连接到您的实例。
* 步骤 3. 执行以下命令：
```bash
 sudo certbot-certonly --domain smth.yourcompany.com --email support@yourcompany.com
 sudo haproxy-refresh
 ```
其中 **smth.yourcompany.com** 是您从第二步获得的 DNS 名称，**support@yourcompany.com** 是您从 [certbot](https://certbot.eff.org/) 获取通知的电子邮件。

### 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}