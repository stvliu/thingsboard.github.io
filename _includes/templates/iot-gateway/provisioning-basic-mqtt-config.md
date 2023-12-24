使用以下配置，您可以配置网关以使用 MQTT 基本预配策略：

| **参数** | **默认值** | **说明** |
|---|---|---|
| type | **MQTT_BASIC** | 预配策略的类型。 |
| provisionDeviceKey | **DEVICE_KEY** | 预配设备密钥，您应该从配置的设备配置文件中获取它。 |
| provisionDeviceSecret | **DEVICE_SECRET** | 预配设备密钥，您应该从配置的设备配置文件中获取它。 |
| --- | | |

配置文件中的预配子部分将如下所示：
```json
...
"provisioning": {
  "type": "MQTT_BASIC",
  "provisionDeviceKey": "PUT_YOUR_DEVICE_KEY_HERE",
  "provisionDeviceSecret": "PUT_YOUR_DEVICE_SECRET_HERE"
},
...
```