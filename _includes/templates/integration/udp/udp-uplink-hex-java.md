现在将以下脚本复制并粘贴到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为 JSON
var data = decodeToJson(payload).reports[0].value;

// 包含设备遥测数据的 Result 对象
var result = {
    deviceName: hexToString(data.substring(0, 12)),
    deviceType: hexToString(data.substring(12, 26)),
    telemetry: {
        temperature: parseFloat(hexToString(data.substring(26, 34))),
        humidity: parseFloat(hexToString(data.substring(34, 38))),
    }
};

/** 辅助函数 **/

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

// 十六进制字符串到字符串
function hexToString(hex) {
    var str = '';
    for (var i = 0; i < hex.length; i += 2) {
        var notNullValue = parseInt(hex.substr(i, 2), 16);
        if (notNullValue) {
            str += String.fromCharCode(notNullValue);
        }
    }
    return str;
}

function decodeToJson(payload) {
    // 将有效负载转换为字符串。
    var str = decodeToString(payload);

    // 将字符串解析为 JSON
    var data = JSON.parse(str);
    return data;
}

return result;
``` 
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-uplink-converter-hex-java-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-uplink-converter-hex-java-paas.png)
{% endif %}