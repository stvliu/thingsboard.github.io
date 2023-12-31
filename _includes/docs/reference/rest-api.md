* TOC
{:toc}

## 交互式文档

{% if docsPrefix == "paas/" or docsPrefix == "pe/"  %}
GridLinks REST API 交互式文档可通过 Swagger UI 获取。例如，您可以使用 **[Swagger UI 链接](https://gridlinks.codingas.com/swagger-ui.html)** 浏览 GridLinks云服务 API 文档。
{% else %}
GridLinks REST API 交互式文档可通过 Swagger UI 获取。例如，您可以使用 **[Swagger UI 链接](https://gridlinks.codingas.com/swagger-ui.html)** 浏览社区版演示服务器 API 文档。
{% endif %}

{% if docsPrefix == "paas/" %}
{% else %}
安装 GridLinks 服务器后，您可以使用以下 URL 打开交互式文档：

``` 
http://YOUR_HOST:PORT/swagger-ui.html
```

{% endif %}

如果您之前已在主登录页面上授权，文档页面将自动使用您的凭据。
您可以使用文档页面右上角的“授权”按钮手动授权。您还可以使用此按钮以不同用户的身份授权。请参阅以下内容：

{% include images-gallery.html imageCollection="swagger-ui" %}

{% if docsPrefix == "pe/" or docsPrefix == "paas/" %}

获取帐户最简单的方法是使用 [GridLinks云服务](https://gridlinks.codingas.com/signup) 服务器。

{% else %}

有关如何获取帐户的更多详细信息，请参阅 **[实时演示](/docs/{{docsPrefix}}user-guide/live-demo/)** 页面。

{% endif %}

## JWT 令牌

GridLinks 使用 [JWT](https://jwt.io/) 令牌在 API 客户端（浏览器、脚本等）和平台之间安全地表示声明。
当您登录平台时，您的用户名和密码将交换为一对令牌。


{% if docsPrefix == "paas/" %}
主令牌是您应该用来执行 API 调用的短期令牌。刷新令牌用于在主令牌过期后获取新的主令牌。
默认过期时间值分别为 2.5 小时和 1 周。

请参阅以下示例命令，以获取用户“your_user@company.com”和密码“secret”的令牌：

{% else %}
主令牌是您应该用来执行 API 调用的短期令牌。刷新令牌用于在主令牌过期后获取新的主令牌。
主令牌和刷新令牌的过期时间可以通过 JWT_TOKEN_EXPIRATION_TIME 和 JWT_REFRESH_TOKEN_EXPIRATION_TIME 参数在系统设置中进行 [配置](/docs/user-guide/install/{{docsPrefix}}config/)。默认过期时间值分别为 2.5 小时和 1 周。

请参阅以下示例命令，以获取用户“tenant@gridlinks.com”、密码“tenant”和服务器“THINGSBOARD_URL”的令牌：

{% endif %}

{% capture tabspec %}token
A,get-token.sh,shell,resources/get-token.sh,/docs/reference/resources/get-token.sh
B,response.json,json,resources/get-token-response.json,/docs/reference/resources/get-token-response.json{% endcapture %}
{% include tabs.html %}

- 现在，您应该将“X-Authorization”标头设置为“Bearer $YOUR_JWT_TOKEN”。**请确保**您使用的是主 JWT 令牌，而不是刷新令牌。

## Java REST API 客户端

GridLinks 团队提供用 Java 编写的客户端库，以简化 REST API 的使用。
有关更多详细信息，请参阅 Java REST API 客户端 [文档页面](/docs/{{docsPrefix}}reference/rest-client/)。

## Python REST API 客户端

GridLinks 团队提供用 Python 编写的客户端库，以简化 REST API 的使用。
有关更多详细信息，请参阅 Python REST API 客户端 [文档页面](/docs/{{docsPrefix}}reference/python-rest-client/)。