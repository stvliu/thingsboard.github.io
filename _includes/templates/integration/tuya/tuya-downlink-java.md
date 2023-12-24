您可以使用我们的下行转换器示例，或根据您的配置编写自己的示例：

```javascript
/** Encoder **/

var command = {};
command["code"] = msg.method;
if (msg.params == "false" || msg.params == "true") {
    command["value"] = Boolean.valueOf(msg.params);
} else {
    command["value"] = msg.params;
}

var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "JSON",

    // 下行数据
    data: JSON.stringify(command),

    // 以键/值格式显示的可选元数据对象
    metadata: {
            deviceId: metadata.deviceName
    }

};

return result;
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-downlink-converter-java-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-downlink-converter-java-pe.png)
{% endif %}