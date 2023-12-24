### 在 The Things Industries 上添加网关

我们需要在 The Things Industries 云上添加一个网关。

要添加网关，您可以按照以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/1-login-page.png,
        title: 登录云并打开控制台。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/2-cloud-console.png,
        title: 选择 **网关**。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/3-gateway-list.png,
        title: 按 **添加网关** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/4-register-gateway.png,
        title: 输入有关网关的信息（网关 EUI）。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/5-gateway-info.png,
        title: 网关已添加，复制并保存 **网关服务器地址**，我们稍后会用到它。 
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}
{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/devices-library/blocks/integrations/devices-configuration/" | append: articleFilename | append: "-thethingsindustries-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

### 在 The Things Industries 云上配置应用程序

现在我们需要在 The Things Industries 上配置集成。为此，请按照以下步骤操作：

{% assign addIntegrationSteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/application-integration-mqtt.png,
        title: 在菜单中打开 **集成** -> **MQTT**。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/integration-mqtt-new-key.png,
        title: 单击 **生成新的 API 密钥** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/integration-mqtt.png,
        title: 按复制图标复制密钥并保存它（离开页面后将不会显示）。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addIntegrationSteps %}


### 创建上行转换器

首先，我们将创建一个上行转换器来处理传入的数据：

{% capture converterCode %}
var data = decodeToJson(payload);

var deviceName = data.end_device_ids.device_id;
var deviceType = data.end_device_ids.application_ids.application_id;

// 如果您想以某种方式解析传入数据，可以将您的代码添加到此函数中。
// 输入：字节
// 预期输出：
//  {
//    "attributes": {"attributeKey": "attributeValue"},
//    "telemetry": {"telemetryKey": "telemetryValue"}
//  }
// 默认功能 - 将字节转换为具有遥测键“HEX_bytes”的 HEX 字符串

function decodeFrmPayload(input) {
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
var incomingDateString = data.uplink_message.received_at;
var dateString = incomingDateString.substring(0, incomingDateString.lastIndexOf(".")+3) + "Z";
var timestamp = new Date(dateString).getTime();
// --- 时间戳解析

// 您可以手动将一些键添加到属性或遥测
attributes.f_port = data.uplink_message.f_port;
attributes.settings = data.uplink_message.settings;
// 我们希望将相关性 ID 保存为单个对象，因此我们将其从属性解析中排除并手动添加
attributes.correlation_ids = data.correlation_ids;

// 您可以从结果中排除一些键
var excludeFromAttributesList = ["device_id", "application_id", "uplink_message", "correlation_ids"];
var excludeFromTelemetryList = ["uplink_token", "gateway_id", "settings"];

// 消息解析
// 为了避免解码对象中的路径，我们将 false 值传递给函数作为“pathInKey”参数。
// 警告：pathInKey 可能会导致已找到的字段被最后找到的值覆盖，例如，uplink_message 中的 receive_at 将被写入根中的 receive_at。
var telemetryData = toFlatMap(data.uplink_message, excludeFromTelemetryList, false);
var attributesData = toFlatMap(data, excludeFromAttributesList, false);

// 将传入字节传递给 decodeFrmPayload 函数，以获取自定义解码
var customDecoding = {};
if (data.uplink_message.get("frm_payload") != null) {
  customDecoding = decodeFrmPayload(base64ToBytes(data.uplink_message.frm_payload));
}

// 收集数据以获得结果
if (customDecoding.?telemetry.size() > 0) {
    telemetry.putAll(customDecoding.telemetry);
}

if (customDecoding.?attributes.size() > 0) {
    attributes.putAll(customDecoding.attributes);
}

telemetry.putAll(telemetryData);
attributes.putAll(attributesData);

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
        ts: timestamp,
        values: telemetry
    },
    attributes: attributes
};

return result;
{% endcapture %}

{% include code-toggle.liquid code=converterCode params="javascript|.copy-code.expandable-20" %}

### 创建集成

接下来，我们将在 GridLinks 中创建与 The Things Industries 的集成。

{% assign createTTIIntegration = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/1-create-tti-integration.png,
        title: 转到 **集成**，按 **加号** 按钮并选择 **The Things Industries 集成** 作为类型，输入一些名称。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/2-create-tti-integration-uplink.png,
        title: 选中 **创建新的上行数据转换器** 并替换代码或创建现有代码。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/3-create-tti-integration-configuration.png,
        title: 用您的参数填写字段， 
'
%}

打开 **集成** 部分并添加具有以下参数的新集成：

- **区域**：*eu1*（在 The Things Industries 控制台中注册应用程序的区域）
- **用户名**：*thingsboard-data-integration@thingsboard*（使用 The Things Stack Industries 上集成的 ***用户名***）
- **密码**：使用 The Things Industries 上集成的 ***密码***

要添加集成，请单击“**+**”按钮并按照以下步骤操作：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createTTIIntegration %} 

按 **添加** 按钮，集成将被添加。