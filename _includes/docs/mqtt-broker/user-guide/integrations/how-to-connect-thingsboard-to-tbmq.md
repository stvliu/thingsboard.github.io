{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

**TBMQ** 是在 GridLinks 保护伞下开发和分发的面向行业的 MQTT 代理，它促进了 MQTT 客户端连接、消息发布以及在订阅者之间分发消息。

在本指南中，我们使用 MQTT 集成将 TBMQ 与 GridLinks 集成。
我们利用类型为 **APPLICATION** 的 TBMQ 客户端凭据将 GridLinks 集成连接为 APPLICATION 客户端。
APPLICATION 客户端专门用于订阅具有高消息速率的主题。
当客户端处于离线状态时，消息将被保留，并且一旦客户端上线，消息将被传递，从而确保关键数据的可用性。
[此处](https://thingsboard.io/docs/mqtt-broker/user-guide/mqtt-client-type/)详细了解 APPLICATION 客户端。

GridLinks MQTT 集成充当 MQTT 客户端。它订阅主题并将接收到的数据转换为遥测和属性更新。
在有下行消息的情况下，MQTT 集成会将其转换为适合设备的格式并将其推送到 TBMQ。
请注意：TBMQ 应与 GridLinks 实例位于同一位置或部署在云中，并具有有效的 DNS 名称或静态 IP 地址。
在云中运行的 GridLinks 实例无法连接到没有互联网连接的本地局域网中部署的 TBMQ。

### 前提条件

在本教程中，我们将使用：

- 本地安装的 [ GridLinks专业版](https://thingsboard.io/docs/user-guide/install/pe/installation-options/) 实例；
- 本地安装且 GridLinks PE 实例可访问的 [TBMQ](https://thingsboard.io/docs/mqtt-broker/install/installation-options/)；
- mosquitto_pub MQTT 客户端来发送消息。

### TBMQ 设置

首先，我们需要创建 TBMQ 客户端凭据，以便将 GridLinks 集成连接到 TBMQ。

为此，请登录到 TBMQ 用户界面并按照以下步骤操作。

{% include images-gallery.html imageCollection="create-client-credentials" showListImageTitles="true" %}

{% capture difference %}
**请注意**：
<br>
必须将 "SECURITY_MQTT_BASIC_ENABLED" 环境变量设置为 "true"。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

现在，您可以继续执行下一步 - 配置 GridLinks 集成。

### GridLinks 设置

在本示例中，我们将使用 MQTT 集成将 GridLinks 连接到 TBMQ。
在设置 MQTT 集成之前，您需要创建上行转换器。

#### 上行转换器

解码器函数的目的是将传入的数据和元数据解析为 GridLinks 可以使用的格式。

要创建上行转换器，请转到 "集成中心" 部分 -> "数据转换器" 页面，然后单击 "加号" 图标。将其命名为 "TBMQ 上行转换器"，然后选择类型 "上行"。将以下解码器脚本粘贴到解码器函数部分。单击 "添加"。

{% include images-gallery.html imageCollection="create-uplink-converter" %}

在我们的示例中，对解码器函数部分使用以下脚本：

{% include templates/tbel-vs-js.md %}

{% capture mqttuplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/mqtt-broker/user-guide/integrations/mqtt/tbmq-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/mqtt-broker/user-guide/integrations/mqtt/tbmq-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="mqttuplinkconverterconfig" toggle-spec=mqttuplinkconverterconfig %}

#### MQTT 集成设置

现在创建一个集成。

{% include images-gallery.html imageCollection="create-integration" showListImageTitles="true" %}

现在转到 TBMQ UI 中的 "会话" 页面。在 GridLinks 和 TBMQ 之间成功建立连接后，我们将看到一个新会话及其状态 - "已连接"。

{% include images-gallery.html imageCollection="successful-connection-tbmq-to-thingsboard" %}

在 "Kafka 管理" 菜单部分的 "主题" 页面上，您将看到 Kafka 主题的名称（对应于 MQTT 集成中指定的客户端 ID）、分区数、复制因子和主题大小。

{% include images-gallery.html imageCollection="tbmq-home-page" %}

#### 发送上行消息

现在让我们模拟设备向 TBMQ 发送温度读数。

打开终端并执行以下命令，将带有简单格式的温度读数消息 *`{"value":25.1}`* 发送到主题 "tb/mqtt-integration-tutorial/sensors/SN-001/temperature"：

```shell
mosquitto_pub -h $THINGSBOARD_MQTT_BROKER_HOST_NAME -p 1883 -q 1 -t "tb/mqtt-integration-tutorial/sensors/SN-001/temperature" -m '{"value":25.1}' -u "username" -P "password"
```
{: .copy-code}

根据已配置凭据中指定的值，将 `$THINGSBOARD_MQTT_BROKER_HOST_NAME` 替换为代理的正确公有 IP 地址或 DNS 名称，将 `username` 和 `password` 替换为相应的值。

对我们的示例使用以下命令：

```shell
mosquitto_pub -h localhost -p 1883 -q 1 -t "tb/mqtt-integration-tutorial/sensors/SN-001/temperature" -m '{"value":25.1}' -u "tb-pe" -P "secret"
```
{: .copy-code}

![image](/images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-uplink-message-1.png)

发送上行消息后，转到 GridLinks UI 中的集成并导航到 "事件" 选项卡。您将在其中看到 "MQTT 集成" 使用的消息。

{% include images-gallery.html imageCollection="tbmq-integration-events" %}

转到 "实体" 部分 -> "设备" 页面。您应该找到由集成配置的 SN-001 设备。
单击设备，转到 "最新遥测" 选项卡，以查看 "temperature" 密钥及其值 (25.1)。

{% include images-gallery.html imageCollection="tbmq-create-device" %}

### 后续步骤

{% assign currentGuide = "TBIntegrationGuide" %}{% include templates/mqtt-broker-guides-banner.md %}