{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign deviceVendorLink = "https://www.milesight-iot.com/lorawan/gateway/ug56/" %}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardHost = 'https://thingsboard.cloud' %}
{% else %}
{% assign thingsboardHost = 'https://demo.thingsboard.io' %}
{% endif %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [UG56 网关用户手册](https://resource.milesight-iot.com/milesight/document/ug56-user-guide-en.pdf){: target="_blank"}
- [网络服务器帐户](#configuration)
'
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[UG56 LoRaWAN® 网关]({{deviceVendorLink}}){: target="_blank"}是一款高性能 8 通道 LoRaWAN® 网关，可为工业应用提供可靠的连接。

工业级设计
先听后说


免费嵌入式网络服务器
多种回程连接
全球 LoRaWAN® 频率计划：
RU864/IN865/EU868/AU915/US915/KR920/AS923

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

按照本指南中所述的步骤操作后，您将在网络服务器上连接并配置网关，并在 GridLinks 上集成，这将允许您添加设备、从设备接收数据并处理数据。

## 先决条件

要继续本指南，我们需要以下内容：
{{ prerequisites }}
- [GridLinks 帐户]({{ thingsboardHost }}){: target="_blank"}

## 网关连接

根据 [官方用户手册](https://resource.milesight-iot.com/milesight/document/ug56-user-guide-en.pdf){: target="_blank"} 和 [本指南](https://support.milesight-iot.com/support/solutions/articles/73000514278-how-to-connect-milesight-gateway-to-the-internet){: target="_blank"}，您可以通过两种方式将网关连接到网络并访问 WebUI：

- 无线连接：
  1. 在计算机上启用无线网络连接并搜索接入点“Gateway_******”以连接它。
  2. 在电脑上打开网页浏览器，输入IP地址**192.168.1.1**以访问Web GUI。
  3. 输入用户名（默认：**admin**）和密码（默认：**password**），单击**登录**。

- 有线连接：
  将 PC 直接或通过 PoE 注入器连接到 UG56 以太网端口以访问网关的 Web GUI。以下步骤基于 Windows 10 系统供您参考。

  1. 转到“控制面板”→“网络和 Internet”→“网络和共享中心”，然后单击“以太网”（可能名称不同）。
  2. 转到“属性”→“Internet 协议版本 4 (TCP/IPv4)”并选择“使用以下 IP 地址”，然后在网关的同一子网中手动分配一个静态 IP。
  3. 在电脑上打开网页浏览器，输入IP地址**192.168.23.150**以访问Web GUI。
  4. 输入用户名和密码，单击“登录”。

{% assign gatewayGeneralSettings = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/general-settings-view.png,
        title: 现在您可以配置网关。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayGeneralSettings %}

{% assign gatewayPacketForwarderTab = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-before.png,
        title: 在左侧菜单中打开**数据包转发器**并保存**网关 EUI**和**网关 ID**，我们需要它们在网络服务器上创建网关。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayPacketForwarderTab %}

默认情况下，网关 EUI 和网关 ID 相同。

接下来的步骤将描述如何将网关连接到网络服务器。

## 配置

要与网络服务器建立集成，请首先选择一个受支持的网络服务器：

{% assign targetIntegrationTypes = '
ChirpStack,
TheThingsStack,
TheThingsIndustries,
Loriot
'%}

{% include /docs/devices-library/blocks/basic/thingsboard-create-integration-block.liquid target-integration-types=targetIntegrationTypes %}

{% include /docs/devices-library/blocks/basic/thingsboard-check-integration-connection.md %}


## 结论

{% include /docs/devices-library/blocks/basic/lora-gateway-conclusion-block.md %}