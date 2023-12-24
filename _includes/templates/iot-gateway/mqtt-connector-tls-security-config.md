下表描述了在 mqtt 代理上配置授权的参数。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| caCert                   | **/etc/thingsboard-gateway/ca.pem**          | CA 文件的路径。                                               |
| privateKey               | **/etc/thingsboard-gateway/privateKey.pem**  | 私钥文件的路径。                                      |
| cert                     | **/etc/thingsboard-gateway/certificate.pem** | 证书文件的路径。
|---    

配置文件中的安全子部分将如下所示：

```json
  "security":{
    "caCert": "/etc/thingsboard-gateway/ca.pem",
    "privateKey": "/etc/thingsboard-gateway/privateKey.pem",
    "cert": "/etc/thingsboard-gateway/certificate.pem"
  }
```