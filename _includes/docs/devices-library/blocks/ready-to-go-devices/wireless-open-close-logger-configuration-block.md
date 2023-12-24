整个 Efento 传感器的配置都是通过一个免费的 Android 移动应用程序完成的。  
可以从 [Google Play](https://play.google.com/store/apps/details?id=pl.efento.cloud&hl=en) 下载应用程序。  
在开始配置之前，请确保传感器能够在 NB-IoT 网络中注册，并且 APN 设置正确。  
可以在 Efento 网站的 [支持部分](https://getefento.com/support/) 中找到 Efento NB-IoT 传感器和 Efento 移动应用程序的详细用户手册。  

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardHost = 'coap.thingsboard.cloud' %}
{% else %}
{% assign thingsboardHost = 'demo.thingsboard.io' %}
{% endif %}

{% assign efentoSensorConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-1.jpg,
        title: 下载并安装应用程序后，选择“附近传感器”模式并解锁高级用户模式：打开应用程序菜单并快速点击 Efento 徽标五次。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-2.jpg,
        title: 确保您使用的 APN 允许设备连接到运行 GridLinks 实例的服务器。您可以在 Efento 移动应用程序中检查网络状态。连接到传感器 -> 单击菜单（右上角的三个点）
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-3.jpg,
        title: 单击蜂窝网络状态。确保“注册状态”字段的值为“已注册”或“已注册漫游”
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-2.jpg,
        title: 将传感器设置为将数据发送到运行 GridLinks 实例的服务器。连接到传感器 -> 单击菜单（右上角的三个点）。
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-4.jpg,
        title: 单击高级用户 -> 服务器配置。选择“其他”并填写服务器地址（' | append: thingsboardHost | append: '）。用于 CoAP 通信的默认端口为 5683。将身份验证模式设置为“自定义令牌”，并在 GridLinks 平台上为设备输入您创建的令牌。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=efentoSensorConfiguration %}

设置传感器将向其发送数据的 CoAP 端点。单击菜单（右上角的三个点）-> 高级用户 -> CoAP 端点。将端点设置为以下值：

- 数据：“efento/m”
- 时间：“efento/t”
- 配置：“efento/c”
- 设备信息：“efento/i”

{% assign configureSensorEndpoints = '        
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-5.jpg
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=configureSensorEndpoints %}