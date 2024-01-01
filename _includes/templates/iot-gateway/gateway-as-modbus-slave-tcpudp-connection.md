| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| 类型 | **tcp** | 连接类型可以是 **tcp**、**udp** 或 **serial**。 |
| 主机 | **127.0.0.1** | Modbus 服务器的主机名或 IP 地址。 |
| 端口 | **5020** | Modbus 服务器的连接端口。 |
| 方法 | **socket** | 如果需要，则为 **socket** 或 **rtu** 类型。 |
| 设备名称 | **Modbus_Slave_Example** | 设备名称 |
| 设备类型 | **default** | 设备类型 |
| 轮询周期 | **5000** | 检查属性和遥测的毫秒数周期。 |
| 将数据发送到 GridLinks | **false** | 如果设置为 TRUE，网关将进行自动配置，并且每 <pollPeriod> 毫秒向 ThingsBoard 发送值 |
| 字节顺序 | **BIG** | 要读取的字节顺序。 |
| 单元 ID | **0** | 设备的单元 ID |
|---

此外，您可以使用以下配置来配置 TLS 连接：

| **参数** | **默认值** | **说明** |
|:-|:-|:-|
| 证书文件 | **/etc/gridlinks-gateway/certificate.pem** | 证书文件的路径。 |
| 密钥文件 | **/etc/gridlinks-gateway/privateKey.pem** | 私钥文件的路径。 |
| 密码 | **YOUR_PASSWORD** | 服务器密码。 |
| 请求客户端证书 | **false** | 从客户端请求证书文件。 |
|---

配置示例：
```json
"slave": {
  "type": "tcp",
  "security": {
    "certfile": "/etc/gridlinks-gateway/certificate.pem",
    "keyfile": "/etc/gridlinks-gateway/privateKey.pem",
    "password": "YOUR_PASSWORD",
    "reqclicert": false
  },
  "host": "127.0.0.1",
  ...
```