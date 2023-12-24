一种安全配置类型是使用 clientId、用户名和密码，要获取它们，您应该登录到您的 ThingsBoard 平台实例，转到 DEVICE 选项卡，按加号图标，填写值并选中“Is gateway”选项，按“Next: Credentials”，选中“Add credentials”，选择凭据类型“MQTT Basic”并用您的值替换默认值。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| clientId                | **clientId**      | ThingsBoard 服务器的网关表单的 MQTT 客户端 ID     |
| username                | **admin**         | ThingsBoard 服务器的网关表单的 MQTT 用户名      |
| password                | **admin**         | ThingsBoard 服务器的网关表单的 MQTT 密码      |
|---


```json
...
"security": {
  "clientId": "YOUR_CLIENT_ID",
  "username": "YOUR_USERNAME",
  "password": "YOUR_PASSWORD"
},
...
```