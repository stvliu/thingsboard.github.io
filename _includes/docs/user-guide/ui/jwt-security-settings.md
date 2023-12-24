GridLinks 使用 [JWT](https://jwt.io/) 令牌在 API 客户端（浏览器、脚本等）和平台之间安全地表示声明。当您登录平台时，您的用户名和密码将交换为一对令牌。

主令牌是您应该用来执行 API 调用的短期令牌。刷新令牌用于在主令牌过期后获取新的主令牌。

要自定义 JWT，请以系统管理员身份登录 ThingsBoard。

{% if docsPrefix == null %}
![image](/images/user-guide/ui/jwt/jwt-provider-settings-step-1-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/ui/jwt/jwt-provider-settings-step-1-pe.png)
{% endif %}

您可以自定义以下 JWT 选项：

**颁发者名称** - 此字段是必需的，并添加到令牌的默认“iss”声明值中。此字段包含在生成的令牌中，并在解码的令牌中进行验证。

**签名密钥** - 此字段值用于对生成的令牌的内容进行签名。对于 HMAC 签名，这应该是一个随机字符串，以 Base64 格式编码，并且至少包含 256 位数据，这是签名协议所要求的。

**令牌过期时间** - 以秒为单位的值指定访问令牌的有效期。此值在令牌生成期间添加到当前 UTC 中，以获取令牌的默认“exp”声明值。默认值为 9000 秒。最小值为 60 秒。

**刷新令牌过期时间** - 以秒为单位的值指定刷新令牌的有效期。此值在令牌生成期间添加到当前 UTC 中，以获取令牌的默认“exp”声明值。默认值为 604800 秒。最小值为 900 秒。