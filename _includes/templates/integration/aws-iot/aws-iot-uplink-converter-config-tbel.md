**上行转换器的示例：**

```ruby
// 将有效负载解码为 JSON
var data = decodeToJson(payload);
var topicParts = metadata.topic.split("/");
var deviceType = topicParts[3];
var deviceName = topicParts[4];
// 包含设备属性/遥测数据的 Result 对象
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
       state: data.val0,
   },
   telemetry: {
       temperature: data.val1,
       fan_ins: data.val2,
       fan_out: data.val3,
   }
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/aws-iot/aws-iot-uplink-converter-tbel-pe.png)