* TOC
{:toc}

ThingsBoard 系统管理员能够配置到 SMTP 服务器的连接，该连接将用于向用户分发激活和密码重置电子邮件。{% unless docsPrefix %}
此配置步骤在生产环境中是必需的。如果您正在评估平台，预先配置的
[**演示帐户**](/docs/samples/demo-account/#demo-tenant) 在大多数用例中就足够了。
{% endunless %}

{% capture difference %}
**注意：**
<br>
系统邮件设置仅在用户创建和密码重置过程中使用，并由系统管理员控制。
租户管理员能够 [**设置电子邮件规则节点**](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 来分发由 [**规则引擎**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 生成的警报。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 邮件服务器配置

需要执行以下步骤来配置邮件服务器设置。

首先，您必须以 *系统管理员* 身份登录到您的 ThingsBoard 实例 WEB UI。然后，左键单击 WEB UI 右上角的三个点，然后选择“个人资料”。
将 'sysadmin@thingsboard.org' 更改为您的电子邮件地址。现在再次以管理员身份重新登录。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/mail-settings-change-administrator-email-address-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/mail-settings-change-administrator-email-address-pe.png)
{% endif %}

<br>
现在我们需要配置 SMTP 服务器。

从 ThingsBoard 3.5.2 开始，我们为以下提供商添加了邮件设置模板：Google、Office 365、SendGrid。
因此，用户不必填写连接设置，如 SMTP 服务器主机、端口和 TLS 配置。
如果您想更改某些设置，请使用“自定义”SMTP 提供程序类型。

本指南提供了使用 [Sendgrid](#sendgrid-configuration-example)、[Gmail](#gmail-configuration-with-basic-authentication-example) 和 [Office 365](#office-365-configuration-with-oauth2-authentication-example) 配置 SMTP 服务器的示例。在您的配置中，您可以使用任何其他 SMTP 服务器。

### Sendgrid 配置示例

SendGrid 配置非常简单直接。首先，您需要创建一个 [SendGrid](https://sendgrid.com/) 帐户。
您可以免费试用，免费套餐很可能足以评估平台。

**ㅤ1. 设置 SendGrid 配置**

{% include images-gallery.html imageCollection="sendgrid-configuration" showListImageTitles="true" %}

**ㅤ2. 设置 ThingsBoard 邮件服务器设置**

现在导航到您的 ThingsBoard 实例的“设置”页面 -> “邮件服务器”选项卡，然后填写表单：

- 填写“发件人”字段；
- 选择 SMTP 提供商 - **SendGrid**；
- 输入用户名：**apikey**；
- 输入密码：之前生成的 **密码**。

单击“保存”按钮。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/sendgrid-settings-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/sendgrid-settings-pe.png)
{% endif %}

<br>
**ㅤ3. 发送测试电子邮件**

可选，您可以在您的电子邮件上接收测试邮件。
如果配置错误，您应该会收到一个包含错误日志的弹出窗口。

您还可以在 SendGrid 网站上完成验证。

![image](/images/user-guide/ui/mail/sendgrid-it-works.png)

### Gmail 配置（带基本身份验证示例）

为了使用 Gmail，您需要启用两步验证（此步骤不是强制性的，但强烈建议您启用）。并生成一个 [**应用密码**](https://support.google.com/accounts/answer/185833?hl=en)。

**ㅤ1. 设置 Google 帐户配置**

{% include images-gallery.html imageCollection="gmail-generate-an-app-password" showListImageTitles="true" %}

**ㅤ2. 设置 ThingsBoard 邮件服务器设置**

一旦准备就绪，您应该能够使用以下信息设置邮件服务器。
导航到您的 ThingsBoard 实例的“设置”页面 -> “邮件服务器”选项卡，然后填写表单：

- 填写“发件人”字段；
- 选择 SMTP 提供商 - **Google**；
- 输入您的电子邮件作为 **用户名**；
- 保留 **基本** 身份验证类型；
- 输入之前复制的 **应用密码**。

单击“保存”按钮。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/gmail-settings-basic-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/gmail-settings-basic-pe.png)
{% endif %}

<br>
**ㅤ3. 发送测试电子邮件**

可选，您可以在您的电子邮件上接收测试邮件。
如果配置错误，您应该会收到一个包含错误日志的弹出窗口。

### Gmail 配置（带 OAuth2 身份验证示例）

从 ThingsBoard 3.5.2 开始，可以对 Gmail SMTP 服务器使用 OAuth2 授权。
使用 OAuth 2.0 协议，用户可以通过 Gmail Web OAuth 进行身份验证，而不是直接在应用程序中输入用户名和密码。
这种方式更安全，但有点复杂。

要使用 Gmail OAuth2，您需要在 Google Developers Console 中创建一个项目，但首先让我们设置 ThingsBoard 邮件服务器设置。

**ㅤ1. 设置 ThingsBoard 邮件服务器设置**

- 在您的 ThingsBoard 实例中，转到“设置”页面 -> “邮件服务器”选项卡；
- 填写“发件人”字段；
- 选择 SMTP 提供商 - “**Google**”；
- 在“身份验证”块中，使用您将用于发送邮件的电子邮件地址填写用户名；
- 将身份验证类型切换为 **OAuth2**；
- 复制并保存“**重定向 URI 模板**”。在设置 Google 项目凭据时需要用到它。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/google-oauth-settings-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/google-oauth-settings-1-pe.png)
{% endif %}

<br>
**ㅤ2. 现在让我们在 [Google Developers Console](https://console.developers.google.com/projectcreate) 中创建一个项目**

{% include images-gallery.html imageCollection="create-gmail-project" showListImageTitles="true" %}

**ㅤ3. 然后您需要创建凭据**

{% include images-gallery.html imageCollection="create-gmail-credentials" showListImageTitles="true" %}

<br>
**ㅤ4. 完成 ThingsBoard 设置设置**

返回 Thingsboard 门户，并将上一步中的 **客户端 ID** 和 **客户端密钥** 粘贴到相应的字段中。单击“保存”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/google-oauth-settings-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/google-oauth-settings-2-pe.png)
{% endif %}

<br>
**ㅤ5. 生成访问令牌**

最后，我们可以获取访问令牌。为此，单击 **生成访问令牌**，您的浏览器将重定向到提供商登录页面。
请按照浏览器中的步骤操作，在接受后，我们将自动保存刷新令牌和访问令牌，并将您重定向回 ThingsBoard 门户。
如果访问令牌生成成功，您将看到“已生成”状态。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/google-oauth-settings-3-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/google-oauth-settings-3-pe.png)
{% endif %}

<br>
**ㅤ6. 发送测试电子邮件**

要检查一切是否正常，请单击“发送测试电子邮件”按钮。请记住，每次您更改提供程序信息，系统都会删除刷新和访问令牌，您需要重新生成它们。

### Office 365 配置（带 OAuth2 身份验证示例）

从 Thingsboard 3.5.2 开始，可以对 Office 365 SMTP 服务器使用 OAuth2 授权。

要使用 Office 365 OAuth2，您需要在 Azure 门户中注册一个应用程序，但首先让我们设置 Thingsboard 邮件服务器设置。

**ㅤ1. 设置 ThingsBoard 邮件服务器设置**

 - 在您的 ThingsBoard 实例中，转到“设置”页面 -> “邮件服务器”选项卡；
 - 填写“发件人”字段；
 - 选择 SMTP 提供商 - “**Office 365**”；
 - 在“身份验证”块中，使用您将用于发送邮件的电子邮件地址填写用户名；
 - 将身份验证类型切换为 **OAuth2**；
 - 复制并保存“**重定向 URI 模板**”。在设置 Azure 门户凭据时需要用到它。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-1-pe.png)
{% endif %}

