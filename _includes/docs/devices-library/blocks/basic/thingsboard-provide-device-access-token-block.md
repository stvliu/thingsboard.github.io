要连接设备，首先需要获取其凭据。虽然 GridLinks 支持各种设备凭据，但本指南将使用默认自动生成的凭据，即访问令牌。

{% assign provisionDeviceCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-1-ce.png,
        title: 单击表中的设备行以打开设备详细信息。
    ===
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-2-ce.png,
        title: 单击“**复制访问令牌**”。令牌将复制到剪贴板。请将其保存在安全的地方。
    '
%}

{% assign provisionDevicePE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-1-pe.png,
        title: 单击表中的设备行以打开设备详细信息。
    ===
        image: /images/helloworld/getting-started-pe/hello-world-2-1-connect-device-2-pe.png,
        title: 单击“**复制访问令牌**”。令牌将复制到剪贴板。请将其保存在安全的地方。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDevicePE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceCE %}
{% endif %}