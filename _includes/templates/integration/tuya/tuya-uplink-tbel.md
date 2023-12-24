现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - 键/值对象

/** 解码器 **/

// 将有效负载解码为 JSON
var data = decodeToJson(payload);

var deviceName = data.devId;
var deviceType = 'Tuya 设备';

var telemetry = [];
if (data.status != null) {
    for (var i = 0; i < data.status.length; i++) {
        var res = {};
        var code = data.status[i].code;
        var value = data.status[i].value;
        if (code == "cur_voltage" || code == "cur_power") {
            value = data.status[i].value / 10;
        } else if (code == "cur_current") {
            value = data.status[i].value / 100;
        }
        res[code] = value;
        telemetry.push(res);
    }
    
} else {
    telemetry = data;
}

var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {},
   telemetry: telemetry
};

/** 辅助函数 'decodeToString' 和 'decodeToJson' 已内置 **/

return result;
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-uplink-converter-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-uplink-converter-tbel-pe.png)
{% endif %}