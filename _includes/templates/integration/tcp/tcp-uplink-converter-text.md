现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为字符串
var strArray = decodeToString(payload);
var payloadArray = strArray.replace(/\"/g, "").replace(/\s/g, "").split(',');

var telemetryKey = payloadArray[2];
var telemetryValue = payloadArray[3]; 

var telemetryPayload = {};
telemetryPayload[telemetryKey] = telemetryValue;

// 包含设备属性/遥测数据的 Result 对象
var result = {
    deviceName: payloadArray[0],
    deviceType: payloadArray[1],
    telemetry: telemetryPayload,
    attributes: {}
  };

/** 辅助函数 **/

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

return result;
```
{: .copy-code}


解码器函数的目的是将传入的数据和元数据解析为 ThingsBoard 可以使用的一种格式。
**deviceName** 和 **deviceType** 是必需的，而 **attributes** 和 **telemetry** 是可选的。
**attributes** 和 **telemetry** 是扁平的键值对象。不支持嵌套对象。