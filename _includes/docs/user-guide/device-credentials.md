设备凭证用于通过在设备上运行的应用程序连接到 ThingsBoard 服务器。
ThingsBoard 旨在支持不同的设备凭证。目前支持三种凭证类型：

- [**访问令牌**](/docs/{{docsPrefix}}user-guide/access-token/) - 适用于各种设备的通用凭证。基于访问令牌的身份验证可用于未加密的单向 SSL 模式或 DTLS accessToken 模式。
   - **优点：**受资源受限设备支持。网络开销低。易于配置和使用。
   - **缺点：**在使用未加密的网络连接（HTTP 而不是 HTTPS、MQTT 无 TLS/SSL、CoAP 无 DTLS 等）时可能很容易被拦截。
- [**基本 MQTT 凭证**](/docs/{{docsPrefix}}user-guide/basic-mqtt/) - 与第一个选项类似，但基于 MQTT 客户端 ID、用户名和密码工作。可用于未加密或单向 SSL 模式。
   - **优点：**受资源受限设备支持。网络开销低。易于配置和使用。
   - **缺点：**在使用未加密的网络连接（MQTT 无 TLS/SSL）时可能很容易被拦截。
- [**X.509 证书**](/docs/{{docsPrefix}}user-guide/certificates/) - [PKI](https://en.wikipedia.org/wiki/Public_key_infrastructure)、[TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) 和 [DTLS](https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security) 标准。基于 X.509 证书的身份验证用于双向 SSL 模式和具有 X.509 证书模式的 CoAP DTLS。
   - **优点：**使用加密的网络连接和公钥基础设施的高安全性。
   - **缺点：**某些资源受限设备不支持。影响电池和 CPU 使用率。

设备凭证需要配置到服务器上相应的设备实体。有多种方法可以做到这一点：

- **自动**，使用 [X.509 证书链](/docs/user-guide/certificates/) 或 [设备配置](/docs/{{docsPrefix}}user-guide/device-provisioning/)。允许设备在 ThingsBoard 中自动配置自身。
- **通过脚本**，使用 ThingsBoard [REST API](/docs/{{docsPrefix}}reference/rest-api/)。例如，在制造、质量保证或采购订单履行期间。
- **手动**，使用 ThingsBoard [Web UI](/docs/{{docsPrefix}}user-guide/ui/devices/#manage-device-credentials)。例如，用于开发目的或由系统管理员。