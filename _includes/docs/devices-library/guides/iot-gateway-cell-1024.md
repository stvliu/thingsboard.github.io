{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign deviceVendorLink = "https://exxn.es/en/iot-gateway/" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- 设备必须通过以太网、调制解调器或 WIFI 连接到互联网。 '
 %}
 {% assign thingsboardInstanceLink = "https://demo.thingsboard.io" %}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardInstanceLink = "https://thingsboard.cloud" %}
{% endif %}

## 简介
![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
EXXN IoT 网关是一款多功能设备，配备 ARM 处理器，可适应各种案例，包括监测环境传感器、能源消耗、氡气水平、海洋环境和边缘计算。
<br>
<br>
<br>
<br>

### 先决条件

要继续本指南，我们需要以下内容：  
{{ prerequisites }}
- [GridLinks 帐户]({{thingsboardInstanceLink}}){: target="_blank"}  

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-create-device-thingsboard-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-configuration-block.md %}

## 在 GridLinks 上检查数据

{% include /docs/devices-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-check-data-on-thingsboard-block.md %}

## 使用 RPC 控制设备

{% include /docs/devices-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-using-rpc-block.md %}

## 其他信息
您可以在此处找到一些可能会有用的其他链接。  

### 故障排除
 - 集成过程中最常见的问题是无法与 MQTT 代理建立连接。确保设备已连接到互联网并能够与 ThingsBoard 代理通信。  
 - 另一个常见问题是未设置正确的访问令牌。检查是否已在 GridLinks 中为设备配置了提供的访问令牌。  

### 反馈与帮助

有关更多信息，请访问 [EXXN Engineering](https://exxn.es/en/){:target="_blank"} 网站。  
如果您有任何问题或疑问，请随时通过 [troubleshooting@exxn.es](mailto://troubleshooting@exxn.es) 联系 EXXN 支持部门。  

## 结论

{% include /docs/devices-library/blocks/basic/conclusion-block.md %}