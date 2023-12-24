在您成功完成上述所有步骤且 {{deviceName}} 发送数据后，您可以在设备遥测选项卡中看到它：

{% assign deviceTelemetryCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-1-ce.png,
        title: 单击表格中的设备行以打开设备详细信息；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-3-ce.png,
        title: 导航到遥测选项卡。
    '
%}

{% assign deviceTelemetryPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-1-pe.png,
        title: 单击表格中的设备行以打开设备详细信息；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-3-pe.png,
        title: 导航到遥测选项卡。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceTelemetryCE %}
{% endif %}

让我们在仪表板上显示 {{deviceName}} 属性和遥测。为此，您可以使用自定义小部件创建自己的仪表板，或使用现成的仪表板并简单地导入它。