您可以使用我们的下行链路转换器示例，或根据您的配置编写自己的转换器：

```javascript
// 对来自规则引擎消息的下行链路数据进行编码
// msg - JSON 消息有效负载下行链路消息 json
// msgType - 消息类型，例如“ATTRIBUTES_UPDATED”、“POST_TELEMETRY_REQUEST”等。
// metadata - 包含有关消息的其他数据的键值对列表
// integrationMetadata - 包含由执行此转换器的集成中定义的其他数据的键值对列表
// 具有编码下行链路有效负载的结果对象
var result = {
    // 下行链路数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "TEXT",
    // 下行链路数据
    data:  msg.test,
    // 以键/值格式显示的可选元数据对象
    metadata: {
        "device": "2203961"
    }
};
return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/sigfox/sigfox-create-downlink-converter-java-1-pe.png)