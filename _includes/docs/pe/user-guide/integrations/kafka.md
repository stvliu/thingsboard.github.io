{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## Kafka 集成

[Apache Kafka](https://kafka.apache.org/) — 是 Apache 基金会下的开源分布式软件消息代理。它使用 Java 和 Scala 编程语言编写。

设计为分布式、水平可扩展系统，可随着源的数量和负载以及订阅者系统数量的增加而实现容量增长。订阅者可以组合成组。支持暂时存储数据以供后续批处理的能力。

在某些情况下，可以在设备与实例之间没有稳定连接的情况下，将 Kafka 用作消息队列的替代。

![image](/images/user-guide/integrations/kafka/Kafka_main.png)

## 所需环境
在开始设置集成之前，您应该已经准备好了 Broker Kafka 服务器。这可以是本地安装或云解决方案。如果您尚未安装 Kafka Broker，可以在 [我们的网站](https://docs.codingas.com/docs/user-guide/install/pe/ubuntu/?ubuntuThingsboardQueue=kafka#step-5-choose-thingsboard-queue-service) 上找到在本地基本安装 Kafka Broker 的示例。如果您需要使用云解决方案，那么您可以考虑 [Kafka Confluent](https://www.confluent.io/)，本指南中的示例将基于此构建。

## 创建上行转换器

在创建集成之前，您需要在数据转换器中创建一个上行转换器。上行对于将来自设备的传入数据转换为在 GridLinks 中显示它们所需的格式是必要的。单击 **“加号”** 和 **“创建新转换器”**。要查看事件，请启用调试。在函数解码器字段中，指定一个脚本来解析和转换数据。

{% capture kafka_please_note %}
**注意：**虽然调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会显著增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。在调试完成后，强烈建议关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=kafka_please_note %}

让我们回顾一下来自 Kafka 的示例上行消息：
```json
{
  "EUI"  : "43T1YH-REE",
  "ts"   : 1638876127000,
  "data"  : "3d1f0059",
  "port" : 10,
  "freq" : 24300,
  "rssi" : -130,
  "serial"  : "230165HRT"
}
```
**EUI** 负责设备的名称。**“data”** 是通过两个字符进行遥测连接，其中第一个值 **“3d”** - 温度，**“1f”** - 湿度，**“00”** - 风扇速度，**“59”** - 压力。

您可以使用以下代码，将其复制到解码器函数部分：

```js
// 解码来自缓冲区的上行消息
// payload - 字节数组
// metadata - 键/值对象
/** 解码器 **/
// 将有效负载解码为 JSON
var payloadJson = decodeToJson(payload);
// 使用 EUI 作为唯一的设备名称。
var deviceName = payloadJson.EUI;
// 指定设备类型。每个设备类型或应用程序使用一个数据转换器。
var deviceType = 'Monitoring-sensor';
// 可选，添加客户名称和设备组以在 GridLinks 中自动创建它们并将新设备分配给它们。
// var customerName = 'customer';
// var groupName = 'thermostat devices';
// 结果对象，包含设备/资产属性/遥测数据
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
//   customerName: customerName,
//   groupName: groupName,
   attributes: {},
   telemetry: {
        ts: payloadJson.ts,
        values: {
            Temperature:hexToInt(payloadJson.data.substring(0,2)),
            Humidity:   hexToInt(payloadJson.data.substring(2,4)),
            Fan:        hexToInt(payloadJson.data.substring(4,6)),
            Port:       payloadJson.port,
            Freq:       payloadJson.freq,
            Pressure:   hexToInt(payloadJson.data.substring(6,8)),
            rssi:       payloadJson.rssi,
            serial:     payloadJson.serial
       }
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

function hexToInt(value) {
    return parseInt('0x' + value.match(/../g).reverse().join(''));
}

return result;
```
{: .copy-code}

{% include images-gallery.html imageCollection="Create Uplink Converter" %}

在创建转换器或编辑时，您可以更改参数和解码器代码。如果转换器已经创建，请单击铅笔图标进行编辑。复制示例转换器配置（或使用您自己的配置）并将其粘贴到解码器函数中。然后单击复选标记图标保存更改。

## 创建集成

在创建上行转换器后，就可以创建集成。

在此阶段，您需要设置参数以在 GridLinks 和 Kafka Broker 之间建立连接。建立连接后，集成将把所有接收到的数据传输到上行转换器进行处理，然后根据设备中指定的设备配置文件将其传输到规则链。

|**字段**|**说明**|
|:-|:-|-
| **名称**              | 集成的名称。|
| **类型**              | 选择 Kafka 类型。|
| **'启用' 复选框**              | 启用/禁用集成。|
| **'调试模式' 复选框**              | 在集成调试期间启用。|
| **'允许创建设备或资产' 复选框**              | 如果 GridLinks 中没有设备，则将创建该设备。|
| **上行数据转换器**              | 选择之前创建的转换器。|
| **下行数据转换器**              | 此选项不支持通过集成，有关 [下行](https://docs.codingas.com/docs/user-guide/integrations/kafka/?installationType=common&integrationTypes=common&uplinkTypes=common#advanced-usage-kafka-producer-downlink) 的更多详细信息，请参阅指南中的以下内容。|
| **'远程执行' 复选框**              | 如果您想从主 GridLinks 实例远程执行集成，请激活。有关远程集成的更多信息，请访问 [链接（远程集成）](https://docs.codingas.com/docs/user-guide/integrations/remote-integrations/)。|
| **组 ID**              | 指定 Kafka 消费者所属的消费者组的名称。|
| **客户端 ID**              | 消费者组中的 Kafka 消费者标识符。|
| **主题**              | GridLinks 在连接到 Kafka 代理后将订阅的主题。|
| **引导服务器**              | 主机和端口对，它是 Kafka 客户端首次连接以进行引导的 Kafka 代理的地址。|
| **轮询间隔**              | 如果没有新消息到达，则轮询消息之间的持续时间（以毫秒为单位）。|
| **自动创建主题**              | 如果需要自动创建主题，请设置 **启用**|
| **其他属性**              | 可以为 kafka 代理连接提供任何其他附加属性。|
| **元数据**              | 元数据是一个键值映射，其中包含一些集成特定字段。例如，您可以放置设备类型。|
|---

{% capture integrationTypes %}
Kafka<br><small>通用/Docker </small>%,%common%,%templates/integration/kafka/kafka-common-and-docker-integration%br%
Confluent Cloud<br><small>云解决方案</small>%,%confluent%,%/templates/integration/kafka/kafka-confluent-integration{% endcapture %}

{% include content-toggle.html content-toggle-id="integrationTypes" toggle-spec=integrationTypes %}

## 从发送测试上行消息

{% capture uplinkTypes %}
Kafka<br><small>通用/Docker </small>%,%common%,%templates/integration/kafka/kafka-common-and-docker-send-msg%br%
Confluent Cloud<br><small>云解决方案</small>%,%confluent%,%/templates/integration/kafka/kafka-confluent-send-msg{% endcapture %}

{% include content-toggle.html content-toggle-id="uplinkTypes" toggle-spec=uplinkTypes %}

## 高级用法：Kafka 生产者（下行）

要获得诸如 Kafka 生产者之类的功能，您需要使用 [Kafka 规则节点](https://docs.codingas.com/docs/pe/user-guide/rule-engine-2-0/external-nodes/#kafka-node)，您可以在其中指定引导服务器、主题和其他参数以连接到 Kafka 代理，您可以在相应的 [指南](https://docs.codingas.com/docs/pe/user-guide/rule-engine-2-0/external-nodes/#kafka-node) 中找到更多详细信息。

如果无法直接向设备发送命令以从 GridLinks 进行管理，而只能通过代理发送，那么在这种情况下，您可以使用 Kafka 下行规则节点。让我们考虑一个带有其节点的小示例，假设数据来自代理并通过转换器，并且根据设备配置文件的配置，被定向到自定义规则链（“Monitoring-sensor”），并且在所有处理结束时，我们将发送一个关于成功或失败的响应回到代理（您可以将响应更改为命令以控制您的设备等）。

{% include images-gallery.html imageCollection="kafka_confluent_downlink" %}

检查消息是否已传输，您可以在启用调试模式的 Kafka 规则节点的事件选项卡中看到：

{% include images-gallery.html imageCollection="kafka_confluent_downlink_result" %}

{% capture kafka_note_downnlink %}
**注意：**对上行和下行连接使用相同的代理主题可能会导致数据循环。
{% endcapture %}

{% include templates/info-banner.md content=kafka_note_downnlink %}

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}