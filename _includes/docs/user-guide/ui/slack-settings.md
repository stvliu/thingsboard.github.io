* TOC
{:toc}

通过将 Slack 与 Thingsboard 集成，用户将能够在 Slack 中接收有关 Thingsboard 系统中根据您设置的通知规则发生的事件的通知。例如，通知设备状态或检测到的问题。

{% capture difference %}
**注意：**
<br>
您只能向工作区中的用户发送 Slack 通知
{% endcapture %}
{% include templates/info-banner.md content=difference %}

租户管理员能够设置分发由 [**规则引擎**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 生成的警报。

### 在 Slack 中创建应用程序。获取 Slack API 令牌

要在 Thingsboard 中配置 Slack 设置，首先在 Slack API 中注册一个应用程序。为此，请打开 [获取 Slack API 令牌](https://api.slack.com/tutorials/tracks/getting-a-token) 页面。接下来，请按照以下步骤操作：

{% include images-gallery.html imageCollection="slackProviderSettings" showListImageTitles="true" %}

{% unless docsPrefix == 'paas/' %}
### 作为系统管理员配置 Slack 设置

以系统管理员身份登录到您的 ThingsBoard UI。导航到“设置”页面，“通知”选项卡。在“Slack 设置”窗口中，将复制的 Slack API 令牌粘贴到“Slack API 令牌”行，然后单击“保存”。

{% include images-gallery.html imageCollection="thingsboardSystemAdminSettings" %}
{% endunless %}

### 作为租户管理员配置 Slack 设置

以租户管理员身份登录到您的 ThingsBoard UI。导航到“设置”页面，“通知”选项卡。在“Slack 设置”窗口中，将复制的 Slack API 令牌粘贴到“Slack API 令牌”行，然后单击“保存”。

{% include images-gallery.html imageCollection="thingsboardTenantAdminSettings" %}

<br>
配置好通知后，每当根据您设置的通知规则在您的 Thingsboard 实例中触发事件时，您都将在 Slack 频道中收到通知。您还将能够向任何用户发送消息。