现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为字符串
var payloadStr = decodeToString(payload);

// 将有效负载解码为 JSON
// var data = decodeToJson(payload);

var deviceName = payloadStr.substring(0,6);
var deviceType = payloadStr.substring(6,13);

// 包含设备/资产属性/遥测数据的 Result 对象
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {},
   telemetry: {
       temperature: parseFloat(payloadStr.substring(13,17))
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

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-uplink-converter-binary-java-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tcp/tcp-create-uplink-converter-binary-java-paas.png)
{% endif %}