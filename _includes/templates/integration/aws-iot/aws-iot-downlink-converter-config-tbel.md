{% include images-gallery.html imageCollection="downlink_0-1" %}

下行转换器的示例：

```ruby
// 对来自规则引擎消息的下行数据进行编码

// msg - JSON 消息有效负载下行消息 json
// msgType - 消息类型，例如“ATTRIBUTES_UPDATED”、“POST_TELEMETRY_REQUEST”等。
// metadata - 包含有关消息的其他数据的键值对列表
// integrationMetadata - 包含由执行此转换器的集成定义的其他数据的键值对列表

/** 编码器 **/
var data = {};

// 处理来自传入消息和元数据的数据
data.v0 = msg.state;
data.m0 = "att_upd_success";
data.devSerialNumber = metadata['ss_serialNumber'];

// 包含编码下行有效负载的结果对象
var result = {
    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",
    // 下行数据
    data: JSON.stringify(data),
    // 以键/值格式显示的可选元数据对象
    metadata: {
            type: "sensors/device/upload"
    }
};
return result;
```
{: .copy-code}