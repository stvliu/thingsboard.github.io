要订阅来自边缘的针对 **空调** 设备的 RPC 命令，您首先需要获取 **空调** 设备凭据。
GridLinks 支持不同的设备凭据。我们建议使用本指南中的默认自动生成凭据，即访问令牌。

请使用以下 URL 打开 ThingsBoard **Edge** UI：**EDGE_URL**。

{% include images-gallery.html imageCollection="copyAccessTokenAirConditioner" showListImageTitles="true" %}

现在，您已准备好订阅空调设备的 RPC 命令。
在本示例中，我们将使用简单的命令通过 MQTT 协议订阅 RPC 命令。

请将以下脚本下载到您的本地文件夹：
- [**mqtt-js.sh**](/docs/edge/use-cases/resources/manage-alarms-rpc-requests/mqtt-js.sh)
- [**cooler.js**](/docs/edge/use-cases/resources/manage-alarms-rpc-requests/cooler.js)

{% include templates/edge/node-js-installed-banner.md %}

在运行脚本之前，请相应地修改 **mqtt-js.sh**：

- 将 **YOUR_ACCESS_TOKEN** 替换为从上述步骤中复制的 **空调** 设备访问令牌。

- 将 **YOUR_TB_EDGE_HOST** 替换为您的 ThingsBoard Edge 主机。例如，**localhost**。

- 将 **YOUR_TB_EDGE_MQTT_PORT** 替换为您的 ThingsBoard Edge MQTT 端口。例如，**11883** 或 **1883**。

打开终端，转到包含 **mqtt-js.sh** 和 **cooler.js** 脚本的文件夹，并确保它可执行：
```shell
 chmod +x *.sh
```

安装 **mqtt** 节点模块，以便能够在 **cooler.js** 脚本中使用 mqtt 包：
```shell
npm install mqtt --save
```

然后运行以下命令：
```shell
bash mqtt-js.sh
```

您应该会看到以下屏幕，其中显示您的主机和设备令牌：

```shell
pc@pc-XPS-15-9550:~/alarm-tutorial$ bash mqtt-js.sh
Connecting to: localhost:1883 using access token: sFqoF18PTyViO8L0qo7c
Cooler is connected!
```

{% capture new-tab %}
请打开一个新的终端选项卡，将温度遥测数据推送到设备，并将其留在后台运行，直到本指南结束。{% endcapture %}
{% include templates/info-banner.md content=new-tab %}