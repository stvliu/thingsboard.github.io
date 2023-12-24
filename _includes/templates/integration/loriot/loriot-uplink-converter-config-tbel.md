**上行转换器的示例：**

```javascript
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - 键/值对象
/** 解码器 **/
// 将有效负载解码为 JSON
var payloadJson = decodeToJson(payload);
// 使用 EUI 作为唯一的设备名称。
var deviceName = payloadJson.EUI;
// 指定设备类型。每个设备类型或应用程序使用一个数据转换器。
var deviceType = 'temperature-sensor';
// 可选，添加客户名称和设备组，以便在 ThingsBoard 中自动创建它们并将新设备分配给它们。
// var customerName = 'customer';
// var groupName = 'thermostat devices';
// 包含设备/资产属性/遥测数据的 result 对象
var result = {
    deviceName: deviceName,
    deviceType: deviceType,
//   customerName: customerName,
//   groupName: groupName,
    attributes: {},
    telemetry: {
        ts: payloadJson.ts,
        values: {
            temperature: parseLittleEndianHexToInt(payloadJson.data.substring(0,2)),
            humidity: parseLittleEndianHexToInt(payloadJson.data.substring(2,4)),
            fcnt: payloadJson.fcnt,
            port: payloadJson.port,
            freq: payloadJson.freq,
            dr: payloadJson.dr,
            rssi: payloadJson.rssi,
            snr: payloadJson.snr,
            rawData: payloadJson.data
        }
    }
};

return result;

``` 
{: .copy-code}

{% include images-gallery.html imageCollection="uplink-tbel" %}

您可以在创建转换器时或创建转换器后更改解码器函数。如果转换器已经创建，则单击“铅笔”图标进行编辑。复制转换器的配置示例（或您自己的配置）并将其插入解码器函数中。单击“对勾”图标保存更改。

{% include images-gallery.html imageCollection="uplink-edit-tbel" %}