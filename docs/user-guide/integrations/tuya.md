---
layout: docwithnav-pe
title: 涂鸦集成
description: 涂鸦集成指南

tuya-application-add-device:
    0:
        image: /images/user-guide/integrations/tuya/tuya-add-device-1.png
    1:
        image: /images/user-guide/integrations/tuya/tuya-add-device-2.png
    2:
        image: /images/user-guide/integrations/tuya/tuya-add-device-3.png
    3:
        image: /images/user-guide/integrations/tuya/tuya-add-device-4.png
    4:
        image: /images/user-guide/integrations/tuya/tuya-add-device-5.png
    5:
        image: /images/user-guide/integrations/tuya/tuya-add-device-6.png
    6:
        image: /images/user-guide/integrations/tuya/tuya-add-device-7.png
    7:
        image: /images/user-guide/integrations/tuya/tuya-add-device-8.png

tuya-create-cloud-project:
    0:
        image: /images/user-guide/integrations/tuya/tuya-create-cloud-project-1.png
        title: '转到“云”选项卡->“开发”。单击“创建云项目”按钮'
    1:
        image: /images/user-guide/integrations/tuya/tuya-create-cloud-project-2.png
        title: '在弹出窗口中，填写必填字段，然后单击“创建”'
    2:
        image: /images/user-guide/integrations/tuya/tuya-create-cloud-project-3.png
        title: '在“授权 API 服务”窗口中进行其他设置，然后单击“授权”'
    3:
        image: /images/user-guide/integrations/tuya/tuya-create-cloud-project-4.png
        title: '在“项目配置”窗口中填写必填字段，然后单击“创建”'
    4:
        image: /images/user-guide/integrations/tuya/tuya-create-cloud-project-5.png
        title: '现在，您的云项目已创建。在此窗口中，记住访问 ID 和访问密钥值。在涂鸦集成设置期间需要这些值。'

tuya-message-service-enable:
    0:
        image: /images/user-guide/integrations/tuya/tuya-message-service-enable-1.png
        title: '转到“云”选项卡->“消息服务”'
    1:
        image: /images/user-guide/integrations/tuya/tuya-message-service-enable-2.png
        title: '切换以启用消息服务'
    2:
        image: /images/user-guide/integrations/tuya/tuya-message-service-enable-3.png
        title: '在弹出窗口中，设置消息服务。配置“消息服务类型”和“警报联系人”的设置。单击“确定”'
    3:
        image: /images/user-guide/integrations/tuya/tuya-message-service-enable-4.png
        title: '消息服务已启用'

tuya-add-smart-life-app:
    0:
        image: /images/user-guide/integrations/tuya/tuya-add-smart-life-app-1.png
        title: '转到“云”选项卡->“开发”。选择您的项目'
    1:
        image: /images/user-guide/integrations/tuya/tuya-add-smart-life-app-2.png
        title: '导航到“设备”选项卡->选择“链接涂鸦应用帐户”选项卡。单击“添加应用帐户”'
    2:
        image: /images/user-guide/integrations/tuya/tuya-add-smart-life-app-3.png
        title: '使用 Smart Life 应用扫描二维码进行授权'
    3:
        image: /images/user-guide/integrations/tuya/tuya-add-smart-life-app-4.png
        title: '在弹出窗口中，设置设备链接方法并选择设备权限：读取、读取/写入或读取/写入/管理”。单击“确定”'
    4:
        image: /images/user-guide/integrations/tuya/tuya-add-smart-life-app-5.png
        title: '现在，移动应用帐户下的设备已添加到项目中'
    5:
        image: /images/user-guide/integrations/tuya/tuya-add-smart-life-app-6.png
        title: '导航到“所有设备”选项卡。您可以看到添加到项目中的设备'

tuya-enable-rules-environment:
    0:
        image: /images/user-guide/integrations/tuya/tuya-enable-rules-environment-1-pe.png
        title: '导航到“消息服务”选项卡。单击“创建消息规则”按钮；'
    1:
        image: /images/user-guide/integrations/tuya/tuya-enable-rules-environment-2-pe.png
        title: '单击“添加消息过滤规则”按钮；'
    2:
        image: /images/user-guide/integrations/tuya/tuya-enable-rules-environment-3-pe.png
        title: '添加新的消息过滤规则，然后单击“发布规则”按钮；'
    3:
        image: /images/user-guide/integrations/tuya/tuya-enable-rules-environment-5-pe.png
        title: '启用消息规则。'

---
{% assign docsPrefix = "pe/" %}
{% include docs/pe/user-guide/integrations/tuya.md %}