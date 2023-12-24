### 配置网关以发送数据

要连接并向 Loriot 发送数据，我们应该配置网关。
要执行此操作，请按照以下步骤操作：
{% assign connectGatewayToNS = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/general-settings-view.png,
        title: 打开网关控制面板。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-before.png,
        title: 单击 **加号** 按钮，以添加新的转发器。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-loriot-configuration-window.png,
        title: 在 **服务器地址** 中输入服务器地址，在我们的案例中是 **eu2.loriot.io**。并将端口设置为 **1780**。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-after.png,
        title: 按 **保存** 按钮。
    ===
        image: /images/devices-library/basic/integrations/loriot/gateway-added-disconnected.png,
        title: 现在，您可以在 Loriot 上检查网关的状态，它应该已连接。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=connectGatewayToNS %}

现在，网关能够向网络服务器发送数据。