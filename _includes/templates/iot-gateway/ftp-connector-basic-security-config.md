一种安全配置是基本配置，
对于授权，将使用本节中 config 中提供的用户名/密码组合。


|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **basic**                      | 授权类型。      |
| username           | **username**                   | 授权用户名。 |
| password           | **password**                   | 授权密码。 |
|---

配置文件中的安全子部分将如下所示：

```yaml
    "security": {
      "type": "basic",
      "username": "username",
      "password": "password"
    }
```