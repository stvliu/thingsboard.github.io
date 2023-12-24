您的电脑必须与网关 192.168.1.XXX 处于同一网络。如果不是这种情况，请更改电脑的 IP 地址。

{% capture infoWired %}
<body>
  <p>
    <b style="color:red">警告：</b>
    <span style="color:black">不要使用网络上设备已使用的 IP 地址！</span>
  </p>
</body>
{% endcapture %}
{% include templates/warn-banner.md content=infoWired %}

**对于 Windows：**
1. 转到 **“控制面板”** → **“网络和 Internet”** → **“网络和共享中心”**，然后单击 **“以太网”**（可能名称不同）；
2. 导航到 **“属性”** → **“Internet 协议版本 4(TCP/IPv4)”** 并选择 **“使用以下 IP 地址”**，然后在网关的同一子网中手动分配一个静态 IP；
3. 通过输入其 IP 地址 192.168.1.1 使用浏览器转到 Web 界面；
4. 要进入路由器的 Web 界面 (WebUI)，请在 Internet 浏览器的 URL 字段中输入 **http://192.168.1.1**；
5. 当提示进行身份验证时，输入用户名 admin 并输入设备信息标签/铭牌上的密码；
6. 登录后，出于安全原因，您必须设置一个新密码。在更改默认密码之前，您将无法与路由器的 WebUI 进行交互；
7. 接下来，配置向导将帮助您设置路由器的一些主要操作参数。

![](/images/devices-library/ready-to-go-devices/teltonika-rut955/wired-connection-1.png)
<br><br>

**对于 macOS：**
1. 转到 **“系统设置”** > **“网络”**，然后单击 **“USB 10/100/1000 LAN”**（可能名称不同）；
2. 导航到 **“详细信息...”** > **“TCP/IP”** 并选择 **“手动”**，然后在网关的同一子网中手动分配一个静态 IP；
3. 通过输入其 IP 地址 192.168.1.1 使用浏览器转到 Web 界面；
4. 要进入路由器的 Web 界面 (WebUI)，请在 Internet 浏览器的 URL 字段中输入 **http://192.168.1.1**；
5. 当提示进行身份验证时，输入用户名 admin 并输入设备信息标签/铭牌上的密码；
6. 登录后，出于安全原因，您必须设置一个新密码。在更改默认密码之前，您将无法与路由器的 WebUI 进行交互；
7. 接下来，配置向导将帮助您设置路由器的一些主要操作参数。

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-macos-ip.png)
<br><br>

**对于 Ubuntu Linux：**
1. 转到 **“设置”** > **“网络”**，然后单击 **“有线设置”**（可能名称不同）；
2. 导航到 **“IPv4”** 并选择 **“手动”**，然后在网关的同一子网中手动分配一个静态 IP；
3. 通过输入其 IP 地址 192.168.1.1 使用浏览器转到 Web 界面；
4. 要进入路由器的 Web 界面 (WebUI)，请在 Internet 浏览器的 URL 字段中输入 **http://192.168.1.1**；
5. 当提示进行身份验证时，输入用户名 admin 并输入设备信息标签/铭牌上的密码；
6. 登录后，出于安全原因，您必须设置一个新密码。在更改默认密码之前，您将无法与路由器的 WebUI 进行交互；
7. 接下来，配置向导将帮助您设置路由器的一些主要操作参数。

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-linux-ip.png)
<br><br>