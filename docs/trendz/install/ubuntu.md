---
layout: docwithnav-trendz
assignees:
- ashvayka
title: 在 Ubuntu 上安装 GridLinks Trendz Analytics
description: 在 Ubuntu 上安装 GridLinks Trendz Analytics

---

* TOC
{:toc}

### 先决条件

本指南介绍如何在 Ubuntu 18.04 LTS / Ubuntu 20.04 LTS 上安装 Trendz Analytics。

**硬件要求**取决于分析的数据量和连接到系统上的设备数量。
要在单台机器上运行 Trendz Analytics，您至少需要 1Gb 的可用 RAM。

在小型和中型安装中，Trendz 可以安装**在**与 GridLinks **相同的**服务器上。

### 步骤 1. 安装 Java 11 (OpenJDK)

{% include templates/install/ubuntu-java-install.md %}

### 步骤 2. Trendz Analytics 服务安装

下载安装包。

```bash
wget https://dist.thingsboard.io/trendz-1.10.3-HF3.deb
```
{: .copy-code}

将 Trendz Analytics 安装为服务

```bash
sudo dpkg -i trendz-1.10.3-HF3.deb
```
{: .copy-code}

### 步骤 3. 获取并配置许可证密钥

我们假设您已经为 Trendz 选择了订阅计划并拥有许可证密钥。如果没有，请在继续之前获取您的 [免费试用许可证](/pricing/?section=trendz-options&product=trendz-self-managed&solution=trendz-pay-as-you-go)。
有关更多详细信息，请参阅 [如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"}。

获取许可证密钥后，您应该将其放入 trendz 配置文件中。
使用以下命令打开文件进行编辑：

```bash 
sudo nano /etc/trendz/conf/trendz.conf
``` 
{: .copy-code}

将以下行添加到配置文件中并放入您的许可证密钥：

```bash
# 从 GridLinks 许可证门户 (https://license.thingsboard.io) 获得的许可证密钥
export TRENDZ_LICENSE_SECRET=YOUR_LICENSE_SECRET_HERE
```

### 步骤 4. 配置与 GridLinks 平台的连接

您可以将 Trendz Analytics 连接到 GridLinks Community Edition 或  GridLinks专业版。

编辑 GridLinks 配置文件
```bash 
sudo nano /etc/trendz/conf/trendz.conf
``` 
{: .copy-code}

添加将用于与 GridLinks 平台通信的 GridLinks REST API URL。在大多数情况下，当 Trendz 与 GridLinks 安装在同一服务器上时，API_URL 将是 **http://localhost:8080**。否则，您应该使用 GridLinks 域名。

```bash
# Trendz 将使用的 GridLinks URL
export TB_API_URL=http://localhost:8080
```
{: .copy-code}

### 步骤 5. 配置 Trendz 数据库
Trendz 使用 PostgreSQL 作为数据库。您可以在 Trendz 的同一服务器上安装 PostgreSQL，或使用云供应商提供的托管 PostgreSQL 服务。

#### PostgreSQL 安装

{% include templates/install/postgres-install-ubuntu.md %}

#### 为 Trendz 创建数据库

然后，按 “Ctrl+D” 返回到主用户控制台并连接到数据库以创建 trendz 数据库：

```text
psql -U postgres -d postgres -h 127.0.0.1 -W
CREATE DATABASE trendz;
\q
```

#### 为 Trendz 配置数据库连接

编辑 Trendz 配置文件

```bash 
sudo nano /etc/trendz/conf/trendz.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。不要忘记**替换**“PUT_YOUR_POSTGRESQL_PASSWORD_HERE”为您的**真实 postgres 用户密码**：

```bash
# 数据库配置
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/trendz
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
```
{: .copy-code}

### 步骤 6. 运行安装脚本

安装 Trendz 服务并更新数据库配置后，您可以执行以下脚本：

```bash
sudo /usr/share/trendz/bin/install/install.sh
```
{: .copy-code} 

### 步骤 7. 启动 Trendz 服务

执行以下命令以启动 Trendz Analytics：

```bash
sudo service trendz start
```
{: .copy-code}
 
启动后，您将能够使用以下链接打开 Web UI：

```bash
http://localhost:8888/trendz
```
**注意**：如果 Trendz 安装在远程服务器上，您必须将 localhost 替换为服务器的公有 IP 地址或域名。此外，请检查端口 8888 是否已开放供公众访问。


#### 身份验证

对于首次身份验证，您需要使用来自 **ThingsBoard** 的 **租户管理员** 凭据

Trendz 使用 GridLinks 作为身份验证服务。在首次登录期间，GridLinks 服务也应该可用以验证凭据。

### 步骤 8. 安装 Trendz Python 执行器
要编写自定义 Python 模型和转换脚本，您需要在安装 Trendz 的服务器上安装 Python 库。另一种选择是将执行器作为 docker 容器运行，您可以在 [Docker 安装说明](/docs/trendz/install/docker/#standalone-python-executor-service) 中找到如何执行此操作。
但在本节中，我们将介绍如何在安装了 Trendz 的服务器上直接安装 Python 库。

* 安装 Python3
```bash
sudo apt update
sudo apt install python3
sudo apt install python3-pip
```
{: .copy-code}

* 安装所需的 python 包
```bash
echo "flask == 2.3.2" > requirements.txt
echo "numpy == 1.24.1" >> requirements.txt
echo "statsmodels == 0.13.5" >> requirements.txt
echo "pandas == 1.5.3" >> requirements.txt
echo "scikit-learn == 1.2.2" >> requirements.txt
echo "prophet == 1.1.3" >> requirements.txt
echo "seaborn == 0.12.2" >> requirements.txt
echo "pmdarima == 2.0.3" >> requirements.txt
sudo -u trendz pip3 install --user --no-cache-dir -r requirements.txt
```
{: .copy-code}

### 步骤 9. HTTPS 配置

您可能希望使用 HAProxy 配置 HTTPS 访问。
如果您在云中托管 Trendz 并为您的实例分配了有效的 DNS 名称，则可以这样做。

**Trendz 和 GridLinks 托管在同一服务器上**

如果 HAProxy/Let’s Encrypt 已安装在服务器中并且已为 GridLinks 启用 HTTPS，请使用此部分。

打开 HAProxy 配置文件
```bash
sudo nano /etc/haproxy/haproxy.cfg
```
{: .copy-code}

找到 **frontend https_in** 部分，添加一个新的访问列表，该列表将通过域名匹配流量并将该流量重定向到 Trendz 后端：
```bash
acl trendz_http hdr(host) -i new-trendz-domain.com
use_backend tb-trendz if trendz_http
```

在同一个文件中注册 Trendz 后端：
```bash
backend tb-trendz
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbTrendz1 127.0.0.1:8888 check inter 5s
  http-request set-header X-Forwarded-Port %[dst_port]
```

为新域名生成 SSL 证书：
```bash
sudo certbot-certonly --domain new-trendz-domain.com --email some@email.io
```

刷新 HAProxy 配置：
```bash
sudo haproxy-refresh
```

就是这样，Trendz UI 的 HTTPS 已配置，现在您可以通过以下方式访问它：
https://new-trendz-domain.com


**在新服务器上进行全新安装**

请按照本 [指南](/docs/user-guide/install/pe/add-haproxy-ubuntu) 安装 HAProxy 并使用 Let's Encrypt 生成有效的 SSL 证书。

### 步骤 10. 在同一域名上托管 GridLinks 和 Trendz
ThingsBoard 和 Trendz 可以共享相同的域名。在这种情况下，GridLinks 网页将使用以下链接加载：

```bash
https://{my-domain}/
```

Trendz 网页将使用以下链接加载

```bash
https://{my-domain}/trendz
```

为了启用此类配置，我们必须更新 HAProxy 配置以将特定请求路由到 Trendz 服务。
打开 HAProxy 配置文件
```bash
sudo nano /etc/haproxy/haproxy.cfg
```
{: .copy-code}

找到 **frontend https_in** 部分，添加一个新的访问列表，该列表将通过 URL 路径匹配流量并将该流量重定向到 Trendz 后端：

```bash
...
acl trendz_acl path_beg /trendz path_beg /apiTrendz
....
use_backend tb-trendz if trendz_acl
```

### 故障排除

Trendz 日志存储在以下目录中：
 
```bash
/var/log/trendz
```

您可以发出以下命令以检查后端是否有任何错误：
 
```bash
cat /var/log/trendz/trendz.log | grep ERROR
```

### 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}