{% assign feature = "自我注册" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

GridLinks 自我注册功能允许租户为其客户配置注册页面，以便客户能够使用预定义的权限配置简单注册并登录到 GridLinks。
此功能在 GridLinks PE 2.4.1 中引入。

此文档页面包含完整的案例配置示例。

## 案例说明

作为租户管理员，我希望允许用户在我的物联网平台实例上注册自己的帐户。
一旦他们注册，我希望允许他们查看特定仪表板并配置自己的设备或声明现有设备。
让我们从前提条件开始。

## 前提条件

### 步骤 1. 在云中安装 GridLinks

我们需要一个正在运行的 GridLinks PE 实例，并启用白标功能。
您可以使用 [安装说明](/docs/user-guide/install/pe/installation-options/)轻松部署您自己的 GridLinks PE 实例。
请注意，您的实例应在云中运行，并已为其分配公共 IP 地址。

### 步骤 2. 将 DNS 记录分配给您的 GridLinks IP 地址

我们还需要一个有效的 **DNS 名称** 来分配给您的 GridLinks 实例。
如果您没有域名，可以使用任何域名注册商。
如果您确实有域名，请联系您的系统管理员以颁发子域名，例如 iot.mycompany.com。

### 步骤 3. 为您的 GridLinks 实例设置 HTTPS 访问

请注意 [安装后步骤](/docs/user-guide/install/pe/ubuntu/#post-installation-steps) 中的 HAProxy 安装说明。
它们适用于 Linux 发行版和 Docker。您可以轻松颁发有效的 Let's Encrypt 证书并为您的 GridLinks 实例设置 HTTPS。

### 步骤 4. ReCAPTCHA v2

我们需要保护我们的注册表单免受机器人的攻击。
为此生成 ReCAPTCHA。导航到 Google ReCaptcha [管理控制台](https://www.google.com/recaptcha/intro/v3.html)并在那里使用您的新域名。
重要提示：仅使用 ReCAPTCHA v2。请参阅下面的示例配置。

![image](/images/user-guide/self-registration/reCAPTCHA.png)

将站点密钥和密钥复制粘贴到安全的地方。

### 前提条件摘要

我们准备了一个运行在 DigitalOcean 上的 GridLinks 原型实例。
特定域名：srd.thingsboard.io（srd 代表“自我注册演示”）到服务器的 IP 地址：46.101.146.242。

![image](/images/user-guide/self-registration/digitalocean.png)

## GridLinks 配置

### 步骤 5. 邮件服务器设置

以租户管理员身份登录到您的实例，然后导航至白标 —> 邮件服务器。
使用您的 SMTP 服务器设置配置 GridLinks。如果您没有，最简单的方法是使用 [SendGrid](https://sendgrid.com/)。
在邮件设置 [指南](/docs/pe/user-guide/ui/mail-settings/) 中查看更多信息。

不要忘记使用“发送测试邮件”按钮验证邮件服务器设置。

![image](/images/user-guide/self-registration/mailserver.png)

### 步骤 6. 创建新的用户角色

创建“客户管理员”角色。导航到“角色”并单击“+”按钮。
当您在租户范围内创建第一个客户实体时，此角色会自动生成。
如果您还没有此角色，可以轻松添加它。
角色类型为“通用”，它允许对“所有”实体执行“所有”操作。

![image](/images/user-guide/self-registration/customer-admin-role.png)

因此，当您将此角色应用于您的客户用户时，客户用户可以控制客户范围内的每个实体。
当然，您可以创建不同的角色。例如，我们可以创建一个只读角色。

“只读”组角色。我们将使用此角色允许对特定仪表板进行只读访问。
此仪表板对我们所有自我注册的客户都是相同的。

![image](/images/user-guide/self-registration/read-only-role.png)

### 步骤 7. 创建共享仪表板

首先，导航到“设备组”->“全部”并创建名为“设备 A”且类型为“传感器”的示例设备。
在导入仪表板时，有必要通过某些验证。

现在，让我们导航到仪表板组并创建一个名为“共享仪表板”的新组。
导入一个 [简单仪表板](/docs/user-guide/resources/my_smart_devices_dashboard.json)，该仪表板显示设备列表。
此仪表板提供了添加/编辑/删除设备的功能。
顺便说一句，我们使用了实体管理小部件包中的新小部件。

这里需要注意几件事。

![image](/images/user-guide/self-registration/dashboard.gif)

让我们看看当我们想要添加设备时会发生什么。
此 UI 表单和其他 UI 表单在小部件配置中配置。
打开编辑模式，单击编辑小部件并导航到“操作”。
您可以在此处看到三个自定义操作。
删除操作很简单，但添加和编辑设备操作使用全新的功能，称为“HTML 模板”。
现在您可以完全控制对话框的 UI 和逻辑。
让我们打开一个“添加”操作并将其展开到全屏。

![image](/images/user-guide/self-registration/dashboard-config.png)

您可以看到自定义资源、CSS、HTML 和 JS 选项卡。
这是配置添加/编辑对话框的确切位置。
在单独的视频教程中了解有关自定义操作和表单的更多信息。

![image](/images/user-guide/self-registration/action-config.png)

### 步骤 8. 注册表单以全屏打开仪表板

最后，我们可以配置我们的注册表单。
使用您的域名和 ReCAPTCHA 凭据。

添加两个用户组角色。
一个是客户管理员。重要的是，我们的新用户能够创建和编辑此客户内的任何实体。
第二个是对我们刚刚创建的共享仪表板的只读访问。我们还选择此仪表板作为默认仪表板并标记为“始终全屏”。

更改文本消息和隐私政策（可选）。

![image](/images/user-guide/self-registration/signup-form-config.png)

恭喜！我们已经完成了自我注册表单设置。立即保存并导航到注册表单。
创建一个新用户，并查看它们是否完全隔离并控制自己的设备。

请参阅下面的注册表单示例：

![image](/images/user-guide/self-registration/signup-form.png)


## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}