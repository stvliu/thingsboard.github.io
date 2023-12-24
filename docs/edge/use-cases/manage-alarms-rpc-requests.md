---
layout: docwithnav-edge
title: 管理边缘设备上的警报和 RPC 请求
description: ThingsBoard Edge 案例 #1

configureAlarmRules:
    0:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-1.png
        title: '登录到您的 <b>ThingsBoard</b> 实例并打开设备配置文件页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-2.png
        title: '单击 "+" 以添加新的设备配置文件。'
    2:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-3.png
        title: '输入设备配置文件名称。例如，键入 "edge thermostat"。单击 "传输配置" 以继续。'
    3:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-4.png
        title: '对于此示例，我们将使用默认传输配置。单击 "警报规则" 以继续。'        
    4:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-5.png
        title: '单击 "添加警报规则" 按钮。'
    5:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-6.png
        title: '指定警报类型。例如，"高温"。单击 "+" 图标以添加新的警报条件。'
    6:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-7.png
        title: '单击 "添加键过滤器" 按钮。'
    7:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-8.png
        title: '选择键类型，输入键名称，选择值类型，然后单击 "添加"。'
    8:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-9.png
        title: '选择操作并输入阈值。单击 "添加"。'
    9:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-10.png
        title: '单击 "保存" 按钮。'
    10:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-11.png
        title: '单击 "添加" 按钮。'
    11:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-12.png
        title: '新创建的设备配置文件将首先显示在列表中，因为默认排序顺序是按创建时间排序。'

configureAlarmRulesEdge:
    0:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-13.png
        title: '登录到您的 ThingsBoard <b>Edge</b> 实例并打开设备配置文件页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/configure-rules-item-14.png
        title: '验证 "edge thermostat" 也已配置到 edge。'

provisionDevicesEdge:
    0:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-1.png
        title: '登录到您的 ThingsBoard <b>Edge</b> 实例并打开设备页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-2.png
        title: '单击表格右上角的 "添加设备" ("+") 图标。'
    2:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-3.png
        title: '输入设备名称。例如，"DHT22"。从设备配置文件列表中选择 "edge thermostat"。此时无需进行其他更改。单击 "添加" 以添加设备。'
    3:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-4.png
        title: '现在您的 "DHT22" 设备应首先列出，因为表格默认使用创建时间对设备进行排序。单击 "添加" 以添加更多设备。'
    4:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-5.png
        title: '输入设备名称。例如，"Air Conditioner"。此时无需进行其他更改。单击 "添加" 以添加设备。'
    5:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-6.png
        title: '现在您的 "Air Conditioner" 设备应首先列出，因为表格默认使用创建时间对设备进行排序。'
    6:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-7.png
        title: '单击 "DHT22" 设备行以打开设备详细信息并导航到 "关系" 选项卡。单击 "+" 图标以添加新关系。'
    7:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-8.png
        title: '指定关系类型 "管理"，然后从列表中选择 "Air Conditioner" 设备。单击 "添加" 以添加此关系。现在我们验证设备是否已配置到云端。'

provisionDevices:    
    0:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-10.png
        title: '登录到您的 <b>ThingsBoard</b> 实例并打开设备页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-11.png
        title: '确保 "DHT22" 和 "Air Conditioner" 设备在设备列表中。'
    2:
        image: /images/edge/use-cases/manage-alarms/provision-devices-item-12.png
        title: '验证从 "DHT22" 到 "Air Conditioner" 的关系也已配置。'

rootRuleChainPreview:
    0:
        image: /images/edge/use-cases/manage-alarms/root-rule-chain.png

