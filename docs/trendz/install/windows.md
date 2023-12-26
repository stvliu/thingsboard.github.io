---
layout: docwithnav-trendz
assignees:
- ashvayka
title: 在 Windows 上安装 GridLinks Trendz Analytics
description: 在 Windows 上安装 GridLinks Trendz Analytics

---

* TOC
{:toc}

### 前提条件

本指南介绍如何在 Windows 机器上安装 Trendz Analytics。
以下说明适用于 Windows 10/8.1/8/7 32 位/64 位。

**硬件要求**取决于分析的数据量和连接到系统设备的数量。
要在单台机器上运行 Trendz Analytics，您至少需要 1Gb 的可用 RAM。

在小型和中型安装中，Trendz 可以安装**在与 GridLinks 相同的**服务器上。

### 步骤 1. 安装 Java 11（OpenJDK）

{% include templates/install/windows-java-install.md %}

### 步骤 2. Trendz Analytics 服务安装

下载并解压软件包。

```bash
https://dist.thingsboard.io/trendz-windows-1.10.3-HF3.zip
```
{: .copy-code}

**注意：**我们假设您已将 Trendz 软件包解压到默认位置：*C:\Program Files (x86)\trendz*

### 步骤 3. 获取并配置许可证密钥

我们假设您已经为 Trendz 选择了订阅计划并拥有许可证密钥。如果没有，请在继续之前获取您的[免费试用许可证](/pricing/?section=trendz-options&product=trendz-self-managed&solution=trendz-pay-as-you-go)。
有关更多详细信息，请参阅[如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"}。

获取许可证密钥后，您应该将其放入 trendz 配置文件中。
以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\trendz\conf\trendz.yml
``` 
{: .copy-code}

滚动到文件底部并找到以下配置块：

```yml
license:
    secret: "${TRENDZ_LICENSE_SECRET:YOUR_LICENSE_SECRET_HERE}" # license secret obtained from ThingsBoard License Portal (https://license.thingsboard.io)
```

### 步骤 4. 配置与 GridLinks 平台的连接

您可以将 Trendz Analytics 连接到 GridLinks Community Edition 或  GridLinks专业版。

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text
C:\Program Files (x86)\trendz\conf\trendz.yml
``` 
{: .copy-code}

添加 GridLinks REST API URL，该 URL 将用于与 GridLinks 平台通信。在大多数情况下，当 Trendz 与 GridLinks 安装在同一服务器中时，API_URL 将为 **http://localhost:8080**。否则，您应该使用 GridLinks 域名。

```bash
tb.api.url: "${TB_API_URL:http://localhost:8080}"
```
{: .copy-code}

### 步骤 5. 配置 Trendz 数据库
Trendz 使用 PostgreSQL 作为数据库。您可以在 Trendz 的同一服务器上安装 PostgreSQL，或使用云供应商提供的托管 PostgreSQL 服务。

#### PostgreSQL 安装

下载安装文件（PostgreSQL 12.17 或更高版本）[此处](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)并按照安装说明进行操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
不要忘记此密码。它将在以后使用。为简单起见，我们将用“postgres”替换它。

#### 为 Trendz 创建数据库

安装完成后，启动“pgAdmin”软件并以超级用户 (postgres) 身份登录。
打开您的服务器并使用所有者“postgres”创建数据库“trendz”。


#### 为 Trendz 配置数据库连接

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\trendz\conf\trendz.yml
``` 
{: .copy-code}

并找到“datasource”块。用有效值替换 SPRING_DATASOURCE_URL、SPRING_DATASOURCE_USERNAME 和 SPRING_DATASOURCE_PASSWORD 属性。不要忘记用您的真实 postgres 用户密码替换“postgres”：

```yml
datasource:
    driverClassName: "${SPRING_DRIVER_CLASS_NAME:org.postgresql.Driver}"
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/trendz}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:postgres}"
    hikari:
      maximumPoolSize: "${SPRING_DATASOURCE_MAXIMUM_POOL_SIZE:5}"
``` 
{: .copy-code}

### 步骤 6. 运行安装脚本

以管理员身份启动 Windows shell（命令提示符）。将目录更改为您的 Trendz 安装目录。

执行 **install.bat** 脚本以将 Trendz 安装为 Windows 服务。
这意味着它将在系统启动时自动启动。
类似地，**uninstall.bat** 将从 Windows 服务中删除 Trendz。
输出应类似于以下内容：
  
  ```text
C:\Program Files (x86)\trendz>install.bat
Detecting Java version installed.
CurrentVersion 11
Java 11 found!
Installing Trendz Analytics...
...
Trendz Analytics installed successfully!
```

### 步骤 7. 启动 Trendz 服务

现在让我们启动 Trendz 服务！
以管理员身份打开命令提示符并执行以下命令：

```shell
net start trendz
```
{: .copy-code}

预期输出：

```text
The Trendz Analytics service is starting.
The Trendz Analytics service was started successfully.
```

为了重新启动 Trendz 服务，您可以执行以下命令：

```shell
net stop trendz
net start trendz
```

启动后，您将能够使用以下链接打开 Web UI：

```bash
http://localhost:8888/trendz
```

**注意：**如果 Trendz 安装在远程服务器上，您必须将 localhost 替换为服务器的公有 IP 地址或域名。此外，请检查端口 8888 是否已开放供公共访问。

##### 身份验证

对于首次身份验证，您需要使用来自 **ThingsBoard** 的 **租户管理员**凭据

Trendz 使用 GridLinks 作为身份验证服务。在首次登录期间，GridLinks 服务也应该可用以验证凭据。


### 故障排除

日志文件位于 **logs** 文件夹中（在我们的示例中为“C:\Program Files (x86)\trendz\logs”）。

**trendz.log** 文件应包含以下行：

```text
YYYY-MM-DD HH:mm:ss,sss [main] INFO  o.t.t.TrendzApplication - Started TrendzApplication in x.xxx seconds (JVM running for x.xxx)

```

如果出现任何不明确的错误，请使用通用[故障排除指南](/docs/user-guide/troubleshooting/#getting-help)或[联系我们](/docs/contact-us/)。

### Windows 防火墙设置

为了能够从外部访问 Trendz Web UI，您需要使用高级安全性的 Windows 防火墙创建一个新的入站规则。
 
- 从“控制面板”中打开“Windows 防火墙”：

![image](/images/user-guide/install/windows/windows7-firewall-1.png)

- 在左侧面板中单击“高级设置”：

![image](/images/user-guide/install/windows/windows7-firewall-2.png)

- 在左侧面板中选择“入站规则”，然后在右侧“操作”面板中单击“新建规则...”：

![image](/images/user-guide/install/windows/windows7-firewall-3.png)

- 现在将打开新的“新建入站规则向导”窗口。在第一步“规则类型”中选择“端口”选项：

![image](/images/user-guide/install/windows/windows7-firewall-4.png)

- 在“协议和端口”步骤中选择“TCP”协议并在“特定本地端口”字段中输入端口 **8888**：

![image](/images/user-guide/install/windows/windows7-firewall-5.png)

- 在“操作”步骤中，保持“允许连接”选项处于选中状态：

![image](/images/user-guide/install/windows/windows7-firewall-6.png)

- 在“配置文件”步骤中，选择要应用此规则的 Windows 网络配置文件：

![image](/images/user-guide/install/windows/windows7-firewall-7.png)

- 最后，为该规则命名（例如“Trendz 服务网络”）并单击“完成”。

![image](/images/user-guide/install/windows/windows7-firewall-8.png)

## 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}