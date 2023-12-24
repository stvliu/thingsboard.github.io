---
layout: docwithnav
title: 集成 Syrus 4 IoT 远程信息处理网关 - Thingsboard
description: Syrus 4 IoT 远程信息处理网关集成指南
hidetoc: "true"

---

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 说明

这是一个详细的集成示例，介绍如何通过 MQTT 连接将 Syrus 4G IoT 远程信息处理网关与 Thingsboard 平台集成。

## 入门

[Syrus 4G IoT 远程信息处理网关。](https://syrus.pegasusgateway.com/syrdocs/syrus4/getting-started/)

[Thingsboard 注册](https://demo.thingsboard.io/signup)

## 为 Thingsboard 配置设备

为简单起见，我们将使用 UI 手动配置设备。

### 1. 登录到 ThingsBoard 实例并打开“设备”页面。

![image](/images/samples/syrus/device_page.png)

单击表格右上角的“+”图标，然后选择“添加新设备”。

![image](/images/samples/syrus/add_device.png)

输入设备名称。例如，“Syrus”。此时无需进行其他更改。单击“添加”以添加设备。

![image](/images/samples/syrus/name_device.png)

现在，您的设备应首先列出，因为表格默认按创建时间对设备进行排序。

![image](/images/samples/syrus/device_details.png)

### 2. 令牌创建

要连接设备，您首先需要获取设备凭据。ThingsBoard 支持不同的设备凭据。我们建议使用本指南中作为访问令牌的默认自动生成凭据。

单击表格中的设备行以打开设备详细信息

![image](/images/samples/syrus/copy_token.png)

单击“复制访问令牌”。令牌将复制到您的剪贴板。将其保存在安全的地方。

## Syrus 4G IoT 远程信息处理网关配置

第一步是确保您拥有最新版本的 Apex OS

### 1. 准备您的系统

如果您通过 USB 电缆连接，请转到管理工具（**http://192.168.9.2**），选择“系统”并确认您已更新

![image](/images/samples/syrus/update_device.png)

现在，转到应用程序管理器并检查更新，确保您已安装最新版本的 SyrusJS 应用程序：

![image](/images/samples/syrus/js_latest.png)

### 2. 创建实例

在应用程序管理器中下拉 SyrusJS 菜单，这将向您显示已安装的所有应用程序版本，选择最新版本并创建新实例：

![image](/images/samples/syrus/new_instance.png)

为您的实例命名并选择“创建实例”按钮：

![image](/images/samples/syrus/name_instance.png)


现在，您已创建实例：

![image](/images/samples/syrus/instance_created.png)

### 3. 创建配置文件

我们需要在任何记事本应用程序（记事本++、崇高、vscode 等）上创建两个文件，您可以根据需要命名，但扩展名必须是 syrus.conf

![image](/images/samples/syrus/configuration_files.png)

一个文件包含目标数据、协议、输出格式、MQTT URI、用户名和主题。

您可以在 MQTT 传输配置中定义自定义 MQTT 主题。请参阅[传输配置](/docs/user-guide/device-profiles/#transport-configuration)

这是一个示例：

![image](/images/samples/syrus/example.png)

将 [YOUR\_TOKEN] 替换为您在创建设备时从 Thingsboard 复制的访问令牌。

有关更多信息：[https://syrus.pegasusgateway.com/syrdocs/syrus4/syruslang/#destinations](https://syrus.pegasusgateway.com/syrdocs/syrus4/syruslang/#destinations)

第二个文件包含将通过 MQTT 发送到 Thingsboard 的所有事件，这是一个示例，它将每分钟发送点火开/关事件和跟踪点：

{% highlight bash %}
_####### ###### ####### ###### #######_

_############ START MQTT EVENT ###########_

define variable constant_1 1

define fieldset thingsboard
fields="ident":$modem.imei,position.context.lat:$gnss.latitude,position.context.lng:$gnss.longitude,
position.value:$variables.constant_1,"position.direction":$gnss.heading,"position.hdop":$gnss.hdop,
"position.pdop":$gnss.pdop,"position.vdop":$gnss.vdop,"position.speed":$gnss.mph,
"position.altitude":$gnss.altitude,"event.enum":code,"can.engine.rpm":$ecu.rpm,
"can.throttle.pedal.level":$ecu.accel_pedal_position,"can.engine.temperature":$ecu.coolant_temp,
"can.fuel.consumed":$ecu.fuel_total,"can.intake.map":$ecu.intake_manif_pressure,
"can.vehicle.speed":$ecu.fe6c_7-8,"can.fuel.temperature":$ecu.fuel_temp,"can.engine.load":$ecu.engine_load,
"can.engine.torque":$ecu.actual_engine_torque,"can.catalyst.outlet.temp":$ecu.aftmt_catalyst_outlet_gas_temp
"can.fuel.rate":$ecu.fuel_rate,"can.engine.hours":$ecu.hours_total,"can.ambient.temp":$ecu.ambient_air_temp,
"can.oil.pressure":$ecu.oil_pressure

define group thingsboard

set destinations group=thingsboard thingsboard

define tracking_resolution thingsboard_tracking 5m 25deg 1000mts

define signal ignitionON min_duration=5s $io.ign == true
define signal ignitionOFF min_duration=5s $io.ign == false

define event ignitionONmqtt group=thingsboard fieldset=thingsboard ack=seq label=ignonmqtt code=102 trigger=ignitionON
define event ignitionOFFmqtt group=thingsboard fieldset=thingsboard ack=seq label=ignoffmqtt code=103 trigger=ignitionOFF
 
_# Define tracking event, a single tracking resolution signal that can be controlled by different actions

define event trackingOffMqtt group=thingsboard fieldset=thingsboard ack=seq label=prdtst code=100 trigger=@tracking_resolution.thingsboard_tracking.signal,ignitionOFF,and
define event trackingOnMqtt group=thingsboard fieldset=thingsboard ack=seq label=trckpnt code=101 trigger=@tracking_resolution.thingsboard_tracking.time,ignitionON,and
define event trackingHeadingMqtt group=thingsboard fieldset=thingsboard ack=seq label=heading code=140 trigger=@tracking_resolution.thingsboard_tracking.heading,ignitionON,and
define event trackingDistanceMqtt group=thingsboard fieldset=thingsboard ack=seq label=distance code=141 trigger=@tracking_resolution.thingsboard_tracking.distance,ignitionON,and


_############ END MQTT EVENT ###########_

_####### ###### ####### ###### #######_

define event trackingOnMqtt group=mqtt fieldset=mqtt ack=seq label=trckpnt code=101 trigger=@tracking_resolution.mqtt_tracking.time,ignitionON,and
define event trackingHeadingMqtt group=mqtt fieldset=mqtt ack=seq label=heading code=140 trigger=@tracking_resolution.mqtt_tracking.heading,ignitionON,and
define event trackingDistanceMqtt group=mqtt fieldset=mqtt ack=seq label=distance code=141 trigger=@tracking_resolution.mqtt_tracking.distance,ignitionON,and
_############ END MQTT EVENT ###########
_####### ###### ####### ###### #######
{% endhighlight %}

如果您需要有关如何配置更多事件的更多信息，请参阅 SyrusLang 文档：

[https://syrus.pegasusgateway.com/syrdocs/syrus4/syruslang](https://syrus.pegasusgateway.com/syrdocs/syrus4/syruslang)

### 4. 上传配置文件

选择您创建的实例：

![image](/images/samples/syrus/select_instance.png)

转到“数据文件夹”选项卡：

![image](/images/samples/syrus/data_tab.png)

选择“上传文件”：

![image](/images/samples/syrus/upload_file.png)

并在本地磁盘中搜索之前创建的配置文件，然后逐个上传

![image](/images/samples/syrus/upload_config.png)

转到“配置”选项卡，在“配置”和“目标文件”中下拉，选择您之前更新的项目，然后单击“保存”按钮：

![image](/images/samples/syrus/select_configuration.png)

### 5. 启动您的实例

最后，返回“信息”选项卡并单击“启动”按钮：

![image](/images/samples/syrus/information_tab.png)

## 在 Thingsboard 演示帐户中检查您的数据

报告的变量会根据字段集配置自动创建。

转到“设备”，选择 Syrus 4，然后单击“最新遥测”

![image](/images/samples/syrus/latest_telemetry.png)

现在，您可以使用 Thingsboard 的工具使用 Syrus 4G 数据设计自己的仪表板：

![image](/images/samples/syrus/dashboard.png)