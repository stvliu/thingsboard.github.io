{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

CoAP 集成允许从使用 CoAP 协议连接到 GridLinks 的设备流式传输数据，并将这些设备的有效负载转换为 GridLinks 格式。

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/coap-integration.svg)

## 前提条件

在本教程中，我们将向您展示 CoAP 集成如何作为 **tb-core** 服务的一部分工作，并选择 **NO SECURE** 安全模式。为此，我们将使用：

{% if docsPrefix == "pe/" %}
- 本地安装的 [ GridLinks专业版](https://docs.codingas.com/docs/user-guide/install/pe/installation-options/) 实例；
{% endif %}
{% if docsPrefix == "paas/" %}
-  GridLinks专业版 实例 — [thingsboard.cloud](https://thingsboard.cloud)；
{% endif %}

- [coap-client](https://manpages.ubuntu.com/manpages/focal/man5/coap-client.5.html) 实用程序，旨在模拟将连接到 CoAP 集成的 CoAP 客户端；

{% if docsPrefix == "pe/" %}
让我们假设我们有一个传感器，它正在发送当前温度和湿度读数。我们的传感器设备 **SN-001** 将其温度和湿度读数发布到 **coap://localhost** URL 上的 CoAP 集成。
{% endif %}
{% if docsPrefix == "paas/" %}
让我们假设我们有一个传感器，它正在发送当前温度和湿度读数。我们的传感器设备 **SN-001** 将其温度和湿度读数发布到 **coap://int.thingsboard.cloud** URL 上的 CoAP 集成。
{% endif %}

出于演示目的，我们假设我们的设备足够智能，可以发送 3 种不同有效负载类型的数据：
- **文本** - 在这种情况下，有效负载是：

```text
SN-001,default,temperature,25.7,humidity,69
```

- **JSON** - 在这种情况下，有效负载是：

```json
{
  "deviceName": "SN-001",
  "deviceType": "default",
  "temperature": 25.7,
  "humidity": 69
}
```

- **二进制** - 在这种情况下，有效负载如下所示（以 HEX 字符串表示）：

```text
\x53\x4e\x2d\x30\x30\x31\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x36\x39
```

以下是此有效负载中字节的说明：
- **0-5** 字节 - **\x53\x4e\x2d\x30\x30\x31** - 设备名称。如果我们将其转换为文本 - **SN-001**；
- **6-12** 字节 - **\x64\x65\x66\x61\x75\x6c\x74** - 设备类型。如果我们将其转换为文本 - **default**；
- **13-16** 字节 - **\x32\x35\x2e\x37** - 温度遥测。如果我们将其转换为文本 - **25.7**；
- **17-18** 字节 - **\x36\x39** - 湿度遥测。如果我们将其转换为文本 - **69**；

您可以根据设备功能和业务案例使用有效负载类型。

## 上行转换器

在设置 **CoAP 集成** 之前，您需要创建一个 **上行转换器**，它是一个用于解析和转换 CoAP 集成接收的数据的脚本，以转换为 GridLinks 使用的格式。**deviceName** 和 **deviceType** 是必需的，而属性和遥测是可选的。属性和遥测是扁平的键值对象。不支持嵌套对象。

要创建 **上行转换器**，请转到 **数据转换器** 部分，然后单击 **添加新数据转换器 —> 创建新转换器**。将其命名为 **“CoAP 上行转换器”** 并选择类型 **上行**。现在使用调试模式。

{% capture difference %}
**注意**
<br>
尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**选择设备有效负载类型以进行解码器配置：**

- **文本有效负载**

{% include templates/tbel-vs-js.md %}

{% capture coapuplinktext %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/coap/coap-uplink-text-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/coap/coap-uplink-text-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="coapuplinktext" toggle-spec=coapuplinktext %}

- **JSON 有效负载**

{% include templates/tbel-vs-js.md %}

{% capture coapuplinkjson %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/coap/coap-uplink-json-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/coap/coap-uplink-json-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="coapuplinkjson" toggle-spec=coapuplinkjson %}


- **二进制有效负载**

{% capture coapuplinkbinary %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/coap/coap-uplink-binary-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/coap/coap-uplink-binary-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="coapuplinkbinary" toggle-spec=coapuplinkbinary %}

## CoAP 集成设置

{% include images-gallery.html imageCollection="coap-integration-setup" showListImageTitles="true" %}

### CoAP 集成配置

CoAP 集成允许我们选择安全模式：

- **NO SECURE（默认模式）**
- **DTLS**
- **MIXED**

![image](/images/user-guide/integrations/coap/coap-integration-modes-1.png)

{% if docsPrefix != "paas/" %}


对于最后 2 种类型，在创建集成之前，应在 .yml 配置文件中启用 DTLS 支持，或应通过覆盖 .conf 文件中的以下环境变量来更新：

```
# 启用/禁用 DTLS 1.2 支持
export COAP_DTLS_ENABLED=true
# 默认 CoAP DTLS 绑定端口
export COAP_DTLS_BIND_PORT=5484 
# 保存 SSL 证书的密钥库的路径
export COAP_DTLS_KEY_STORE=coapserver.jks 
# 用于访问密钥库的密码
export COAP_DTLS_KEY_STORE_PASSWORD=server_ks_password
# 用于访问密钥的密码
export COAP_DTLS_KEY_PASSWORD=server_key_password
# 密钥别名
export COAP_DTLS_KEY_ALIAS=serveralias
# 跳过客户端证书的证书有效性检查
export TB_COAP_X509_DTLS_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT=false
```

请注意，上面添加的环境变量使用默认的 DTLS 配置设置。为了使 CoAP 服务器在 DTLS 模式下正确启动，您需要至少更新密钥库设置。请参阅 [CoAP over DTLS](/docs/pe/user-guide/coap-over-dtls) 指南以了解更多有关 CoAP DTLS 配置的信息。

{% endif %}

此外，CoAP 集成将根据基本 URL 路径和以下路径前缀为我们自动生成 CoAP 端点 URL 以传输数据：
- **/i** - CoAP 服务器中的集成资源
- **/$INTEGRATION_ROUTING_KEY** - 自动生成的集成路由密钥

{% if docsPrefix != "pe/" %}

您还可以通过在基本 URL 前面设置其他路径前缀来更新 CoAP 端点 URL：

![image](/images/user-guide/integrations/coap/coap-integration-configuration-extra-path-prefix-1-paas.png)

每个其他路径前缀都将作为 CoAP 资源添加到 CoAP 服务器，其中：
- **api** - 父资源
- **v2** - **api** 资源的子资源和集成资源 **i** 的父资源

{% endif %}

## 发送上行消息

创建 CoAP 集成后，CoAP 服务器会注册适当的资源，然后等待来自设备的数据。

选择设备有效负载类型以发送上行消息

{% capture senduplink %}
文本有效负载<br>%,%text%,%templates/integration/coap/coap-send-uplink-text.md%br%
JSON 有效负载<br>%,%json%,%templates/integration/coap/coap-send-uplink-json.md%br%
二进制有效负载<br>%,%binary%,%templates/integration/coap/coap-send-uplink-binary.md{% endcapture %}

{% include content-toggle.html content-toggle-id="coapintegrationsenduplink" toggle-spec=senduplink %}

一旦命令发送，您就可以转到 **设备组** -> **全部**，您应该找到由集成配置的 **SN-001** 设备。
单击设备，转到 **最新遥测** 选项卡，您应该在那里找到“温度”键及其值 (25.7)，以及“湿度”键及其值 (69)。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/coap/coap-integration-test-uplink-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/coap/coap-integration-test-uplink-paas.png)
{% endif %}

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/guides-banner.md %}