### 在 Chirpstack 上添加设备

我们需要在 [Chirpstack](https://chirpstack.io){: target="_blank"} 上添加一个设备。

要添加设备，您可以按照以下步骤操作：

{% assign addDeviceSteps = '
    ===
        image: /images/devices-library/basic/integrations/chirpstack/main-page.png,
        title: 登录 Chirpstack 服务器。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/add-device-profile.png,
        title: 转到 **设备配置文件** 页面，然后单击 **添加设备配置文件** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-profile.png,
        title: 填写字段，然后单击 **提交** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-step-0.png,
        title: 转到 **应用程序** 页面，单击您的应用程序，然后按 **添加设备** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-step-1.png,
        title: 使用设备配置中的值填充参数。然后选择先前创建的设备配置文件，然后单击 **提交** 按钮。
    ===
        image: /images/devices-library/basic/integrations/chirpstack/create-device-step-2.png,
        title: 将您的 **应用程序密钥** 放入字段中，然后单击 **提交** 按钮以保存设备。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addDeviceSteps %}

{% include /docs/devices-library/blocks/integrations/converters/basic/add-or-change-converter-block.md integration-type="chirpstack" %}