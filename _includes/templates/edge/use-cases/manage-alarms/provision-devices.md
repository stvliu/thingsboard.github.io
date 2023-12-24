为简单起见，我们将使用 UI 手动配置设备。

我们首先在边缘创建 **DHT22 温度传感器** 和 **空调** 设备，并在这些设备之间添加关系。一旦 **DHT22 温度传感器** 发送关键温度值，此关系将用于查找相关的 **空调** 设备。

我们将在边缘配置设备。请使用 URL：**EDGE_URL** 打开 ThingsBoard **Edge** UI。

{% include images-gallery.html imageCollection="provisionDevicesEdge" showListImageTitles="true" %}

请使用 URL **SERVER_URL** 打开 **{{appPrefix}}**：

{% include images-gallery.html imageCollection="provisionDevices" showListImageTitles="true" %}