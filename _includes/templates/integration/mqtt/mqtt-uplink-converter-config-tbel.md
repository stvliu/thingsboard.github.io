现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为字符串
var payloadStr = decodeToString(payload);
var data = JSON.parse(payloadStr);

var deviceName =  metadata.topic.split("/")[3];
// 将有效负载解码为 JSON
var deviceType = 'sensor';

// 包含设备属性/遥测数据的 Result 对象
var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    attributes: {
        integrationName: metadata['integrationName'],
    },
    telemetry: {
        temperature: data.value,
    }
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
``` 
{: .copy-code}

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-uplink-converter-tbel-1-pe.png)