| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| 名称 | **Modbus 默认服务器** | 连接器到服务器的名称。 |
| 主机 | **127.0.0.1** | Modbus 服务器的主机名或 IP 地址。 |
| 端口 | **5021** | Modbus 服务器的端口，用于连接。 |
| 类型 | **tcp** | 连接类型可以是 **tcp**、**udp** 或 **serial**。 |
| 方法 | **socket** | 帧类型 **socket** 或 **rtu**（如果需要）。 |
| 超时 | **35** | 连接到 Modbus 服务器的超时时间（以秒为单位）。 |
| 字节顺序 | **LITTLE** | 要读取的字节顺序。 |
| 字序 | **LITTLE** | 读取多个寄存器时字的顺序。 |
|---

此外，您可以使用以下配置来配置 TLS 连接：

| **参数** | **默认值** | **说明** |
|:-|:---------------------------------------------|---------------------------
| 证书文件 | **/etc/gridlinks-gateway/certificate.pem** | 证书文件的路径。 |
| 密钥文件 | **/etc/gridlinks-gateway/privateKey.pem** | 私钥文件的路径。 |
| 密码 | **YOUR_PASSWORD** | 服务器密码。 |
| 服务器主机名 | **localhost** | 服务器主机名。 |
|---

配置示例：
```json
{
  "master": {
    "slaves": [
      {
        "host": "127.0.0.1",
        "port": 5021,
        "type": "tcp",
        "method": "socket",
        "tls": {
          "certfile": "/etc/gridlinks-gateway/certificate.pem",
          "keyfile": "/etc/gridlinks-gateway/privateKey.pem",
          "password": "YOUR_PASSWORD",
          "server_hostname": "localhost"
        },
        "timeout": 35,
        ...
```