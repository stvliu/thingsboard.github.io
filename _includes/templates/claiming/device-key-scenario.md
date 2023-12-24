此过程要求设备根据某些触发事件生成密钥。
例如，设备启动后或按下某个物理按钮时。
生成密钥后，它在一定时间内有效。
设备将包含密钥和密钥有效期持续时间的声明信息发送到服务器。

{% capture cache-living-time %}
默认情况下，您可以将到期日期设置为请求接收日期和时间加 1 天作为最大值。
要增加更多时间，您应该增加 thingsboard.yaml 文件中参数 **caffeine.specs.claimDevices.timeToLiveInMinutes** 的值。{% endcapture %}
{% include templates/info-banner.md content=cache-living-time %}

GridLinks 服务器在密钥有效期内存储声明信息。请参阅下图。

![image](/images/user-guide/claiming-devices/device-side-key-diagram.png)

设备可以使用所有支持的传输协议将声明信息发送到 TB。消息正文有两个参数：**secretKey** 和 **durationMs**，可以根据需要指定。
**secretKey** 参数为声明过程增加了安全性。
**durationMs** 参数确定声明时间的到期时间。
如果未指定 **secretKey**，则使用空字符串作为默认值。
如果未指定 **durationMs**，则使用系统参数 **device.claim.duration**（在文件 **/etc/thingsboard/conf/thingsboard.yml** 中）。

{% unless docsPrefix == "paas/" %}
为了启用声明设备功能，系统参数 **security.claim.allowClaimingByDefault**（请参阅 [配置指南](/docs/user-guide/install/{{docsPrefix}}config/))
应设置为 **true**，否则已配置设备必须具有值为 **true** 的服务器端 **claimingAllowed** 属性。
{% endunless %}

请参阅设备 API 参考以获取有关消息结构以及要向其发送声明消息的主题/URL 的信息。
您还可以使用 MQTT 网关 API，该 API 还允许一次启动多个设备的声明。

- [MQTT 设备 API](/docs/{{docsPrefix}}reference/mqtt-api/#claiming-devices)
- [CoAP 设备 API](/docs/{{docsPrefix}}reference/coap-api/#claiming-devices)
- [HTTP 设备 API](/docs/{{docsPrefix}}reference/http-api/#claiming-devices)
- [MQTT 网关 API](/docs/{{docsPrefix}}reference/gateway-mqtt-api/#claiming-devices-api)


发送声明信息后，设备可以以纯文本或使用 QR 码显示密钥。用户应扫描此密钥并使用它来发送声明请求。
声明请求由设备名称和密钥组成。您可以使用 MAC 地址或其他唯一属性作为设备名称。
请参阅 [此处](/docs/{{docsPrefix}}user-guide/claiming-devices/#device-claiming-api-request) 的说明，了解如何发送声明请求。

**注意：**密钥也可以是空字符串。如果您的设备没有任何方式显示密钥，这将很有用。
例如，您可以在设备上按下声明按钮后 30 秒内允许声明设备。在这种情况下，用户只需要知道设备名称（MAC 地址等）。

服务器验证声明请求并回复声明响应。声明响应包含声明操作的状态和操作成功时的设备 ID。

配置声明信息后，客户用户可以使用 [声明设备](/docs/{{docsPrefix}}user-guide/claiming-devices/#device-claiming-widget) 小部件。