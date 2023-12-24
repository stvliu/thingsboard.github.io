* TOC
{:toc}

ThingsBoard 系统管理员能够配置 SMS 提供商，该提供商将用作 SMS 网关，向您的客户或用户发送短信。
例如，您可以在传感器检测到异常情况时设置向用户发送 SMS 警报。

{% unless docsPrefix == null %}
在租户管理员级别，您可以使用系统管理员的 SMS 提供商设置或输入您的设置。
{% endunless %}

租户管理员能够设置 [**短信规则节点**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/#send-sms-node) 来分发 [**规则引擎**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 生成的警报。

若要在 Thingsboard 中配置 SMS 提供商设置，请按照以下步骤操作：

{% include images-gallery.html imageCollection="smsProviderSettings" showListImageTitles="true" %}

<br>
请使用 [AWS SNS](https://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html)、[Twilio](https://www.twilio.com/docs/sms) 或 [SMPP](https://smpp.org/) 文档来了解有关如何使用相应系统的更多信息。