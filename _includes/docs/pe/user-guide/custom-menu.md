{% assign feature = "自定义菜单" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 简介

GridLinks 自定义菜单功能允许您扩展 GridLinks UI。
您可以添加新菜单项并显示/隐藏现有菜单项。

## 隐藏现有菜单项

要在 GridLinks 用户界面中隐藏菜单项，请在“自定义菜单”窗口中以 JSON 数据格式指定要隐藏的菜单项。

隐藏“主页”和“警报”菜单项的 JSON 数据格式示例：

```json
{
  "disabledMenuItems": [
    "home",
    "alarms"
  ],
  "menuItems": []
}
```
{: .copy-code}

**可禁用的 GridLinks 菜单项名称：**

| **参数**             | **说明**                                                                                                                         |
|:--------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|
| home                      | 隐藏左侧面板上的“主页”项                                                            |
| tenants                   | 隐藏左侧面板上的“租户”项（仅限系统管理员级别）               |
| tenant_profiles           | 隐藏左侧面板上的“租户配置文件”项（仅限系统管理员级别）        |
| billing                   | 隐藏左侧面板上的“计划和计费”项                                                |
| alarms                    | 隐藏左侧面板上的“警报”项                                                          |
| dashboards                | 隐藏左侧面板上的“仪表板”项                                                      |
| dashboard_all             | 隐藏“仪表板”页面上的“全部”选项卡                                                       |
| dashboard_groups          | 隐藏“仪表板”页面上的“组”选项卡                                                    |
| solution_templates        | 隐藏左侧面板上的“解决方案模板”项                                              |
| entities                  | 隐藏左侧面板上的“实体”项                                                        |
| devices                   | 隐藏左侧面板上的“设备”项                                                         |
| assets                    | 隐藏左侧面板上的“资产”项                                                          |
| entity_views              | 隐藏左侧面板上的“实体视图”项                                                    |
| profiles                  | 隐藏左侧面板上的“配置文件”项                                                        |
| device_profiles           | 隐藏左侧面板上的“设备配置文件”项                                                 |
| asset_profiles            | 隐藏左侧面板上的“资产配置文件”项                                                  |
| customers                 | 隐藏左侧面板上的“客户”项                                                       |
| customer_all              | 隐藏“客户”页面上的“全部”选项卡                                                        |
| customer_groups           | 隐藏“客户”页面上的“组”选项卡                                                     |
| customers_hierarchy       | 隐藏“客户”页面上的“层次结构”选项卡                                                  |
| users                     | 隐藏左侧面板上的“用户”项                                                           |
| user_all                  | 隐藏“客户”页面上的“全部”选项卡                                                        |
| user_groups               | 隐藏“客户”页面上的“组”选项卡                                                     |
| integrations_center       | 隐藏左侧面板上的“集成中心”项                                             |
| integrations              | 隐藏左侧面板上的“集成”项                                                    |
| converters                | 隐藏左侧面板上的“数据转换器”项                                                 |
| rule_chains               | 隐藏左侧面板上的“规则链”项                                                     |
| edge_management           | 隐藏左侧面板上的“边缘管理”项                                                 |
| edges                     | 隐藏左侧面板上的“实例”项                                                       |
| rulechain_templates       | 隐藏左侧面板上的“规则链模板”项                                            |
| integration_templates     | 隐藏左侧面板上的“集成模板”项                                           |
| converter_templates       | 隐藏左侧面板上的“转换器模板”项                                             |
| features                  | 隐藏左侧面板上的“高级功能”项                                               |
| otaUpdates                | 隐藏左侧面板上的“OTA 更新”项                                                     |
| version_control           | 隐藏左侧面板上的“版本控制”项                                                 |
| scheduler                 | 隐藏左侧面板上的“调度程序”项                                                       |
| resources                 | 隐藏左侧面板上的“资源”项                                                       |
| widget_library            | 隐藏左侧面板上的“小部件库”项                                                 |
| resources_library         | 隐藏左侧面板上的“资源库”项                                               |
| notifications_center      | 隐藏左侧面板上的“通知中心”项                                            |
| notification_inbox        | 隐藏“通知中心”页面上的“收件箱”选项卡                                           |
| notification_sent         | 隐藏“通知中心”页面上的“已发送”选项卡                                            |
| notification_recipients   | 隐藏“通知中心”页面上的“收件人”选项卡                                      |
| notification_templates    | 隐藏“通知中心”页面上的“模板”选项卡                                       |
| notification_rules        | 隐藏“通知中心”页面上的“规则”选项卡                                           |
| api_usage                 | 隐藏左侧面板上的“API 使用情况”项                                                       |
| white_labeling            | 隐藏左侧面板上的“品牌定制”项                                                  |
| white_labeling_general    | 隐藏“品牌定制”页面上的“常规”选项卡                                               |
| login_white_labeling      | 隐藏“品牌定制”页面上的“登录”选项卡                                                 |
| mail_templates            | 隐藏“品牌定制”页面上的“邮件模板”选项卡                                        |
| custom_translation        | 隐藏“品牌定制”页面上的“自定义翻译”选项卡                                    |
| custom_menu               | 隐藏“品牌定制”页面上的“自定义菜单”选项卡                                           |
| settings                  | 隐藏左侧面板上的“设置”项                                                        |
| general                   | 隐藏“设置”页面上的“常规”选项卡（仅限系统管理员级别）            |
| home_settings             | 隐藏“设置”页面上的“主页设置”选项卡                                               |
| mail_server               | 隐藏“设置”页面上的“邮件服务器”选项卡                                                 |
| notification_settings     | 隐藏“设置”页面上的“通知”选项卡                                               |
| queues                    | 隐藏“设置”页面上的“队列”选项卡（仅限系统管理员级别）             |
| repository_settings       | 隐藏“设置”页面上的“存储库设置”选项卡                                         |
| auto_commit_settings      | 隐藏“设置”页面上的“自动提交设置”选项卡                                        |
| security_settings         | 隐藏左侧面板上的“安全”项                                                        |
| security_settings_general | 隐藏“安全”下拉菜单中的“常规”项（仅限系统管理员级别） |
| 2fa                       | 隐藏左侧面板上的“双因素身份验证”项                                       |
| roles                     | 隐藏左侧面板上的“角色”项                                                           |
| self_registration         | 隐藏左侧面板上的“自助注册”项                                               |
| audit_log                 | 隐藏左侧面板上的“审计日志”项                                                      |
| oauth2                    | 隐藏左侧面板上的“Oauth2”项（仅限系统管理员级别）                 |
| ---                       

我们来看看它是如何工作的：

{% assign addNewMenuItem = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-add-new-menu-item-1.png,
        title: 转到“**品牌定制**”页面 -> “**自定义菜单**”选项卡。可以隐藏的菜单项名称显示在空的“**自定义菜单**”窗口中；
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-hide-menu-item-2.png,
        title: 请在“**自定义菜单**”窗口中以 JSON 数据格式提供要隐藏的菜单项。然后单击“**保存**”；
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-hide-menu-item-3.png,
        title: 选定的菜单项现在已隐藏。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewMenuItem %}

## 添加新菜单项

您可以添加一个新菜单项，该菜单项将链接到特定仪表板、文档页面或外部网页。
为此，请在“**自定义菜单**”窗口中以 JSON 数据格式指定新菜单项的参数。

用于添加新菜单项的 JSON 配置应包含以下参数：

| **参数**          | **说明**                                             |
|:-----------------------|:------------------------------------------------------------|
| name                   | 菜单项名称                                              |
| iconUrl                | 图标链接                                                |
| materialIcon           | 从默认材质图标中选择的图标名称 |
| iframeUrl              | 要打开的页面的链接                           |
| dashboardId            | 指定要打开的仪表板 ID                   |
| hideDashboardToolbar   | 显示/隐藏仪表板工具栏                             |
| childMenuItems         | 在一个部分下分组创建子菜单项             |
| ---                    

我们来创建三个新菜单项：两个项目将链接到仪表板，并将分组在一个部分下。
第三个项目将链接到文档。

{% assign addNewMenuItem = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-add-new-menu-item-1.png,
        title: 转到“**品牌定制**”页面 -> “**自定义菜单**”选项卡；
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-add-new-menu-item-2.png,
        title: 在“**自定义菜单**”窗口中以 JSON 格式指定数据。使用下面的 JSON 作为示例。单击“**保存**”；
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-add-new-menu-item-3.png,
        title: 创建了新菜单项。单击“我的仪表板”部分 -> “垃圾管理管理”页面。将打开 JSON 中指定的仪表板；
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-add-new-menu-item-4.png,
        title: 转到“智能农业和智能农业解决方案”页面。页面将打开 JSON 中指定的文档。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewMenuItem %}

<br>
对于此示例，请使用以下 JSON 添加新菜单项。

别忘了用你的仪表板 ID 替换 $DASHBOARD_ID 值。

```json
{
  "disabledMenuItems": [],
  "menuItems": [
    {
      "name": "My Dashboards",
      "iconUrl": null,
      "materialIcon": "grid_view",
      "iframeUrl": null,
      "dashboardId": null,
      "hideDashboardToolbar": null,
      "setAccessToken": false,
      "childMenuItems": [
        {
          "name": "Waste Management Administration",
          "iconUrl": null,
          "materialIcon": "dashboard",
          "iframeUrl": null,
          "dashboardId": "$DASHBOARD_ID",
          "hideDashboardToolbar": false,
          "setAccessToken": false,
          "childMenuItems": []
        },
        {
          "name": "Assisted Living Administration",
          "iconUrl": null,
          "materialIcon": "tablet_dashboard",
          "iframeUrl": null,
          "dashboardId": "$DASHBOARD_ID",
          "hideDashboardToolbar": null,
          "setAccessToken": false,
          "childMenuItems": []
        }
      ]
    },
    {
      "name": "Smart farming solutions",
      "iconUrl": "https://cdn-icons-png.flaticon.com/512/3214/3214679.png",
      "materialIcon": null,
      "iframeUrl": "https://docs.codingas.com/smart-farming/",
      "dashboardId": null,
      "hideDashboardToolbar": null,
      "setAccessToken": false,
      "childMenuItems": []
    }
  ]
}
```
{: .copy-code}

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}