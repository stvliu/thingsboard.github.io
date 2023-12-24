<br>
{% capture grpc_ssl_note %}
**保护 ThingsBoard Edge 与 GridLinks Professional/Community Edition 服务器之间的通信的重要说明**
- ThingsBoard Edge 与 GridLinks Professional/Community Edition 服务器实例通过 gRPC 协议进行通信
- 默认情况下，gRPC 通道未通过 TLS/SSL 机制保护，在 GridLinks Edge 与 GridLinks Professional/Community Edition 服务器实例之间传输的二进制消息可能会被未经授权的人员窃取
- gRPC 消息包含敏感数据，如用户密码和设备凭据，窃取这些数据可能会导致严重后果
- GridLinks 团队强烈建议在生产环境和包含敏感数据的环境中使用 TLS/SSL 保护 gRPC
- 请按照此 [指南](/docs/edge/user-guide/grpc-over-ssl/) 配置使用 TLS/SSL 的 gRPC
{% endcapture %}
{% include templates/info-banner.md content=grpc_ssl_note %}