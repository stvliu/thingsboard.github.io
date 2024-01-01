这种身份选项最安全。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| type | **cert.PEM** | OPC-UA 服务器上的身份类型。 |
| caCert | **/etc/gridlinks-gateway/ca.pem** | CA 证书的路径。 |
| privateKey | **/etc/gridlinks-gateway/private_key.pem** | 私钥的路径。 |
| cert | **/etc/gridlinks-gateway/cert.pem** | 证书文件的路径。 |
| mode | **SignAndEncrypt** | 安全模式，有 2 个选项 -- **Sign** 和 **SignAndEncrypt**。 |
| username | **user** | 登录 OPC-UA 服务器的用户名。 |
| password | **5Tr0nG?@$sW0rD** | 登录 OPC-UA 服务器的密码。 |
|---

***您可以选择提供用户名/密码对。***

配置的这一部分看起来像：

```json
    "identity": {
      "type": "cert.PEM",
      "caCert": "etc/gridlinks-gateway/ca.pem",
      "privateKey": "etc/gridlinks-gateway/private_key.pem", 
      "cert": "etc/gridlinks-gateway/cert.pem",
      "mode": "SignAndEncrypt",
      "username": "user",
      "password": "5Tr0nG?@$sW0rD"
    },
```