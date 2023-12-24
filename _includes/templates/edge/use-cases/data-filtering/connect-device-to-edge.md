要将“车载监控系统”连接到 GridLinks Edge，您首先需要获取设备凭据。
GridLinks 支持不同的设备凭据。我们建议使用本指南中的默认自动生成凭据，即访问令牌。

请使用以下网址打开 ThingsBoard **Edge** UI：**EDGE_URL**。

{% include images-gallery.html imageCollection="copyAccessTokenDevice" showListImageTitles="true" %}

我们将使用简单的命令为设备 **车载监控系统** 生成随机遥测数据，并通过 MQTT 协议将其发布到 GridLinks **Edge**。

请将以下脚本下载到您的本地文件夹：
- [**mqtt-generator.py**](/docs/{{docsPrefix}}use-cases/resources/data-filtering-traffic-reduce/mqtt-generator.py)

在运行脚本之前，请相应地修改 **mqtt-generator.py**：

- 将 **YOUR_ACCESS_TOKEN** 替换为从上述步骤中复制的 **车载监控系统** 设备访问令牌。

- 将 **YOUR_TB_EDGE_HOST** 替换为您的 GridLinks Edge 主机。例如，**localhost**。

- 将 **YOUR_TB_EDGE_MQTT_PORT** 替换为您的 GridLinks Edge MQTT 端口。例如，**11883** 或 **1883**。

打开终端并安装 MQTT Python 库：
```bash
sudo pip install paho-mqtt
```

转到包含 Python 脚本的文件夹，并通过以下命令启动应用程序：

```bash
python mqtt-generator.py
```

打开 ThingsBoard **Edge** UI 并验证设备是否成功接收遥测数据：

{% include images-gallery.html imageCollection="verifyDeviceTelemetryEdge" showListImageTitles="true" %}

打开 **{{appPrefix}}** UI 并验证边缘是否成功将数据推送到云端：

{% include images-gallery.html imageCollection="verifyDeviceTelemetry" showListImageTitles="true" %}