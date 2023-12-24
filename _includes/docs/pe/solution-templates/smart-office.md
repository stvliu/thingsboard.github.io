* TOC
{:toc}

{% include templates/solution-templates.md %}

智能办公室模板代表基本工作空间监控和管理解决方案。
使用此模板，您可以获得一个交互式仪表板，能够控制 HVAC 系统，并获得有效和主动的办公室管理所需的关键指标的高级报告。

{% include images-gallery.html imageCollection="solution-highlights" %}

### 仪表板

作为此解决方案的一部分，我们创建了“智能办公室”仪表板，该仪表板显示来自多个设备的数据。您可以使用仪表板来：

* 观察办公室传感器及其位置；
* 浏览室内温度和功耗历史记录；
* 监控温度警报；
* 控制 HVAC（需要连接的设备）；
* 观察每个传感器的具体细节。

仪表板有多个状态。主状态显示设备列表、它们在办公室地图上的位置以及它们的警报列表。
您可以通过单击表格行来向下钻取到设备详细信息状态。设备详细信息特定于设备类型。

您始终可以使用仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义“智能办公室”仪表板。

### 设备

我们已经创建了“办公室”资产和与之相关的 4 个设备。我们还为这些设备加载了演示数据。有关创建的设备及其凭据的列表，请参阅解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。

解决方案根据每种设备的类型期望来自每种设备的特定遥测。
您可以在下面找到有效载荷示例。

**能量表**


有效载荷示例：

```json
{"voltage":  220, "frequency":  60, "amperage": 16, "power": 3000, "energy": 300 }
```
{: .copy-code}

**水表**


有效载荷示例：

```json
{"water": 2.3, "voltage": 3.9 }
```
{: .copy-code}

**智能传感器**


有效载荷示例：

```json
{"co2": 500, "tvoc": 0.3, "temperature": 22.5, "humidity": 50, "occupancy": true}
```
{: .copy-code}


**HVAC**


有效载荷示例：

```json
{"airFlow": 300, "targetTemperature": 21.5, "enabled": true}
```
{: .copy-code}


HVAC 设备还接受来自仪表板的命令以启用/禁用空调以及设置目标温度。
这些命令使用平台[RPC API](/docs/{{docsPrefix}}user-guide/rpc/)发送。

您可以在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中找到代表创建的设备发送数据的准确命令。有关连接真实设备的各种连接选项，请参阅[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

### 警报

警报是使用“智能传感器”[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)中的两个警报规则生成的。