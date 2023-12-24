{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}


## 概述
TheThingsIndustries 是 LoRaWAN 网络，旨在使用 LoRaWAN 堆栈连接您的设备。
将 TheThingsIndustries 与 GridLinks 集成后，您可以在 GridLinks IoT 平台中连接、通信、处理和可视化设备数据。


## The Things Stack

##### 注册应用程序
第一步是在 TheThingsIndustries 控制台中创建一个 **应用程序**。通过打开控制台，打开 **应用程序** 部分，按 **添加应用程序** 按钮并填写所需字段。

- **应用程序 ID** - thingsboard-integration

![image](/images/user-guide/integrations/tti/tti-create-app.png)


##### 有效负载解码器
我们的设备以二进制格式提交数据。我们有 2 个选项来解码此数据：

- **TheThingsIndustries 解码器** - 数据将在进入 ThingsBoard 之前解码
- **ThingsBoard 转换器** - 上行/下行转换器将用于将数据从二进制格式解码为 JSON

在本教程中，我们将使用 TTI 解码器将初始转换转换为 JSON，然后使用 GridLinks 转换器进行正确的数据处理。
在实际场景中，由您决定在哪里解码/编码数据，因为可以在任何一方执行此操作。

在 TTI 中注册应用程序后，转到 **有效负载格式程序**，**上行** 选择解码器功能。我们将取第一个字节作为设备的温度值，并将其转换为 JSON。

解码函数 {% highlight javascript %}
function Decoder(bytes, port) {
  var decoded = {temperature: bytes[0]};
  return decoded;
}
{% endhighlight %}
 
输出 json：
{% highlight json %}
{
  "temperature": 2
}
{% endhighlight %}

![image](/images/user-guide/integrations/tti/tti-create-decoder.png)

按 **保存有效负载函数**

##### 在 TheThingsIndustries 中注册设备

下一步是在 TTI 中创建设备。打开 **终端设备** 页面并按 **添加终端设备**

- 设备 ID - thermostat1。
- DevEUI - 唯一的设备标识符。

- 按 **网络层设置** 按钮。

![image](/images/user-guide/integrations/tti/tti-create-device-1.png)

- 为您的设备选择配置。

![image](/images/user-guide/integrations/tti/tti-create-device-2.png)

- 按 **应用程序层设置** 按钮。

通过生成按钮填写 **AppSKey**。

按 **添加终端设备** 按钮。

## 与 GridLinks 集成

我们需要在 The Things Industries 上创建集成，为此，打开 **集成** - **MQTT** 并按 **生成新的 API 密钥**。
复制用户名和密码，我们稍后会用到。

![image](/images/user-guide/integrations/tti/tti-integration.png)

现在我们可以开始配置 GridLinks。

##### ThingsBoard 上行数据转换器

首先，我们需要创建上行数据转换器，该转换器将用于接收来自 TTI 的消息。转换器应将传入有效负载转换为所需的消息格式。
消息必须包含 **deviceName** 和 **deviceType**。这些字段用于将数据提交给正确的设备。如果未找到设备，则将创建新设备。
以下是 TheThingsIndustries 的有效负载的示例：
{% highlight json %}
{
  "end_device_ids": {
    "device_id": "thermostat1",
    "application_ids": {
      "application_id": "thingsboard-integration"
    },
    "dev_eui": "ABABABABABABABAA",
    "join_eui": "0000000000000000",
    "dev_addr": "270000BC"
  },
  "correlation_ids": [
    "as:up:01EFEBYDTA1X51TDGPKC1EYK6N",
    "gs:conn:01ED482WRPY2BABY4TYZV57RJG",
    "gs:uplink:01ED9B93M49J8P3FQXCGGCYTGX",
    "ns:uplink:01ED9B93MH00CTY41A6KF674E4",
    "rpc:/ttn.lorawan.v3.AppAs/SimulateUplink:01EFEBYDS9BGD5A9VVZ6GSNBAV",
    "rpc:/ttn.lorawan.v3.GsNs/HandleUplink:01ED9B93MH293RE2TR3F1WMHEG"
  ],
  "received_at": "2020-08-11T08:59:45.869225403Z",
  "uplink_message": {
    "session_key_id": "BXGsg614fdmYH7efd+fRvA==",
    "f_port": 2,
    "f_cnt": 23787,
    "frm_payload": "AhJF8HTI3khf",
    "decoded_payload": {
      "temperature": 2
    },
    "settings": {
      "data_rate": {}
    },
    "received_at": "2020-08-11T10:08:31.505981496Z"
  }
}
{% endhighlight %}

