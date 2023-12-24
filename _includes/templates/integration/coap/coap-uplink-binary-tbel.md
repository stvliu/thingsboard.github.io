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
       temperature: parseFloat(payloadStr.substring(13,17)),
       humidity: parseFloat(payloadStr.substring(17,19))
   }
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
``` 
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/coap/coap-uplink-converter-binary-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/coap/coap-uplink-converter-binary-tbel-paas.png)
{% endif %}