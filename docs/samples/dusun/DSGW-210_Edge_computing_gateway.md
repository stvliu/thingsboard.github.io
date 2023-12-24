## 简介
本文包含有关如何配置 GridLinks IoT 平台和连接 DSGW-210 网关的说明。[ThingsBoard](https://thingsboard.io/) 是一个用于数据收集、处理、可视化和设备管理的 IoT 平台。它支持云和本地部署，并且结合了可扩展性、容错性和性能，以消除 IoT 数据丢失的可能性。

DSGW-210 是具有多种协议和边缘计算功能的 IoT 网关。它为各种无线 IoT 设备提供可靠的连接。网关的模块化架构提供了自定义许多网关功能的能力，包括蜂窝、蓝牙、Wi-Fi、以太网、USB、ZigBee、Z-wave 和锂电池备份。

#### 产品摘要
•	支持 5V USB Type-C 电源
•	支持 IEEE802.11ac、IEEE802.11a、IEEE802.11n、IEEE802.11g、IEEE 802.11b 协议
•	支持 4G LTE CAT M1、CAT1
•	支持蓝牙 5.2
•	支持 ZigBee3.0
•	支持 Z-WAVE
•	一个 WAN/LAN 可变网络端口
•	支持 USB2.0
•	备用锂电池

#### 硬件框图
<img src="/images/samples/dusun/1.png" width="800" alt="Block-diagram for Cortex">



## 集成方法

### 块 1 ThingsBoard 配置
GridLinks 中的配置步骤如下所示，这里以 ThingsBoard.cloud 中的示例服务器为例

* [步骤 1.1] 注册并登录 [ThingsBoard PE](https://thingsboard.cloud/signup)

<img src="/images/samples/dusun/2.png" alt="Thingsboard login screen">

* [步骤 1.2] 切换到设备部分

<img src="/images/samples/dusun/3.png" width="800" alt="Device management choosing">

* [步骤 1.3] 按“+”按钮添加一个设备

<img src="/images/samples/dusun/4.png" width="800" alt="Press plus sign to add new device">

* [步骤 1.4] 填写设备名称，以 Test_gateway 为例，单击“is gateway”

<img src="/images/samples/dusun/5.png" width="800" alt="Device naame filling">

* [步骤 1.5] 复制访问令牌，记录下来以便网关连接到 GridLinks 云

<img src="/images/samples/dusun/6.png" width="800" alt="Press button to copy device access token">

### 块 2 设备配置
* [步骤 2.1] 使用用户名：root，密码：root 登录网关
<img src="/images/samples/dusun/7.png" width="800" alt="Authorization screen">

* [步骤 2.2] 切换到部分 IOT 服务 -> 云配置
<img src="/images/samples/dusun/8.png" width="800" alt="Choosing cloud config item from IoT Servicees menu item">

* [步骤 2.3] 填写 GridLinks 云的凭据，GridLinks 服务器：thingsboard.cloud，服务器端口：1883，访问令牌在第 1.5 节中

<img src="/images/samples/dusun/9.png" width="800" alt="Filling credentials in Cloud Config">


### 块 3 其他信息

* [步骤 3.1] 检查 GridLinks 云中的连接
* [步骤 3.1.1] 从网关的最新遥测中可以看到，连接信息已正确收到服务器中
<img src="/images/samples/dusun/10.png" width="800" alt="Latest telemetry screen">

* [步骤 3.1.2] 激活并连接附近的血氧仪，通知其数据
<img src="/images/samples/dusun/11.png" width="800" alt="Bluetooth device screen">
* [步骤 3.1.3] 设备已正确注册到 GridLinks 服务器，并且血氧仪数据已在云中收到
<img src="/images/samples/dusun/12.png" width="800" alt="Timeseries table example">
* [步骤 3.1.4] 使用另一个 Zigbee 温湿度传感器进行测试
<img src="/images/samples/dusun/13.png" width="800" alt="Added device screen">
* [步骤 3.1.5] 手动触发传感器上传数据，查看图表中上传的数据
<img src="/images/samples/dusun/14.png" width="800" alt="Timeseries bar chart example">

* [步骤 3.2] 故障排除步骤。

错误指示器

| LED 状态 | 可能的原因和解决方案 |
| ------------ | ------------ |
| 蓝色 LED 持续闪烁 | 网关正在重新启动 |
| 红色 LED 闪烁 | 网关未连接到云服务器，正在尝试重新连接 |
| 红色 LED 常亮 | 互联网已断开，用户需要检查互联网连接 |
| 黄色 LED 亮起 | 网关电池电量不足，用户需要为网关充电 |


## 联系我们

- [网关规格](https://www.dusuniot.com/iot-progammable-gateway/iot-edge-computer-gateway)

有关集成的其他问题，请咨询 sales@dusunremotes.com