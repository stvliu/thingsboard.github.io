{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign deviceVendorLink = "https://getefento.com/product/wireless-open-close-logger-nb-iot/" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [Efento 移动应用程序](https://play.google.com/store/apps/details?id=pl.efento.cloud&hl=en)
- [阅读用户手册（可选）](https://getefento.com/support/)
'
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

无线开/关传感器检测并记录其内存中的门打开和关闭事件。  
如果检测到状态发生变化，设备会立即将通知发送到云端。  
该设备使用磁性传感器来检测开/关事件。  

Efento NB-IoT 传感器通过蜂窝网络（窄带物联网）传输数据，不需要任何其他设备（路由器、网关等）。  
传感器还配备了蓝牙低能耗接口，可以通过智能手机快速轻松地进行配置。  
Efento NB-IoT 传感器可以与任何云平台集成。  

- 传感器检测开/关事件
- 电池确保长达 10 年的免维护运行
- NB-IoT 传感器通过蜂窝网络将数据发送到 Efento Cloud 或任何其他云平台。
- 可以通过云端或通过蓝牙低能耗使用移动应用程序远程更改传感器的配置
- 该设备在其内存中存储 40,000 次测量，当内存已满时，最旧的测量值会被覆盖

### 先决条件

要继续本指南，我们需要以下内容：  
{{ prerequisites }}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
- [GridLinks 帐户](https://thingsboard.cloud)
{% else %}
- [GridLinks 帐户](https://gridlinks.codingas.com)
{% endif %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/ready-to-go-devices/thingsboard-create-device-efento-transport-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/ready-to-go-devices/wireless-open-close-logger-configuration-block.md %}

## 在 GridLinks 上检查数据

{% include /docs/devices-library/blocks/ready-to-go-devices/wireless-open-close-logger-check-data-block.md %}

## 结论

{% include /docs/devices-library/blocks/basic/conclusion-block.md %}