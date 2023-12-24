使用以下配置，您可以配置网关以通过服务器配置策略使用自动生成的访问令牌：

| **参数** | **默认值** | **说明** |
|---|---|---|
| type | **AUTO** | 配置策略的类型。 |
| provisionDeviceKey | **DEVICE_KEY** | 配置设备密钥，您应该从配置的设备配置文件中获取它。 |
| provisionDeviceSecret | **DEVICE_SECRET** | 配置设备密钥，您应该从配置的设备配置文件中获取它。 |
| --- | | |

配置文件中的配置子部分将如下所示：
```json
...
"provisioning": {
  "type": "AUTO",
  "provisionDeviceKey": "PUT_YOUR_DEVICE_KEY_HERE",
  "provisionDeviceSecret": "PUT_YOUR_DEVICE_SECRET_HERE"
},
...
```