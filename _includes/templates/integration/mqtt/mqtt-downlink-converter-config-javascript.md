现在将以下脚本复制并粘贴到编码器函数部分：

```javascript
// 对来自规则引擎消息的下行数据进行编码

// msg - JSON 消息有效负载下行消息 json
// msgType - 消息类型，例如“ATTRIBUTES_UPDATED”、“POST_TELEMETRY_REQUEST”等。
// metadata - 包含有关消息的其他数据的键值对列表
// integrationMetadata - 包含在此转换器中执行的集成中定义的其他数据的键值对列表

/** 编码器 **/

var data = {};

// 处理来自传入消息和元数据的数据

data.tempFreq = msg.temperatureUploadFrequency;
data.humFreq = msg.humidityUploadFrequency;

data.devSerialNumber = metadata['ss_serialNumber'];

// 包含编码下行有效负载的结果对象
var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(data),

    // 以键/值格式显示的可选元数据对象
    metadata: {
        topic: metadata['deviceType']+'/'+metadata['deviceName']+'/upload'
    }

};

return result;

``` 
{: .copy-code}


![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-downlink-converter-java-1-pe.png)