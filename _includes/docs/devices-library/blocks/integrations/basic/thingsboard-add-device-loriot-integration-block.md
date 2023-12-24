### 在 Loriot 上添加设备

我们需要在 [Loriot](https://loriot.io){: target="_blank"} 上添加一个设备。

若要添加设备，可以按照以下步骤操作：

{% assign addDeviceSteps = '
    ===
        image: /images/devices-library/basic/integrations/loriot/main-page.png,
        title: 登录 Loriot 服务器。我们使用 **eu2.loriot.io**，但它取决于注册期间选择的区域。
    ===
        image: /images/devices-library/basic/integrations/loriot/create-device-step-0.png,
        title: 转到左侧菜单中的 **应用程序** 页面。
    ===
        image: /images/devices-library/basic/integrations/loriot/create-device-step-1.png,
        title: 打开您的应用程序，在我们的示例中是 **SampleApp**。
    ===
        image: /images/devices-library/basic/integrations/loriot/create-device-step-2.png,
        title: 使用设备中的配置填写字段。然后单击 **注册** 按钮。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceSteps %}


{% include /docs/devices-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="loriot" %}