---
layout: docwithnav
title: OAuth 2.0 支持
description: OAuth 2.0 支持

---

* TOC
{:toc}

## 概述
ThingsBoard 允许您为您的客户提供单点登录功能，并使用支持 **OAuth 2.0 协议** 的外部用户管理平台自动创建租户、客户或子客户。
本指南仅适用于 **OAuth0 OAuth**。
## 情景描述

在本指南中，我们将使用 [OAuth0](https://auth0.auth0.com/) 配置 **OAuth** 进行身份验证。
在这种情况下，用户将登录到租户，其名称将等于用户的电子邮件域名。
此外，对于每个用户，我们将创建一个新客户，客户名称将是用户的电子邮件

为了从 Auth0 平台映射这些外部用户信息，我们将使用内置的 [基本映射器](/docs/user-guide/oauth-2-support/#basic-mapper)。

如果 [基本映射器](/docs/user-guide/oauth-2-support/#basic-mapper) 功能不适合您的业务需求，您可以配置 [自定义映射器](/docs/user-guide/oauth-2-support/#custom-mapper)，以便能够添加适合您特定需求的实现。

## 使用 OAuth0 登录

### 准备工作
要正确应用配置，我们首先需要获取 **clientName**、**clientId** 和 **clientSecret**。
出于这些原因，我们首先访问 [OAuth0 管理控制台](https://auth0.auth0.com/)。
首先，我们需要创建应用程序。

![image](/images/user-guide/oauth-2-support/oauth0/Application-to-create.png)

然后，我们需要指定应用程序名称和应用程序类型。
应用程序名称等于 **clientName**。应用程序类型是 **常规 Web 应用程序**。

![image](/images/user-guide/oauth-2-support/oauth0/Application-creation.png)

之后，您需要指定正在使用的技术。请指定 **Java Spring Security**。

![image](/images/user-guide/oauth-2-support/oauth0/Application-creation-specify-type.png)

然后，我们将被转发到应用程序信息页面。在那里，我们可以找到 **clientName**、**clientId** 和 **clientSecret**。

![image](/images/user-guide/oauth-2-support/oauth0/Application-Details-1.png)

对于允许的回调 URL，我们需要为我们的实例指定重定向 URI。

**重定向 URI** 需要以以下格式指定：

```bash
    http://domain:port/login/oauth2/code/
```

在域下，请指定您当前的 **域**，对于 **端口**，请指定端口以通过 HTTP 访问您的 GridLinks 实例。
例如，我的域是 localhost，端口是默认的 GridLinks 安装端口 80。

![image](/images/user-guide/oauth-2-support/oauth0/Application-Details-2.png)

因此，我们已经收到了三个值，需要将它们插入到我们的 **thingsboard.yml** 中。

在我们的示例中，这些等于：
```bash
clientName=ThingsBoard
clientId=XXXXXXXX
clientSecret=YYYYYYYY
```

因此，现在我们需要将它们插入到 **thingsboard.yml** 中。

我们还需要获取以下变量的链接列表：

```bash
SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI
SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI
SECURITY_OAUTH2_DEFAULT_JWK_SET_URI
SECURITY_OAUTH2_DEFAULT_USER_INFO_URI
```

可以在应用程序页面的底部找到这些变量的最新列表。

![image](/images/user-guide/oauth-2-support/oauth0/Application-Details-3.png)

对于我们的示例，我们将 Auth0 应用程序域设置为 tbsupport.eu.auth0.com，因此正在使用以下值：

```bash
SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI=https://tbsupport.eu.auth0.com/oauth/token
SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI=https://tbsupport.eu.auth0.com/authorize
SECURITY_OAUTH2_DEFAULT_JWK_SET_URI=https://tbsupport.eu.auth0.com/.well-known/jwks.json
SECURITY_OAUTH2_DEFAULT_USER_INFO_URI=https://tbsupport.eu.auth0.com/userinfo
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
           auth0:
             # 将在登录按钮上显示的标签 - '使用 {loginButtonLabel} 登录'
             loginButtonLabel: "${SECURITY_OAUTH2_DEFAULT_LOGIN_BUTTON_LABEL:Auth0}"
             # 将在登录按钮上显示的图标。材质设计图标 ID (https://material.angularjs.org/latest/api/directive/mdIcon)
             loginButtonIcon: "${SECURITY_OAUTH2_DEFAULT_LOGIN_BUTTON_ICON:}"
             clientName: "${SECURITY_OAUTH2_DEFAULT_CLIENT_NAME:ThingsBoard}"
             clientId: "${SECURITY_OAUTH2_DEFAULT_CLIENT_ID:XXXXXXXX}"
             clientSecret: "${SECURITY_OAUTH2_DEFAULT_CLIENT_SECRET:YYYYYYYY}"
             accessTokenUri: "${SECURITY_OAUTH2_DEFAULT_ACCESS_TOKEN_URI:https://tbsupport.eu.auth0.com/oauth/token}"
             authorizationUri: "${SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_URI:https://tbsupport.eu.auth0.com/authorize}"
             scope: "${SECURITY_OAUTH2_DEFAULT_SCOPE:openid,email,profile}"
             # 重定向 URL，必须与 'security.oauth2.loginProcessingUrl' 同步，但添加了域名
             redirectUriTemplate: "${SECURITY_OAUTH2_DEFAULT_REDIRECT_URI_TEMPLATE:http://localhost:80/login/oauth2/code/}"
             jwkSetUri: "${SECURITY_OAUTH2_DEFAULT_JWK_SET_URI:https://tbsupport.eu.auth0.com/.well-known/jwks.json}"
             # 'authorization_code', 'implicit', 'refresh_token' 或 'client_credentials'
             authorizationGrantType: "${SECURITY_OAUTH2_DEFAULT_AUTHORIZATION_GRANT_TYPE:authorization_code}"
             clientAuthenticationMethod: "${SECURITY_OAUTH2_DEFAULT_CLIENT_AUTHENTICATION_METHOD:post}" # basic 或 post
             userInfoUri: "${SECURITY_OAUTH2_DEFAULT_USER_INFO_URI:https://tbsupport.eu.auth0.com/userinfo}"
             userNameAttributeName: "${SECURITY_OAUTH2_DEFAULT_USER_NAME_ATTRIBUTE_NAME:email}"
             mapperConfig:
               # 允许在用户不存在时创建用户
               allowUserCreation: "${SECURITY_OAUTH2_DEFAULT_MAPPER_ALLOW_USER_CREATION:true}"
               # 允许用户设置 GridLinks 内部密码并通过默认登录窗口登录
               activateUser: "${SECURITY_OAUTH2_DEFAULT_MAPPER_ACTIVATE_USER:false}"
               # 从外部用户到内部用户的转换器映射器类型 - 'basic' 或 'custom'
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
                 customerNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_CUSTOMER_NAME_PATTERN: %{email}}"
                 parentCustomerNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_PARENT_CUSTOMER_NAME_PATTERN:}" # %{attribute_key} 作为属性值占位符
                 userGroupsNamePattern: "${SECURITY_OAUTH2_DEFAULT_MAPPER_BASIC_USER_GROUPS_NAME_PATTERN: Customer Users}" # 以逗号分隔的用户组名称列表，%{attribute_key} 作为属性值占位符
               custom:
                 url: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_URL:}"
                 username: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_USERNAME:}"
                 password: "${SECURITY_OAUTH2_DEFAULT_MAPPER_CUSTOM_PASSWORD:}"
```


应用所有更改后，请确保重新启动 GridLinks。
可以在 Linux 服务器上使用以下命令调用 GridLinks 重新启动：
```bash
$ sudo service thingsboard restart
```  
之后，转到您的用户界面，以确保没有问题，按 **使用 OAuth0 登录**。

如果在这些方面遇到故障排除问题，请 [使用联系我们表格](/docs/contact-us/) 联系我们。

## 后续步骤

{% assign currentGuide = "OAuth" %}{% include templates/guides-banner.md %}