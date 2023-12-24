您可以使用我们的下行链路转换器示例，或根据您的配置编写自己的示例：

```javascript
// 带有编码下行链路有效负载的结果对象
var result = {

    // 下行链路数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行链路数据
    data: JSON.stringify(msg),

    // 以键/值格式显示的可选元数据对象
    metadata: {}

};

return result;
``` 
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-create-downlink-converter-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-create-downlink-converter-tbel-paas.png)
{% endif %}