现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为字符串
var strArray = decodeToString(payload);
var payloadArray = strArray.replaceAll("\"", "").replaceAll("\\\\n", "").split(',');

var telemetryPayload = {};
for (var i = 2; i < payloadArray.length; i = i + 2) {
    var telemetryKey = payloadArray[i];
    var telemetryValue = parseFloat(payloadArray[i + 1]);
    telemetryPayload[telemetryKey] = telemetryValue;
}

// 包含设备属性/遥测数据的 result 对象
var result = {
    deviceName: payloadArray[0],
    deviceType: payloadArray[1],
    telemetry: telemetryPayload,
    attributes: {}
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-uplink-converter-text-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-uplink-converter-text-tbel-paas.png)
{% endif %}