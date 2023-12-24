下表描述了在 ThingsBoard 平台上配置 IoT 网关授权的参数。

| **参数** | **默认值** | **说明** |
|:-|:-|-
| caCert                   | **/etc/thingsboard-gateway/ca.pem**          | CA 文件的路径。                                                      |
| privateKey               | **/etc/thingsboard-gateway/privateKey.pem**  | 私钥文件的路径。                                             |
| cert                     | **/etc/thingsboard-gateway/certificate.pem** | 证书文件的路径。                                             |
| checkCertPeriod          | **86400**                                    | 检查证书的周期（以秒为单位）。                                   |
| certificateDaysLeft      | **3**                                        | 证书到期前的天数，届时将生成新的证书。                          |
|---    

配置文件中的安全子部分将如下所示：

```json
...
"security": {
  "caCert": "/etc/thingsboard-gateway/ca.pem",
  "privateKey": "/etc/thingsboard-gateway/privateKey.pem",
  "cert": "/etc/thingsboard-gateway/certificate.pem",
  "checkCertPeriod": 86400,
  "certificateDaysLeft": 3
},
...
```