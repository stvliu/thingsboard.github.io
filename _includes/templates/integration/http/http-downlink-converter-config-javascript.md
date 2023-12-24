{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-downlink-java-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/downlink-java-1-pe.png)
{% endif %}

<br>
将转换器添加到集成。您可以根据配置自定义下行链路。
我们考虑一个发送属性更新消息的示例。因此，我们应该在 **//downlink data** 输入下更改下行链路编码器函数中的代码：

```ruby
data: JSON.stringify(msg)
```
{: .copy-code}
其中 **msg** 是我们接收并发送回设备的消息。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-downlink-java-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/downlink-java-2-pe.png)
{% endif %}

<br>
下行链路转换器的示例：

```ruby
// Encode downlink data from incoming Rule Engine message

// msg - JSON message payload downlink message json
// msgType - type of message, for ex. 'ATTRIBUTES_UPDATED', 'POST_TELEMETRY_REQUEST', etc.
// metadata - list of key-value pairs with additional data about the message
// integrationMetadata - list of key-value pairs with additional data defined in Integration executing this converter

var result = {

    // downlink data content type: JSON, TEXT or BINARY (base64 format)
    contentType: "JSON",

    // downlink data
    data: JSON.stringify(msg),

    // Optional metadata object presented in key/value format
    metadata: {
    }
};

return result;
```
{: .copy-code}