此时，MI-8 应已配置好并可以与 GridLinks 通信。  
要检查传入的数据，您可以执行以下步骤：  

- 打开 GridLinks，然后导航至设备组，然后选择<b>全部</b>。  
- 单击刚刚与 MI-8 关联的设备，然后导航至<b>最新遥测</b>选项卡。  

![](/images/devices-library/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger/open-device-timeseries.png)

- 您还可以检查从设备接收到的属性。
    为此，请导航至**属性**选项卡。  
    属性是从 MI-8 发送到 GridLinks 的其他数据，这些数据或多或少是固定的，不会更改，例如调制解调器 IMEI、SIM ID (ICCID) 和 MI-8 固件版本。

![](/images/devices-library/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger/check-attributes.png)

一旦 MI-8 加电并能够建立蜂窝连接，则应显示在活动 MI-8 触发器中配置的所有传感器值。  
请注意，GPS 值仅在首次 GPS 定位后才会传输，具体取决于上次定位已过去多长时间以及 MI-8 自上次定位以来移动了多远。  
GPS 值（纬度、经度和高度）仅在至少传输一次后才会显示在遥测窗口中。