* TOC
{:toc}

## 前提条件

我们假设您已经完成了常规的 [入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南，以便熟悉 GridLinks。我们还建议您首先查看 [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/) 文档。

## Sparkplug 基础知识

[Sparkplug](https://sparkplug.eclipse.org/) 是一项开源软件规范，它为 MQTT 客户端提供了一个框架，以便在 MQTT 基础设施中无缝集成来自其应用程序、传感器、设备和网关的数据。

GridLinks 充当 MQTT 服务器，支持 SparkPlug 有效负载和主题结构，并允许从 MQTT 网络边缘 (EoN) 节点进行连接。

EoN 节点是任何符合 V3.1.1 的 MQTT 客户端应用程序，它管理 MQTT 会话并提供物理和/或逻辑网关功能。EoN 节点负责与现有旧设备（PLC、RTU、流量计算机、传感器等）的任何本地协议接口和/或任何本地离散 I/O 和/或任何逻辑内部过程变量 (PV)。

该协议 [规范](https://sparkplug.eclipse.org/specification/version/2.2/documents/sparkplug-specification-2.2.pdf) 为 EoN 节点定义了 MQTT 主题和消息结构，以便与 MQTT 服务器通信。单个 EoN 节点可以表示多个物理设备和传感器，并为每个设备上传设备指标。GridLinks 从 Sparkplug 有效负载中解码设备指标，并将其存储为相应的设备 [属性](/docs/{{docsPrefix}}user-guide/attributes/) 或 [时序](/docs/{{docsPrefix}}user-guide/telemetry/) 数据。您还可以使用 [从共享属性更新到 MQTT EONDevice](#update-metrics-from-shared-attributes-to-mqtt-eondevice) 或 [rpc 命令](#update-metrics--using-the-thingsboard-rpc-command-from-server-to-mqtt-eondevice) 从服务器端向 Sparkplug 设备发出更新。

{% capture difference %}
**注意：**
<br>
GridLinks 仅支持 **Sparkplug™ B** 有效负载。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 入门

本指南将教我们如何：将 Sparkplug EoN 节点连接到 GridLinks，收集设备指标并将它们存储为 GridLinks 时序数据，以及将命令推送到设备。

### 步骤 1. 创建设备配置文件

首先，您需要为 Sparkplug 设备创建 MQTT [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)：

1. 导航到 *配置文件 -> 设备配置文件* 页面，然后单击设备配置文件表标题中的“+”图标以打开 *添加设备配置文件* 对话框；
2. 使用 *MQTT EoN 节点* 作为配置文件名称或任何其他有意义的值；
3. 导航到 *传输配置* 选项卡并选择 *MQTT* 传输类型；
4. 确保已选中“MQTT Sparkplug B 网络边缘 (EoN) 节点”复选框；
5. 输入您希望存储为属性而不是时序数据的 Sparkplug 指标的名称。此列表还应包括您可能希望从服务器端更新并推送到设备的指标。支持简单的星号后缀作为通配符。例如：“节点控制/*”、“设备控制/*”、“属性/*”。

{% include images-gallery.html imageCollection="sparkplug-create-device-profile" %}

### 步骤 2. 配置 EoN 节点凭据

1. 导航到 *实体 -> 设备* 页面，然后单击设备表标题中的“+”图标以打开 *添加新设备* 对话框；
2. 输入您的 EoN 节点设备名称（例如 *节点 1*）并选择现有设备配置文件：*MQTT EoN 节点*。
3. 创建设备并导航到设备详细信息。复制访问令牌。我们将在下一步中使用它。请注意，您也可以使用其他类型的 [凭据](/docs/{{docsPrefix}}user-guide/device-credentials/)。

{% include images-gallery.html imageCollection="sparkplug-create-device" %}

### 步骤 3. 启动 EoN 节点模拟器

我们已经为测试目的准备了 sparkplug 节点 [模拟器](https://github.com/thingsboard/sparkplug-emulator)。让我们启动它并连接到我们的平台实例。我们将使用上一步中的访问令牌凭据：

{% if docsPrefix == null %}
```bash
docker run -e SPARKPLUG_SERVER_URL='tcp://demo.thingsboard.io:1883' -e SPARKPLUG_CLIENT_MQTT_USERNAME='YOUR_THINGSBOARD_DEVICE_TOKEN' thingsboard/tb-sparkplug-emulator:latest
```
{: .copy-code}

别忘了用令牌的实际值替换 <code>YOUR_THINGSBOARD_DEVICE_TOKEN</code>。您还应该用您的服务器主机名替换 <code>demo.thingsboard.io</code>。
{% endif %}
{% if docsPrefix == "pe/" %}
```bash
docker run -e SPARKPLUG_SERVER_URL='tcp://YOUR_SERVER_HOSTNAME:1883' -e SPARKPLUG_CLIENT_MQTT_USERNAME='YOUR_THINGSBOARD_DEVICE_TOKEN' thingsboard/tb-sparkplug-emulator:latest
```
{: .copy-code}

别忘了用令牌的实际值替换 <code>YOUR_THINGSBOARD_DEVICE_TOKEN</code>。您还应该用您的服务器主机名替换 <code>YOUR_SERVER_HOSTNAME</code>。
{% endif %}
{% if docsPrefix == "paas/" %}
```bash
docker run -e SPARKPLUG_SERVER_URL='tcp://thingsboard.cloud:1883' -e SPARKPLUG_CLIENT_MQTT_USERNAME='YOUR_THINGSBOARD_DEVICE_TOKEN' thingsboard/tb-sparkplug-emulator:latest
```
{: .copy-code}

别忘了用令牌的实际值替换 <code>YOUR_THINGSBOARD_DEVICE_TOKEN</code>。您还应该用您的服务器主机名替换 <code>thingsboard.cloud</code>。
{% endif %}

{% capture difference %}
**请注意**
<br>
您不能在 docker 容器内使用 <code>localhost</code> 作为 <code>SPARKPLUG_SERVER_URL</code>。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if docsPrefix == null %}
![image](/images/reference/sparkplug/sparkplug-emulator-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/reference/sparkplug/sparkplug-emulator-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/reference/sparkplug/sparkplug-emulator-pe.png)
{% endif %}

模拟器成功启动后，您应该会看到以下消息：

```shell
2023-05-04 13:40:42,787 [pool-2-thread-1] INFO  o.t.sparkplug.SparkplugEmulation - Publishing [Sparkplug Node 1] NBIRTH
2023-05-04 13:40:42,815 [pool-2-thread-1] INFO  o.t.sparkplug.SparkplugEmulation - Publishing [Sparkplug Device 1] DBIRTH
2023-05-04 13:40:42,816 [pool-2-thread-1] INFO  o.t.sparkplug.SparkplugEmulation - Publishing [Sparkplug Device 2] DBIRTH
```

### 步骤 4. 观察设备指标作为属性和遥测

导航到 EoN 节点设备（例如 *节点 1*）的详细信息并打开 *最新遥测* 选项卡。您应该会看到设备指标，例如 *当前电网电压*。导航到 *属性* 选项卡并选择 *共享属性* 范围。您将看到您之前在 [步骤 1](#step-1-create-device-profile)（第 5 项）中配置的指标。

{% include images-gallery.html imageCollection="sparkplug-create-device-telemetry-and-attributes" %}

刷新 *设备* 页面并注意模拟器创建了两个新的 Sparkplug 设备：“Sparkplug 设备 1”和“Sparkplug 设备 2”。这两个设备都有自己的属性和遥测值，这些值由模拟器生成。

此外，为这两个新设备创建了一个单独的设备配置文件，其名称由您的 Sparkplug 节点名称 + “设备”组成。

{% include images-gallery.html imageCollection="sparkplug-create-two-devices" %}

### 步骤 5. 将更新从 GridLinks 服务器推送到 MQTT EON 和设备的 Sparkplug 指标

您可以通过共享属性更新或 RPC 命令从 GridLinks 将更新推送到 Sparkplug 节点/设备指标。

#### 使用共享属性更新指标

GridLinks [共享属性](/docs/{{docsPrefix}}user-guide/attributes/#shared-attributes) 用于向设备传递指标值更新。您可以通过多种方式更改共享属性 - 通过管理 UI、仪表板小部件、REST API 或规则引擎节点。

<br>
让我们手动更改属性“*输出/LED/绿色*”和“*设备控制/扫描速率*”的值。

要更改属性“输出/LED/绿色”的值，您首先需要将特定指标添加到 *MQTT EoN 节点* 设备配置文件中，以将其存储为共享属性而不是遥测。在 *传输配置* 选项卡中，添加一个新的 Sparkplug 指标名称 — “*输出/*”*。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-1" %}

返回 *设备* 页面并选择 *Sparkplug 设备 1*。在 *共享属性* 选项卡上，您将看到两个新属性：“*输出/LED/绿色*”的值为“*true*”和“*输出/LED/黄色*”的值为“*false*”。这些是存储为属性的指标，我们可以修改并将其值发送到设备。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-2" %}

单击“铅笔”图标并将属性“*输出/LED/绿色*”的值从“true”更改为“false”，方法是取消选中相应的框。然后，单击更新。一个名为“*输出/LED/绿色*”且值为“*false*”的属性从服务器发送到设备“*Sparkplug 设备 1*”。

在运行模拟器的 *终端* 中，您应该会看到以下消息：

```shell
2023-05-04 14:09:00,417 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Message Arrived on topic spBv1.0/Sparkplug Group 1/DCMD/Sparkplug Node 1/Sparkplug Device 1
2023-05-04 14:09:00,417 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Command: [DCMD]  nodeDeviceId: [Sparkplug Device 1]
2023-05-04 14:09:00,417 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Metric [Outputs/LEDs/Green] value [false]
```

如您所见，“*输出/LED/绿色*”的新属性值已成功发送到设备。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-3" %}

现在让我们更改“*设备控制/扫描速率*”属性的值。单击“铅笔”图标并将值从“*60000*”更改为“*30000*”。单击更新。

当“*设备控制/扫描速率*”属性的新值发送到“*Sparkplug 设备 1*”设备时，您将在 *终端* 中看到以下消息：

```shell
2023-05-04 14:16:51,715 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Message Arrived on topic spBv1.0/Sparkplug Group 1/DCMD/Sparkplug Node 1/Sparkplug Device 1
2023-05-04 14:16:51,715 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Command: [DCMD]  nodeDeviceId: [Sparkplug Device 1]
2023-05-04 14:16:51,715 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Metric [Device Control/Scan Rate] value [30000]
```

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-4" %}

“*输出/LED/绿色*”和“*设备控制/扫描速率*”的属性值已更改并发送到“*Sparkplug 设备 1*”设备。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-shared-attributes-5" %}

#### 使用 GridLinks RPC 命令从服务器更新指标到 MQTT EON/设备

GridLinks 支持使用 RPC（远程过程调用）功能按需更新 Sparkplug EoN 节点或设备的指标。我们还使用术语“命令”而不是 RPC 以简化。
您可以使用 REST API、仪表板小部件、规则引擎或自定义脚本发送命令。
有关命令的结构，请参阅此处记录 [here](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc)。

命令的关键属性是 *方法* 和 *参数*。
*方法* 定义 Sparkplug 操作，可以是以下之一：

 * NCMD - 命令到 EoN 节点；
 * DCMD - 命令到 EoN 设备；

*参数* 是一个 JSON，用于定义指标和值。

例如，要重新启动 Sparkplug EoN *节点*，您应该发送以下命令：

  ```json
  {
    "method": "NCMD",
    "params": {"metricName": "Node Control/Reboot", "value": true}
  }
  ```
  {: .copy-code}

要重新启动 Sparkplug EoN *设备*，您应该发送以下命令： 

  ```json
  {
    "method": "DCMD",
    "params": {"metricName": "Device Control/Reboot", "value": true}
  }
  ```
  {: .copy-code}

在此示例中，我们将使用“*RPC 按钮*”小部件重新启动 *Sparkplug EoN 节点*。请参阅以下带有屏幕截图的分步指南。

转到 *仪表板* 页面并创建一个名为 *Sparkplug* 的新仪表板。打开仪表板并通过单击 *实体别名* 图标添加新别名。
将别名命名为（例如 *EoN 节点*），选择过滤器类型“*单个实体*”、“*设备*”并选择 *节点 1*。按添加，然后按保存。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-the-thingsboard-rpc-command-1" %}

现在创建一个新小部件。单击“添加新小部件”，从下拉菜单中选择 *控制小部件* 捆绑包，然后选择 *RPC 按钮* 小部件。在 *数据* 字段中选择创建的别名（EoN 节点）。
转到 *高级* 选项卡并输入 *按钮标签* - REBOOT NODE。在 *RPC 设置* 中输入 *RPC 方法* - “NCMD”（命令到 EoN 节点）和 *RPC 方法参数* - “*{"metricName": "Node Control/Reboot", "value": true}*”。单击添加并保存更改。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-the-thingsboard-rpc-command-2" %}

现在单击小部件上的“*REBOOT NODE*”按钮。RPC 命令名称为“Node Control/Reboot”且值为“true”从服务器发送到节点“*Sparkplug Node 1*”。

{% include images-gallery.html imageCollection="sparkplug-update-metrics-using-the-thingsboard-rpc-command-3" %}

在运行模拟器的 *终端* 中，您应该会看到以下消息：

```shell
2023-05-04 14:27:02,215 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Message Arrived on topic spBv1.0/Sparkplug Group 1/NCMD/Sparkplug Node 1
2023-05-04 14:27:02,215 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Command: [NCMD]  nodeDeviceId: [Sparkplug Node 1]
2023-05-04 14:27:02,215 [MQTT Call: Sparkplug Node 1] INFO  o.t.sparkplug.SparkplugMqttCallback - Metric [Node Control/Reboot] value [true]
```

*Sparkplug EoN 节点 1* 已重新启动。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}