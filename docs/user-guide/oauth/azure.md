---
layout: docwithnav
title: OAuth 2.0 支持
description: OAuth 2.0 支持

---

* TOC
{:toc}

## 概述
GridLinks 允许您为您的客户提供单点登录功能，并使用支持 **OAuth 2.0 协议** 的外部用户管理平台自动创建租户、客户或子客户。
本指南仅适用于 **Azure Active Directory OAuth**。
## 情景描述

在本指南中，我们将使用 [Azure Active Directory](https://portal.azure.com/) 配置 **OAuth** 进行身份验证。
用户将登录到租户，租户名称将等于用户的电子邮件。
如果系统中不存在租户，则将创建新租户。

为了从 Auth0 平台映射这些外部用户信息，我们将使用内置的 [基本映射器](/docs/user-guide/oauth-2-support/#basic-mapper)。

如果 [基本映射器](/docs/user-guide/oauth-2-support/#basic-mapper) 功能不适合您的业务需求，您可以配置 [自定义映射器](/docs/user-guide/oauth-2-support/#custom-mapper)，以便能够添加适合您特定需求的实现。

如果您需要高级自定义，可以参考 [Microsoft 标识平台和 OpenID Connect 协议](https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-protocols-oidc) 文档。

## 使用 Azure Active Directory 登录

### 准备工作

Azure Active Directory 需要使用 SSL。请确保您已为您的域配置 HTTPS，以便可以使用 **Azure Active Directory** 配置这些域。

如果未配置 SSL，请按照 [本指南](/docs/user-guide/install/pe/add-haproxy-ubuntu/) 安装 HAProxy 并使用 Let’s Encrypt 生成有效的 SSL 证书。


为了正确应用配置，我们需要首先获取 **clientName**、**clientId** 和 **clientSecret**。

出于这些原因，我们首先访问 [Azure Active Directory](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview)。

现在我们需要创建应用程序。

![image](/images/user-guide/oauth-2-support/azure/azure-go-for-ad.png)

然后我们需要进行应用程序注册并注册我们的应用程序。

![image](/images/user-guide/oauth-2-support/azure/azure-go-for-and-create-application.png)

在本例中，平台类型等于 **Web**。

名称等于 **clientName**，登录重定向 URI 等于我们这边的 **redirectUriTemplate**。

可以在 **thingsboard.yml** 中找到 **redirectUriTemplate**

```bash
    https://domain:port/login/oauth2/code/
```

在 domain 下，请指定您当前的 **domain**，对于 **port**，请指定端口以通过 HTTPS 访问您的 GridLinks 实例。

对于我们的示例，我们的 **domain** 等于 tb.tbsupport.xyz，**port** 为 443，因此无需另外指定端口。


![image](/images/user-guide/oauth-2-support/azure/azure-create-application.png)

然后我们需要确认应用程序的注册。

![image](/images/user-guide/oauth-2-support/azure/azure-application-general-data.png)

现在我们位于我们的常规页面上，我们可以在其中找到 **clientId** 和我们之前指定的 **clientName**。


![image](/images/user-guide/oauth-2-support/azure/azure-application-authentication.png)

现在让我们转到 **身份验证** 选项卡。在这里我们可以找到 **redirectUriTemplate**，我们需要为授权端点指定令牌。出于示例原因，我们将指定 **访问令牌**，我们需要 **保存我们应用的更改**。

![image](/images/user-guide/oauth-2-support/azure/azure-application-secrets.png)

然后我们转到 **证书和密钥** 选项卡并创建 **clientSecret**

![image](/images/user-guide/oauth-2-support/azure/azure-application-endpoints.png)

我们还需要获取以下变量的链接列表：

```bash
SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI
SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI
SECURITY_OAUTH2_DEFAULT_JWK_SET_URI
```

可以在 **OpenID Connect 元数据文档** 链接中找到这些变量的最新列表。

这样我们就可以引用我们变量的以下值。
```bash
SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI=https://login.microsoftonline.com/example-tenant-id/oauth2/token
SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI=https://login.microsoftonline.com/example-tenant-id/oauth2/authorize
SECURITY_OAUTH2_DEFAULT_JWK_SET_URI=https://login.microsoftonline.com/example-tenant-id/discovery/keys
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
        # 有关详细信息，请参阅 https://docs.codingas.com/docs/user-guide/oauth-2-support/
        enabled: "${SECURITY_OAUTH2_ENABLED:true}"
        # 将处理来自外部用户管理系统的访问代码的重定向 URL
        loginProcessingUrl: "${SECURITY_OAUTH2_LOGIN_PROCESSING_URL:/login/oauth2/code/}"
        # SSO 客户端列表
        clients:
          default:
            # 将显示在登录按钮上的标签 - '使用 {loginButtonLabel} 登录'
            loginButtonLabel: "${SECURITY_OAUTH2_DEFAULT_LOGIN_BUTTON_LABEL:Azure Active Directory}"
            # 将显示在登录按钮上的图标。材质设计图标 ID (https://material.angularjs.org/latest/api/directive/mdIcon)
            loginButtonIcon: "${SECURITY_OAUTH2_DEFAULT_LOGIN_BUTTON_ICON:}"
            clientName: "${SECURITY_OAUTH2_DEFAULT_CLIENT_NAME:ThingsBoard}"
            clientId: "${SECURITY_OAUTH2_DEFAULT_CLIENT_ID:XXXXXXXX}"
            clientSecret: "${SECURITY_OAUTH2_DEFAULT_CLIENT_SECRET:YYYYYYYY}"
            accessTokenUri: "${SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI:https://login.microsoftonline.com/example-tenant-id/oauth2/token}"
            authorizationUri: "${SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI:https://login.microsoftonline.com/example-tenant-id/oauth2/authorize}"
            scope: "${SECURITY_OAUTH2_DEFAULT_SCOPE:openid,email,profile}"
            # 重定向 URL，必须与 'security.oauth2.loginProcessingUrl' 同步，但添加了域名
            redirectUriTemplate: "${SECURITY_OAUTH2_DEFAULT_REDIRECT_URI_TEMPLATE:https://tb.tbsupport.xyz/login/oauth2/code/}"
            jwkSetUri: "${SECURITY_OAUTH2_DEFAULT_JWK_SET_URI:https://login.microsoftonline.com/example-tenant-id/discovery/keys}"
            # 'authorization_code', 'implicit', 'refresh_token' 或 'client_credentials'
            authorizationGrantType: "${SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_GRANT_TYPE:authorization_code}"
            clientAuthenticationMethod: "${SECURITY_OAUTH2_DEFAULT_CLIENT_AUTHENTICATION_METHOD:post}" # basic 或 post
            userInfoUri: "${SECURITY_OAUTH2_DEFAULT_USER_INFO:}"
            userNameAttributeName: "${SECURITY_OAUTH2_DEFAULT_USER_NAME_ATTRIBUTE_NAME:email}"
            mapperConfig:
              # 允许在用户不存在时创建用户
              allowUserCreation: "${SECURITY_OAUTH2_DEFAULT_MAPPER_ALLOW_USER_CREATION:true}"
              # 允许用户设置 GridLinks 内部密码并在默认登录窗口中登录
              activateUser: "${SECURITY_OAUTH2_DEFAULT_MAPPER_ACTIVATE_USER:false}"
              # 将外部用户转换为内部用户的映射器类型 - 'basic' 或 'custom'
              type: "${SECURITY_OAUTH2_DEFAULT_MAPPER_TYPE:basic}"
              basic:
                # 从外部用户对象的属性中用作电子邮件的键
                emailAttributeKey: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_EMAIL_ATTRIBUTE_KEY:email}"
                firstNameAttributeKey: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_FIRST_NAME_ATTRIBUTE_KEY:}"
                lastNameAttributeKey: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_LAST_NAME_ATTRIBUTE_KEY:}"
                # 从外部用户对象生成租户的策略 - 'domain', 'email' 或 'custom'
                # 'domain' - 租户的名称将从用户的电子邮件中提取为域
                # 'email' - 租户的名称将是用户的电子邮件
                # 'custom' - 请为自定义映射配置 'tenantNamePattern'
                tenantNameStrategy: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_TENANT_NAME_STRATEGY:domain}"
                # %{attribute_key} 作为外部用户对象属性值的占位符
                tenantNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_TENANT_NAME_PATTERN:}"
                # 如果此字段不为空，则用户将作为定义的客户下的用户创建
                # %{attribute_key} 作为外部用户对象属性值的占位符
                customerNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_CUSTOMER_NAME_PATTERN:}"
                # 如果此字段与非空 'defaultDashboardName' 一起设置，则用户将从定义的仪表板以全屏模式开始
                alwaysFullScreen: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_ALWAYS_FULL_SCREEN:false}"
              custom:
                url: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_URL:}"
                username: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_USERNAME:}"
                password: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_PASSWORD:}"
```


应用所有更改后，请确保重新启动 GridLinks。
可以在 Linux 服务器上使用以下命令调用 GridLinks 重新启动：
```bash
$ sudo service gridlinks restart
```

之后，转到您的用户界面，以确保没有问题，按 **使用 Azure Active Directory 登录**。

![image](/images/user-guide/oauth-2-support/azure/azure-login.png)

如果遇到这些问题，请 [使用联系我们表格](/docs/contact-us/) 联系我们。

## 后续步骤

{% assign currentGuide = "OAuth" %}{% include templates/guides-banner.md %}