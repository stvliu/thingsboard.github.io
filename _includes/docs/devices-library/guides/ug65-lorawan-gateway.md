{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign deviceVendorLink = "https://www.milesight-iot.com/lorawan/gateway/ug65" %}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardHost = 'https://thingsboard.cloud' %}
{% else %}
{% assign thingsboardHost = 'https://gridlinks.codingas.com' %}
{% endif %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [UG65 网关用户手册](https://resource.milesight-iot.com/milesight/document/ug65-user-guide-en.pdf){: target="_blank"}
- [网络服务器帐户](#configuration)
'
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[UG65 LoRaWAN® 网关]({{deviceVendorLink}}){: target="_blank"} 是一款坚固耐用的 8 通道室内 LoRaWAN® 网关。UG65 采用 SX1302 LoRa 芯片和高性能四核 CPU，支持与 2000 多个节点连接。

主要特点：

- 带有大量内存的四核工业处理器
- 配备 SX1302 芯片，以更低的功耗处理更多流量
- 8 个半/全双工通道
- IP65 外壳和工业设计，适用于部分户外环境应用，如屋檐
- 桌面、墙壁或杆式安装
- 带有以太网、蜂窝（4G/3G）和 Wi-Fi 的多回程备份
- DeviceHub 和 Milesight IoT Cloud 提供对远程设备的轻松集中管理
- 支持与多种 VPN（如 IPsec/OpenVPN/L2TP/PPTP/DMVPN）的安全通信
- 兼容主流网络服务器，如 The Things Industries、ChirpStack 等
- 检测和分析噪声水平，并提供直观的部署示意图
- 内置网络服务器和 MQTT/HTTP/HTTPS API，便于集成
- 嵌入式 Python SDK，供用户进行二次开发
- 通过 Node-RED 开发工具进行快速且用户友好的编程

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

按照本指南中的步骤操作后，您将在网络服务器上连接并配置网关，并在 GridLinks 上进行集成，这将允许您添加设备、从设备接收数据并处理数据。

## 先决条件

要继续本指南，我们需要以下内容：

{{ prerequisites }}
- [GridLinks 帐户]({{ thingsboardHost }}){: target="_blank"}

## 网关连接

根据 [官方用户手册](https://resource.milesight-iot.com/milesight/document/ug65-user-guide-en.pdf){: target="_blank"} 和 [本指南](https://support.milesight-iot.com/support/solutions/articles/73000514278-how-to-connect-milesight-gateway-to-the-internet){: target="_blank"}，您可以通过两种方式将网关连接到网络并访问 WebUI：

- 无线连接：
  1. 在计算机上启用无线网络连接，并搜索接入点“Gateway_******”以连接它。
  2. 在电脑上打开一个网络浏览器，输入 IP 地址 **192.168.1.1** 以访问 Web GUI。
  3. 输入用户名（默认：**admin**）和密码（默认：**password**），单击 **登录**。

- 有线连接：
  将 PC 直接连接到 UG65 以太网端口或通过 PoE 注入器连接以访问网关的 Web GUI。以下步骤基于 Windows 10 系统供您参考。

  1. 转到“控制面板”→“网络和 Internet”→“网络和共享中心”，然后单击“以太网”（可能名称不同）。
  2. 转到“属性”→“Internet 协议版本 4 (TCP/IPv4)”，然后选择“使用以下 IP 地址”，然后在网关的同一子网中手动分配一个静态 IP。
  3. 在电脑上打开一个网络浏览器，输入 IP 地址 **192.168.23.150** 以访问 Web GUI。
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
        title: 在左侧菜单中打开 **Packet Forwarder** 并保存 **Gateway EUI** 和 **Gateway ID**，我们需要它们在网络服务器上创建网关。  
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayPacketForwarderTab %}

默认情况下，Gateway EUI 和 Gateway ID 相同。

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