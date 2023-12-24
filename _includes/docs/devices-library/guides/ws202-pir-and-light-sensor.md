{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign deviceVendorLink = "https://www.milesight-iot.com/lorawan/sensor/ws202/" %}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardHost = 'https://thingsboard.cloud' %}
{% else %}
{% assign thingsboardHost = 'https://demo.thingsboard.io' %}
{% endif %}
{% assign officialManualLink = "https://resource.milesight-iot.com/milesight/document/ws202-user-guide-en.pdf" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [WS202 PIR & Light Sensor 用户手册](' | append: officialManualLink | append: '){: target="_blank"}
- 具有 NFC 功能的智能手机和 Milesight ToolBox 应用程序 ([Android](https://play.google.com/store/apps/details?id=com.ursalinknfc){: target="_blank"}/[iOS](https://itunes.apple.com/app/id1518748039){: target="_blank"})
- LoRaWAN® 网关
- 在网络服务器和 ThingsBoard 上配置的集成
- [网络服务器帐户](#device-connection)
'
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[WS202 PIR 和光传感器]({{deviceVendorLink}}){: target="_blank"} 是一款基于被动红外技术的 PIR 传感器，用于检测运动或占用。  
WS202 可以检测 6-8 米范围内是否有移动。  
此外，WS202 配备了一个光传感器，可以将 PIR 检测结果链接到触发场景。  
WS202 可广泛用于智能家居、智能办公室、学校、仓库等。  
传感器数据使用标准 LoRaWAN® 协议实时传输。  
LoRaWAN® 能够在很远的距离上进行加密无线传输，同时消耗非常少的电量。  

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}
<br>

## 先决条件

要继续本指南，我们需要以下内容：  
{{ prerequisites }}
- [GridLinks 帐户]({{ thingsboardHost }}){: target="_blank"}


## 设备连接

根据 [官方用户手册]({{officialManualLink}}){: target="_blank"}，我们需要一部支持 NFC 的智能手机和 ToolBox 应用程序来连接传感器。  
由于此设备只能使用 LoRaWAN® 网关操作，因此我们必须先将其连接到已配置与 ThingsBoard 集成的网络服务器。  
之后，可以将其配置到 GridLinks。

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}

{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/devices-library/blocks/ready-to-go-devices/" | append: articleFilename | append: "-configuration-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

要配置设备，我们还需要将其添加到网络服务器，因此选择网关连接到的网络服务器：  

{% assign targetIntegrationTypes = '
ChirpStack,
TheThingsStack,
TheThingsIndustries,
Loriot
'%}

{% include /docs/devices-library/blocks/basic/thingsboard-add-lorawan-device-through-integration-block.liquid target-integration-types=targetIntegrationTypes %}

{% include /docs/devices-library/blocks/ready-to-go-devices/ws202-pir-and-light-sensor-check-data-block.md %}

## 结论

{% include /docs/devices-library/blocks/basic/conclusion-block.md %}