updateRootRuleChain:
    0:
        image: /images/edge/use-cases/manage-alarms/update-root-item-1.png
        title: '登录到您的 <b>ThingsBoard</b> 实例并打开规则链模板页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/update-root-item-2.png
        title: '打开默认的 "Edge Root Rule Chain"。'
    2:
        image: /images/edge/use-cases/manage-alarms/update-root-item-3.png
        title: '按 "脚本" 一词过滤节点，并将脚本节点（转换）拖动到规则链。'
    3:
        image: /images/edge/use-cases/manage-alarms/update-root-item-4.png
        title: '输入节点名称并添加 <b>JavaScript</b> 代码（您可以从上面的代码段中复制并粘贴），以创建适用于 Air Conditioner 设备的正确 <b>启用</b> 命令。单击 "添加" 以继续。'
    4:
        image: /images/edge/use-cases/manage-alarms/update-root-item-5.png
        title: '将连接从 "设备配置文件节点" 拖动到新添加的 <b>启用</b> 脚本节点。'
    5:
        image: /images/edge/use-cases/manage-alarms/update-root-item-6.png
        title: '从列表中选择 "警报已创建"，然后单击 "添加" 按钮。'
    6:
        image: /images/edge/use-cases/manage-alarms/update-root-item-7.png
        title: '单击 "应用更改" 以保存当前进度。'
    7:
        image: /images/edge/use-cases/manage-alarms/update-root-item-8.png
        title: '按 "更改" 一词过滤规则节点，并将 "更改发起者" 节点添加到规则链。'
    8:
        image: /images/edge/use-cases/manage-alarms/update-root-item-9.png
        title: '选择 "相关" 源。选择 "管理" 过滤器。选择 "设备" 类型。单击 "添加"。'
    9:
        image: /images/edge/use-cases/manage-alarms/update-root-item-10.png
        title: '从脚本节点向更改发起者添加 "成功" 关系。从更改发起者向 RPC 调用请求节点添加 "成功" 关系。保存更改。'

updateRootRuleChainEdge:
    0:
        image: /images/edge/use-cases/manage-alarms/update-root-item-11.png
        title: '登录到您的 ThingsBoard <b>Edge</b> 实例并打开规则链页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/update-root-item-12.png
        title: '打开 "Edge root rule chain" 以验证更改。'
    2:
        image: /images/edge/use-cases/manage-alarms/update-root-item-13.png
        title: '验证规则链是否与您在云端更新的规则链相同。'

copyAccessTokenAirConditioner:
    0:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-1.png
        title: '在 GridLinks <b>Edge</b> 实例中打开设备页面。'
    1:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-2.png
        title: '单击表格中的 <b>Air Conditioner</b> 设备行以打开设备详细信息。'
    2:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-3.png
        title: '单击 "复制访问令牌"。令牌将复制到您的剪贴板。将其保存在安全的地方。'

copyAccessTokenDht22:
    0:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-1.png
        title: '在 GridLinks <b>Edge</b> 实例中打开设备页面。'
    2:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-4.png
        title: '单击表格中的 <b>DHT22</b> 设备行以打开设备详细信息。'
    3:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-5.png  
        title: '单击 "复制访问令牌"。令牌将复制到您的剪贴板。将其保存在安全的地方。'

deviceAlarmTab:
    0:
        image: /images/edge/use-cases/manage-alarms/copy-access-token-item-4.png
        title: '单击表格中的 <b>DHT22</b> 设备行以打开设备详细信息。'
    1:
        image: /images/edge/use-cases/manage-alarms/device-alarm-tab-item-1.png
        title: '导航到警报选项卡。'

mqttWindows:
    0:
        image: /images/edge/getting-started/mqtt-windows-item-1.png
        title: '使用以下屏幕截图中列出的属性创建新的 MQTT 客户端。'
    1:
        image: /images/edge/getting-started/mqtt-windows-item-2.png
        title: '填写主题名称和有效负载。确保有效负载是有效的 JSON 文档。单击 "发布" 按钮。'

---
* TOC
{:toc}

{% assign docsPrefix = "edge/" %}
{% assign appPrefix = "ThingsBoard" %}

## 案例

{% include templates/edge/use-cases/manage-alarms/use-case.md %}

## 先决条件

{% include templates/edge/use-cases/prerequisites.md %}

## 配置警报规则

{% include templates/edge/use-cases/manage-alarms/configure-alarm-rules.md %}

## 配置设备

{% include templates/edge/use-cases/manage-alarms/provision-devices.md %}

## 配置边缘规则引擎以处理警报并发送 RPC 调用

{% include templates/edge/use-cases/manage-alarms/configure-edge-rule-engine.md %}

## 将 "Air Conditioner" 连接到边缘并订阅 RPC 命令

{% include templates/edge/use-cases/manage-alarms/connect-air-conditioner.md %}

## 将遥测数据发布到 "DHT22" 传感器以创建警报

{% include templates/edge/use-cases/manage-alarms/post-telemetry-to-dht22.md %}

## 验证 RPC 请求是否已发送到 "Air Conditioner" 设备

{% include templates/edge/use-cases/manage-alarms/verify-rpc-request.md %}

## 后续步骤

{% assign currentGuide = "ManageAlarmsAndRpcRequestsOnEdgeDevices" %}
{% include templates/edge/guides-banner-edge.md %}