<br>
**ㅤ2. 现在让我们在 [Azure 门户](https://portal.azure.com/) 中注册一个应用程序**

{% include images-gallery.html imageCollection="azure-portal" showListImageTitles="true" %}

<br>
**ㅤ3. 然后您需要创建一个“客户端密钥”**

{% include images-gallery.html imageCollection="azure-portal-2" showListImageTitles="true" %}

<br>
**ㅤ4. 要完成身份验证设置，您需要为 SMTP 添加 API 权限**

{% include images-gallery.html imageCollection="add-api-permissions" showListImageTitles="true" %}

<br>
**ㅤ5. 完成 ThingsBoard 设置设置**

返回 ThingsBoard 门户，并将上一步中的 **客户端 ID**、**客户端密钥** 和 **目录（租户）ID** 粘贴到相应的字段中。单击“保存”。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-2-pe.png)
{% endif %}

<br>
**ㅤ6. 生成访问令牌**

最后，我们可以获取访问令牌。为此，单击“生成访问令牌”按钮，您的浏览器将重定向到提供商登录页面。
请按照浏览器中的步骤操作，在接受后，我们将自动保存刷新令牌和访问令牌，并将您重定向回 ThingsBoard 门户。
如果访问令牌生成成功，您将看到“已生成”状态。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-3-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/ui/mail/microsoft-azure-oauth-settings-3-pe.png)
{% endif %}

<br>
**ㅤ7. 发送测试电子邮件**

要检查一切是否正常，请单击“发送测试电子邮件”按钮。请记住，每次您更改提供程序信息，系统都会删除刷新和访问令牌，您需要重新生成它们。

<br>
**Office 365 故障排除**

如果您在发送电子邮件时看到身份验证错误（例如 5.7.3）：

1. 确保为用户启用了 SMTP 设置。为此，请转到 [此处](https://portal.office.com/adminportal/home#/users)。然后选择用户 → 邮件 → 管理电子邮件应用程序 → 身份验证 SMTP（如果已启用 - 禁用并再次启用）；
2. 在 Azure 门户中，确保已禁用安全默认值。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}