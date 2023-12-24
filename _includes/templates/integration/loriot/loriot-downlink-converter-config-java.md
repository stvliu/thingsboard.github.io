您可以根据配置自定义下行链路。我们考虑一个发送属性更新消息的示例。因此，我们应该在 `//downlink data input` 下的 downlink 编码器函数中更改代码

```
data: msg.firmware
```

此外，在元数据中指示所需的参数：

```
metadata: {
  "EUI": "$Device_EUI",
  "port": 1
}
```
下行链路转换器的示例：

```javascript
// Encode downlink data from incoming Rule Engine message
// msg - JSON message payload downlink message json
// msgType - type of message, for ex. 'ATTRIBUTES_UPDATED', 'POST_TELEMETRY_REQUEST', etc.
// metadata - list of key-value pairs with additional data about the message
// integrationMetadata - list of key-value pairs with additional data defined in Integration executing this converter
// Result object with encoded downlink payload
var result = {
    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "TEXT",
    // downlink data
    data: msg.firmware,
    // Optional metadata object presented in key/value format
    metadata: {
            "EUI": "BE7A000000000552",
            "port": 1
    }
};
return result;

``` 
{: .copy-code}

{% include images-gallery.html imageCollection="create_downlink-java" %}

其中 **EUI** 是设备 EUI，取自 LORIOT 中的设备。**端口**可以是 1 到 223