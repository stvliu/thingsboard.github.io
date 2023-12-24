* TOC
{:toc}

GridLinks 提供了通过 SSL 运行 MQTT 服务器的功能。支持单向和双向 SSL。

大多数 ThingsBoard 环境使用负载均衡器作为设备与平台之间 SSL 连接的终止点。
换句话说，MQTT 流量在设备和负载均衡器之间加密，但在负载均衡器和平台服务之间解密。
这种选项的优点是配置简单。
大多数云负载均衡器（AWS、Google Cloud 等）都具有内置证书生成工具和丰富的文档，介绍如何通过 TCP 配置 SSL。
这种选项的缺点是无法实现双向 SSL。客户端证书的信息不会从负载均衡器传递到平台服务。

尽管如此，仍然可以将 GridLinks 配置为 MQTT 的双向 SSL 并避免在负载均衡器上终止 SSL。
我们建议使用受信任的 CA 机构生成的有效 SSL 证书，避免花费时间解决[自签名证书](#self-signed-certificates-generation)的问题。
请参阅以下说明，了解如何为存储在 PEM 文件格式或 Java 密钥库中的证书配置 SSL。


### 使用 PEM 证书文件进行 SSL 配置

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过[配置](/docs/user-guide/install/{{docsPrefix}}config/)文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
例如，我们将使用 **thingsboard.conf**：

```bash
...
export MQTT_SSL_ENABLED=true
export MQTT_SSL_CREDENTIALS_TYPE=PEM
export MQTT_SSL_PEM_CERT=server.pem
export MQTT_SSL_PEM_KEY=server_key.pem
export MQTT_SSL_PEM_KEY_PASSWORD=secret
...
```

其中：

* MQTT_SSL_ENABLED - 启用/禁用 SSL 支持；
* MQTT_SSL_CREDENTIALS_TYPE - 服务器凭据类型。PEM - pem 证书文件；KEYSTORE - java 密钥库；
* MQTT_SSL_PEM_CERT - 服务器证书文件的路径。保存服务器证书或证书链，也可能包括服务器私钥；
* MQTT_SSL_PEM_KEY - 服务器证书私钥文件的路径。默认情况下是可选的。如果服务器证书文件中没有私钥，则需要；
* MQTT_SSL_PEM_KEY_PASSWORD - 可选的服务器证书私钥密码。

完成设置后，启动或重新启动 GridLinks 服务器。

{% include templates/ssl/pem_files_location.md %}

### 其他配置属性

您可以通过[配置](/docs/user-guide/install/{{docsPrefix}}config/)文件、docker-compose 或 kubernetes 脚本配置以下其他环境变量。

* MQTT_SSL_BIND_ADDRESS - MQTT 服务器的绑定地址。默认值 *0.0.0.0* 表示所有接口；
* MQTT_SSL_BIND_PORT - MQTT 服务器的绑定端口。默认值为 *8883*；
* MQTT_SSL_PROTOCOL - ssl 协议名称。默认值为 *TLSv1.2*。有关更多详细信息，请参阅[java 文档](https://docs.oracle.com/en/java/javase/11/docs/specs/security/standard-names.html#sslcontext-algorithms)；
* MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT - 跳过客户端证书的证书有效性检查。默认值为 *false*。

{% include docs/user-guide/ssl/self-signed-ecc.md %}

## 客户端示例

请参阅以下资源：

- [设备身份验证选项](/docs/{{docsPrefix}}user-guide/device-credentials/)，了解身份验证选项概述
- [基于访问令牌的身份验证](/docs/{{docsPrefix}}user-guide/access-token/)，了解 **单向 SSL** 连接的示例
- [基于 X.509 证书的身份验证](/docs/{{docsPrefix}}user-guide/certificates/)，了解 **双向 SSL** 连接的示例