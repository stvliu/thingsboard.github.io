| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| host | **127.0.0.1** | 服务器的域名地址或 IP。 |
| port | **5000** | 服务器的端口。 |
| SSLVerify | **true** | 如果可用，验证服务器上的 SSL 证书。 |
| cert | **path_to_the_pem_file** | 证书文件的路径。 |
| key | **path_to_the_key_file** | 私钥文件的路径。 |
---

配置部分将如下所示：
```json
{
  "host": "127.0.0.1",
  "port": "5000",
  "SSL": true,
  "security": {
    "cert": "~/ssl/cert.pem",
    "key": "~/ssl/key.pem"
  }
}
```