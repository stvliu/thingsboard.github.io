* TOC
{:toc}

{% include templates/solution-templates.md %}

车辆跟踪模板是指公交车跟踪解决方案。
使用此模板，您可以获得一个交互式仪表板，其中包含车辆的实时跟踪以及路线详细信息、路线上的资产状态等。

{% include images-gallery.html imageCollection="solution-highlights" %}

### 仪表板

作为此解决方案的一部分，我们创建了一个“车辆跟踪”仪表板，该仪表板显示来自多辆公交车的数据。此仪表板包含 2 个状态 - **主状态**和**公交车状态**。

您可以使用**主状态**来：
- 实时观察交互式地图上的公交车位置；
- 控制公交车的状态、速度和燃油水平；
- 监控公交车跟踪事件（警报）。

<br>
为了进入**公交车状态**，请单击公交车部分中所需传感器的行。

<br>
您可以使用**公交车状态**来：
- 以路线记录的形式查看特定公交车的路线历史记录，并可以播放该记录；
- 查看当前公交车路线；
- 实时监控速度、燃油水平和状态。此外，还可以查看公交车速度统计数据；
- 使用警报系统响应出现的事件。

此外，为了方便查看信息，用户可以从白天模式切换到夜间模式，反之亦然。

您始终可以使用仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义“车辆跟踪”仪表板。


### 设备

我们已经创建了四个公交车跟踪设备，并为它们加载了一些演示数据。有关创建的设备及其凭据的列表，请参阅解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。

解决方案期望公交车跟踪设备上传“纬度”、“经度”、“速度”、“燃油”和“状态”值。预期有效负载的最简单示例采用 JSON 格式：

```json
{"latitude":  37.764702, "longitude":  -122.476071, "speed":  50, "fuel":  5, "status": "On route"}
```
{: .copy-code}

您可以在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中找到代表创建的设备发送数据的准确命令。有关连接真实设备的各种连接选项，请参阅[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

### 警报

警报是使用“公交车”[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)中的两个警报规则生成的。