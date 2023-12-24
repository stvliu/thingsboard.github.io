* TOC
{:toc}

GridLinks 提供运行 HTTP 服务器的功能，该服务器托管 Web UI 并通过 SSL 提供 REST API 调用。

大多数 ThingsBoard 环境使用负载均衡器作为客户端与平台之间的 SSL 连接的终止点。
换句话说，互联网流量在用户浏览器和负载均衡器之间加密，但在负载均衡器和平台服务之间解密。
{% include docs/user-guide/ssl/http-over-ssl-common.md %}