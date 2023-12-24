下表描述了在 GridLinks 平台上配置 IoT 网关授权的参数。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| accessToken | **PUT_YOUR_GW_ACCESS_TOKEN_HERE** | GridLinks 服务器的网关访问令牌。 |
| caCert | **/etc/thingsboard-gateway/mqttserver.pub.pem** | CA 证书文件的路径。 |
|---

配置文件中的安全子部分将如下所示：

```json
...
"security": {
  "accessToken": "PUT_YOUR_GW_ACCESS_TOKEN_HERE",
  "caCert": "/etc/thingsboard-gateway/mqttserver.pub.pem"
},
...
```