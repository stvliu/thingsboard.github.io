您可以使用以下代码，将其复制到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为字符串
var data = decodeToJson(payload);
var deviceName = data.devName;
var deviceType = 'thermostat';

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
        temperature: data.msg.temp,
        humidity: data.msg.humidity
    }
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/
return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-uplink-converter-tbel-1-pe.png)