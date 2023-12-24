您可以使用我们的下行链路转换器示例，或根据您的配置编写自己的转换器：

```javascript
// 对来自规则引擎消息的下行链路数据进行编码
// msg - JSON 消息有效负载下行链路消息 json
// msgType - 消息类型，例如“ATTRIBUTES_UPDATED”、“POST_TELEMETRY_REQUEST”等。
// 包含编码下行链路有效负载的结果对象
var result = {
    contentType: "JSON",
    data: JSON.stringify(msg),
    metadata: {
        deviceId: 'Sensor A1'
    }
};

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/azure-service-bus/azure-service-bus-integration-create-downlink-converter-tbel-1-pe.png)