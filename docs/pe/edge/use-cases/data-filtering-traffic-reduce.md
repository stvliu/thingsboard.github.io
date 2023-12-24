---
layout: docwithnav-pe-edge
title: 数据过滤和流量减少
description: GridLinks Edge案例#2

provisionDevicesEdge:
    0:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-1.png
        title: '登录您的ThingsBoard <b>Edge</b>实例并打开设备组页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-2.png
        title: '打开“全部”设备组。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-3.png
        title: '单击表格右上角的“添加设备”(“+”)图标。'
    3:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-4.png
        title: '输入设备名称。例如，“车载监控系统”。单击“添加”以添加设备。'
    4:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-5.png
        title: '现在您的“车载监控系统”设备应位于设备表中。'

provisionDevices:    
    0:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-6.png
        title: '登录您的<b>ThingsBoard PE</b>实例。打开<b>设备组</b>页面的<b>全部</b>组。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/provision-devices-item-7.png
        title: '确保“车载监控系统”设备位于设备列表中。'
        
rootRuleChainPreview:
    0:
        image: /images/pe/edge/use-cases/data-filtering/root-rule-chain.png

updateRootRuleChain:
    0:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-1.png
        title: '登录您的<b>ThingsBoard PE</b>实例并打开规则链模板页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-2.png
        title: '单击“打开规则链”图标以开始编辑“Edge根规则链”。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-3.png
        title: '按“脚本”字词过滤节点，并将脚本节点（转换）拖动到规则链。'
    3:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-4.png
        title: '输入节点名称，例如“转换传入消息”，并添加<b>JavaScript</b>代码（您可以从上面的代码段复制并粘贴），以仅进一步发送“距离”读数。单击“添加”以继续。'
    4:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-5.png
        title: '删除“保存时序”节点与新添加的脚本节点之间的连接。'
    5:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-6.png
        title: '将连接从“保存时序”拖动到转换脚本节点。'
    6:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-7.png
        title: '从列表中选择“成功”，然后单击“添加”按钮。'
    7:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-8.png
        title: '将连接从“转换传入消息”拖动到“推送到云”节点，然后单击“添加”按钮。'
    8:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-9.png
        title: '从列表中选择“成功”，然后单击“添加”按钮。'
    9:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-10.png
        title: '单击“应用更改”以保存当前进度。'
        
updateRootRuleChainEdge:
    0:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-11.png
        title: '登录您的ThingsBoard <b>Edge</b>实例并打开规则链页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-12.png
        title: '打开“Edge根规则链”以验证更改。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/update-root-item-13.png
        title: '您应该看到与云端相同的规则链节点配置。'

copyAccessTokenDevice:
    0:
        image: /images/pe/edge/use-cases/data-filtering/copy-access-token-item-1.png
        title: '在ThingsBoard <b>Edge</b>实例中打开设备组页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/copy-access-token-item-2.png
        title: '打开“全部”设备组。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/copy-access-token-item-3.png
        title: '单击表格中的<b>车载监控系统</b>设备行以打开设备详细信息。'
    3:
        image: /images/pe/edge/use-cases/data-filtering/copy-access-token-item-4.png  
        title: '单击“复制访问令牌”。令牌将复制到您的剪贴板。将其保存在安全的地方。'

verifyDeviceTelemetryEdge:
    0:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-1.png
        title: '在ThingsBoard <b>Edge</b>实例中打开设备组页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-2.png
        title: '打开“全部”设备组。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-3.png
        title: '单击表格中的<b>车载监控系统</b>设备行以打开设备详细信息。'
    3:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-4.png
        title: '单击选项卡<b>最新遥测</b>。您应该会看到Python脚本不断生成的遥测。'

