为简单起见，我们将使用 UI 手动提供设备。

{% assign provisionDeviceCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-1-ce.png,
        title: 登录到您的 GridLinks 实例并导航到“**实体**”。然后单击“**设备**”页面。
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-2-ce.png,
        title: 单击表格右上角的“**+**”图标，然后选择“**添加新设备**”。
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-3-ce.png,
        title: 输入设备名称。例如，“*我的设备*”。此时无需其他更改。单击“**添加**”以添加设备。
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-4-ce.png,
        title: 您的设备已添加。
    '
%}

{% assign provisionDevicePE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-1-pe.png,
        title: 登录到您的 GridLinks 实例并打开“设备”页面。
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-2-pe.png,
        title: 默认情况下，您导航到设备组“全部”。单击表格右上角的“**+**”图标，然后选择“**添加新设备**”。
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-3-pe.png,
        title: 输入设备名称。例如，“我的设备”。此时无需其他更改。单击“**添加**”以添加设备。
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-4-pe.png,
        title: 您的第一个设备已添加。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDevicePE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceCE %}
{% endif %}