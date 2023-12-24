* TOC
{:toc}

{% include templates/solution-templates.md %}

废物管理模板代表了用于监控和控制废物容器满度的解决方案。借助此解决方案，您将能够监控垃圾箱的位置、其满度，还可以查看有关垃圾箱的统计信息。

{% include images-gallery.html imageCollection="solution-highlights" %}

### 仪表板

作为此解决方案的一部分，我们创建了**废物管理管理**仪表板，该仪表板显示来自废物传感器的的数据。

#### 废物管理管理

废物管理管理具有多个状态 - **主状态**和**垃圾箱状态**。

您可以使用**主状态**来：
- 在交互式地图的帮助下修改所需垃圾箱的位置和装填；
- 实时接收数据；
- 关注垃圾箱满度的主要指标；
- 查看和管理所有可用传感器；
- 控制有关满度和电池电量的通知系统。

<br>

要切换到**垃圾箱状态**，请从传感器的一般列表中单击所需传感器的行，或在交互式地图上单击特定传感器的卡片/弹出窗口上的“详细信息”。

<br>

您可以使用**垃圾箱状态**来：
- 查看和编辑特定垃圾箱的基本信息、传感器位置；
- 监控基本的垃圾和电池统计信息；
- 控制有关电量和电池电量的通知系统。

您可以随时使用仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义“废物管理管理”仪表板。


### 设备

我们已经创建了 10 个废物监控传感器并为它们加载了一些演示数据。有关创建的设备及其凭据的列表，请参阅解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。该解决方案期望传感器设备将上传满度等级和电池电量值。预期有效负载的最简单示例采用 JSON 格式：

```json
{"fullLevel": 42, "batteryLevel": 77 }
```
{: .copy-code}


您可以在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中找到代表创建的设备发送数据的准确命令。有关连接真实设备的各种连接选项，请参阅[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

### 警报
警报是使用“废物传感器”<a href="/docs/pe/user-guide/device-profiles/" target="_blank">设备配置文件</a>中的两个<a href="https://thingsboard.io/docs/user-guide/device-profiles/#alarm-rules" target="_blank">警报规则</a>生成的。
用户可以通过“编辑传感器”表单通过“废物管理”仪表板打开和关闭警报以及配置警报阈值。