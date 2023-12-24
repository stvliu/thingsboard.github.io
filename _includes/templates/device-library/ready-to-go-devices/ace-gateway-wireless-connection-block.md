1. 转到 **网络** > **无线**，单击 **“扫描”** 按钮；
2. 选择要加入的网络；
3. 输入密码/口令（如果存在）；
4. 让新网络的名称（wwan）；
5. 在 **“设备配置”** 页面上单击 **“保存并应用”** 按钮；
6. 在 **“接口配置”** 页面上单击 **“保存并应用”** 按钮；
7. 检查 WWAN 上的新 IP 地址：
   - 在 **网络** > **接口** 中检查 WWAN 接口上的新 IP 地址。
8. 检查与互联网的连接：
   - 转到 **网络** > **诊断** 并 ping Internet 上的 “openwrt.org” 服务器。如上所述（通过连接到网络的 WAN RJ45 端口）。
9. 使用浏览器，通过输入其 IP 地址：192.168.8.1 访问 **ACE-GTW-MQTT** Web 界面；
10. 输入用户名（默认：**root**）和密码（默认：**root**），然后单击登录。

{% assign wirelessConnection = '
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-1.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-2.png,
	===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-3.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-4.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-5.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-6.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=wirelessConnection %}