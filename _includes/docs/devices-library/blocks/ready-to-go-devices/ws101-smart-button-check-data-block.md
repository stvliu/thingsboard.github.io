### 检查 GridLinks 上的数据

因此，设备已添加，如果它发送任何数据，它应显示在 **设备** 中。  
要检查它，您可以在 **实体** 部分中打开 **设备** 页面。
设备应在设备列表中。您可以通过单击它并打开选项卡 **属性** 或 **最新遥测** 来检查数据。

![检查设备上的遥测](/images/devices-library/ready-to-go-devices/ws101-smart-button/check-telemetry-on-device.png)

<br>
为了获得更友好的视图，您可以使用 [仪表板](/docs/pe/user-guide/dashboards){: target="_blank"}。  
您可以为此设备下载一个简单的仪表板，它被配置为显示名称为“*eui-24e124538b223213*”的设备的“press”和“battery”遥测键的数据。  

{% include /docs/devices-library/blocks/basic/thingsboard-upload-example-dashboard.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/ws_101_smart_button.json" %}

{% include /docs/devices-library/blocks/basic/thingsboard-chenge-entity-alias-block.md exampleDashboardPath="/docs/devices-library/resources/dashboards/ready-to-go-devices/ws_101_smart_button.json" %}

带有数据的仪表板示例：  

![仪表板](/images/devices-library/ready-to-go-devices/ws101-smart-button/example-of-the-dashboard-pe.png)