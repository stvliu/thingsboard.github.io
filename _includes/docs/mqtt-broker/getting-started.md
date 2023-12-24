* TOC
{:toc}

### 简介

本教程的目的是展示 [TBMQ](/docs/mqtt-broker/getting-started-guides/what-is-thingsboard-mqtt-broker/) 的基本用法。
通过本教程，您将获得以下领域的知识和技能：

* 在 MQTT 客户端和代理之间建立连接。
* 发布 MQTT 消息。
* 订阅主题以接收已发布的消息。
* 为 MQTT 客户端配置身份验证和授权机制。

有关 TBMQ 架构的更全面信息，请导航至以下 [文档](/docs/mqtt-broker/architecture/)。
此资源将为您提供对代理的基础结构和设计原理的详细见解，让您能够更深入地了解其内部功能。

### 安装 TBMQ

要获取有关如何在不同平台上安装 TBMQ 的详细说明，我们建议您查阅
[**安装选项**](/docs/mqtt-broker/install/installation-options) 文档。
此资源将为您提供针对各种部署场景的逐步指导。

根据您的系统，按照以下说明快速安装 TBMQ。

{% capture contenttogglespec %}
Linux & Mac OS%,%linuxmacos%,%templates/mqtt-broker/install/linux-macos/linux-macos.md%br%
Windows%,%windows%,%templates/mqtt-broker/install/windows/windows.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tbmqGettingStartedInstallation" toggle-spec=contenttogglespec %}

本地部署的安装过程完成后，您可以访问以下 URL 来访问 TBMQ UI：**http://localhost:8083**。
耐心等待服务启动并运行。要登录，请使用以下默认凭据。

**用户名：**
```text
sysadmin@thingsboard.org
```
{: .copy-code}

**密码：**
```text
sysadmin
```
{: .copy-code}

### 配置客户端身份验证和授权

为了保护与代理的连接，我们应该启用基本或 TLS 身份验证。
在本教程中，我们将重点介绍 [基本](/docs/mqtt-broker/security/#basic-authentication) 身份验证类型。
为此，我们在上一步下载的 `docker-compose.yml` 中将 `SECURITY_MQTT_BASIC_ENABLED` 环境变量设置为 `true`。

启用基本身份验证后，有必要创建类型为“基本”的 MQTT 客户端凭据来验证连接的客户端。

* 导航到“凭据”选项卡，单击表格右上角的“+”。
* 输入凭据名称。例如，“入门凭据”。
* 输入“用户名”和“密码”以及所选值。例如，分别使用 `username` 和 `password` 值。
* 默认情况下，授权规则允许发布/订阅任何主题。
* 单击“添加”以保存凭据。

{% include images-gallery.html imageCollection="broker-mqtt-creds-creation" %}

可以在 [安全指南](/docs/mqtt-broker/security/) 中找到更广泛的身份验证方法，为确保安全访问提供了增强的选项。

### 发布和订阅主题

现在，让我们继续发布消息并订阅主题以观察消息流。在本教程中，
我们将为此目的使用 [Mosquitto](https://mosquitto.org/) 客户端。

请参阅以下链接以了解如何将消息 [发布](https://mosquitto.org/man/mosquitto_pub-1.html) 到主题以及
[订阅](https://mosquitto.org/man/mosquitto_sub-1.html) 主题过滤器以接收消息。

#### 订阅主题

要订阅 **sensors/temperature** 主题并开始从 TBMQ 接收消息，您可以使用以下命令：

```bash
mosquitto_sub -d -h $THINGSBOARD_MQTT_BROKER_HOST_NAME -p 1883 -t sensors/temperature -q 1 -u username -P password -i tbmq_dev
```
{: .copy-code}

**注意**，将 **$THINGSBOARD_MQTT_BROKER_HOST_NAME** 替换为代理的正确公共 IP 地址或 DNS 名称，
`username` 和 `password` 值根据已配置凭据中的指定值。
请复制上述过程以发布以下消息。

对本地部署使用以下命令：
```bash
mosquitto_sub -d -h localhost -p 1883 -t sensors/temperature -q 1 -u username -P password -i tbmq_dev
```
{: .copy-code}

在成功建立连接后，我们可以继续检查 UI 中的会话信息。

{% include images-gallery.html imageCollection="broker-sessions" %}

#### 发布消息

要将消息发布到 TBMQ 以获取主题 **sensors/temperature**，您可以使用以下命令：

```bash
mosquitto_pub -d -h $THINGSBOARD_MQTT_BROKER_HOST_NAME -p 1883 -t sensors/temperature -m 32 -q 1 -u username -P password
```
{: .copy-code}

对本地部署使用以下命令：
```bash
mosquitto_pub -d -h localhost -p 1883 -t sensors/temperature -m 32 -q 1 -u username -P password
```
{: .copy-code}

#### 结果

您应该收到并观察已订阅客户端的已发布消息。

![image](/images/mqtt-broker/getting-started/broker-pub-sub.png)

### 后续步骤

{% assign currentGuide = "GettingStartedGuide" %}{% include templates/mqtt-broker-guides-banner.md %}