我们将采用 **device_id** 并将其映射到 **deviceName**，并将 **application_id** 映射到 **deviceType**。但您可以在特定案例中使用其他映射。
此外，我们将采用 **temperature** 字段的值并将其用作设备遥测。

转到 **数据转换器** 并使用此函数创建新的 **上行** 转换器： {% highlight javascript %}
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
{% endhighlight %}

![image](/images/user-guide/integrations/tti/tb-uplink.png)


##### ThingsBoard 下行数据转换器
要从 GridLinks 向 TTI 内部的设备发送下行消息，我们需要定义下行转换器。
通常，下行转换器的输出应具有以下结构：
{% highlight json %}
{
  "downlinks": [{
    "f_port": 2,
    "frm_payload": "vu8=",
    "priority": "NORMAL"
  }]
}

{% endhighlight %}

- **contentType** - 定义如何对数据进行编码 {TEXT \| JSON \| BINARY}
- **data** - 将发送到 TTI 中设备的实际数据。有关 API 的更多详细信息，请参阅此 [TTI API](https://enterprise.thethingsstack.io/integrations/mqtt/){:target="_blank"}
- **metadata** - 在此对象中，您应放置正确的 **devId**（设备 ID）值，该值将用于在 TTI 中识别目标设备

转到 **数据转换器** 并使用此函数创建新的 **下行** 转换器： {% highlight javascript %}
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
{% endhighlight %}

此转换器将从传入消息中获取 **version** 字段，并将其添加为出站消息中的有效负载字段。目标设备是 **thermostat1** 设备。

![image](/images/user-guide/integrations/tti/tb-downlink.png)

##### TTI 集成

接下来，我们将在 GridLinks 内创建与 TheThingsIndustries 的集成。打开 **集成** 部分并添加类型为 **TheThingsIndustries** 的新集成

- **名称**：*TTI 集成*
- **类型**：*TheThingsIndustries*
- **上行** 数据转换器：*TTI 上行*
- **下行** 数据转换器：*TTI 下行*
- **区域**：*eu1*（您在 TTI 内注册应用程序的区域）
- **用户名**：*thingsboard-integration@thingsboard*（使用 TTI 集成的 ***用户名***）
- **密码**：使用 TTI 集成的 ***密码***

![image](/images/user-guide/integrations/tti/tb-integration-1.png)  

![image](/images/user-guide/integrations/tti/tb-integration-2.png)  

## 验证

##### 验证上行消息
让我们验证我们的集成。

当设备发送数据时，我们可以在 GridLinks 中检查它，为此：

转到 **设备组** -> **全部** -> **thermostat1** - 您可以看到

- 新设备已在 Thingsboard 中注册，名称为“thermostat1”
- 在 **最新遥测** 部分，您将看到最后提交的温度 = 2。

![image](/images/user-guide/integrations/tti/tb-device-telemetry.png)

##### 验证下行消息
为了测试下行消息，我们将更新我们的根规则链，以便在设备属性更改时发送下行消息。
打开并编辑 **根规则链**。添加 **集成下行** 操作节点，并使用关系 **属性已更新** 将其与 **消息类型开关** 节点连接

![image](/images/user-guide/integrations/tti/tb-add-rule-downlink.png)

![image](/images/user-guide/integrations/tti/tb-route-to-downlink.png)

保存更改。

转到 **设备组** -> **全部** -> **thermostat1** -> 属性部分。我们将添加名称为 **version** 的 **共享属性**，值 **v.0.11**

![image](/images/user-guide/integrations/tti/tb-add-version.png)

通过执行此步骤，我们触发了向设备 **thermostat1** 发送的下行消息，此消息应包含版本字段值。打开 TTI 控制台，导航到 **thingsboard-integration** 应用程序，到 **数据** 部分。
我们看到收到了下行消息（它显示为字节 **76 2E 30 2E 31 31**）。

![image](/images/user-guide/integrations/tti/ttn-downlink-verified.png)

## 另请参阅
通过此集成，您还可以配置下行转换器并使用规则引擎节点触发所需的操作。

- [集成概述](/docs/{{peDocsPrefix}}user-guide/integrations/)
- [上行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#uplink-data-converter)
- [下行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#downlink-data-converter)
- [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)


## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}