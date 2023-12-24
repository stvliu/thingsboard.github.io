成功发布属性和遥测数据后，您应该立即在设备遥测选项卡中看到它们：

{% assign deviceTelemetryCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-1-ce.png,
        title: 单击表中的设备行以打开设备详细信息。
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-2-ce.png,
        title: 导航到遥测选项卡。
    '
%}

{% assign deviceTelemetryPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-1-pe.png,
        title: 单击表中的设备行以打开设备详细信息。
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-2-pe.png,
        title: 导航到遥测选项卡。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryCE %}
{% endif %} 

此外，我们还可以在仪表板上显示单板计算机属性和遥测。为此，您可以使用自定义小部件创建自己的仪表板，或使用现成的仪表板并简单地导入它。

{% capture minicomputerstogglespec %}
导入的仪表板%,%importedDashboard%,%templates/device-library/single-board-computers/device-imported-dashboard.md%br%
新仪表板%,%newDashboard%,%templates/device-library/single-board-computers/device-new-dashboard.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="minicomputersDashboard" toggle-spec=minicomputerstogglespec %}