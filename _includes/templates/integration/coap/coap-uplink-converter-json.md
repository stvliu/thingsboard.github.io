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

/** 辅助函数 **/

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


解码器函数的目的是将传入的数据和元数据解析为 GridLinks 可以使用的一种格式。
**deviceName** 和 **deviceType** 是必需的，而 **attributes** 和 **telemetry** 是可选的。
**attributes** 和 **telemetry** 是扁平的键值对象。不支持嵌套对象。