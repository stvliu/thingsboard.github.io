### 设备配置

要连接并发送数据，我们应该配置设备和网络服务器。  
首先，我们将配置设备，并保存网络服务器配置所需的信息。  
要将设备添加到网络服务器并从中获取信息，我们需要以下设备参数：  
- **设备 EUI** - 设备标识符
- **应用 EUI** - 应用标识符
- **应用密钥** - 应用密钥用于识别设备。我们建议使用生成的密钥，而不是示例中的密钥！  

以上参数是连接所必需的。  

根据网络服务器，您可能还需要提供加入类型 (OTAA)、LoRaWAN 版本。  

要通过 NFC 配置设备，您需要像下图一样握住智能手机：  
![NFC 区域](/images/devices-library/ready-to-go-devices/ws202-pir-and-light-sensor/nfc-area.png)  
<br>

要在设备上读取和写入配置，您可以在智能手机上按照以下步骤操作：  
{% assign readWriteConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/ws202-pir-and-light-sensor/toolbox-application.png,
        title: 打开 **ToolBox** 应用。
    ===
        image: /images/devices-library/ready-to-go-devices/ws202-pir-and-light-sensor/toolbox-read-success.png,
        title: 点击 **NFC 读取** 按钮，并将智能手机靠近设备。
    ===
        image: /images/devices-library/ready-to-go-devices/ws202-pir-and-light-sensor/toolbox-configuration.png,
        title: 转到 **设置** 选项卡，设置并保存所需字段和任何其他您需要的配置。
    ===
        image: /images/devices-library/ready-to-go-devices/ws202-pir-and-light-sensor/toolbox-write-success.png,
        title: 按下 **写入** 按钮，并将智能手机靠近设备。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=readWriteConfiguration %}

如果您在没有保护壳的情况下配置设备和智能手机时遇到一些问题 - 制造商建议尝试在没有保护壳的情况下配置智能手机。  

现在，设备能够向网络服务器发送数据。