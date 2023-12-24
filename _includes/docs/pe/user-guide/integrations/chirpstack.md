{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

ChirpStack 开源 LoRaWAN 网络服务器堆栈为 LoRaWAN 网络提供开源组件。

将 ChirpStack 与 GridLinks 集成后，您可以在 GridLinks IoT 平台中连接、通信、处理和可视化设备数据。

## ChirpStack 配置

为了获取数据，您应该配置 ChirpStack 网络服务器堆栈实例。

在本指南中，我们将使用通过 docker compose 安装的 ***配置的本地实例***。
[**如何使用 docker compose 安装 ChirpStack 网络服务器堆栈**](https://www.chirpstack.io/project/guides/docker-compose/)。

此外，我们已经连接了设备，您可以在 [**官方网站的连接指南**](https://www.chirpstack.io/project/guides/connect-device/) 中找到如何连接设备。

当设备连接并且数据出现在 **设备数据** 选项卡中时，我们可以开始配置与 GridLinks 的集成。

## 创建上行转换器

在创建集成之前，您需要在 **数据转换器** 中创建一个 **上行转换器**。

上行对于将来自设备的传入数据转换为在 GridLinks 中显示它们所需的格式是必要的。

单击 **“加号”** 和 **“创建新转换器”。**

要查看事件，请启用 **调试。** 在函数解码器字段中，指定一个脚本来解析和转换数据。

**注意** 尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。

{% include images-gallery.html imageCollection="uplink" %}

让我们回顾一下来自 ChirpStack 的上行示例消息：

```
{
    "applicationID": "1",
    "applicationName": "Application",
    "deviceName": "Device_1",
    "devEUI": "e3EP8SqeZiw=",
    "rxInfo": [],
    "txInfo": {
        "frequency": 868100000,
        "modulation": "LORA",
        "loRaModulationInfo": {
            "bandwidth": 125,
            "spreadingFactor": 10,
            "codeRate": "4/5",
            "polarizationInversion": false
        }
    },
    "adr": false,
    "dr": 2,
    "fCnt": 22,
    "fPort": 2,
    "data": "GVAy",
    "objectJSON": "",
    "tags": {},
    "confirmedUplink": false,
    "devAddr": "AJTrGg==",
    "publishedAt": "2021-09-17T13:45:00.342008687Z"
}
```
如您所见，设备名称出现在 "deviceName" 字段中。我们将在 GridLinks 中将其用作设备名称。设备数据编码在 "data" 字段中。
此处的 Base64 编码数据为：
```
"data": "GVAy"
```
让我们将它们转换为标志、电池和光值。

在解码形式中，我们有以下字符串：***258050***

**25** 是 **标志** 的值。
**80** 是 **电池** 的值。
**50** 是 **光** 的值。

在转换器中，它将指示如下：

```
var flags = parseInt(incomingHexData.substring(0, 2), 16);
var battery = parseInt(incomingHexData.substring(2, 4), 16);
var light = parseInt(incomingHexData.substring(4, 6), 16);
```


#### 上行转换器的示例

```javascript
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - 键/值对象

/** 解码器 **/

// 将有效负载解码为字符串
var payloadStr = decodeToString(payload);

// 将有效负载解码为 JSON
var data = decodeToJson(payload);

var deviceName = data.deviceName;
var deviceType = data.applicationName;

var incomingHexData = base64ToHex(data.data);
var flags = parseInt(incomingHexData.substring(0, 2), 16);
var battery = parseInt(incomingHexData.substring(2, 4), 16);
var light = parseInt(incomingHexData.substring(4, 6), 16);

var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
       applicationId: data.applicationId,
       DevEUI: base64ToHex(data.devEUI),
       integrationName: metadata['integrationName'],
       txInfo: data.txInfo,
       fPort: data.fPort,
       devAddr: base64ToHex(data.devAddr),
       dr: data.dr
   },
   telemetry: {
       flags: flags,
       battery: battery,
       light: light
   }
};

/** 帮助器函数 **/

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

function base64ToHex(str) {
  var raw = atob(str);
  var res = "";
  for (var i = 0; i < raw.length; i++) {
    var hex = raw.charCodeAt(i).toString(16);
    res += (hex.length === 2 ? hex : '0' + hex);
  }
  return res.toUpperCase();
}

return result;
```
{: .copy-code}

您可以在创建转换器或创建转换器后更改解码器函数。如果转换器已经创建，则单击“铅笔”图标进行编辑。
复制转换器的配置示例（或您自己的配置）并将其插入解码器函数。单击“对勾”图标保存更改。


## 创建集成

要在 GridLinks 上创建集成，我们需要以下部分：
- **上行转换器**
- **应用服务器 URL**
- **应用服务器的应用 API 密钥**

要获取 API 密钥，我们需要打开应用服务器 UI，从左上角菜单中打开 **API 密钥** 选项卡并创建一个 API 密钥。

{% include images-gallery.html imageCollection="api-keys" %}

现在已经创建了上行转换器，并且我们拥有所有所需数据，就可以创建集成。

**注意：** 建议出于调试目的启用 **调试模式**，以便在集成上查看上行/下行事件。

{% include images-gallery.html imageCollection="integration" %}

为了将数据从 ChirpStack 传输到 GridLinks，您需要为您的 ChirpStack 应用配置一个 **集成**。

要在 ChirpStack 网络服务器堆栈上创建集成，我们需要执行以下步骤：
1. 登录到 ChirpStack 网络服务器堆栈用户界面（默认登录名/密码 - **admin**/**admin**）。
2. 我们转到左侧菜单中的 **应用** 选项卡并打开我们的应用（我们的应用名为 *应用*）。
3. 打开 **集成** 选项卡并创建一个 **HTTP** 集成。
4. 让我们转到 GridLinks 中的 **集成** 选项卡。找到您的 ChirpStack 集成并单击它。在那里您可以找到 HTTP 端点 URL。单击图标复制 URL。
5. 使用来自 ThingsBoard 集成的端点 URL 填写字段。

{% include images-gallery.html imageCollection="chirpstack_integration" %}


## 处理上行消息

当设备发送上行消息时，您将在集成上收到一个上行事件和来自设备的数据。

{% include images-gallery.html imageCollection="uplink_message" %}

可以在 **设备组 -> 全部** 部分中看到具有数据的已创建设备

{% include images-gallery.html imageCollection="device_groups" %}

可以在上行转换器中查看接收到的数据。在 **事件** 选项卡的 **“输入”** 和 **“输出”** 块中：

{% include images-gallery.html imageCollection="uplink_events" %}

使用仪表板处理数据。仪表板是收集和可视化数据集的现代格式。通过各种小部件实现数据呈现的可见性。

ThingsBoard 有几种类型的仪表板示例，您可以使用它们。您可以在 **解决方案模板** 选项卡中找到它们。

{% include images-gallery.html imageCollection="solution_templates" %}

如何使用仪表板 [在此处阅读](/docs/{{docsPrefix}}user-guide/dashboards/)



## 高级用法：创建下行转换器

在 **数据转换器** 中创建下行。要查看事件 - 启用 **调试。**

{% include images-gallery.html imageCollection="create_downlink" %}


您可以根据您的配置自定义下行。

让我们考虑一个我们发送属性更新消息的示例。
`因此，我们应该在 `//下行数据输入` 行下更改下行编码器函数中的代码

```
data: msg.downlink
```

此外，在元数据中指明所需的参数：

```
metadata: {
  "EUI": "$Device_EUI",
  "port": 1
}
```
下行转换器的示例：

```javascript
// 从传入的规则引擎消息对下行数据进行编码

// msg - JSON 消息有效负载下行消息 json
// msgType - 消息类型，例如 'ATTRIBUTES_UPDATED'、'POST_TELEMETRY_REQUEST' 等。
// metadata - 包含有关消息的其他数据的键值对列表
// integrationMetadata - 包含有关在执行此转换器的集成中定义的其他数据的键值对列表

/** 编码器 **/

// 具有编码下行有效负载的 Result 对象
var result = {

    // 下行数据内容类型：JSON、TEXT 或 BINARY（base64 格式）
    contentType: "TEXT",

    // 下行数据
    data: btoa(msg.downlink),

    // 以键/值格式显示的可选元数据对象
    metadata: {
            DevEUI: metadata.cs_DevEUI,
            fPort: metadata.cs_fPort
    }

};

return result;

```
{: .copy-code}

其中 **DevEUI** 是设备 EUI，它将从设备上行消息中获取。

**fPort** 可以是 1 到 223，它将从设备上行消息中获取。

{% include images-gallery.html imageCollection="downlink" %}

将转换器添加到集成。您可以在创建集成或编辑集成的阶段执行此操作。

为了发送下行，我们使用规则链来处理共享属性更新。

要从设备获取 **fPort** 和 **DevEUI**，我们必须导入规则链。

您可以在 [**此处**](/docs/user-guide/integrations/resources/downlink_to_chirpstack.json) 找到它。

{% include images-gallery.html imageCollection="downlink_rule_chain" %}

此外，我们必须配置根规则链：

{% include images-gallery.html imageCollection="root_rule_chain" %}

我们转到 **设备组** 部分中的 **全部** 文件夹，以示例方式查看此内容。

我们已在 **共享属性** 中指明设备的下行。

现在，我们通过单击“铅笔”图标对其进行编辑。

然后，我们对属性进行更改（将 **下行** 更改为 01040206）并保存数据。

{% include images-gallery.html imageCollection="shared_attributes" %}

可以在下行转换器中查看接收到的数据和发送的数据。在 **事件** 选项卡的 **“输入”** 块中，我们看到输入了什么数据，**“输出”** 字段显示到设备的消息：

{% include images-gallery.html imageCollection="downlink_events" %}


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}