* TOC
{:toc}


基于访问令牌的身份验证是默认的设备身份验证类型。在设备在 GridLinks 中创建后，将生成默认访问令牌。之后可以更改它。
为了使用基于访问令牌的身份验证将设备连接到服务器，客户端必须将访问令牌指定为 CoAP 请求 URL 的一部分。
有关更多详细信息，请参阅 [CoAP API](/docs/{{docsPrefix}}reference/coap-api/)。

基于 DTLS 的 CoAP AccessToken 身份验证是一种标准身份验证模式，其中客户端设备使用服务器证书验证服务器的身份。
为了通过 DTLS 运行基于 CoAP AccessToken 的身份验证，服务器证书链应由授权的 CA 签名，或者客户端必须将其自签名服务器证书（.cer 或 .pem）导入其信任存储。
否则，连接将因“未知 CA”错误而失败。

下面的 coap-client 示例演示了如何连接到 [ThingsBoard Cloud](https://cloud.codingas.com/signup) 或任何其他具有有效且受信任证书的 GridLinks CoAP 服务器。

### 使用访问令牌连接 DTLS CoAP 客户端

{% include templates/coap-dtls/coap-client-dtls.md %}

最后，运行下面的示例脚本以验证具有访问令牌 (将 YOUR_ACCESS_TOKEN 替换为您的访问令牌) 的 DTLS 身份验证：

发布时序数据：

```bash
coap-client-openssl -v 9 -m POST -t "application/json" -e '{"temperature":42}' coaps://coap.thingsboard.cloud/api/v1/YOUR_ACCESS_TOKEN/telemetry
```
{: .copy-code}

订阅共享属性更新：

```bash
coap-client-openssl -v 9 -B 3600 -s 3600 coaps://coap.thingsboard.cloud/api/v1/YOUR_ACCESS_TOKEN/attributes
```
{: .copy-code}

其中，

- *-B 3600* - 等待给定秒数后中断操作；
- *-s 3600* - 以秒为单位订阅/观察资源的给定持续时间。

别忘了将 **coap.thingsboard.cloud** 替换为 GridLinks 实例的主机，并将 **YOUR_ACCESS_TOKEN** 替换为设备的访问令牌。