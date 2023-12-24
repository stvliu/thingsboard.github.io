{% assign feature = "邮件设置" %}{% include templates/pe-feature-banner.md %} 

* TOC
{:toc}

## 简介

ThingsBoard 使用邮件模板在发生某些事件时向用户发送电子邮件通知。
例如，关于激活帐户或重置密码的消息。

{% capture difference %}
**注意**
<br>
要通过电子邮件发送消息，租户管理员应配置 [外发邮件服务器](/docs/user-guide/ui/mail-settings/)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

ThingsBoard 提供具有示例内容的默认系统邮件消息模板，可以从列表中单独自定义。

为此，请执行以下步骤：
- 转到“**白标**”页面 -> “**邮件模板**”选项卡；

![image](/images/user-guide/white-labeling/mail-templates-1.png)

- 取消选中“**使用系统邮件模板**”框；
- 从下拉列表中选择要编辑的 **邮件模板**；
- 编辑 **邮件主题** 和 **邮件正文**；
- 保存更改。

![image](/images/user-guide/white-labeling/mail-templates-2.png)

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}