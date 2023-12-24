* TOC
{:toc}

{% include templates/solution-templates.md %}

智能灌溉模板表示通用田地灌溉解决方案，用于配置田地和相关设备。

{% include images-gallery.html imageCollection="solution-highlights" %}

### 仪表板

作为此解决方案的一部分，我们创建了智能灌溉仪表板，该仪表板显示来自多个土壤湿度传感器的数据。此仪表板包含 2 个状态 - **主状态** 和 **田地状态**。

您可以使用 **主状态** 来：
- 在交互式地图上监控现有田地的平均土壤湿度值；
- 监控列表中相关土壤作物的田地并根据需要添加新田地；
- 为每个田地设置施加灌溉的限制值；
- 使用图表实时监控土壤湿度历史记录；
- 监控在未满足既定条件时发生的警报；

<br>
为了进入 **田地状态**，请单击田地部分中所需传感器的行或在交互式地图上选择所需的田地。

<br>
您可以使用 **田地状态** 来：
- 监控灌溉状态；
- 设置和编辑灌溉将起作用的包含时间表和条件；
- 查看土壤湿度统计数据；
- 监控已发生的警报；
- 管理土壤湿度水平传感器并在交互式地图上查看它们；
- 查看灌溉任务。

您始终可以使用仪表板开发 [指南](/docs/{{docsPrefix}}user-guide/dashboards/) 自定义“智能灌溉”仪表板。

### 设备

我们已经创建了多个设备并为它们加载了一些演示数据。有关创建的设备及其凭据的列表，请参阅解决方案 <a href="https://thingsboard.io/docs/paas/solution-templates/overview/#install-solution-template">说明</a>。

#### SI 水表
如果“电池”遥测值低于可配置阈值，则配置文件被配置为发出警报。当值低于 30 时，会发出警告警报。
该设备还上传用于计算耗水量的“脉冲计数器”。示例设备有效负载：

```json
{"battery": 99, "pulseCounter": 123000}
```
{: .copy-code}

#### SI 土壤湿度传感器
如果“电池”遥测值低于可配置阈值，则配置文件被配置为发出警报。当值低于 30 时，会发出警告警报。
该设备还上传“湿度”水平。示例设备有效负载：
```json
{"battery": 99, "moisture": 57}
```
{: .copy-code}

#### SI 智能阀门
如果“电池”遥测值低于可配置阈值，则配置文件被配置为发出警报。当值低于 30 时，会发出警告警报。示例设备有效负载：
```json
{"battery": 99}
```
{: .copy-code}

该设备还接受启用或禁用水流的 RPC 命令。示例 RPC 命令：
```json
{"method": "TURN_ON", "params": {}}
```
{: .copy-code}

您可以在解决方案 [说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template) 中找到代表创建的设备发送数据的准确命令。有关连接真实设备的各种连接选项，请参阅 [连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

### 警报
用户可以通过“智能灌溉”仪表板打开和关闭警报以及配置警报阈值。