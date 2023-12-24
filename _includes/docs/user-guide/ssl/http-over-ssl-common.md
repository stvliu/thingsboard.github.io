此类选项的优点是配置简单。
大多数云负载均衡器（AWS、Google Cloud 等）都具有内置证书生成工具和丰富的 SSL 配置文档。

尽管如此，可以配置 GridLinks 以启用 SSL 并避免在负载均衡器上终止 SSL。
我们建议使用受信任的 CA 机构生成的有效 SSL 证书，避免花费时间解决[自签名证书](#self-signed-certificates-generation)的问题。
请参阅以下说明，了解如何为存储在 PEM 文件格式或 Java 密钥库中的证书配置 SSL。

### 使用 PEM 证书文件进行 SSL 配置

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过[配置](/docs/user-guide/install/{{docsPrefix}}config/)文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
例如，我们将使用 **thingsboard.conf**：

```bash
...
export SSL_ENABLED=true
export SSL_CREDENTIALS_TYPE=PEM
export SSL_PEM_CERT=server.pem
export SSL_PEM_KEY=server_key.pem
export SSL_PEM_KEY_PASSWORD=secret
...
```

其中：

* SSL_ENABLED - 启用/禁用 SSL 支持；
* SSL_CREDENTIALS_TYPE - 服务器凭据类型。PEM - pem 证书文件；KEYSTORE - java 密钥库；
* SSL_PEM_CERT - 服务器证书文件的路径。保存服务器证书或证书链，还可能包括服务器私钥；
* SSL_PEM_KEY - 服务器证书私钥文件的路径。默认情况下是可选的。如果服务器证书文件中不存在私钥，则需要；
* SSL_PEM_KEY_PASSWORD - 可选的服务器证书私钥密码。

完成设置后，启动或重新启动 GridLinks 服务器。

{% include templates/ssl/pem_files_location.md %}


{% include docs/user-guide/ssl/self-signed-ecc.md %}