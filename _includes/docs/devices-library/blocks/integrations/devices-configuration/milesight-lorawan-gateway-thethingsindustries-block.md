### 配置网关以发送数据

要连接并向 The Things Industries 云发送数据，我们应该配置网关。  
为此，请按照以下步骤操作：  
{% assign connectGatewayToNS = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/general-settings-view.png,
        title: 打开网关控制面板
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-before.png,
        title: 单击<b>加号</b>按钮，以添加新的转发器
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-window.png,
        title: 放置来自网络服务器的<b>网关服务器地址</b>
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-after.png,
        title: 按<b>保存</b>按钮
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=connectGatewayToNS %}

现在，网关能够向网络服务器发送数据。