---
layout: docwithnav
assignees:
- ashvayka
title: 短信提供商设置
description: GridLinks IoT 平台短信提供商设置
smsProviderSettings:
    0:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-2-ce.png
        title: '登录 GridLinks UI。导航到“设置”页面。现在，转到“通知”选项卡。在此窗口中，选择一个可用的提供商：AWS SNS Twilio 或 SMPP；'
    1:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-3-ce.png
        title: '如果您选择了 AWS SNS，请填写 AWS 访问密钥 ID 和秘密访问密钥。单击“保存”按钮；'
    2:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-4-ce.png
        title: '如果您选择了 Twilio，请填写 Twilio 帐户 SID 和令牌。指定将用作“发件人”的电话号码。单击“保存”按钮；'
    3:
        image: /images/user-guide/ui/sms/sms-provider-settings-step-5-ce.png
        title: '如果您选择了 SMPP，请填写系统 ID 和密码。指定 SMPP 版本、SMPP 主机和端口。单击“保存”按钮。'

---

{% include docs/user-guide/ui/sms-provider-settings.md %}