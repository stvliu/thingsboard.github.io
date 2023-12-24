### 配置网关以发送数据

要连接并向 Chirpstack 发送数据，我们应该配置网关。
要做到这一点，请按照以下步骤操作：
{% assign connectGatewayToNS = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/general-settings-view.png,
        title: 打开网关控制面板。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-before.png,
        title: 单击 **加号** 按钮，以添加新的转发器。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-chirpstack-configuration-window.png,
        title: 在 **服务器地址** 中输入您的服务器地址，在我们的示例中，它是 **sample.network.server.com**。
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-after.png,
        title: 按 **保存** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/gateway-added.png,
        title: 现在，您可以在 Chirpstack 上检查网关的状态，它应该处于在线状态。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=connectGatewayToNS %}

现在，网关能够向网络服务器发送数据。