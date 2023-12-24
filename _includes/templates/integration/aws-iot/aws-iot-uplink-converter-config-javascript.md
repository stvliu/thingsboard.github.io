**上行转换器的示例：**

```ruby
// 将有效负载解码为 JSON
var payloadStr = decodeToString(payload);
var data = JSON.parse(payloadStr);
var topicPattern = 'tb/aws/iot/(.+)/(.+)';
var deviceName = metadata.topic.match(topicPattern)[2];
var deviceType = metadata.topic.match(topicPattern)[1];

// 包含设备属性/遥测数据的 Result 对象
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
        state: data.val0,
   },
   telemetry: {
       temperature: data.val1,
       fan_ins:     data.val2,
       fan_out:     data.val3,
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

![image](/images/user-guide/integrations/aws-iot/aws-iot-uplink-converter-java-pe.png)