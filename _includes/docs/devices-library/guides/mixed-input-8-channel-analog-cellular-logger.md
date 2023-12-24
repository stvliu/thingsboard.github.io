{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign deviceVendorLink = "https://fusiondaq.com/product/mixed-input-8-channel-analog-cellular-logger/" %} 
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [阅读用户手册（可选）](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf)
'
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

FDQ-99900 MI-8 是一款紧凑型 24 位数据采集系统 (DAQ)，旨在测量多达十个外部传感器，然后将值本地记录到 SD 卡或通过蜂窝数据连接将数据推送到云端。  
高级触发功能允许 MI-8 仅传输感兴趣的事件，从而节省存储空间和网络数据。  
低功耗和宽工作温度范围旨在允许户外和远程安装。  
MI-8 提供带外壳和不带外壳两种型号，以支持定制包装解决方案。例如，无外壳（OEM）配置通常与支持传感器和硬件一起安装到 IP-67 等级 NEMA 外壳中。  

在本指南中，我们将学习如何 [在 Thingsboard 上创建设备](#create-device-on-thingsboard)。  
在此之后，我们将 [配置并连接设备](#connect-device-to-thingsboard)，并 [检查 GridLinks 上的数据](#check-data-on-thingsboard)。  

### 先决条件

要继续本指南，我们需要以下内容：  
{{ prerequisites }}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
- [GridLinks 帐户](https://gridlinks.codingas.com)
{% else %}
- [GridLinks 帐户](https://gridlinks.codingas.com)
{% endif %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger-configuration-block.md %}

## 检查 GridLinks 上的数据

{% include /docs/devices-library/blocks/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger-check-data-block.md %}

## 结论

{% include /docs/devices-library/blocks/basic/conclusion-block.md %}