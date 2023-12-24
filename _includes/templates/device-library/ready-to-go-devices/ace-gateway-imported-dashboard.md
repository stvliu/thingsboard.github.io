### 导入仪表板

您可以导入 JSON 格式的仪表板。要导入仪表板，您应转到仪表板组，然后单击页面右上角的 **“+”** 按钮，并选择 **“导入仪表板”**。仪表板导入窗口应弹出，系统将提示您上传 JSON 文件并单击 **“导入”**。

{% assign importingDashboardPE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-pe.png,
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-pe.png,
    '
%}

{% assign importingDashboardCE = '
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-1-ce.png,
    ===
        image: /images/user-guide/dashboards/managing-dashboard/import-dashboard-2-ce.png,
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importingDashboardCE %}
{% endif %}

以下，您可以找到仪表板 JSON 文件：

[检查和控制设备数据仪表板](/docs/devices-library/resources/dashboards/ready-to-go-devices/ace-dashboard.json){:target="_blank" download="ace-dashboard.json"}

导入后，我们应为我们的设备选择一个实体别名。

要执行此操作 - 我们需要按笔图标并选择实体别名，选择别名 **“我的设备”** 并按笔图标将其打开进行编辑。

然后，从下拉列表中选择名称为我的设备的设备，并保存实体别名。现在，您应能够看到来自设备的数据。

如果您正确执行了所有操作，则您必须看到以下仪表板：

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
![imagePe](/images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-gateway-dashboard.png)
{% else %}  
![imageCe](/images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-dashboard-1-ce.png)
{% endif %}