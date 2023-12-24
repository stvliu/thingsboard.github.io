一种安全配置类型是基本身份验证。
REST 连接器等待带有 Authorization 标头的 HTTP 请求，该标头包含单词 Basic，后跟一个空格和一个 base64 编码的字符串 username:password。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **basic**                      | 授权类型。      |
| username           | **username**                   | 授权用户名。 |
| password           | **password**                   | 授权密码。 |
|---

配置文件中的安全部分将如下所示：

```json
    "security": {
      "type": "basic",
      "username": "username",
      "password": "password"
    }
```

此外，请确保您的请求具有提供凭据的 `Authorization` 标头。

如果您使用 cURL，则请求将如下所示：
```bash
curl --user username:password -H "Content-Type: application/json" -X POST \
    -d '{"sensorName": "SN-001", "sensorModel": "example"}' http://127.0.0.1:5000/my_devices
```

或者，如果您使用 Postman 或 Insomnia，只需启用基本身份验证即可。