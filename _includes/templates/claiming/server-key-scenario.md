{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

假设您有数千个 NB IoT/LoRaWAN/Sigfox 设备，它们使用 ThingsBoard [集成](/docs/{{peDocsPrefix}}user-guide/integrations/)之一进行连接。
集成层会自动在 ThingsBoard 中预置这些设备。
假设租户管理员知道 DevEUI（LoRaWAN）或任何其他设备标识符的列表，
则可以为每个设备生成一个随机密钥，并使用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 或 UI 将此密钥作为服务器端属性上传到 ThingsBoard。
完成后，租户管理员可以将这些密钥通过电子邮件发送给客户，或将它们放在设备包装盒中。

![image](/images/user-guide/claiming-devices/server-side-key-diagram.png)

为了预置设备密钥，租户管理员应将服务器端属性“claimingData”设置为以下值：

```json
{"secretKey": "YOUR_SECRET_KEY", "expirationTime": 1640995200000}
``` 

，其中到期日期是设备可以被认领的时间的结束时间，即 01/01/2022，以具有毫秒精度的 Unix 时间戳表示。

一旦预置了服务器端属性，客户用户就可以使用 [认领设备](/docs/{{docsPrefix}}user-guide/claiming-devices/#device-claiming-widget) 小部件。