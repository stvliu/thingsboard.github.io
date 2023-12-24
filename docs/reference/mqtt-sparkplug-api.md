---
layout: docwithnav
assignees:
- nick
title: MQTT Sparkplug API
description: 支持的 MQTT Sparkplug API 参考，适用于物联网设备

sparkplug-create-device-profile:
    0:
        image: /images/reference/sparkplug/sparkplug-create-device-profile-1-ce.png
        title: '导航到设备配置文件页面，然后单击设备配置文件表头中的“+”图标以打开添加设备配置文件对话框。使用 MQTT EoN 节点作为配置文件名称或任何其他有意义的值；'
    1:
        image: /images/reference/sparkplug/sparkplug-create-device-profile-2-ce.png
        title: '导航到传输配置选项卡并选择 MQTT 传输类型。确保已选中“MQTT Sparkplug B 边缘网络 (EoN) 节点”复选框。输入您希望存储为属性（而不是时序数据）的 Sparkplug 指标的名称。此列表还应包括您可能希望从服务器端更新并推送到设备的指标；'
    2:
        image: /images/reference/sparkplug/sparkplug-create-device-profile-3-ce.png
        title: '已创建 MQTT EoN 节点。'

sparkplug-create-device:
    0:
        image: /images/reference/sparkplug/sparkplug-create-device-1-ce.png
        title: '导航到设备页面，然后单击设备表头中的“+”图标以打开添加新设备对话框。输入您的 EoN 节点设备名称（例如，节点 1）并选择现有设备配置文件：MQTT EoN 节点。单击添加；'
    1:
        image: /images/reference/sparkplug/sparkplug-create-device-3-ce.png
        title: '导航到管理凭据并复制访问令牌。我们将在下一步中使用它。请注意，您也可以使用其他类型的凭据。'

sparkplug-create-device-telemetry-and-attributes:
    0:
        image: /images/reference/sparkplug/sparkplug-device-latest-telemetry-1-ce.png
        title: '导航到 EoN 节点设备的详细信息并打开最新遥测选项卡。您应该会看到设备指标，例如当前电网电压；'
    1:
        image: /images/reference/sparkplug/sparkplug-device-shared-attribute-1-ce.png
        title: '导航到属性选项卡并选择共享属性范围。您应该会看到您之前在步骤 1 中配置的指标。'

sparkplug-create-two-devices:
    0:
        image: /images/reference/sparkplug/sparkplug-created-two-devices-1-ce.png
        title: '导航到设备表并注意模拟器创建了两个新的 Sparkplug 设备：“Sparkplug 设备 1”和“Sparkplug 设备 2”；'
    1:
        image: /images/reference/sparkplug/sparkplug-created-two-devices-2-ce.png
        title: '两个设备都有自己的属性和遥测值，这些值由模拟器生成。'

sparkplug-update-metrics-using-shared-attributes-1:
    0:
        image: /images/reference/sparkplug/sparkplug-edit-device-profile-1-ce.png
        title: '转到配置文件 -> 设备配置文件并选择 MQTT EoN 节点设备配置文件。在传输配置选项卡中，添加新的 Sparkplug 指标名称 — “Outputs/*”。'

sparkplug-update-metrics-using-shared-attributes-2:
    0:
        image: /images/reference/sparkplug/sparkplug-new-attributes-1-ce.png
        title: '返回设备页面并选择 Sparkplug 设备 1。在共享属性选项卡上，您将看到两个新属性：“Outputs/LEDs/Green”，值为“true”，以及“Outputs/LEDs/Yellow”，值为“false”。这些是存储为属性的指标，我们可以修改它们并将值发送到设备。'

sparkplug-update-metrics-using-shared-attributes-3:
    0:
        image: /images/reference/sparkplug/sparkplug-edit-attribute-1-ce.png
        title: '单击“铅笔”图标，然后取消选中相应的框，将属性“Outputs/LEDs/Green”的值从“true”更改为“false”。然后，单击更新。'

sparkplug-update-metrics-using-shared-attributes-4:
    0:
        image: /images/reference/sparkplug/sparkplug-edit-attribute-2-ce.png
        title: '现在让我们更改“设备控制/扫描速率”属性的值。单击“铅笔”图标并将值从“60000”更改为“30000”。单击更新。'

sparkplug-update-metrics-using-shared-attributes-5:
    0:
        image: /images/reference/sparkplug/sparkplug-edit-attribute-3-ce.png
        title: '已成功将“Outputs/LEDs/Green”和“Device Control/Scan Rate”的新属性值发送到设备。'

sparkplug-update-metrics-using-the-thingsboard-rpc-command-1:
    0:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-1-ce.png
        title: '转到仪表板页面并创建一个名为 Sparkplug 的新仪表板；'
    1:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-2-ce.png
        title: '打开仪表板并通过单击右上角的实体别名图标添加别名。命名别名（例如，EoN 节点），选择过滤器类型“单个实体”，键入“设备”并选择我们的节点 1。按添加，然后按保存。'

sparkplug-update-metrics-using-the-thingsboard-rpc-command-2:
    0:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-3-ce.png
        title: '单击“添加新小部件”；'
    1:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-4-ce.png
        title: '从下拉菜单中选择“控制小部件”；'
    2:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-5-ce.png
        title: '选择“RPC 按钮”小部件；'
    3:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-6-ce.png
        title: '在数据字段中选择创建的别名；'
    4:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-7-ce.png
        title: '转到“高级”选项卡并输入按钮标签。在 RPC 设置中输入“RPC 方法”（向 EoN 节点发送的命令）和“RPC 方法参数”。单击添加；'
    5:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-8-ce.png
        title: '保存更改。'

sparkplug-update-metrics-using-the-thingsboard-rpc-command-3:
    0:
        image: /images/reference/sparkplug/sparkplug-create-new-dashboard-9-ce.png
        title: '单击小部件上的“重新启动节点”按钮。在终端中，您将看到一条消息，指示已向设备发送 RPC 命令，并且 Sparkplug EoN 节点 1 已重新启动。'

---

{% include docs/reference/mqtt-sparkplug-api.md %}