verifyDeviceTelemetry:
    0:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-5.png
        title: '登录您的<b>ThingsBoard PE</b>实例并打开设备组页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-6.png
        title: '打开<b>全部</b>设备组。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-7.png
        title: '单击行<b>车载监控系统</b>以打开设备详细信息。'
    3:
        image: /images/pe/edge/use-cases/data-filtering/verify-device-telemetry-item-8.png
        title: '单击选项卡<b>最新遥测</b>以验证距离读数已从边缘成功推送到云端。'

createDashboard:
    0:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-1.png
        title: '登录您的<b>ThingsBoard PE</b>实例并打开“仪表板组”页面。'
    1:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-2.png
        title: '单击右上角的“添加实体组”(“+”)图标。输入名称“Edge仪表板”，然后单击“添加”。'
    2:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-3.png
        title: '单击“打开”图标打开“Edge仪表板”组。'
    3:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-4.png
        title: '单击“添加”(“+”)图标。输入新仪表板的标题，例如“Edge车辆”，然后单击“添加”。'
    4:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-5.png
        title: '单击新创建的仪表板的“打开仪表板”图标。'
    5:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-6.png
        title: '要开始编辑仪表板，请单击右下角的“编辑”图标。'
    6:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-7.png
        title: '单击“实体别名”图标以添加新的<a href="/docs/user-guide/ui/aliases/" target="_blank">别名</a>，以便在仪表板上可视化数据。'
    7:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-8.png
        title: '单击“添加别名”按钮。'
    8:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-9.png
        title: '输入别名名称“edge device”。选择过滤器类型 - “单个实体”，类型 - “设备”，设备 - “车载监控系统”。然后单击“添加”按钮。'
    9:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-10.png
        title: '单击“保存”按钮以保存新别名。'
    10:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-11.png
        title: '单击仪表板页面中间的“添加新小组件”。'
    11:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-12.png
        title: '单击“选择小组件包”并查找“数字仪表”。'
    12:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-13.png
        title: '在可用小组件列表中选择您在图像上看到的小组件。单击“+ 添加”按钮为小组件添加数据源。'
    13:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-14.png
        title: '单击“+ 添加”按钮添加新数据源。'
    14:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-15.png
        title: '选择实体别名“edge device”，然后单击选择“distance”作为设备时序。'
    15:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-16.png
        title: '单击小组件右上角的“编辑小组件”图标以添加样式。'
    16:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-17.png
        title: '单击“设置”选项卡，您可以选择添加一些标题、图标和显示配置，如图像所示。'
    17:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-18.png
        title: '单击“高级”选项卡，输入最大值为“1000”，单位标题为“MLS”。然后单击“应用更改”并关闭卡片。'
    18:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-19.png
        title: '您还可以通过拖动小组件的左下角来调整小组件的大小。不要忘记单击“应用更改”图标以保存当前进度。'
    19:
        image: /images/pe/edge/use-cases/data-filtering/configure-dashboards-item-20.png
        title: '您的仪表板应与您在图像上看到的一样。'

---
* TOC
{:toc}

{% assign cloudDocsPrefix = "pe/" %}
{% assign docsPrefix = "pe/edge/" %}
{% assign appPrefix = "ThingsBoard PE" %}

## 案例

{% include templates/edge/use-cases/data-filtering/use-case-description.md %}

## 先决条件

{% include templates/edge/use-cases/prerequisites.md %}

## 创建设备

{% include templates/edge/use-cases/data-filtering/create-device.md %}

## 配置边缘规则引擎将过滤后的数据推送到云端

{% include templates/edge/use-cases/data-filtering/configure-edge-rule-engine.md %}

## 将设备连接到边缘并发布遥测

{% include templates/edge/use-cases/data-filtering/connect-device-to-edge.md %}

## 创建仪表板

{% include templates/edge/use-cases/data-filtering/create-dashboard.md %}

## 后续步骤

{% assign currentGuide = "ManageAlarmsAndRpcRequestsOnEdgeDevices" %}
{% include templates/edge/guides-banner-edge.md %}