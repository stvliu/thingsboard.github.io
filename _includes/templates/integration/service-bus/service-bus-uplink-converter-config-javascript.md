您可以使用以下代码，将其复制到解码器函数部分：

```javascript
/** Decoder **/

// decode payload to string
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

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
    var str = decodeToString(payload);
    var data = JSON.parse(str);
    return data;
}

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-uplink-converter-java-1-pe.png)