---
layout: docwithnav
assignees:
- ashvayka
title: 邮件设置
description: ThingsBoard IoT 平台邮件设置

sendgrid-configuration:
    0:
        image: /images/user-guide/ui/mail/sendgrid-welcome.png
        title: '创建帐户后，您将被转发到欢迎页面。单击“开始”按钮；'
    1:
        image: /images/user-guide/ui/mail/sendgrid-smtp-relay.png
        title: '转到“电子邮件 API”部分 -> “集成指南”页面，然后选择设置方法 - “SMTP 中继”；'
    2:
        image: /images/user-guide/ui/mail/sendgrid-token.png
        title: '创建 API 密钥：输入 API 密钥名称并生成它。'

gmail-generate-an-app-password:
    0:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-1.png
        title: '转到您的 Google 帐户并导航到“安全”页面。然后选择“两步验证”选项卡；'
    1:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-2.png
        title: '在页面底部，选择“应用密码”；'
    2:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-3.png
        title: '单击“选择应用”并在下拉菜单中选择“其他”应用；'
    3:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-4.png
        title: '输入应用名称并单击“生成”按钮；'
    4:
        image: /images/user-guide/ui/mail/gmail-generate-an-app-password-5.png
        title: '复制并保存应用密码。'

create-gmail-project:
    0:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-1-pe.png
        title: '输入“项目名称”和“位置”。然后单击“创建”。创建新项目。'

create-gmail-credentials:
    0:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-2-pe.png
        title: '选择创建的项目并导航到“API 和服务”页面；'
    1:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-3-pe.png
        title: '单击“凭据”选项卡，然后单击“创建凭据”按钮并选择“OAuth 客户端 ID”；'
    2:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-4-pe.png
        title: '在“创建 OAuth 客户端 ID”窗口中选择应用程序类型 - “Web 应用程序”并输入 OAuth2 客户端的名称。然后，在“授权的重定向 URI”部分，单击“+ 添加 URI”按钮并粘贴先前复制的“重定向 URI 模板”。单击“创建”；'
    3:
        image: /images/user-guide/ui/mail/gmail-with-oauth2-5-pe.png
        title: '保存创建的客户端 ID 和客户端密钥以备将来使用。'

azure-portal:
    0:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-1-pe.png
        title: '登录 Azure 门户并选择 Azure Active Directory；'
    1:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-2-pe.png
        title: '在“管理”下选择“应用注册”，然后单击“新建注册”；'
    2:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-3-pe.png
        title: '输入应用程序的名称并输入先前复制的“重定向 URI 模板”。单击“注册”；'
    3:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-4-pe.png
        title: '创建应用程序后，您可以在“概述”页面上找到“客户端 ID”和“目录（租户）ID”。将它们保存以备将来使用。'

azure-portal-2:
    0:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-5-pe.png
        title: '选择“证书和密钥”>“客户端密钥”>单击“新建客户端密钥”按钮；'
    1:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-6-pe.png
        title: '为您的客户端密钥添加说明。为密钥选择到期时间或指定自定义生命周期。单击“添加”；'
    2:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-7-pe.png
        title: '保存客户端密钥值以备将来使用。'

add-api-permissions:
    0:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-1-pe.png
        title: '在 Azure 门户中转到“API 权限”页面并单击“添加权限”按钮；'
    1:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-2-pe.png
        title: '选择 API - “Microsoft Graph”；'
    2:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-3-pe.png
        title: '选择权限类型 - “委派权限”；'
    3:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-4-pe.png
        title: '搜索并选中“SMTP.Send”权限。然后单击“添加权限”按钮；'
    4:
        image: /images/user-guide/ui/mail/microsoft-azure-with-oauth2-api-permissions-5-pe.png
        title: '权限已更新。'

---

{% include docs/user-guide/ui/mail-settings.md %}