{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}


## 概述
TheThingsStack 是 LoRaWAN 网络，旨在使用 LoRaWAN 堆栈连接您的设备。
将 TheThingsStack 与 Thingsboard 集成后，您可以在 Thingsboard IoT 平台中连接、通信、处理和可视化设备数据。


## The Things Stack 社区设置

##### 注册应用程序
第一步是在 TheThingsStack 控制台中创建一个 **应用程序**。转到 [控制台](https://console.thethingsnetwork.org/){:target="_blank"}，打开
**应用程序** 部分，按 **添加应用程序** 按钮并填写必填字段。

- **应用程序 ID** - thingsboard-connection

处理程序注册 - 用于标识将注册应用程序的区域。在我们的示例中，它将是 *eu* 区域。

![image](/images/user-guide/integrations/ttn/ttn-add-application.png)

##### 有效负载解码器
我们的设备以二进制格式提交数据。我们有 2 个选项来解码此数据：

- **TheThingsStack 解码器** - 数据将在进入 Thingsboard 之前进行解码
- **Thingsboard 转换器** - 上行/下行转换器将用于将数据从二进制格式解码为 JSON

在本教程中，我们将使用 TTS 解码器将初始转换转换为 JSON，然后使用 Thingsboard 转换器进行正确的数据处理。
在实际场景中，由您决定在哪里解码/编码数据，因为可以在任何一方执行此操作。

解码函数：
```ruby
function Decoder(bytes, port) {
  var decoded = {temperature: bytes[0]};
  return decoded;
}
```
{: .copy-code}

![image](/images/user-guide/integrations/ttn/ttn-decoder.png)

按 **保存有效负载函数**

##### 在 TheThingsStack 中注册设备

下一步是在 TTS 中创建设备。打开 **设备** 页面并按 **注册设备**

- 设备 ID - thermostat_a
- 设备 EUI - 按 **生成** 按钮生成随机标识
- AppEUI - 您可以用零填充
- AppKey - 按 **生成** 按钮生成随机标识


![image](/images/user-guide/integrations/ttn/ttn-add-device_0.png)

![image](/images/user-guide/integrations/ttn/ttn-add-device_1.png)

按 **注册** 按钮。

##### 有效负载格式化程序（可选）

在 TTS 中添加设备后，您可以测试您的解码器和有效负载。转到您的设备 **thermostat-a**，然后选择选项卡 **payload_formatters**。我们将从设备中获取第一个字节作为温度值，然后将其转换为 JSON。

**有效负载：**
```
  0F
```
{: .copy-code}

**输出 json：**
```json
{
  "temperature": 15
}
```

![image](/images/user-guide/integrations/ttn/payload_format.png)

#### 访问密钥（API 密钥）

此外，还需要一个访问密钥来配置集成，可以在 API 密钥菜单中生成。保存它很重要。

{% include images-gallery.html imageCollection="api_key_access" %}

## 与 Thingsboard 集成
我们在 TheThingsStack 中进行了所有必需的配置（注册应用程序、添加解码器函数和注册设备）。现在我们可以开始配置 Thingsboard。

##### Thingsboard 上行数据转换器

首先，我们需要创建一个上行数据转换器，该转换器将用于接收来自 TTS 的消息。
转换器应将传入有效负载转换为所需的消息格式。消息必须
包含 **deviceName** 和 **deviceType**。这些字段用于将数据提交给正确的设备。
如果未找到设备，将创建新设备。

来自 TheThingsStack 的有效负载如下所示：
```json
{
  "end_device_ids": {
    "device_id": "thermostat-a",
    "application_ids": {
      "application_id": "thingsboard-connection"
    },
    "dev_eui": "70B3D57ED00550F2",
    "join_eui": "0000000000000000"
  },
  "correlation_ids": ["as:up:01GC9S4G55D3AJ2PG32TCAZ6H1", "rpc:/ttn.lorawan.v3.AppAs/SimulateUplink:48ff02a3-cc7d-4097-b301-1411dbae3ca2"],
  "received_at": "2022-09-06T16:11:35.461454886Z",
  "uplink_message": {
    "f_port": 1,
    "frm_payload": "Dw==",
    "decoded_payload": {
      "temperature": 15
    },
    "rx_metadata": [{
      "gateway_ids": {
        "gateway_id": "test"
      },
      "rssi": 42,
      "channel_rssi": 42,
      "snr": 4.2
    }],
    "settings": {
      "data_rate": {
        "lora": {
          "bandwidth": 125000,
          "spreading_factor": 7
        }
      }
    }
  },
  "simulated": true
}
```
{: .copy-code}

我们将采用 **device_id** 并将其映射到 **deviceName**，并将 **application_id** 映射到 **deviceType**。但您可以在您的特定案例中使用其他映射。此外，我们将采用 **temperature** 字段的值并将其用作设备遥测。

转到 **数据转换器** 并使用此函数创建新的 **上行** 转换器：

```ruby
var data = decodeToJson(payload);
var deviceName = data.end_device_ids.device_id;
var deviceType = data.end_device_ids.application_ids.application_id;

var result = {
    deviceName: deviceName,
    deviceType: deviceType,
    telemetry: {
         temperature: data.uplink_message.decoded_payload.temperature
    }
};

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
    var str = decodeToString(payload);
    var data = JSON.parse(str);
    return data;
}

return result;
```
{: .copy-code}

![image](/images/user-guide/integrations/ttn/tb-converter_0.png)

![image](/images/user-guide/integrations/ttn/tb-converter_1.png)

##### Thingsboard 下行数据转换器
要将下行消息从 Thingsboard 发送到 TTS 内的设备，我们需要定义一个下行
转换器。通常，下行转换器的输出应具有以下结构：
```json
{
  "downlinks": [{
    "f_port": 2,
    "frm_payload": "vu8=",
    "priority": "NORMAL"
  }]
}
```
{: .copy-code}

- **contentType** - 定义如何对数据进行编码 {TEXT \| JSON \| BINARY}
- **data** - 将发送到 TTS 中设备的实际数据。有关 API 的更多详细信息，请参阅此 [TTS API](https://www.thethingsnetwork.org/docs/applications/mqtt/api.html){:target="_blank"}
- **metadata** - 在此对象中，您应放置正确的 devId 值，该值将用于在 TTS 中识别目标设备

转到 **数据转换器** 并使用此函数创建新的 **下行** 转换器：

```ruby
var data = {
        downlinks: [{
            f_port: 2,
            confirmed: false,
            frm_payload: btoa(msg.version),
            priority: "NORMAL"
        }]
    };

var result = {
    contentType: "JSON",
    data: JSON.stringify(data),
    metadata: {
        devId: 'thermostat1'
    }

};
return result;
```
{: .copy-code}

此转换器将从传入消息中获取 **version** 字段，并将其作为出站消息中的有效负载字段添加。目标设备是 **thermostat-a** 设备。

![image](/images/user-guide/integrations/ttn/tb-downlink-converter.png)

##### TTS 集成

接下来，我们将在 Thingsboard 内创建与 TheThingsStack 的集成。打开 **集成** 部分并添加类型为
**TheThingsStack** 的新集成

- 名称：**TheThingsStack 集成**
- 类型：**The Things Stack 社区**
- 上行数据转换器：**TheThingsStack 上行**
- 下行数据转换器：**TheThingsStack 下行**
- 区域：**eu1**（您在 TTS 内注册应用程序的区域）
- 应用程序 ID：**thingsboard-connection**（使用 TTS 中的 **应用程序 ID**）
- 访问密钥：使用 TTS 中的 **访问密钥**
- 使用 API v3：设置 **启用**

![image](/images/user-guide/integrations/ttn/tb-integration_0.png)

添加集成时，您可以测试 ThingsBoard 和 TheThingsStack 之间的连接。为此，
在所有必需的配置完成后，单击 **检查连接** 按钮。

![image](/images/user-guide/integrations/ttn/tb-integration_1.png)

## 验证

##### 验证上行消息
让我们验证我们的集成。转到 TheThingsStack 中的设备 **thermostat-a** 页面。滚动到 **模拟上行** 部分。
我们的设备将发布温度 **0F**（15）。因此，在有效负载字段中输入 **0F**，然后按 **发送** 按钮。

![image](/images/user-guide/integrations/ttn/ttn-send-payload.png)

在 Thingsboard 中，转到 **设备组** -> **全部** -> **thermostat-a** - 在这里您可以看到

- 新设备已在 Thingsboard 中注册
- 在 **最新遥测** 部分，您将看到最后提交的温度等于 15。

![image](/images/user-guide/integrations/ttn/tb-device-telemetry.png)

##### 验证下行消息
要测试下行消息，我们将更新我们的根规则链，以便在设备属性更改时发送下行消息。
打开并编辑 **根规则链**。添加 **集成下行** 操作节点，并使用关系
**属性已更新** 将其与 **消息类型开关** 节点连接

![image](/images/user-guide/integrations/ttn/tb-add-rule-downlink.png)

![image](/images/user-guide/integrations/ttn/tb-route-to-downlink.png)

保存更改。

转到 **设备组** -> **全部** -> **thermostat_a** -> 属性部分。我们将添加名称为 **version** 的 **共享属性**，
值为 **v.0.11**

![image](/images/user-guide/integrations/ttn/tb-add-version.png)

通过执行此步骤，我们向设备 **thermostat-a** 触发了下行消息，此消息应包含版本字段值。
打开 TTS 控制台，导航到 **tb_platform** 应用程序，到 **数据** 部分。我们看到收到了下行消息。

![image](/images/user-guide/integrations/ttn/ttn-downlink-verified.png)

## 另请参阅
通过此集成，您还可以配置下行转换器并使用规则引擎节点触发所需的操作。

- [集成概述](/docs/{{peDocsPrefix}}user-guide/integrations/)
- [上行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#uplink-data-converter)
- [下行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#downlink-data-converter)
- [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}