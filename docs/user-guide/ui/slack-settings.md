---
layout: docwithnav
assignees:
- ashvayka
title: Slack 设置
description: ThingsBoard IoT 平台 Slack 设置
slackProviderSettings:
    0:
        image: /images/user-guide/ui/slack/create-slack-api-token-1.png
        title: '在“如何快速获取并使用 Slack API 令牌”页面中，向下滚动并找到“创建预配置的应用”；'
    1:
        image: /images/user-guide/ui/slack/create-slack-api-token-2.png
        title: '单击“创建应用”按钮；'
    2:
        image: /images/user-guide/ui/slack/create-slack-api-token-3.png
        title: '在新窗口中，从下拉菜单中选择你的工作空间，然后单击“下一步”；'
    3:
        image: /images/user-guide/ui/slack/create-slack-api-token-4.png
        title: '查看摘要并单击“创建”按钮以创建你的应用；'
    4:
        image: /images/user-guide/ui/slack/create-slack-api-token-5.png
        title: '欢迎使用你的应用配置。单击“开始”；'
    5:
        image: /images/user-guide/ui/slack/create-slack-api-token-6.png
        title: '下一步 - 将你的应用安装到你的 Slack 工作空间。单击“安装到工作空间”按钮；'
    6:
        image: /images/user-guide/ui/slack/create-slack-api-token-7.png
        title: '应用正在请求访问你的 Slack 工作空间的权限。单击“允许”；'
    7:
        image: /images/user-guide/ui/slack/create-slack-api-token-8.png
        title: '成功！你的应用已创建。现在，导航到“OAuth 和权限”页面；'
    8:
        image: /images/user-guide/ui/slack/create-slack-api-token-9.png
        title: '复制“机器人用户 OAuth 令牌”。这是我们需要的“Slack API 令牌”。'

thingsboardSystemAdminSettings:
    0:
        image: /images/user-guide/ui/slack/add-slack-api-token-sysadmin-1-ce.png
        title: '以系统管理员身份登录你的 ThingsBoard UI。导航到“设置”页面，“通知”选项卡。在“Slack 设置”窗口中，将复制的 Slack API 令牌粘贴到“Slack API 令牌”行，然后单击“保存”。'

thingsboardTenantAdminSettings:
    0:
        image: /images/user-guide/ui/slack/add-slack-api-token-tenant-admin-1-ce.png
        title: '以租户管理员身份登录你的 ThingsBoard UI。导航到“设置”页面，“通知”选项卡。在“Slack 设置”窗口中，将复制的 Slack API 令牌粘贴到“Slack API 令牌”行，然后单击“保存”。'


---

{% include docs/user-guide/ui/slack-settings.md %}