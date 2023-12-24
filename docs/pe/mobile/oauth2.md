---
layout: docwithnav-mobile-pe
title: 在 ThingsBoard PE 移动应用程序中配置 OAuth 2.0

oauth2:
 0:
  image: /images/mobile/pe/oauth2-1.png
  title: '转到<b>系统设置</b> -> <b>OAuth2</b>。展开域面板。<br>打开<b>移动应用程序</b>选项卡。'
 1:
  image: /images/mobile/pe/oauth2-2.png
  title: '单击<b>添加应用程序</b>。'
 2:
  image: /images/mobile/pe/oauth2-3.png
  title: '指定您的应用程序包（对于 Android：您自己的唯一应用程序 ID。对于 iOS：产品包标识符。）<br>记住自动生成的<b>应用程序密钥</b>或输入您自己的密钥。'
 3:
  image: /images/mobile/pe/oauth2-4.png
  title: '最后，要应用更改，请单击 OAuth 表单右下角的<b>保存</b>按钮。'

oauth2-login-buttons:
 0:
  image: /images/mobile/pe/oauth2-5.png
  title: '您应该在登录表单顶部看到其他 OAuth 2.0 登录按钮。'

---

{% assign docsPrefix = "pe/" %}
{% include docs/mobile/oauth2.md %}