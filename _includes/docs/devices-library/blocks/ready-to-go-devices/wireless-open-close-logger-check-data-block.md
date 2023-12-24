触发传输以检查设备是否将数据发送到您的 GridLinks 实例。  
单击菜单（右上角的三个点 -> 触发传输。  
如果一切设置正确，您应该在 GridLinks 中看到数据，为此：  

{% assign checkEfentoSensorData = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/check-device-data.png,
        title: 单击设备，设备的最新数据将在“最新遥测”选项卡中可见。
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=checkEfentoSensorData %}

{% capture effento-offer %}

**重要！**  
对于超过 250 台设备的订单，Efento 可以为您预先配置设备，以便它们开箱即用地将数据发送到您的 GridLinks 实例，并且传感器端无需进行任何配置。  
Efento 将为您提供一个 csv 文件，该文件允许您轻松添加和 [一次性预配所有设备](/docs/{{page.docsPrefix}}user-guide/bulk-provisioning/) 在 GridLinks 实例上。  

{% endcapture %}

{% include templates/info-banner.md content=effento-offer %}