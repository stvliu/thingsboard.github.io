1. 确保无线网络连接已启用。转到 **开始** — **控制面板** — **网络和 Internet** — **网络和共享中心**。单击左侧面板中的 **更改适配器设置**，然后右键单击 **无线网络适配器**，然后选择 **启用**；
2. 检查是否自动获取 IP 和 DNS。右键单击 **无线网络适配器** 并选择 **属性**。然后选择 **Internet 协议版本 4** 并单击 **属性**；
3. 如果未选中，请选中自动获取 IP 地址和自动获取 DNS 服务器地址。单击 **确定**；
4. 通过右键单击 **无线网络适配器** 并选择 **连接** 来连接到无线网络；
5. 从列表中选择无线网络 <b>RUT955******</b> 并单击 **连接**。输入设备标签上的 WiFi 密码；
6. 要进入路由器的 Web 界面 (WebUI)，请在 Internet 浏览器的 URL 字段中输入 http://192.168.1.1；
7. 当提示进行身份验证时，输入用户名 admin 并输入设备信息标签/铭牌上的密码；
8. 登录后，出于安全原因，您必须设置一个新密码。在更改默认密码之前，您将无法与路由器的 WebUI 进行交互；
9. 接下来，配置向导将帮助您设置路由器的一些主要操作参数。

{% assign wirelessConnection = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-1.png,
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-2.png,
	===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-3.png,
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-4.png,
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-5.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=wirelessConnection %}