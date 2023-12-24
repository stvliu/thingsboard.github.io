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

// 十六进制字符串到字符串
function hexToString(hex) {
    return bytesToString(hexToBytes(hex));
}

return result;
``` 
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/udp/udp-uplink-converter-hex-tbel-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/udp/udp-uplink-converter-hex-tbel-paas.png)
{% endif %}