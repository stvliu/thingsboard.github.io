{% assign changeEntityAliasCE = '
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-1-ce.png,
        title: 打开仪表板并进入编辑模式。单击“实体别名”图标，然后在弹出窗口中单击别名旁边的“编辑别名”图标。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-2-ce.png,
        title: 在编辑别名窗口中，从下拉列表中选择您的设备并保存实体别名。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-3-ce.png,
        title: 应用所有更改。
'
%}

{% assign changeEntityAliasPE = '
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-1-pe.png,
        title: 打开仪表板并进入编辑模式。单击“实体别名”图标，然后在弹出窗口中单击别名旁边的“编辑别名”图标。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-2-pe.png,
        title: 在编辑别名窗口中，从下拉列表中选择您的设备并保存实体别名。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-3-pe.png,
        title: 应用所有更改。
'
%}

要打开导入的仪表板，请单击它。然后，您应该在仪表板的实体别名中指定您的设备。

为此，请按照以下步骤操作：

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=changeEntityAliasPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=changeEntityAliasCE %}
{% endif %}

现在，您应该能够看到来自设备的数据。