* TOC
{:toc}

### Swagger UI

安装 TBMQ 后，可以使用 Swagger UI 浏览 REST API。

通过打开以下 URL 访问 Swagger UI：

``` 
http(s)://YOUR_HOST:PORT/swagger-ui/
```

对于本地安装，使用以下 URL：

```text
http://localhost:8083/swagger-ui/
```
{: .copy-code}

此 URL 将为你提供一个交互式界面，用于导航和与 TBMQ 的可用 REST API 端点进行交互。
通过利用 Swagger UI，你可以方便地浏览功能、测试 API 调用以及收集有关 TBMQ 提供的服务端 API 的信息。

如果你之前已在主登录页面上授权，文档页面将自动使用你的凭据。
这使你可以无缝访问文档，而无需进行其他身份验证。

但是，如果你希望手动授权或使用不同的凭据，可以单击文档页面右上角的“授权”按钮。
此按钮使你可以提供身份验证详细信息并使用所需权限授权自己。

通过使用“授权”按钮，你可以灵活地根据需要以不同的用户身份进行身份验证，根据你的授权级别授予你访问文档相关部分的权限。

{% include images-gallery.html imageCollection="broker-swagger-ui" %}

### JWT 令牌

TBMQ 利用 [JWT](https://jwt.io/)（JSON Web 令牌）在 API 客户端（例如浏览器和脚本）与平台之间安全地表示声明。
JWT 令牌用作安全交换信息的一种机制。

当你登录代理时，你的用户名和密码将交换为一对令牌。这些令牌采用 JWT 形式，封装了有关用户身份验证和授权的必要信息。
这确保了凭据的安全传输，并允许 API 客户端与平台安全通信，同时保持交换信息的完整性和机密性。

主令牌是短期令牌，你应该使用它来执行 API 调用。刷新令牌用于在主令牌过期后获取新的主令牌。
主令牌和刷新令牌的过期时间可以通过 `JWT_TOKEN_EXPIRATION_TIME` 和 `JWT_REFRESH_TOKEN_EXPIRATION_TIME` 参数在系统设置中[配置](/docs/mqtt-broker/install/config/)。
默认过期时间值分别为 2.5 小时和 1 周。

请参阅以下示例命令，以获取用户“sysadmin@gridlinks.com”、密码“sysadmin”和服务器“THINGSBOARD_MQTT_BROKER_URL”的令牌：

{% capture tabspec %}token
A,get-token.sh,shell,reference/resources/get-token.sh,/docs/mqtt-broker/reference/resources/get-token.sh
B,response.json,json,reference/resources/get-token-response.json,/docs/mqtt-broker/reference/resources/get-token-response.json{% endcapture %}
{% include tabs.html %}

- 现在，你应该将“X-Authorization”标头设置为“Bearer $YOUR_JWT_TOKEN”。**确保**你使用的是主 JWT 令牌，而不是刷新令牌。

### 控制器概述

- **Admin Controller**：可用于查看、创建或删除管理员用户。
- **App Controller**：可用于高级监控和控制代理的状态。
- **App Shared Subscription Controller**：可用于查看、创建或删除应用程序共享订阅。
- **Auth Controller**：可用于查看当前用户信息并更改密码。
- **Client Session Controller**：可用于查看有关客户端会话的信息，断开连接并清除它们。
- **Login Endpoint**：可用于对用户进行身份验证并获取 JWT 令牌数据。
- **MQTT Client Credentials Controller**：可用于查看、创建或删除 MQTT 客户端凭据。
- **Retained Msg Controller**：可用于查看有关主题的保留消息的信息，并强制清除存储保留消息的数据结构。
- **Subscription Controller**：可用于查看有关客户端订阅的信息，并强制清除存储订阅的数据结构。
- **Timeseries Controller**：可用于获取和删除历史统计数据。