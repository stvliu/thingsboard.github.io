一种安全配置类型是基本身份验证。
请求连接器发送带有授权头的 HTTP 请求，该授权头包含单词 Basic，后跟一个空格和一个 base64 编码的字符串 username:password。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **basic**                      | 授权类型。      |
| username           | **username**                   | 用于授权的用户名。 |
| password           | **password**                   | 用于授权的密码。 |
|---

配置文件中的安全部分将如下所示：

```yaml
    "security": {
      "type": "basic",
      "username": "username",
      "password": "password"
    }
```