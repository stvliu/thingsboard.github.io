在浏览器中打开平台实例或 ThingsBoard [云]({{thingsboardInstanceLink}}){:target="_blank"}，并以租户管理员身份登录。

{% assign deviceCreation = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-device-cell-1.png,
        title: 转到“<b>设备组</b>”选项卡 -> “<b>全部</b>”，然后单击“加号”按钮以添加新设备。输入设备名称，选择现有设备配置文件或创建新设备配置文件，然后单击“<b>添加</b>”按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-create-device-cell-2.png,
        title: 您的设备已创建。打开其详细信息，然后单击“复制访问令牌”按钮复制自动生成的<b>访问令牌</b>。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceCreation %}