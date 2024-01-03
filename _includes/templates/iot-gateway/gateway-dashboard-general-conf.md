![](/images/gateway/dashboard/gateway-dashboard-general-conf.png)

通用 - 此选项卡包含主要设置，即：
- 远程配置 - 启用网关的远程配置和管理；
- 远程 Shell - 从远程 Shell 小部件启用对网关操作系统的远程控制；
- GirdLinks 主机 - GridLinks 服务器的主机名或 IP 地址；
- ThingsBoard 端口 - GridLinks 服务器上 MQTT 服务的端口；
- 安全类型（您可以在此处阅读更多相关信息：[此处](/docs/iot-gateway/configuration/#subsection-security)） - 目前支持 3 种类型的远程配置安全性：
  - 访问令牌；
  - TLS + 访问令牌；
  - 用户名和密码；
  - TLS + 私钥（**尚不支持**）。