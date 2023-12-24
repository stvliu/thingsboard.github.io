* TOC
{:toc}

ThingsBoard 提供运行 HTTP 服务器的功能，该服务器通过 SSL 处理来自设备的 API 调用。
本指南实际上是 [启用 HTTPS](/docs/{{docsPrefix}}user-guide/ssl/http-over-ssl/) 指南的副本。

大多数 ThingsBoard 环境使用负载均衡器作为设备与平台之间 SSL 连接的终止点。
换句话说，互联网流量在设备与负载均衡器之间加密，但在负载均衡器与平台服务之间解密。
{% include docs/user-guide/ssl/http-over-ssl-common.md %}

## 客户端示例

有关 **单向 SSL** 连接的示例，请参阅 [基于访问令牌的身份验证](/docs/{{docsPrefix}}user-guide/ssl/http-access-token/)。