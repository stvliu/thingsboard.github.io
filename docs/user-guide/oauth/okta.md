---
layout: docwithnav
title: OAuth 2.0 支持
description: OAuth 2.0 支持

---

* TOC
{:toc}

## 概述
ThingsBoard 允许您为您的客户提供单点登录功能，并使用支持 **OAuth 2.0 协议** 的外部用户管理平台自动创建租户、客户或子客户。
本指南仅适用于 **Okta OAuth**。
## 情景描述

在本指南中，我们将使用 [Okta](https://www.okta.com/) 配置 **OAuth** 进行身份验证。
用户将登录到租户，租户名称将等于用户的电子邮件。
如果系统中不存在租户，则将创建新租户。

为了从 Auth0 平台映射这些外部用户信息，我们将使用内置的 [基本映射器](/docs/user-guide/oauth-2-support/#basic-mapper)。

如果 [基本映射器](/docs/user-guide/oauth-2-support/#basic-mapper) 功能不适合您的业务需求，您可以配置 [自定义映射器](/docs/user-guide/oauth-2-support/#custom-mapper)，以便能够添加适合您特定需求的实现。

## 使用 Okta 登录

### 准备工作
要正确应用配置，我们首先需要获取 **clientName**、**clientId** 和 **clientSecret**。
出于这些原因，我们首先访问 [Okta Developer Console](https://developer.okta.com/)。
首先，我们需要创建应用程序。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-application.png)

然后，我们需要指定平台类型。
在我们的案例中，平台类型等于 **Web**。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-application-creation-1.png)

名称等于 **clientName**，登录重定向 URI 等于我们这边的 **redirectUriTemplate**。
可以在 **thingsboard.yml** 中找到 **redirectUriTemplate**

```bash
    http://domain:port/login/oauth2/code/
```

在 domain 下，请指定您当前的 **domain**，在 **port** 中，请指定端口以通过 HTTP 访问您的 ThingsBoard 实例。

对于我们的示例，我们的 **domain** 等于 tb.tbsupport.xyz，**port** 为 80，因此无需另外指定端口。


![image](/images/user-guide/oauth-2-support/okta/okta-go-for-application-creation-2.png)

然后，我们需要确认我们应用的设置。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-application-creation-3.png)

要正确应用配置，我们首先需要获取 **clientId** 和 **clientSecret**。
这些可以在页面底部找到。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-application-creation-clientIdSecret.png)


然后，我们需要创建 **授权服务器**。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-authorization-server-creation.png)

**授权服务器** 的 **name** 和 **audience** 可以设置为任意值。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-authorization-server-creation-1.png)


因此，我们已经收到了三个值，需要将它们插入到我们的 **thingsboard.yml** 中。

因此，现在我们需要将它们插入到 **thingsboard.yml** 中。

我们还需要获取以下变量的链接列表：

```bash
SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI
SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI
SECURITY_OAUTH2_DEFAULT_JWK_SET_URI
```

可以在元数据 URI 的链接中找到这些内容的最新列表。

![image](/images/user-guide/oauth-2-support/okta/okta-go-for-authorization-server-creation-2.png)

单击这些链接会向我们提供一个 json，我们需要在其中找到以下字段。

```js
{
    ...
	"authorization_endpoint":"https://dev-example.okta.com/oauth2/default/v1/authorize",
	"token_endpoint":"https://dev-example.okta.com/oauth2/default/v1/token",
    ...
	"jwks_uri":"https://dev-example.okta.com/oauth2/default/v1/keys",
    ...	
}
```

因此，我们可以参考
```bash
SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI=https://dev-example.okta.com/oauth2/default/v1/token
SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI=https://dev-example.okta.com/oauth2/default/v1/authorize
SECURITY_OAUTH2_DEFAULT_JWK_SET_URI=https://dev-example.okta.com/oauth2/default/v1/keys
```

在我们的示例中，这些等于：
```bash
clientName=ThingsBoard
clientId=XXXXXXXX
clientSecret=YYYYYYYY
```


### 结果

因此，生成的 **thingsboard.yml** 等于以下内容。

