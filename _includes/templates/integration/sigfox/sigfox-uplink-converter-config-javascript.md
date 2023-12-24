您可以使用以下代码，将其复制到解码器函数部分：

```javascript
/** Decoder **/

// 将有效负载解码为字符串
var json = decodeToJson(payload);
var deviceName = 'Sigfox-' + json.device;
var deviceType = 'Sigfox Airwits CO2';
var groupName = 'UC-0023 Sigfox Airwits CO2';

var attrByte = parseInt(json.data.substring(0, 2), 16); // 强制 javascript 转换为 INT
var autoCalibration = (attrByte & 0x1) === 1 ? "on" : "off"; // 第一位的位掩码
var zeroPointAdjusted = ((attrByte & 0x2) >> 1) === 1 ? true : false; // 第二位的位掩码；右移一位，将第二位移至 LSB 位置
var transmitPower = ((attrByte & 0x4) >> 2) === 1 ? "full" : "low"; // 第三位位掩码；右移两位，将第三位移至 LSB 位置
var powerControl = ((attrByte & 0x8) >> 3) === 1 ? "on" : "off"; // 第三位位掩码；右移三位，将第四位移至 LSB 位置
var firmwareVersion = attrByte >> 4; // 右移，将半字节移至前四位；结果为 INT

var temperature = parseInt(json.data.substring(2, 6), 16) / 10 -40;
var humidity = parseInt(json.data.substring(6, 8), 16);
var co2 = parseInt(json.data.substring(8, 12), 16);

var co2Baseline = 0;
var co2BaselineN = parseInt(json.data.substring(12, 14), 16);
if(co2BaselineN === 0){ // 有关基准的更多信息，请参阅文档
    co2Baseline = 400;
}else{
    co2Baseline = co2BaselineN * 10;
}

var result = {
// 使用 deviceName 和 deviceType 或 assetName 和 assetType，但不能同时使用。
    deviceName: deviceName,
    deviceType: deviceType,
    groupName: groupName,
    telemetry: {
        ts: json.time + "000",
        values:{
            //rssi: parseFloat(json.rssi),
            //snr: parseFloat(json.snr),
            temperature: parseFloat(temperature.toFixed(1)),
            humidity: parseFloat(humidity),
            co2: co2,
            co2Baseline: co2Baseline
        }
    },
    attributes:{
        //station: json.station,
        sigfox_id: json.device,
        autoCalibration: autoCalibration,
        zeroPointAdjusted: zeroPointAdjusted,
        transmitPower: transmitPower,
        powerControl: powerControl,
        fwVersion: firmwareVersion
    }
};


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

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/sigfox/sigfox-uplink-converter-java-pe.png)