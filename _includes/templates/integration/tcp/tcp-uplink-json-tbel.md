现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为 JSON
var data = decodeToJson(payload);

// 包含设备/资产属性/遥测数据的 Result 对象

var deviceName = data.deviceName;
var deviceType = data.deviceType;
var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    attributes: {},
    telemetry: {
        temperature: data.temperature,
        humidity: data.humidity
    }
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-uplink-converter-json-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-uplink-converter-json-tbel-paas.png)
{% endif %}