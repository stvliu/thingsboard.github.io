* TOC
{:toc}

双因素身份验证是一种旨在提供额外安全层的最先进的方法。使用 2FA，即使有人知道您的密码，您的 ThingsBoard 帐户也能防止恶意访问。

除了输入密码外，还必须填写发送到预先配置的邮箱或电话的验证码。此外，如果有人尝试访问某人的帐户，系统会发送通知。

有效期和系统管理员可用的剩余属性可以使在线帐户不受网络犯罪分子的侵害。

{% if docsPrefix == null %}
![image](/images/user-guide/two-factor-authentication/two-factor-authentication-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/two-factor-authentication/two-factor-authentication-pe.png)
{% endif %}

### ThingsBoard 中可用的双因素身份验证选项

- **电子邮件**。使用此方法，用户在输入有效的用户名和密码后，将通过邮件收到验证码。为了让 2FA 通过电子邮件正常工作，应配置[外发邮件服务器](/docs/user-guide/ui/mail-settings/)。
- **短信**。一次性验证码会通过短信发送到用户的手机。要接收短信，系统管理员应正确设置[短信提供商](/docs/user-guide/ui/sms-provider-settings/)。
- **身份验证器应用程序**。如果启用，用户需要在计算机或智能手机上安装一个应用程序来生成验证码。该软件动态呈现应在身份验证过程的第二步中使用的短期验证码。用户可以使用任何流行的应用程序，例如 Google Authenticator、Authy 或 Duo。
- **备份代码**。备份代码是用户在 ThingsBoard 中生成并保存在安全设备上或打印出来的数字。只能将备份身份验证与上述任何一种身份验证类型结合使用才能激活。系统管理员无法将备份代码方法配置为唯一可用的 2FA 选项。

### 如何为平台启用双因素身份验证

系统管理员用户为所有剩余用户配置默认安全策略和选项。前者可以打开/关闭使用任何类型的 2FA 的可能性，而后者定义是否使用其他验证。按照以下步骤为您的 ThingsBoard 实例启用双因素身份验证。

1. 以系统管理员身份登录到您的 ThingsBoard 平台实例；
2. 转到“安全”页面 - “双因素身份验证”部分；
3. 激活并配置一种或多种验证方法。如有必要，编辑所有已启用 2FA 提供程序的设置（验证消息模板、验证码生命周期、验证的总允许时间等）；
4. 保存更改。

{% if docsPrefix == null %}
![image](/images/user-guide/two-factor-authentication/two-factor-authentication-sysadmin-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/two-factor-authentication/two-factor-authentication-sysadmin-pe.png)
{% endif %}

### 用户登录的双因素身份验证

如果启用，平台上的用户可以添加额外的身份验证来访问数据。尽管 2FA 可以是公司安全标准，但最终是否使用它的决定取决于特定用户。系统管理员无法强制用户使用 2FA 进行身份验证。

1. 使用基本凭据登录；
2. 在右上角，单击三个点图标。在下拉菜单中，继续“安全”；
3. 激活方便的验证方法。可以激活多个提供程序；
4. 保存更改。

{% include images-gallery.html imageCollection="two-factor-authentication-password-and-authentication" showListImageTitles="true" %}

{% capture difference %}
**重要！**可切换的 2FA 选项列表取决于系统管理员的设置。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

###### 使用身份验证器应用程序的 2FA

{% include images-gallery.html imageCollection="two-factor-authentication-app" showListImageTitles="true" %}

###### 使用短信的 2FA

{% include images-gallery.html imageCollection="two-factor-authentication-sms" showListImageTitles="true" %}

###### 使用电子邮件的 2FA

{% include images-gallery.html imageCollection="two-factor-authentication-email" showListImageTitles="true" %}

###### 使用备份代码的 2FA

{% include images-gallery.html imageCollection="two-factor-authentication-backup-code" showListImageTitles="true" %}

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}