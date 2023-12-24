### 在 The Things Stack Community Edition 上添加设备

我们需要在 [The Things Stack Community Edition](https://console.cloud.thethings.network){:target="_blank"} 上添加一个设备。

要添加设备，您可以按照以下步骤操作：

{% assign addGatewaySteps = '
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/1-tts-login.png,
        title: 登录云并打开控制台。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-0.png,
        title: 转到 **应用程序** 页面。然后选择您的应用程序并单击其名称。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-1.png,
        title: 单击 **注册终端设备** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-3.png,
        title: 将 **加入 EUI** 值放入字段。您可以使用 **应用程序 EUI** 并按 **确认** 按钮。
    ===
        image: /images/devices-library/basic/integrations/thethingsstack/create-device-step-4.png,
        title: 填写其余参数并按 **注册终端设备** 按钮。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addGatewaySteps %}


{% include /docs/devices-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="thethingsstack" %}