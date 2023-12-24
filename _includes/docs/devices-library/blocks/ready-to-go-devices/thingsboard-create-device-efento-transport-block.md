### 创建设备配置文件

在将 Efento 传感器添加到平台之前，您需要为 Efento 设备创建一个新的设备配置文件。

{% assign deviceProfileCreationPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/create-device-profile.png,
        title: 登录您的管理员帐户并导航到<b>设备配置文件</b>部分。单击右上角的<b>+</b>图标以添加新配置文件。选择<b>创建新设备配置文件</b>。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/configure-device-profile-name.png,
        title: 填写配置文件名称（必填）并配置可选设置（规则链、队列名称、说明）。准备就绪后，按<b>下一步：传输配置</b>按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/device-profile-select-transport.png,
        title: 从<b>传输类型</b>字段的下拉菜单中选择<b>CoAP</b>，从<b>CoAP 设备类型</b>字段的下拉菜单中选择<b>Efento NB-IoT</b>，按<b>添加</b>按钮保存。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/check-device-profile-created.png,
        title: 配置文件准备就绪后，您将在<b>设备配置文件</b>部分的列表中看到它。如果您计划仅将 GridLinks 实例与 Efento 传感器一起使用，则可以将该配置文件设置为默认值。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceProfileCreationPE %}

“报警规则”和“设备配置”选项卡的配置是可选的。  
如果您想了解有关这些功能的更多信息，请参阅[文档](/docs/getting-started-guides/helloworld/){:target="_blank"}。  

### 创建设备

为了保存来自传感器的数据，我们还应该在 GridLinks 上创建一个设备。  

{% assign deviceCreationPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/create-device.png,
        title: 转到 GridLinks 的<b>设备组</b>部分。您可以创建一个新的设备组或使用默认设备组（<b>全部</b>）。单击右上角的<b>+</b>图标以添加新设备。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/configure-device-with-transport.png,
        title: 命名设备，在<b>传输类型字段</b>中选择<b>CoAP</b>。选择<b>选择现有配置文件</b>选项，并添加您最近为 Efento 传感器创建的配置文件。按<b>下一步：凭据</b>按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/configure-device-create-credentials.png,
        title: 选择<b>添加凭据</b>，并在<b>访问令牌</b>字段中设置新的访问令牌，该令牌将由传感器用于在平台中验证。请注意，每个传感器令牌必须是唯一的。令牌配置是可选的。按<b>添加</b>按钮保存。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/check-device-created.png,
        title: 添加设备后，它将出现在<b>设备组</b>部分的组<b>全部</b>列表中。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceCreationPE %}