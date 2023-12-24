```js
/** 解码器 **/

// 将有效负载解码为字符串
var payloadStr = decodeToString(payload);
var data = JSON.parse(payloadStr);
var deviceName = metadata.topic.split("/")[3];
// 将有效负载解码为 JSON
var deviceType = 'sensor';

// 包含设备属性/遥测数据的 Result 对象
var telemetry;
if (metadata.topic.endsWith('/temperature')) {
    // 按之前的方式转换传入的数据
    telemetry = getTemperatureTelemetry(data);
} else if (metadata.topic.endsWith('/rx/response')) {
    // 按原样获取输入值
    telemetry = data;
}

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    attributes: {
        integrationName: metadata['integrationName'],
    },
    telemetry: telemetry
};

/** 辅助函数 **/

function getTemperatureTelemetry(data) {
    return {temperature: data.value}
}

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
    // 将有效负载转换为字符串。
    var str = decodeToString(payload);

    // 将字符串解析为 JSON
    var data = JSON.parse(str);
    return data;
}

return result;
```
{: .copy-code}