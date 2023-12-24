{% assign importDashboardCE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-ce.png,
        title: 导航到“**仪表板**”页面，然后单击页面右上角的“**+**”按钮，并选择“**导入仪表板**”。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-ce.png,
        title: 在仪表板导入窗口中，上传 JSON 文件，然后单击“**导入**”按钮。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-ce.png,
        title: 仪表板已导入。
'
%}

{% assign importDashboardPE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-pe.png,
        title: 导航到“**仪表板**”页面。默认情况下，您导航到仪表板组“全部”。单击右上角的“**+**”图标。选择“**导入仪表板**”。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-pe.png,
        title: 在仪表板导入窗口中，上传 JSON 文件，然后单击“**导入**”按钮。
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-3-pe.png,
        title: 仪表板已导入。
'
%}

{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/basic/dashboard.json" %}
{% if boardLedCount == 3 %}
{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/rgb-led/dashboard.json" %}
{% endif %}

{% if hasDisplay == "true" %}
{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/display/dashboard.json" %}
{% endif %}

{% if hasCamera == "true" %}
{% assign exampleDashboardPath = "/docs/devices-library/resources/dashboards/microcontrollers/camera/dashboard.json" %}
{% endif %}

{% if include.exampleDashboardPath %}
{% assign exampleDashboardPath = include.exampleDashboardPath %}
{% endif %}

ThingsBoard 提供创建和自定义交互式可视化（仪表板）以监控和管理数据和设备的功能。  
通过 ThingsBoard 仪表板，您可以高效地管理和监控您的物联网设备和数据。因此，我们将为我们的设备创建仪表板。  

要将仪表板添加到 ThingsBoard，我们需要导入它。要导入仪表板，请按照以下步骤操作：  

- 首先下载 [检查和控制设备数据仪表板]({{exampleDashboardPath}}){:target="_blank" download="dashboard.json"} 文件。

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or  docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importDashboardPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importDashboardCE %}
{% endif %}