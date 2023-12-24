要将温度遥测数据发布到 **DHT22** 传感器，您首先需要获取 **DHT22** 传感器凭据。
ThingsBoard 支持不同的设备凭据。我们建议使用本指南中的默认自动生成凭据，即访问令牌。

请使用以下 URL 打开 ThingsBoard **Edge** UI：**EDGE_URL**。

{% include images-gallery.html imageCollection="copyAccessTokenDht22" showListImageTitles="true" %}

现在，您可以代表您的设备发布温度遥测数据。
在本示例中，我们将使用简单的命令通过 HTTP 或 MQTT 发布温度数据。

{% capture connectdevicetogglespec %}
HTTP<small>Linux、macOS 或 Windows</small>%,%http%,%templates/edge/getting-started/http.md%br%
MQTT<small>Linux 或 macOS</small>%,%mqtt-linux%,%templates/edge/getting-started/mqtt-linux.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/edge/getting-started/mqtt-windows.md%br%
CoAP<small>Linux 或 macOS</small>%,%coap%,%templates/edge/getting-started/coap.md{% endcapture %}
{% include content-toggle.html content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec %}

成功发布值 **51** 的“温度”读数后：

{% capture connectdevicetogglespec %}
HTTP<small>Linux、macOS 或 Windows</small>%,%http%,%templates/edge/use-cases/manage-alarms/http-above-threshold.md%br%
MQTT<small>Linux 或 macOS</small>%,%mqtt-linux%,%templates/edge/use-cases/manage-alarms/mqtt-linux-above-threshold.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/edge/use-cases/manage-alarms/mqtt-windows-above-threshold.md%br%
CoAP<small>Linux 或 macOS</small>%,%coap%,%templates/edge/use-cases/manage-alarms/coap-above-threshold.md{% endcapture %}
{% include content-toggle.html content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec %}

您应该立即在设备警报选项卡中看到警报：

{% include images-gallery.html imageCollection="deviceAlarmTab" showListImageTitles="true" %}