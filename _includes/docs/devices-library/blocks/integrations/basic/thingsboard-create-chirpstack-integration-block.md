### 在 Chirpstack 上添加网关

我们需要在 [Chirpstack](https://chirpstack.io){: target="_blank"} 上添加一个网关。

要添加网关，可以按照以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/main-page.png,
        title: 登录 Chirpstack 服务器。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/gateways.png,
        title: 转到 **网关**，然后单击 **添加网关**。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/add-gateway.png,
        title: 使用您的数据填写 **名称**、**网关 EUI**（它将不同，您可以在网关控制面板上找到它），向下滚动并单击 **提交** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/add-gateway.png,
        title: 向上滚动并将有关网关 **MAC 地址** 的信息（只需删除 ***网关 EUI*** 中间的 **FFFF** 或 **FFFE**）放入 **eth0 MAC 地址** 和网关 EUI 到 **自定义 EUI** 字段。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/gateway-added-offline.png,
        title: 网关已添加。在网关选项卡中，您可以看到其状态。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}
{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/devices-library/blocks/integrations/devices-configuration/" | append: articleFilename | append: "-chirpstack-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

### 在 Chirpstack 上配置应用程序

现在我们需要在 Chirpstack 上配置应用程序。为此，请按照以下步骤操作：

{% assign addIntegrationSteps = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/applications.png,
        title: 转到左侧菜单中的 **应用程序**，然后单击 **添加应用程序**。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-application.png,
        title: 填写应用程序名称，然后单击 **提交** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/api-keys.png,
        title: 转到左侧菜单中的 **API 密钥**，然后单击 **添加 API 密钥** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-api-key.png,
        title: 为 API 密钥输入一些名称，然后单击 **提交** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/api-key-created.png,
        title: 复制创建的 API 密钥并保存，我们将在 GridLinks 上集成时需要它。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addIntegrationSteps %}

现在我们可以转到 GridLinks 来配置集成。

### 创建上行转换器

首先，复制上行转换器的代码，我们将在集成时需要它：

{% capture converterCode %}
var data = decodeToJson(payload);
var deviceName = data.deviceInfo.deviceName;
var deviceType = data.deviceInfo.deviceProfileName;

// 如果您想以某种方式解析传入的数据，可以将您的代码添加到此函数中。
// 输入：字节
// 预期输出：
//  {
//    "attributes": {"attributeKey": "attributeValue"},
//    "telemetry": {"telemetryKey": "telemetryValue"}
//  }
// 默认功能 - 将字节转换为带有遥测键 "HEX_bytes" 的 HEX 字符串

function decodePayload(input) {
    var output = { attributes:{}, telemetry: {} };
    // --- 解码代码 --- //
    
    output.telemetry.HEX_bytes = bytesToHex(input);
    
    // --- 解码代码 --- //
    return output;
}

// --- 属性和遥测对象 ---
var telemetry = {};
var attributes = {};
// --- 属性和遥测对象 ---

// --- 时间戳解析
var dateString = data.time.substring(0, data.time.lastIndexOf('+')-3) + "Z";
var timestamp = new Date(dateString).getTime();
// --- 时间戳解析

// 您可以手动将一些键添加到属性或遥测
attributes.fPort = data.port;
attributes.encodedData = data.data;

// 您可以从结果中排除一些键
var excludeFromAttributesList = ["deviceName", "rxInfo", "txInfo", "deduplicationId", "time", "dr", "fCnt", "fPort"];
var excludeFromTelemetryList = ["data", "deviceInfo", "devAddr", "adr"];

// 消息解析
// 为了避免解码对象中的路径，我们将 false 值作为 "pathInKey" 参数传递给函数。
// 警告：pathInKey 可能会导致已找到的字段被最后找到的值覆盖。

var telemetryData = toFlatMap(data, excludeFromTelemetryList, false);
var attributesData = toFlatMap(data, excludeFromAttributesList, false);

var uplinkDataList = [];

// 将传入的字节传递给 decodePayload 函数，以获取自定义解码
var customDecoding = decodePayload(hexToBytes(data.data));

// 将数据收集到结果中
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

接下来，我们将在 GridLinks 中创建与 Chirpstack 的集成，并在 Chirpstack 上配置集成。

{% assign createChirpstackIntegration = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/1-create-integration.png,
        title: 转到 **集成**，按 **加号** 按钮并选择 **Chirpstack** 作为类型，输入一些名称。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/2-create-integration-uplink.png,
        title: 选中 **创建新的上行数据转换器** 并替换代码或创建现有代码。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/3-create-integration-configuration.png,
        title: 输入您的 **应用程序服务器 URL** 和 **API 密钥** 从 Chirpstack 并复制 **HTTP 端点 URL**，单击 **添加** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/application-integrations.png,
        title: 打开您的 Chirpstack，转到 **应用程序** -> 您的应用程序 -> **集成** 选项卡。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-application-integration.png,
        title: 向下滚动并在 **HTTP** 磁贴下单击 **+**。将 **HTTP URL 端点** 放入 **事件端点 URL(s)** 字段，然后单击 **提交** 按钮。
'
%}

要添加集成，请单击 '**+**' 按钮并按照以下步骤操作：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createChirpstackIntegration %}

集成已创建。