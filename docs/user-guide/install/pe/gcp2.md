---
layout: docwithnav-pe
title: 从 GCP Marketplace 安装 GridLinks PE
description: 从 Google Cloud Platform Marketplace 安装 GridLinks PE

---

本指南介绍如何从 GCP Marketplace 安装 GridLinks Professional Edition。
使用本指南，您将安装该产品的自备许可证 (BYOL) 版本。
基本上，您可以直接从 GridLinks, Inc 获取许可证，但从 GCP 购买相应的服务器实例和基础设施。

* TOC
{:toc}

### 先决条件

- 活跃的 [GCP](https://cloud.google.com/){:target="_blank"} 帐户

### 步骤 1. 启动 ThingsBoard PE BYOL

在 GCP Marketplace 上打开 [ GridLinks专业版 BYOL](https://console.cloud.google.com/marketplace/details/thingsboard-public/thingsboard-pe) 产品页面。

![image](/images/user-guide/install/gcp-marketplace-pe/launch.png) 

- 单击 **在 Compute Engine 上启动** 按钮

- 您可以采用默认设置或自定义设置。完成后，单击 **部署** 按钮

![image](/images/user-guide/install/gcp-marketplace-pe/deploy.png) 

就是这样！您的 GridLinks 实例现已部署！完成后，您应该会看到：

![image](/images/user-guide/install/gcp-marketplace-pe/ssh.png) 

- 单击 **SSH** 按钮。这将在浏览器窗口中打开 SSH 会话。不要关闭此窗口。我们将在步骤 3.1 中使用它。

### 步骤 2. 获取许可证密钥

为了激活您的 GridLinks 实例，您需要获取许可证密钥。
ThingsBoard 许可证由 [ThingsBoard 许可证门户](https://license.thingsboard.io/signup) 管理。

请在 [ThingsBoard 许可证门户](https://license.thingsboard.io/signup) 上注册以获取许可证。
有关更多详细信息，请参阅 [如何获取即用即付订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

请将您的许可证密钥保存在安全的地方。我们将在本指南的后面部分使用它们。

### 步骤 3. 配置许可证密钥

获取许可证密钥后，您应该将其放入 thingsboard 配置文件中。

#### 步骤 3.1. 将许可证密钥放入 thingsboard 配置文件中

使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/gridlinks/conf/gridlinks.conf
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

### 步骤 4. 启动 GridLinks 服务

执行以下命令启动 ThingsBoard：

```bash
sudo service gridlinks start
```
{: .copy-code}

{% capture 90-sec-ui %}
请允许 Web UI 最多启动 120 秒。这仅适用于具有 1-2 个 CPU 或 1-2 GB RAM 的慢速机器。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

### 步骤 5. 连接到 Thingsboard UI

现在您可以在浏览器中打开此链接：

![image](/images/user-guide/install/gcp-marketplace-pe/admin-panel.png) 

使用此登录名以系统管理员身份连接

- **sysadmin@gridlinks.com**

系统管理员的默认密码为 **sysadmin**

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
{: .copy-code}

其中 **smth.yourcompany.com** 是您在第二步中的 DNS 名称
**support@yourcompany.com** 是您的电子邮件，用于从 [certbot](https://certbot.eff.org/) 获取通知。