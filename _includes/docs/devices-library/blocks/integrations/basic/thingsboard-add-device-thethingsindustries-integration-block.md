### 在 The Things Industries 上添加设备

我们需要在 The Things Industries 云上添加一个设备。

要添加设备，您可以按照以下步骤操作：

{% assign addDeviceSteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/1-login-page.png,
        title: 登录云并打开控制台。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/2-cloud-console.png,
        title: 选择 **网关**。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/3-gateway-list.png,
        title: 按 **+ 注册网关** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/4-register-gateway.png,
        title: 输入有关网关的信息（网关 EUI）。然后单击 **注册网关** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsindustries/5-gateway-info.png,
        title: 网关已添加，复制并保存 **网关服务器地址**，我们稍后会用到它。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceSteps %}


{% include /docs/devices-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="thethingsindustries" %}