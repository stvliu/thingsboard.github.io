![image](/images/user-guide/integrations/uplink-converter-example-java.png)

转换器中使用的 javascript 函数的完整源代码：

```shell
// 将有效负载解码为 JSON
var data = decodeToJson(payload);
var result = [];
for (var i in data){
    var report = data[i];
    var deviceName = report.serialNumber;
    var deviceType = metadata.deviceType;
    var raw = report.value;
    var decoded = hexStringToByte(raw);
    // 具有设备属性/遥测数据的 Result 对象
    result.push({
        deviceName: deviceName,
        deviceType: deviceType,
        attributes: { 
            model: metadata.model
        },
        telemetry: {
            ts: report.timestamp,
            values: {
                battery: dataConverter(decoded, 0, 2, 100),
                temperature: dataConverter(decoded, 2, 4, 100),
                rawData: JSON.stringify(report)
            }
        }
    });
}


/** 辅助函数 **/

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
// 将有效负载转换为字符串。
var str = decodeToString(payload);

    // 将字符串解析为 JSON
    var data = JSON.parse(str);
    return data;
}

function hexStringToByte(str) {
if (!str) {
return new Uint8Array();
}

    var a = [];
    for (var i = 0, len = str.length; i < len; i+=2) {
        a.push(parseInt(str.substr(i,2),16));
    }

    return new Uint8Array(a);
}

function dataConverter(decoded, byteIdxFrom, byteIdxTo, divided) {
var bytes = decoded.subarray(byteIdxFrom, byteIdxTo);

    var val = 0;
    for (var j = 0; j < bytes.length; j++) {
        val += bytes[j];
        if (j < bytes.length - 1) {
            val = val << 8;
        }
    }
    return val/divided;
}

return result;
```
{: .copy-code}