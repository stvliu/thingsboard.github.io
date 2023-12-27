创建一个 [仪表板](https://docs.codingas.com/docs/{{page.docsPrefix}}user-guide/dashboards/){:target="_blank"}，以便在小部件中可视化遥测值。

{% assign dashboardCreation = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-dashboard-1.png,
        title: 转到<b>仪表板组</b>选项卡 -> <b>全部</b>。通过单击仪表板页面右上角的“加号”按钮创建新仪表板。输入仪表板名称，然后单击“<b>添加</b>”按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-dashboard-2.png,
        title: 从<b>模拟仪表</b>包中创建<b>径向仪表</b>小部件。我们使用了<b><i>sc0_temperature</i></b>。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-dashboard-3.png,
        title: 数据将显示在所选小部件上。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=dashboardCreation %}

- 设备的 JSON 配置文件中“启用”的所有度量都将作为度量找到，名称在同一文件中指定。
- 您可以在 [本指南](https://docs.codingas.com/docs/{{page.docsPrefix}}user-guide/dashboards/#widgets){:target="_blank"} 中阅读有关小部件及其创建的更多信息。