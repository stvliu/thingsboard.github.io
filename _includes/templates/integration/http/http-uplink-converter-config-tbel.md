{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-create-data-converters-1-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/http/data-converters-2-tbel-pe.png)
{% endif %}

**上行转换器的示例：**

```ruby
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - 键/值对象

/** 解码器 **/

// 将有效负载解码为字符串
// var payloadStr = decodeToString(payload);

// 将有效负载解码为 JSON
var data = decodeToJson(payload);

var deviceName = data.deviceName;
var deviceType = data.deviceType;

// 具有设备属性/遥测数据的 Result 对象
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
       model: data.model,
       serialNumber: data.param2,
   },
   telemetry: {
       temperature: data.temperature
   }
};

/** 帮助器函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
```
{: .copy-code}

您可以在创建转换器或创建转换器后更改解码器函数。如果转换器已创建，请单击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数。单击“对勾”图标保存更改。

{% include images-gallery.html imageCollection="converter-tbel" %}