---
layout: docwithnav-pe-edge
title: 远程集成
description: 远程集成文档

addConverter:
    0:
        image: /images/pe/edge/integrations/remote/add-converter-step-1.png
    1:
        image: /images/pe/edge/integrations/remote/add-converter-step-2.png

addIntegration:
    0:
        image: /images/pe/edge/integrations/remote/add-integration-template-step-1.png
    1:
        image: /images/pe/edge/integrations/remote/add-integration-template-step-2.png
    2:
        image: /images/pe/edge/integrations/remote/add-integration-template-step-3.png

assignIntegration:
    0:
        image: /images/pe/edge/integrations/remote/assign-integration-step-1.png
        title: '将 <b>remoteHttpIntegrationUrl</b> 属性添加到 Edge 并将值设置为远程 HTTP 集成 <b>http://IP:port</b>'
    1:
        image: /images/pe/edge/integrations/remote/assign-integration-step-2.png
        title: '单击 Edge 实体的 <b>管理集成</b> 按钮'
    2:
        image: /images/pe/edge/integrations/remote/assign-integration-step-3.png
        title: '将集成分配给 Edge'
    3:
        image: /images/pe/edge/integrations/remote/assign-integration-step-4.png
        title: '登录到您的 <b>ThingsBoard Edge</b> 实例并打开集成页面 - 占位符将被属性值替换'

copyCredentials:
    0:
        image: /images/pe/edge/integrations/remote/copy-credentials.png

sendUplink:
    0:
        image: /images/pe/edge/integrations/remote/send-uplink-step-1.png
    1:
        image: /images/pe/edge/integrations/remote/send-uplink-step-2.png

device:
    0:
        image: /images/pe/edge/integrations/http/device.png

---

* TOC
{:toc}

## 简介

可以从主 GridLinks Edge 实例远程执行任何 ThingsBoard 集成。
本指南包含有关如何远程启动 ThingsBoard 集成的分步说明。
例如，我们将启动 HTTP 集成并将数据通过 *远程* HTTP 集成推送到 GridLinks Edge。

