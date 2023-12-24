---
layout: docwithnav
title: 电子邮件插件配置
description: 在物联网设备数据阈值时触发电子邮件通知

---

{% include templates/old-guide-notice.md %}

* TOC
{:toc}

在本简短教程中，我们将解释如何配置电子邮件插件以通过电子邮件将警报分发给收件人。
在本教程中，我们将使用 [实时演示](https://demo.thingsboard.io) GridLinks 服务器和 [SendGrid](http://www.sendgrid.com) SMTP API。
电子邮件插件实现基于 [Java Mail](https://en.wikipedia.org/wiki/JavaMail)，可以轻松配置到其他邮件服务器。

## SMTP 服务器参数

### 步骤 1. 获取您的 SendGrid 帐户。

我们假设您有 SendGrid 帐户。您可以使用此 [链接](https://app.sendgrid.com/signup)注册试用。

### 步骤 2. 配置 SMTP 中继

登录后，打开 SMTP 中继 [配置页面](https://app.sendgrid.com/guide/integrate/langs/smtp)。
按照页面上的说明获取 API 密钥。
将 API 密钥保存在某处。

## 插件配置

### 步骤 3. 登录实时演示服务器

使用租户管理员帐户（您在注册期间创建的帐户）登录 [实时演示](https://demo.thingsboard.io) 服务器。

### 步骤 4. 创建新的邮件插件实例

打开 **插件** 页面，然后单击红色的“+”按钮。填写插件名称和说明。

![image](/images/samples/alarms/plugin-form.png)

选择相应的插件类型后，表单将展开。按如下所示填写值。将 API 密钥用作密码。

**注意** 由于演示实例托管在 Google Cloud 上，因此您需要指定 2525 端口。所有其他与 SMTP 相关的端口都被阻止。

![image](/images/samples/alarms/plugin-configuration.png)

不要忘记添加其他将强制安全连接的电子邮件属性。

![image](/images/samples/alarms/plugin-configuration-other.png)

单击“添加”按钮。

### 步骤 5. 激活新插件

成功保存插件后，不要忘记单击“激活”按钮将其激活。

![image](/images/samples/alarms/activate-plugin.png)

## 后续步骤

探索下一个 [教程](/docs/samples/alarms/basic-rules/) 以配置基本规则并根据传感器读数生成电子邮件。

## 故障排除

配置插件和相应的规则后，您可以在插件详细信息页面上查看统计信息和事件。
如果您配置错误，您应该会看到相应选项卡上记录的错误：

![image](/images/samples/alarms/plugin-events.png)