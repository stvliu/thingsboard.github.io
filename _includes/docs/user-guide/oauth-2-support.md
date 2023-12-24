* TOC
{:toc}

## 概述

GridLinks 允许您为您的客户提供单点登录功能，并使用支持 OAuth 2.0 协议的外部用户管理平台自动创建租户、客户或子客户。

支持 OAuth 2.0 协议的平台列表：[Google](https://developers.google.com/identity/protocols/oauth2/openid-connect)、[Okta](https://www.okta.com/)、[Auth0](https://auth0.com/) 等。


## OAuth 2.0 身份验证流程

GridLinks 支持授权码授予类型，以将授权码交换为访问令牌。

一旦用户通过重定向 URL 返回 GridLinks 客户端，平台将从 URL 中获取授权码，并使用它向外部用户管理平台请求访问令牌。
使用 [基本映射器](/docs/{{docsPrefix}}user-guide/oauth-2-support/#basic-mapper) 或 [自定义映射器](/docs/{{docsPrefix}}user-guide/oauth-2-support/#custom-mapper)，外部用户信息对象将从外部平台转换为 GridLinks 内部 OAuth 2.0 用户。
此后，将发生常规的 GridLinks 授权流程。


## 场景描述

在本示例中，我们将使用 [Google](https://developers.google.com/identity/protocols/oauth2/openid-connect) 进行身份验证。
用户将登录到租户，并且租户名称将等于用户的电子邮件。
如果租户在系统中不存在，则将创建新租户。

作为第二步，我们将为身份验证添加一个新的外部提供程序 - [Auth0](https://auth0.com/)。
在这种情况下，用户将登录到租户，其名称将等于用户的电子邮件域名。
此外，对于每个用户，我们将创建一个新客户，并且客户名称将等于用户的电子邮件。

为了从 Google 和 Auth0 平台映射外部用户信息，我们将使用内置的 [基本映射器](/docs/{{docsPrefix}}user-guide/oauth-2-support/#basic-mapper)。

如果 [基本映射器](/docs/{{docsPrefix}}user-guide/oauth-2-support/#basic-mapper) 功能不符合您的业务需求，您可以配置 [自定义映射器](/docs/{{docsPrefix}}user-guide/oauth-2-support/#custom-mapper)，以便能够添加适合您特定需求的实现。

### 使用 Google 登录

要使用 Google OAuth 2.0 身份验证平台进行登录，您需要在 Google API 控制台中设置一个项目以获取 OAuth 2.0 凭据。

请按照 [OpenID Connect](https://developers.google.com/identity/protocols/oauth2/openid-connect) 页面上的说明配置 OAuth 2.0 客户端。
完成上述说明后，您应该有一个新的 OAuth 客户端，其凭据包括客户端 ID 和客户端密钥。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/1-create-credentials.png&#41;)
{% include images-gallery.html imageCollection="step1" preview="false" max-width="100%" %}

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/2-pencil-google.png&#41;)
{% include images-gallery.html imageCollection="step2" preview="false" max-width="100%" %}

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/3-client-id.png&#41;)
{% include images-gallery.html imageCollection="step3" preview="false" max-width="100%" %}

请将我们将在此示例中使用的 GridLinks 默认重定向 URI 添加到授权重定向 URI 部分：

```
http://localhost:8080/login/oauth2/code/
```

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/4-Authorized-redirect-uris.png&#41;)
{% include images-gallery.html imageCollection="step4" preview="false" max-width="100%" %}

#### GridLinks 的配置

以系统管理员身份转到您的 GridLinks (sysadmin@gridlinks.com / sysadmin)。检查常规设置 -> 基本 URL 在末尾不应包含“/”（例如，“`http://127.0.0.1:8080`”而不是“`https://127.0.0.1:8080/`”）。然后在 **主页** 部分，找到“OAuth2”图标并单击它。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/5-home-oauth2.png&#41;)
{% include images-gallery.html imageCollection="step5" preview="false" max-width="100%" %}

选中 **启用 OAuth2 设置** 并单击 **+ 添加**。在出现的窗口中单击 *localhost* 以进行进一步设置。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/6-home-oauth2-add.png&#41;)
{% include images-gallery.html imageCollection="step6" preview="false" max-width="100%" %}

选择所需的协议。如果您决定使用 HTTP 协议，请务必在域名中写下其端口 8080 (localhost:8080)。
在本示例中，我们将配置 Google 提供商。单击此块。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/7-oauth2-google.png&#41;)
{% include images-gallery.html imageCollection="step7" preview="false" max-width="100%" %}

请提供来自 Google API 控制台的信息（**客户端 ID** 和 **客户端密钥**）。
然后展开 **自定义设置** 菜单。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/8-login-provider-google.png&#41;)
{% include images-gallery.html imageCollection="step8" preview="false" max-width="100%" %}

让我们对常规块进行设置。
使用此 [链接](https://developers.google.com/identity/protocols/oauth2/openid-connect#discovery) 查看最新 URL 列表，例如 **accessTokenUri**、**authorizationUri** 等。
在 *客户端身份验证方法* 字段中选择 **POST**。然后选中“允许用户创建”复选框。将以下内容添加到范围字段：*openid、email、profile*。然后转到 **映射器** 块。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/9-oauth2-google-general.png&#41;)
{% include images-gallery.html imageCollection="step9" preview="false" max-width="100%" %}

选择 **基本** 类型，并在必要时填写字段（*在本文档的后面部分中以基本映射器部分进行了更详细的描述*）。
某些配置仅在专业版中可用。然后，**保存设置**。


[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/10-oauth2-google-general-mapper-pe.png&#41;)
{% include images-gallery.html imageCollection="step10" preview="false" max-width="100%" %}

因此，Google 的最终 oauth2 配置将类似于下面提供的配置。

如果我们导航到登录屏幕，我们将看到一个带有 Google 的其他登录选项：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/11-login-with-google.png&#41;)
{% include images-gallery.html imageCollection="step11" preview="false" max-width="100%" %}

一旦我们单击它并选择我们的一个 Google 帐户，我们将使用我们的 Google 电子邮件作为租户管理员电子邮件登录到 GridLinks：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/12-tenant-administrator.png&#41;)
{% include images-gallery.html imageCollection="step12" preview="false" max-width="100%" %}

如果您以系统管理员身份登录，您将看到租户名称是我们的 Google 电子邮件，根据基本映射器：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/13-tenants-email.png&#41;)
{% include images-gallery.html imageCollection="step13" preview="false" max-width="100%" %}

### 使用 Auth0 登录

现在让我们在我们的列表中添加另一个提供商 - [Auth0](https://auth0.com/)。
这次，我们将在单个域租户内为我们的用户创建客户。

要使用 Auth0 身份验证平台进行登录，让我们按照此 [链接](https://auth0.com/docs/quickstarts/) 创建一个“常规 Web 应用程序”类型的应用程序。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/14-auth0-regular-web-app.png&#41;)
{% include images-gallery.html imageCollection="step14" preview="false" max-width="100%" %}

从技术列表中，请选择 *Java Spring Boot*：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/15-auth0-java-spring-boot.png&#41;)
{% include images-gallery.html imageCollection="step15" preview="false" max-width="100%" %}

创建应用程序后，您可以导航到应用程序详细信息以获取 **clientId** 和 **clientSecret**：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/16-auth0-applications-settings.png&#41;)
{% include images-gallery.html imageCollection="step16" preview="false" max-width="100%" %}

同样，请更新您的允许的回调 URL：

```
http://localhost:8080/login/oauth2/code/
```

**请注意**，无需更新应用程序登录 URI。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/17-auth0_allowed-callback-urls.png&#41;)
{% include images-gallery.html imageCollection="step17" preview="false" max-width="100%" %}

在高级详细信息部分，您将能够找到 OAuth 2.0 配置所需的所有 URL（端点）：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/18-auth0-advanced-settings.png&#41;)
{% include images-gallery.html imageCollection="step18" preview="false" max-width="100%" %}

#### GridLinks 的配置

现在我们可以添加另一个提供商：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/19-oauth2-add-provider.png&#41;)
{% include images-gallery.html imageCollection="step19" preview="false" max-width="100%" %}

然后选择 **自定义：**

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/20-oauth2-add-provider-custom.png&#41;)
{% include images-gallery.html imageCollection="step20" preview="false" max-width="100%" %}

请提供来自您的应用程序详细信息的信息（**客户端 ID** 和 **客户端密钥**），您可以在高级详细信息部分找到所有必需的 URL。

在 *客户端身份验证方法* 字段中选择 **POST**。我们在 *提供商标签* 字段中指明 **Auth0**。然后选中“允许用户创建”复选框。将以下内容添加到范围字段：*openid、email、profile*。然后转到 **映射器** 块。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/21-oauth2-custom-general.png&#41;)
{% include images-gallery.html imageCollection="step21" preview="false" max-width="100%" %}

选择 **基本** 类型，并在必要时填写字段（*在本文档的后面部分中以基本映射器部分进行了更详细的描述*）。
某些配置仅在专业版中可用。然后，**保存** 设置。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/22-oauth2-custom-mapper-pe.png&#41;)
{% include images-gallery.html imageCollection="step22" preview="false" max-width="100%" %}

因此，OAuth0 的最终 oauth2 配置将类似于下面提供的配置。


如果我们导航到登录屏幕，我们将看到两个可能的登录选项 - **Google** 和 **Auth0**：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/23-login-with-auth0.png&#41;)
{% include images-gallery.html imageCollection="step23" preview="false" max-width="100%" %}

一旦我们单击它并选择我们的 *Auth0* 帐户，我们将使用我们的电子邮件作为客户用户登录到 GridLinks：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/24_customer.png&#41;)
{% include images-gallery.html imageCollection="step24" preview="false" max-width="100%" %}

如果我们以系统管理员身份登录，您将看到租户名称是我们的 *Auth0* 电子邮件域名，根据基本映射器：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/25-tenants-emails.png&#41;)
{% include images-gallery.html imageCollection="step25" preview="false" max-width="100%" %}

我们已经完成了我们的示例，现在您的用户无需在 GridLinks 中创建帐户 - 他们可以使用已经存在的 SSO 提供商来实现此目的。

### 结果片段
此片段包含我们示例中使用的两个提供商：

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/26-both-providers.png&#41;)
{% include images-gallery.html imageCollection="step26" preview="false" max-width="100%" %}

## 将外部用户映射到 GridLinks 内部用户结构

可以通过使用 **基本** 和 **自定义** 映射器将外部用户的信息对象映射到 GridLinks 用户。
映射器的主要功能是将外部用户的信息对象中的键值属性映射到 GridLinks OAuth 2.0 用户的预期结构：

```java
public class OAuth2User {
    private String tenantName;
    private TenantId tenantId;
    private String customerName;
    private CustomerId customerId;
    private String email;
    private String firstName;
    private String lastName;
    private boolean alwaysFullScreen;
    private String defaultDashboardName;
    
    // NOTE: Next configurations available only in Professional Edition

    private List<String> userGroups;
    private String parentCustomerName;
    private CustomerId parentCustomerId;
}
```

### 基本映射器

基本映射器能够使用一组预定义的规则将外部 OAuth 2.0 用户信息对象合并到 GridLinks OAuth 2.0 用户中。

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/27-oauth2-basic-mapper-pe.png&#41;)
{% include images-gallery.html imageCollection="step27" preview="false" max-width="100%" %}

要使用基本映射器，请将 *mapperConfig.type* 或 *SECURITY_OAUTH2_DEFAULT_MAPPER_TYPE* 环境变量设置为 **basic**。

以下是其他属性的详细信息：

- **allowUserCreation** -
  如果此选项设置为 **true**，那么，如果用户帐户在 GridLinks 中还不存在，它将被创建。
  如果此选项设置为 **false**，用户将收到访问被拒绝的错误，如果他尝试使用外部 OAuth 2.0 提供商登录，但 GridLinks 中没有具有这些凭据的用户。   
 
- **emailAttributeKey** -
  这是外部 OAuth 2.0 用户信息中属性的键，该键将用作 GridLinks 用户的电子邮件属性。
  
- **firstNameAttributeKey** -
  这是外部 OAuth 2.0 用户信息中属性的键，该键将用作 GridLinks 用户的姓氏属性。
    
- **lastNameAttributeKey** -
  这是外部 OAuth 2.0 用户信息中属性的键，该键将用作 GridLinks 用户的姓氏属性。

- **tenantNameStrategy** -
  此选项指定将为创建用户选择哪个租户。
  基本映射器为从外部用户信息对象生成租户名称提供了三种可能的选项策略 - *domain*、*email* 或 *custom*：
     - **domain** - 租户的名称将从用户的电子邮件中提取为域；
     - **email** - 租户的名称将是用户的电子邮件；
     - **custom** - 可以为租户名称设置自定义模式。请参阅 *tenantNamePattern*。

- **tenantNamePattern** -
  如果 *tenantNameStrategy* 是 **custom**，您可以使用自定义模式来指定要为其创建用户的租户的名称。
  您可以使用外部用户信息对象中的属性将它们放入租户的名称中。请使用 %{attribute_key} 作为属性值的占位符。
  
  租户模式示例：
     - **Demo Tenant**           # 硬编码租户名称；
     - **Demo Tenant %{email}**  # 如果用户的电子邮件是 *test@demo.com*，租户的名称将是 *'Demo Tenant test@demo.com'*;
     - **%{givenName}**          # 如果用户的 givenName 属性是 *Demo User*，租户名称将是 *'Demo User'*.
        
- **customerNamePattern**
  用户可以在特定客户下创建，而不在租户下，如果此模式字段不为空。
  您可以使用外部用户信息对象中的属性将它们放入客户名称中。请使用 %{attribute_key} 作为属性值的占位符。
  
  客户模式示例：
     - **Demo Customer**             # 硬编码客户名称；
     - **Demo Customer %{email}**    # 如果用户的 *email* 属性是 *test@demo.com*，客户名称将是 *'Demo Customer test@demo.com'*;
     - **%{city}**                   # 如果用户的 *city* 属性是 *New York*，客户名称将是 *'New York'*. 

- **defaultDashboardName**
  如果此字段不为空，用户将被重定向到特定仪表板。
  
- **alwaysFullScreen**
  如果此字段为 **true** 且 **defaultDashboardName** 不为空，用户将被重定向到全屏模式下的特定仪表板。

- **parentCustomerNamePattern**

  **注意：此配置仅在专业版中可用。**

  如果此模式字段不为空，则可以将用户的客户创建在该父客户的层次结构中。
  您可以使用外部用户信息对象中的属性将它们放入父客户名称中。请使用 %{attribute_key} 作为属性值的占位符。
  
  父客户模式示例：
     - **Demo Parent Customer**           # 硬编码父客户名称；
     - **Demo Parent Customer %{email}**  # 如果用户的 *email* 属性是 *test@demo.com*，父客户名称将是 *'Demo Parent Customer test@demo.com'*;
     - **%{country}**                     # 如果用户的 *country* 属性是 *Top Customer*，父客户名称将是 *'Parent Customer'*. 

- **userGroupsNamePattern**

  **注意：此配置仅在专业版中可用。**

  默认情况下，新创建的用户仅分配给 **All** 用户组。
  您可以通过指定用户必须分配到的组列表来自定义此行为。
  您可以使用外部用户信息对象中的属性将它们放入用户组名称中。请使用 %{attribute_key} 作为属性值的占位符。
  如果组不存在，此组将自动创建。
  
  用户组模式示例：
     - **Tenant Administrators, Managers**   # 硬编码用户组；
     - **%{job_title}**                    # 如果用户的 *job_title* 属性是 *Manager*，用户将被分配到 *Manager* 用户组。

### 自定义映射器

如果基本映射器功能无法满足您的业务需求，您可以借助自定义映射器添加一个实现来满足您的特定目标。

自定义映射器设计为一个单独的微服务，它在 GridLinks 核心微服务附近运行。
GridLinks 将所有映射请求转发到此微服务，并期望作为响应的 GridLinks OAuth 2.0 用户对象：

```java
public class OAuth2User {
    private String tenantName;
    private TenantId tenantId;
    private String customerName;
    private CustomerId customerId;
    private String email;
    private String firstName;
    private String lastName;
    private boolean alwaysFullScreen;
    private String defaultDashboardName;
    
    // NOTE: Next configurations available only in Professional Edition
    private List<String> userGroups;
    private String parentCustomerName;
    private CustomerId parentCustomerId;
}
```

请参阅此 [基本实现](https://github.com/thingsboard/custom-oauth2-mapper)作为自定义映射器的起点。

要使用自定义映射器，请将 *mapperConfig.type* 或 *SECURITY_OAUTH2_DEFAULT_MAPPER_TYPE* 环境变量设置为 **custom**。

以下是其他属性的详细信息：

- **URL**

  自定义映射器端点的 URL。

- **username**

  如果自定义映射器端点配置了基本授权，请在此属性中指定 *username*。
 
- **password**

  如果自定义映射器端点配置了基本授权，请在此属性中指定 *password*。
  
这是一个演示配置的示例：

```bash
  custom:
    url: http://localhost:10010/oauth2/mapper
    username: admin
    password: pa$$word
```

[comment]: <> (![image]&#40;/images/user-guide/oauth-2-support/28-oauth2-google-general-mapper-custom.png&#41;)
{% include images-gallery.html imageCollection="step28" preview="false" max-width="100%" %} 


## OAuth 2.0 配置参数

| 键 | 描述 |
| --- | ----------- |
| security.oauth2.enabled | 启用/禁用 OAuth 2.0 登录功能 |
| security.oauth2.loginProcessingUrl | 将处理来自外部用户管理系统的访问代码的重定向 URL |
| security.oauth2.clients.default.loginButtonLabel | 将显示在登录按钮上的标签 - 'Login with {loginButtonLabel}' |
| security.oauth2.clients.default.loginButtonIcon | 将显示在登录按钮上的图标。材质设计图标 ID。可以在 [此处](https://material.angularjs.org/latest/api/directive/mdIcon) 找到图标 ID 列表 |
| security.oauth2.clients.default.clientName | 客户端或注册的逻辑名称 |
| security.oauth2.clients.default.clientId | 客户端 ID |
| security.oauth2.clients.default.clientSecret | 客户端密钥 |
| security.oauth2.clients.default.accessTokenUri | 令牌端点的 URI |
| security.oauth2.clients.default.authorizationUri | 授权端点的 URI |
| security.oauth2.clients.default.scope | 为客户端设置的范围 |
| security.oauth2.clients.default.redirectUriTemplate | 重定向端点的 URI（或 uri 模板）。必须与 'security.oauth2.loginProcessingUrl'（已添加域名）同步 |
| security.oauth2.clients.default.jwkSetUri | JSON Web Key (JWK) 集端点的 URI |
| security.oauth2.clients.default.authorizationGrantType | 用于客户端的 [授权授予类型](https://docs.spring.io/spring-security/site/docs/current/api/org/springframework/security/oauth2/core/AuthorizationGrantType.html) |
| security.oauth2.clients.default.clientAuthenticationMethod | 在使用授权服务器对客户端进行身份验证时使用的 [身份验证方法](https://docs.spring.io/spring-security/site/docs/current/api/org/springframework/security/oauth2/core/ClientAuthenticationMethod.html) |
| security.oauth2.clients.default.userInfoUri | 用户信息端点的 URI |
| security.oauth2.clients.default.userNameAttributeName | 用于从用户信息响应中访问用户名称的属性名称 |

## HaProxy 配置

如果 GridLinks 在负载均衡器（如 HAProxy）下运行，请正确配置平衡算法，以确保在 GridLinks 实例上可以使用正确的会话：
```bash
backend tb-api-backend
  ...
  balance source # balance 必须设置为 'source'
  ...
```


同样，请为 HTTP 和 HTTPs 请求正确配置 ACL 映射：
```bash
frontend http-in
  ...
  acl tb_api_acl path_beg /api/ /swagger /webjars /v2/ /static/rulenode/ /oauth2/ /login/oauth2/ # '/oauth2/ /login/oauth2/' added
  ...
```

```bash
frontend https_in
  ...
  acl tb_api_acl path_beg /api/ /swagger /webjars /v2/ /static/rulenode/ /oauth2/ /login/oauth2/ # '/oauth2/ /login/oauth2/' added
  ...
```