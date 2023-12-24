---
layout: docwithnav-mobile-pe
title: 在 ThingsBoard PE 移动应用程序中配置白标

login-white-labeling:
 0:
  image: /images/mobile/pe/white-labeling-1.png
  title: '对于租户级别设置，在<b>域名</b>字段中输入域名'
 1:
  image: /images/mobile/pe/white-labeling-2.png
  title: '在<b>基本 URL</b>字段中输入基本 URL（包括协议方案<b>http</b>或<b>https</b>以及端口，如果它不同于标准端口<b>80</b>或<b>443</b>）'
 2:
  image: /images/mobile/pe/white-labeling-3.png
  title: '将所需的徽标图像上传到<b>徽标</b>字段'
 3:
  image: /images/mobile/pe/white-labeling-4.png
  title: '在<b>徽标高度</b>字段中指定徽标高度（如果需要）'
 4:
  image: /images/mobile/pe/white-labeling-5.png
  title: '在<b>主调色板</b>字段中选择主调色板'
 5:
  image: /images/mobile/pe/white-labeling-6.png
  title: '单击<b>保存</b>按钮以应用更改'

login-white-labeling-result:
 0:
  image: /images/mobile/pe/white-labeling-7.png
  title: '您应该在登录表单顶部看到您的徽标图像。按钮和背景应根据所选调色板进行着色。'

white-labeling:
 0:
  image: /images/mobile/pe/white-labeling-8.png
  title: '将所需的徽标图像上传到<b>徽标</b>字段'
 1:
  image: /images/mobile/pe/white-labeling-9.png
  title: '在<b>主调色板</b>字段中选择主调色板'
 2:
  image: /images/mobile/pe/white-labeling-10.png
  title: '单击<b>保存</b>按钮以应用更改'

white-labeling-result:
 0:
  image: /images/mobile/pe/white-labeling-11.png
  title: '您应该在主屏幕的顶部栏中看到您的徽标图像。按钮和图标应根据所选调色板进行着色。'

---

* TOC
{:toc}

## 概述

ThingsBoard PE [白标](/docs/pe/user-guide/white-labeling/)功能允许您配置公司或产品徽标和配色方案。
除了 ThingsBoard Web 界面外，白标设置还适用于 ThingsBoard PE 移动应用程序。
使用白标，您可以自定义移动应用程序登录屏幕和主应用程序界面的外观。

## 登录屏幕白标

作为系统或租户管理员，您可以在 **登录白标** 表单中配置应用程序登录屏幕徽标和调色板。

{% capture login_white_labeling_levels %}
**注意：** 默认情况下，应用系统级别的登录白标（由系统管理员配置）。每个租户都可以通过在 **登录白标** 表单中指定 **域名** 来覆盖这些设置。
在这种情况下，将根据移动应用程序中配置的 API 端点的域名应用租户级别设置（**lib/constants/app_constants.dart** 中 **thingsBoardApiEndpoint** 常量值）。
{% endcapture %}
{% include templates/info-banner.md content=login_white_labeling_levels %}

要配置登录屏幕白标，请执行以下步骤：

1. 通过屏幕左侧的主菜单转到 **白标** -> **登录白标**；
2. 对于租户级别设置，在 **域名** 字段中输入域名；
3. 在 **基本 URL** 字段中输入基本 URL（包括协议方案 **http** 或 **https** 以及端口，如果它不同于标准端口 **80** 或 **443**）；
4. 将所需的徽标图像上传到 **徽标** 字段；
5. 在 **徽标高度** 字段中指定徽标高度（如果需要）；
6. 在 **主调色板** 字段中选择主调色板；
7. 单击 **保存** 按钮以应用更改；

{% include images-gallery.html imageCollection="login-white-labeling" %}

要验证您的登录白标设置，请运行移动应用程序。
您应该在登录表单顶部看到您的徽标图像。按钮和背景应根据所选调色板进行着色。

{% include images-gallery.html imageCollection="login-white-labeling-result" %}

## 主应用程序界面白标

作为系统或租户管理员，您可以在 **白标** 表单中配置主应用程序界面徽标和调色板。

{% capture app_white_labeling_levels %}
**注意：** 默认情况下，应用系统级别的白标（由系统管理员配置）。每个租户都可以在 **白标** 表单中覆盖这些设置。
{% endcapture %}
{% include templates/info-banner.md content=app_white_labeling_levels %}

要配置主应用程序界面白标，请执行以下步骤：

1. 通过屏幕左侧的主菜单转到 **白标** -> **白标**；
2. 将所需的徽标图像上传到 **徽标** 字段；
3. 在 **主调色板** 字段中选择主调色板；
4. 单击 **保存** 按钮以应用更改；

{% include images-gallery.html imageCollection="white-labeling" %}

要验证您的白标设置，请运行移动应用程序并执行登录。
您应该在主屏幕的顶部栏中看到您的徽标图像。按钮和图标应根据所选调色板进行着色。

{% include images-gallery.html imageCollection="white-labeling-result" %}