```bash
...
# 安全参数
security:
   ...
      oauth2:
        # 启用/禁用 OAuth 2 登录功能
        # 有关详细信息，请参阅 https://thingsboard.io/docs/user-guide/oauth-2-support/
        enabled: "${SECURITY_OAUTH2_ENABLED:true}"
        # 将处理来自外部用户管理系统的访问代码的重定向 URL
        loginProcessingUrl: "${SECURITY_OAUTH2_LOGIN_PROCESSING_URL:/login/oauth2/code/}"
        # SSO 客户端列表
        clients:
          default:
            # 将在登录按钮上显示的标签 - '使用 {loginButtonLabel} 登录'
            loginButtonLabel: "${SECURITY_OAUTH2_DEFAULT_LOGIN_BUTTON_LABEL:Okta}"
            # 将在登录按钮上显示的图标。材质设计图标 ID (https://material.angularjs.org/latest/api/directive/mdIcon)
            loginButtonIcon: "${SECURITY_OAUTH2_DEFAULT_LOGIN_BUTTON_ICON:}"
            clientName: "${SECURITY_OAUTH2_DEFAULT_CLIENT_NAME:ThingsBoard}"
            clientId: "${SECURITY_OAUTH2_DEFAULT_CLIENT_ID:XXXXXXXX}"
            clientSecret: "${SECURITY_OAUTH2_DEFAULT_CLIENT_SECRET:YYYYYYYY}"
            accessTokenUri: "${SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI:https://dev-example.okta.com/oauth2/default/v1/token}"
            authorizationUri: "${SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI:https://dev-example.okta.com/oauth2/default/v1/authorize}"
            scope: "${SECURITY_OAUTH2_DEFAULT_SCOPE:openid,email,profile}"
            # 重定向 URL，必须与 'security.oauth2.loginProcessingUrl' 同步，但添加了域名
            redirectUriTemplate: "${SECURITY_OAUTH2_DEFAULT_REDIRECT_URI_TEMPLATE:http://tb.tbsupport.xyz/login/oauth2/code/}"
            jwkSetUri: "${SECURITY_OAUTH2_DEFAULT_JWK_SET_URI:https://dev-example.okta.com/oauth2/default/v1/keys}"
            # 'authorization_code', 'implicit', 'refresh_token' 或 'client_credentials'
            authorizationGrantType: "${SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_GRANT_TYPE:authorization_code}"
            clientAuthenticationMethod: "${SECURITY_OAUTH2_DEFAULT_CLIENT_AUTHENTICATION_METHOD:post}" # basic 或 post
            userInfoUri: "${SECURITY_OAUTH2_DEFAULT_USER_INFO:}"
            userNameAttributeName: "${SECURITY_OAUTH2_DEFAULT_USER_NAME_ATTRIBUTE_NAME:email}"
            mapperConfig:
              # 允许在用户不存在时创建用户
              allowUserCreation: "${SECURITY_OAUTH2_DEFAULT_MAPPER_ALLOW_USER_CREATION:true}"
              # 允许用户设置 GridLinks 内部密码并通过默认登录窗口登录
              activateUser: "${SECURITY_OAUTH2_DEFAULT_MAPPER_ACTIVATE_USER:false}"
              # 转换器类型，用于将外部用户转换为内部用户 - 'basic' 或 'custom'
              type: "${SECURITY_OAUTH2_DEFAULT_MAPPER_TYPE:basic}"
              basic:
                # 来自外部用户对象的属性作为电子邮件的键
                emailAttributeKey: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_EMAIL_ATTRIBUTE_KEY:email}"
                firstNameAttributeKey: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_FIRST_NAME_ATTRIBUTE_KEY:}"
                lastNameAttributeKey: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_LAST_NAME_ATTRIBUTE_KEY:}"
                # 从外部用户对象生成租户的策略 - 'domain', 'email' 或 'custom'
                # 'domain' - 租户的名称将从用户的电子邮件中提取为域
                # 'email' - 租户的名称将是用户的电子邮件
                # 'custom' - 请为自定义映射配置 'tenantNamePattern'
                tenantNameStrategy: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_TENANT_NAME_STRATEGY:domain}"
                # %{attribute_key} 作为外部用户对象的属性值的占位符
                tenantNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_TENANT_NAME_PATTERN:}"
                # 如果此字段不为空，则用户将作为定义的客户下的用户创建
                # %{attribute_key} 作为外部用户对象的属性值的占位符
                customerNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_CUSTOMER_NAME_PATTERN:}"
                # 如果此字段与非空 'defaultDashboardName' 一起设置，则用户将从定义的仪表板以全屏模式开始
                defaultDashboardName: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_DEFAULT_DASHBOARD_NAME:}"
                # 如果此字段设置为 'true' 并且 'defaultDashboardName' 不为空，则用户将从定义的仪表板以全屏模式开始
                alwaysFullScreen: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_ALWAYS_FULL_SCREEN:false}"
              custom:
                url: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_URL:}"
                username: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_USERNAME:}"
                password: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_PASSWORD:}"
```


应用所有更改后，请确保重新启动 ThingsBoard。
可以在 Linux 服务器上使用以下命令调用 ThingsBoard 重新启动：
```bash
$ sudo service thingsboard restart
```

之后，转到您的用户界面，以确保没有问题，按 **使用 Okta 登录**。

如果在这些方面遇到故障排除问题，请使用 [联系我们表格](/docs/contact-us/) 联系我们。

## 后续步骤

{% assign currentGuide = "OAuth" %}{% include templates/guides-banner.md %}