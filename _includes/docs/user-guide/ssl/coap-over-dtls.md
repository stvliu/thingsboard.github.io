* TOC
{:toc}

ThingsBoard 提供了通过 DTLS 运行 CoAP 服务器的功能。支持单向和双向 DTLS。
DTLS 预置需要有效的 [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) 证书。
ECDSA 密钥比 RSA 密钥小，因此更适合受限设备。有关更多详细信息，请参阅比较 [文章](https://sectigostore.com/blog/ecdsa-vs-rsa-everything-you-need-to-know/)。
我们建议使用由受信任的 CA 机构生成的有效 SSL 证书，避免花费时间解决 [自签名证书](#self-signed-certificates-generation) 的问题。
请参阅以下说明，了解如何为存储在 PEM 文件格式或 Java 密钥库中的证书配置 SSL。


### 使用 PEM 证书文件进行 SSL 配置

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过 [配置](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
例如，我们将使用 **thingsboard.conf**：

```bash
...
export COAP_DTLS_ENABLED=true
export COAP_DTLS_CREDENTIALS_TYPE=PEM
export COAP_DTLS_PEM_CERT=server.pem
export COAP_DTLS_PEM_KEY=server_key.pem
export COAP_DTLS_PEM_KEY_PASSWORD=secret
...
```

其中：

* COAP_DTLS_ENABLED - 启用/禁用 SSL 支持；
* COAP_DTLS_CREDENTIALS_TYPE - 服务器凭据类型。PEM - pem 证书文件；KEYSTORE - java 密钥库；
* COAP_DTLS_PEM_CERT - 服务器证书文件的路径。保存服务器证书或证书链，也可能包括服务器私钥；
* COAP_DTLS_PEM_KEY - 服务器证书私钥文件的路径。默认情况下是可选的。如果服务器证书文件中不存在私钥，则需要；
* COAP_DTLS_PEM_KEY_PASSWORD - 可选服务器证书私钥密码。

完成设置后，启动或重新启动 ThingsBoard 服务器。

{% include templates/ssl/pem_files_location.md %}


### 其他配置属性

您可以通过 [配置](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下其他环境变量。

* COAP_DTLS_BIND_ADDRESS - 安全 CoAP 服务器的绑定地址。默认值 *0.0.0.0* 表示所有接口；
* COAP_DTLS_BIND_PORT - 安全 CoAP 服务器的绑定端口。默认值为 *5684*；
* TB_COAP_X509_DTLS_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT - 跳过客户端证书的证书有效性检查。默认值为 *false*。
* TB_COAP_X509_DTLS_SESSION_INACTIVITY_TIMEOUT - DTLS 会话的最大非活动时间（以毫秒为单位）。默认值为 *86400000*，对应于一天。
* TB_COAP_X509_DTLS_SESSION_REPORT_TIMEOUT - 定期清理非活动会话的频率。默认值为 *1800000*，对应于 30 分钟。

{% include docs/user-guide/ssl/self-signed-ecc.md %}

## 客户端示例

请参阅以下资源：

- [基于访问令牌的身份验证](/docs/{{docsPrefix}}user-guide/ssl/coap-access-token/)，了解 **单向 SSL** 连接的示例；
- [基于 X.509 证书的身份验证](/docs/{{docsPrefix}}user-guide/ssl/coap-x509-certificates/)，了解 **双向 SSL** 连接的示例。