有关更多一般信息，请参阅 [部署选项](/docs/pe/edge/user-guide/integrations/#deployment-options)。

## 前提条件

我们假设您已经启动并运行了 GridLinks Edge 实例，并已连接到 **服务器**。

## GridLinks 服务器配置步骤

转换器和集成模板在 **服务器** 上创建，因此请以租户管理员身份登录到服务器实例。

### 步骤 1. 创建上行转换器

在创建集成模板之前，您需要在 **转换器模板** 页面中创建一个上行转换器模板。
上行链路对于将来自设备的传入数据转换为在 GridLinks Edge 中显示它们所需的格式是必需的。
单击“加号”和“创建新转换器”。要查看事件，请启用调试。
在函数解码器字段中，指定一个脚本来解析和转换数据。

{% include images-gallery.html imageCollection="addConverter" %}

{% include templates/edge/integrations/debug-mode-info.md %}

**上行转换器的示例：**

```ruby
// 从缓冲区解码上行消息
// payload - 字节数组
// metadata - 键/值对象
/** 解码器 **/
// 将有效负载解码为字符串
// var payloadStr = decodeToString(payload);
// 将有效负载解码为 JSON
var data = decodeToJson(payload);
var deviceName = data.deviceName;
// 具有设备属性/遥测数据的 Result 对象
var result = {
   deviceName: deviceName,
   deviceType: 'default',
   attributes: {
       model: data.model,
   },
   telemetry: {
       temperature: data.temperature
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
return result;
```
{: .copy-code}

### 步骤 2. 创建远程集成

现在已经创建了上行转换器模板，就可以创建一个集成。

{% include images-gallery.html imageCollection="addIntegration" %}

### 步骤 3. 保存远程集成凭据。

让我们从集成详细信息中复制粘贴集成密钥和机密，我们将在 **远程集成安装步骤** 中稍后使用它们。

{% include images-gallery.html imageCollection="copyCredentials" %}

### 步骤 4. 将集成分配给 Edge。

创建转换器和集成模板后，我们可以将集成模板分配给 Edge。
因为我们在集成配置中使用占位符 **$\{\{remoteHttpIntegrationUrl\}\}**，所以我们需要先将属性 **remoteHttpIntegrationUrl** 添加到 edge。
您需要提供 *HTTP* 远程集成的 **IP 地址** 和 **端口** 作为 **remoteHttpIntegrationUrl** 属性。
默认情况下，远程 HTTP 集成使用 **8082** 端口。
我们将在演示中使用相同的端口，IP 地址将设置为启动远程集成服务的机器的 IP 地址。
添加属性后，我们就可以分配集成并验证是否已添加。

{% include images-gallery.html imageCollection="assignIntegration" showListImageTitles="true" %}

## 远程集成安装步骤

### 选择您的平台并安装

可以通过 Docker、Debian 或 RPM 软件包安装 GridLinks 集成。
请使用以下步骤之一。

 * [Linux 或 Mac OS 上的 Docker](#docker-on-linuxmac)
 * [Windows 上的 Docker](#docker-on-windows)
 * [Ubuntu](#ubuntu-server)
 * [CentOS/RHEL 服务器](#centosrhel-server)

### Linux/Mac 上的 Docker

- **[安装 Docker CE](https://docs.docker.com/engine/installation/)**

- **选择要安装的集成**


{% capture contenttogglespec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/edge/install/integration/http-docker.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/edge/install/integration/mqtt-docker.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/edge/install/integration/opcua-docker.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/edge/install/integration/tcpudp-docker.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/edge/install/integration/coap-docker.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationdockerinstall" toggle-spec=contenttogglespec %}


{% include templates/edge/install/integration/advanced-config-docker.md %} 


- **故障排除**

{% include templates/troubleshooting/dns-issues.md %}

### Windows 上的 Docker

- **[为 Windows 安装 Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)**

- **选择要安装的集成**

{% capture contenttogglespecwin %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/edge/install/integration/http-docker-windows.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/edge/install/integration/mqtt-docker-windows.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/edge/install/integration/opcua-docker-windows.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/edge/install/integration/tcpudp-docker-windows.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/edge/install/integration/coap-docker-windows.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationdockerinstallwin" toggle-spec=contenttogglespecwin %}

{% include templates/edge/install/integration/advanced-config-docker.md %} 

- **故障排除**

{% include templates/troubleshooting/dns-issues-windows.md %}

### Ubuntu 服务器

- 安装 Java 11 (OpenJDK) 

{% include templates/install/ubuntu-java-install.md %}

- **选择要安装的集成包**
 
{% capture ubuntuinstallspec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/edge/install/integration/http-ubuntu.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/edge/install/integration/mqtt-ubuntu.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/edge/install/integration/opcua-ubuntu.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/edge/install/integration/tcpudp-ubuntu.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/edge/install/integration/coap-ubuntu.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationinstallubuntu" toggle-spec=ubuntuinstallspec %} 

### CentOS/RHEL 服务器

- 安装 Java 11 (OpenJDK) 

{% include templates/install/rhel-java-install.md %}

- **选择要安装的集成包**
 
{% capture rhelinstallspec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/edge/install/integration/http-rhel.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/edge/install/integration/mqtt-rhel.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/edge/install/integration/opcua-rhel.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/edge/install/integration/tcpudp-rhel.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/edge/install/integration/coap-rhel.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationinstallrhel" toggle-spec=rhelinstallspec %} 

## 远程 HTTP 集成验证

要发送上行消息，您需要集成中的 HTTP 端点 URL。
让我们登录 ThingsBoard **Edge** 并转到 **集成** 页面。
找到您的 HTTP 集成并单击它。您可以在其中找到 HTTP 端点 URL。单击图标以复制 URL。

**重要提示！** 请确保您的机器能够访问运行远程 HTTP 集成的机器，并且端口 *8082* 未被任何防火墙规则阻止。

使用此命令发送消息。将 $DEVICE_NAME 和 $YOUR_HTTP_ENDPOINT_URL 替换为相应的值。

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICE_NAME\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code}

{% include images-gallery.html imageCollection="sendUplink" %}

可以在 Edge 的 **设备组 -> 全部** 部分中看到创建的具有数据的设备：

{% include images-gallery.html imageCollection="device" %}

## 远程集成配置

远程集成配置通过 GridLinks UI 完成，没有具体步骤。
探索与特定集成相关的指南和视频教程：

 - [HTTP](/docs/pe/edge/user-guide/integrations/http/)
 - [MQTT](/docs/pe/edge/user-guide/integrations/mqtt/)
 - [OPC-UA](/docs/pe/edge/user-guide/integrations/opc-ua/)
 - [TCP](/docs/pe/edge/user-guide/integrations/tcp/)
 - [UDP](/docs/pe/edge/user-guide/integrations/udp/)
 - [CoAP](/docs/pe/edge/user-guide/integrations/coap/)

## 远程集成故障排除

请查看日志文件。它们的位置取决于您使用的平台和安装包，并在安装步骤中提及。

## 后续步骤

{% assign docsPrefix = "pe/edge/" %}
{% include templates/edge/guides-banner-edge.md %}