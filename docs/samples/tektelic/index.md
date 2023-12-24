---
layout: docwithnav
title: 使用 TEKTELIC KONA 核心网络服务器连接 Tektelic LoRaWAN 传感器
description: 了解如何在 GridLinks 上获取 Tektelic LoRaWAN 传感器的数据

---

* TOC
{:toc}

[Tektelic](https://tektelic.com) 是 LoRaWAN® IoT 网关、传感器和自定义应用程序的主要供应商。
本指南介绍如何将数据从 TEKTELIC KONA 核心网络服务器流式传输到 GridLinks。

### 先决条件
我们将使用专为在 EU868 频段工作而设计的网关和传感器。

要开始，需要具备以下条件：
- [智能房间传感器](https://tektelic.com/products/sensors/comfort-base-smart-room-sensor/)。
- [KONA 微型 IoT 网关](https://tektelic.com/products/gateways/kona-micro-iot-gateway/)。
- TEKTELIC KONA 核心网络服务器的 [欧盟实例](https://lorawan-ns-eu.tektelic.com) 的客户帐户。
要获取帐户，请联系 [Tektelic 支持](mailto:support@tektelic.com)。

本指南设置的常见方案如下：

<img src="/images/samples/tektelic/setup_scheme.png" width="800" alt="设置方案">

### 步骤 1. 在网络服务器中注册硬件
##### 步骤 1.1 添加网关
- 创建新的网关组。
- 在组中创建新的网关。可以在网关机身上找到 GW-ID。
- 更改网关凭据，以下是默认用户名和密码的格式：
- 用户名：TEK00XXYY（其中 XXYY 表示 MAC 地址的最后 4 位数字）。
- 密码：网关的 9 位序列号。

网络服务器提供预定义的网关列表，此处使用 Kona Micro EU GW 型号。
您还可以创建一个新的网关型号，根据网关规格设置频段和信道数。

<img data-gifffer="/images/samples/tektelic/add_a_gateway.gif" width="1000" alt="添加网关">

Tektelic 网关随附预定义的网络服务器地址 - EU868 网关的 [lorawan-ns-eu.tektelic.com](https://lorawan-ns-eu.tektelic.com) 和 US915 网关的 [lorawan-ns-na.tektelic.com](https://lorawan-ns-na.tektelic.com)。
在网络服务器上创建网关并连接到互联网后，其状态设置为 *在线*。
网关的 *统计信息* 选项卡会定期更新，并显示通过无线电信道发送和接收的数据包数量。

<img src="/images/samples/tektelic/gateway_statistics.png" width="800" alt="网关统计信息">

##### 步骤 1.2 添加传感器
- 创建一个新的应用程序，例如，*本地传感器*。
- 在应用程序中创建新的设备。
智能房间传感器贴有印有二维码的贴纸，其中包含网络服务器所需的数据。

<img src="/images/samples/tektelic/smart_room_sensor_QR.png"width="200" alt="智能房间传感器二维码">

二维码包含设备 EUI 和应用程序 EUI 值。

<img src="/images/samples/tektelic/QR_scan_result.png" width="200" alt="二维码扫描结果">

其中 *647FDA00000042F0* 是设备 EUI，*647FDA8010000100* 是应用程序 EUI。
Tektelic 在发货时提供包含调试信息的纸质副本。如果您找不到，请联系 [Tektelic 支持](mailto:support@tektelic.com)

<img data-gifffer="/images/samples/tektelic/add_a_sensor.gif" width="1000" alt="添加传感器">

配置传感器后，需要将其打开才能在网络服务器中获取 LoRa 数据包。
拉出保护膜后，智能房间传感器将打开。此操作后，传感器将由出厂安装的电池供电。
因此，加入请求接受数据包将显示在 *实时数据包* 选项卡中。
稍后，上行链路和下行链路也将显示。

<img src="/images/samples/tektelic/sensor_packets.png" width="800" alt="传感器数据包">

智能房间传感器会定期发送上行链路，但您可以使用磁铁触发上行链路。
只需将磁铁靠近传感器机身即可。
网络服务器以编码的 Base64 形式显示数据包。要解码数据包并查看整个 LoRa 数据包有效负载，包括与 LoRa 相关的数据和传感器数据本身，您可以使用免费的 [LoRaWAN 1.0.x 数据包解码器](https://lorawan-packet-decoder-0ta6puiniaut.runkit.sh/)。
解码器需要 *应用程序* 和 *网络* 会话密钥，可以在 *激活* 选项卡中找到。

<img src="/images/samples/tektelic/sensor_activation_tab.png" width="800" alt="传感器激活选项卡">

请注意，*应用程序* 和 *网络* 会话密钥在传感器重新加入时会更改。
智能房间传感器在每次断开电池连接后都会重新加入。
### 步骤 2. 配置与 GridLinks 的集成
GridLinks 提供 [MQTT 网关 API](/docs/reference/gateway-mqtt-api/)。
反过来，网络服务器集成使用此 MQTT 网关 API。
因此，传感器和网关将在 GridLinks 端自动创建。
##### 步骤 2.1 在 GridLinks 中添加网关设备
- 在 GridLinks 中创建新设备。为了方便，我们将其类型设置为 *ns_integration*，类型名称不影响功能。
必须选中 *是网关* 复选框才能使用 [MQTT 网关 API](/docs/reference/gateway-mqtt-api/) 创建设备。
请不要将 GridLinks 中的网关设备与 LoRa 网关混淆，它们只是名称匹配。
需要复制设备访问令牌以在下一步中使用它。

<img src="/images/samples/tektelic/tb_gateway.png" width="800" alt="网关">

##### 步骤 2.2 在网络服务器中添加集成
在网络服务器中打开 *本地传感器* 应用程序，然后单击 *管理集成* 按钮。
现在需要与 GridLinks 创建新的集成。
单击右上角的 *添加集成* 图标，然后设置以下字段：
- *名称* - 集成名称可以是任何名称。
- *类型* - 显然是 GridLinks。
- *数据转换器* - 适当的网络服务器转换器。
- *应用程序地址* - GridLinks 实例地址，不带 http 或 https 前缀。
- *令牌* - 在步骤 2.1 中复制的令牌。

<img src="/images/samples/tektelic/ns_integration.png" width="800" alt="ns 集成">

将其余字段保留为默认值。

### 步骤 3. 集成验证
创建集成后，等待来自传感器的新的上行链路（或触发它）。
**只有在新的上行链路** 网络服务器通过 [MQTT 网关 API](/docs/reference/gateway-mqtt-api/) 才会在 GridLinks 中创建新设备。
在 GridLinks 中，从步骤 2.1 打开设备网关，转到 *关系* 选项卡，然后选择方向为 *来自* 的出站关系。
应该存在在步骤 1.1 和步骤 1.2 中在网络服务器中添加的网关和传感器

<img src="/images/samples/tektelic/tb_from_relations.png" width="1000" alt="来自关系">
<br>
这些设备将显示为适当的类型：
- *CLASS_A* - 步骤 1.2 中的传感器。
类型由网络传感器设置，对应于智能房间传感器正在工作的 LoRaWAN 类。
- *网关* - 步骤 1.1 中的网关。

打开传感器的 *最新遥测* 选项卡，其中将包含网络服务器在最后一条消息中发送的数据。
部分数据（例如 *nsGateway*、*nsRssi*、*nsFPort*）与 LoRa、网络服务器以及接收上行链路的网关相关。
其余数据由网络服务器转换器添加（在我们的案例中 - 由步骤 2.2 中的 Tektelic Home Sensor 添加），并且与传感器的有效负载（*湿度*、*加速度计*、*冲击* 等）相关。
遥测数据的这一部分取决于用于 GridLinks 集成的网络服务器转换器，以及该转换器如何在网络服务器端将传感器的有效负载（字节数组）解析为 JSON。
因此，如果您使用其他型号的传感器，请考虑这一点。
<br>
一旦集成验证成功，接收到的遥测数据即可用于可视化。
您可以导入预定义的仪表板来查看数据。 <a href="./resources/network_server_dashboard.json" download>单击下载。</a>

<img data-gifffer="/images/samples/tektelic/import_dashboard.gif" width="1000" alt="导入仪表板">


## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。