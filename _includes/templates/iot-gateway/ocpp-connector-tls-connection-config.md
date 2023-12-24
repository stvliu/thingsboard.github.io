下表中描述了配置 TLS 连接的参数。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| key | **/etc/thingsboard-gateway/privateKey.pem** | 私钥文件的路径。 |
| cert | **/etc/thingsboard-gateway/certificate.pem** | 证书文件的路径。 |
| password | **YOUR_PASSWORD** | **可选** TLS 连接的密码 |
|---

配置文件中的连接子部分将如下所示：

```yaml
    "connection": {
      "type": "tls",
      "key": "/etc/thingsboard-gateway/privateKey.pem",
      "cert": "/etc/thingsboard-gateway/certificate.pem"
    }
```