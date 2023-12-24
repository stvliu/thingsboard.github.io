### 在 Loriot 上添加网关

我们需要在 [Loriot](https://loriot.io){: target="_blank"} 上添加一个网关。

若要添加网关，可以按照以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/loriot/main-page.png,
        title: 登录 Loriot 服务器。我们使用 **eu2.loriot.io**，但它取决于注册期间选择的区域。
    ===
        image: /images/devices-library/basic/integrations/loriot/sample-network.png,
        title: 转到 **Networks** 并打开 **Sample network** 或创建一个新的网络。
    ===
        image: /images/devices-library/basic/integrations/loriot/register-gateway.png,
        title: 向下滚动并选择 **Packet Forwarder Semtech** 选项。
    ===
        image: /images/devices-library/basic/integrations/loriot/add-gateway.png,
        title: 向上滚动并将有关网关 **MAC 地址** 的信息（只需删除 ***gateway EUI*** 中间的 **FFFF** 或 **FFFE**）放入 **eth0 MAC 地址** 和网关 EUI 到 **Custom EUI** 字段。
    ===
        image: /images/devices-library/basic/integrations/loriot/gateway-added-disconnected.png,
        title: 网关已添加。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}
{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/devices-library/blocks/integrations/devices-configuration/" | append: articleFilename | append: "-loriot-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

### 创建上行转换器

首先，复制上行转换器的代码，我们需要它进行集成：

{% capture converterCode %}
var data = decodeToJson(payload);
var deviceName = data.EUI;
var deviceType = "LoraDevices";

// If you want to parse incoming data somehow, you can add your code to this function.
// input: bytes 
// expected output: 
//  {
//    "attributes": {"attributeKey": "attributeValue"},
//    "telemetry": {"telemetryKey": "telemetryValue"}
//  }
// default functionality - convert bytes to HEX string with telemetry key "HEX_bytes"

function decodePayload(input) {
    var output = { attributes:{}, telemetry: {} };
    // --- Decoding code --- //
    
    output.telemetry.HEX_bytes = bytesToHex(input);
    
    // --- Decoding code --- //
    return output;
}

// --- attributes and telemetry objects ---
var telemetry = {};
var attributes = {};
// --- attributes and telemetry objects ---

// --- Timestamp parsing
var timestamp = data.ts;
// --- Timestamp parsing

// You can add some keys manually to attributes or telemetry
attributes.fPort = data.port;
attributes.battery = data.bat;

// You can exclude some keys from the result
var excludeFromAttributesList = ["data", "gws", "EUI", "ts", "cmd", "port", "seqno", "fcnt", "toa", "ack", "bat", "snr", "rssi"];
var excludeFromTelemetryList = ["gws", "EUI", "ts", "freq", "port", "data", "cmd", "dr", "offline"];

// Message parsing
// To avoid paths in the decoded objects we passing false value to function as "pathInKey" argument.
// Warning: pathInKey can cause already found fields to be overwritten with the last value found.

var telemetryData = toFlatMap(data, excludeFromTelemetryList, false);
var attributesData = toFlatMap(data, excludeFromAttributesList, false);

var uplinkDataList = [];

// Passing incoming bytes to decodePayload function, to get custom decoding
var customDecoding = decodePayload(hexToBytes(data.data));

// Collecting data to result
if (customDecoding.?telemetry.size() > 0) {
    telemetry.putAll(customDecoding.telemetry);
}

if (customDecoding.?attributes.size() > 0) {
    attributes.putAll(customDecoding.attributes);
}

telemetry.putAll(telemetryData);
attributes.putAll(attributesData);

var deviceInfo = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
        ts: timestamp, 
        values: telemetry
    },
    attributes: attributes
};

uplinkDataList.add(deviceInfo);

if (data.cmd == "gw") {
    foreach( gatewayInfo : data.gws ) {
        var gatewayInfoMsg = {
            deviceName: gatewayInfo.gweui,
            deviceType: "LoraGateway",
            attributes: {},
            telemetry: {
                "ts": gatewayInfo.ts,
                "values": toFlatMap(gatewayInfo, ["ts", "time", "gweui"], false)
            }
        };
        uplinkDataList.add(gatewayInfoMsg);
    }
}

return uplinkDataList;
{% endcapture %}

{% include code-toggle.liquid code=converterCode params="javascript|.copy-code.expandable-20" %}

### 创建集成

接下来，我们将在 GridLinks 中创建与 Loriot 的集成。


{% assign createLoriotIntegration = '
    ===
        image: /images/devices-library/basic/integrations/loriot/1-create-integration-name-type.png,
        title: 转到 **Integrations**，按 **加号** 按钮并选择 **Loriot** 作为类型，输入一些名称。
    ===
        image: /images/devices-library/basic/integrations/loriot/2-create-integration-uplink.png,
        title: 选中 **Create new uplink data converter** 并替换代码或创建现有代码。
    ===
        image: /images/devices-library/basic/integrations/loriot/sample-application.png,
        title: 转到左侧菜单中的 **Applications** 并选择 **SampleApp** 或创建一个新的应用程序。复制 **Application ID**。
    ===
        image: /images/devices-library/basic/integrations/loriot/4-create-integration-configuration.png,
        title: 用你的参数填写字段，
'
%}

若要添加集成，请单击“**+**”按钮并按照以下步骤操作：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createLoriotIntegration %} 

按 **Add** 按钮，集成将被添加。