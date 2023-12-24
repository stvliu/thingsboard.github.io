---
layout: docwithnav
title: 使用 NodeMCU 和 DHT11 传感器通过 MQTT 上传温度
description: GridLinks IoT 平台示例，使用 NodeMCU 和 DHT11 传感器通过 MQTT 上传温度数据。

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序执行 DHT11 传感器产生的温度和湿度值收集。
收集的数据推送到 GridLinks 以进行存储和可视化。此应用程序的目的是演示 GridLinks [数据收集 API](/docs/user-guide/telemetry/) 和 [可视化功能](/docs/user-guide/visualization/)。

DHT11 传感器连接到 [NodeMCU](https://en.wikipedia.org/wiki/NodeMCU)。NodeMCU 通过 [MQTT](https://en.wikipedia.org/wiki/MQTT) 协议将数据推送到 GridLinks 服务器。
数据使用内置的可自定义仪表板进行可视化。在 NodeMCU 上运行的应用程序使用 Lua 脚本语言编写，该语言非常简单易懂。

完成此示例/教程后，您将在以下仪表板上看到传感器数据。

![image](/images/samples/nodemcu/temperature/dashboard.png)

{% include templates/prerequisites.md %}

## 硬件和引脚列表

 - [NodeMCU V3](https://www.aliexpress.com/item/1pcs-Wireless-module-NodeMcu-Lua-WIFI-Internet-of-Things-development-board-based-ESP8266-CP2102-with-pcb/32656401198.html?spm=2114.01010208.3.1.JnJev4&ws_ab_test=searchweb0_0,searchweb201602_3_10065_10068_10000007_10084_10083_10080_10082_10081_10060_10061_10062_10056_10055_10037_10054_10033_10059_10032_10099_10078_10079_10077_10073_10097_10100_10096_10070_423_10052_10050_424_10051,searchweb201603_2&btsid=22a4a35a-c3ac-4896-b8b4-8ce38945d312) - 您可以在 [NodeMCU 概述](/docs/samples/nodemcu/) 中找到其他文档列表
 
 ![image](/images/samples/nodemcu/temperature/nodemcu-pinout.jpg)
 
 - [Keyes DHT-11](https://www.aliexpress.com/item/Smart-3pin-KEYES-KY-015-DHT-11-DHT11-Digital-Temperature-And-Relative-Humidity-Sensor-Module-PCB/32571935933.html) - 带内置电阻的 DHT-11 传感器。 

 ![image](/images/samples/nodemcu/temperature/dht-pinout.jpg)
 
 - 3 根母对母跳线

## 接线图

 ![image](/images/samples/nodemcu/temperature/schema.png)

NodeMCU 引脚 | DHT-11 引脚
-----------|-----------
NodeMCU 3.3V | DHT-11 VCC
NodeMCU GND | DHT-11 GND (-)
NodeMCU D5 | DHT-11 数据 (S)

## 对 NodeMCU 设备进行编程

我们需要下载并构建带有 Lua 解释器的 NodeMCU 固件。
此过程在 [官方文档](https://nodemcu.readthedocs.io/) 中进行了描述，有多种方法可以做到这一点。
您可以为此目的使用 [云构建服务](http://nodemcu-build.com/)，但是，我们将使用 [Docker 镜像](https://hub.docker.com/r/marcelstoer/nodemcu-build/)。

### 固件下载

使用以下命令克隆 NodeMCU 固件的官方 GitHub 存储库。

```bash
$ mkdir -p ~/samples/nodemcu
$ cd ~/samples/nodemcu
$ git clone https://github.com/nodemcu/nodemcu-firmware.git
```
可以通过更改两个文件来自定义固件：

 - ~/samples/nodemcu/nodemcu-firmware/app/include/user_config.h - 可以更改默认波特率。
 
请查找并更新以下行以指定自定义波特率。
 
```
...
#define BIT_RATE_DEFAULT BIT_RATE_115200
...
```

 - ~/samples/nodemcu/nodemcu-firmware/app/include/user_modules.h - 包含默认情况下包含的模块类型列表。

在我们的案例中，默认情况下包含所有必要的模块。但是，请检查这些模块是否已取消注释。

```
...
define LUA_USE_MODULES_DHT
...
define LUA_USE_MODULES_MQTT
...
```

### 使用 Docker 构建固件

构建 nodemcu 固件的最简单方法是为此任务使用已准备好的 docker 容器。

请访问 [docker 安装](https://docs.docker.com/engine/installation/) 页面并在您的机器上安装 docker。

安装后，您需要通过以下命令从 docker 中心下载 docker 镜像：

```bash
$ sudo docker pull marcelstoer/nodemcu-build 
```

最终通过以下命令构建固件：

```bash
$ sudo docker run --rm -ti -v ~/samples/nodemcu/nodemcu-firmware:/opt/nodemcu-firmware marcelstoer/nodemcu-build
```

生成的二进制固件位于 **~/samples/nodemcu/nodemcu-firmware/bin** 文件夹中。

### 应用程序源代码

我们的应用程序由三个 *.lua* 文件组成：

 - config.lua - 配置文件，我们在其中定义自定义配置。
   您需要修改此文件以设置您的 wifi 网络参数和 GridLinks 服务器的地址。
   - 您的 wifi 网络 SSID - wifi 网络的名称。
   - 您的 wifi 网络密码 - 网络密码。
   - thingsboard 服务器 IP - 您的 thingsboard 安装的主机。如果您使用的是 [实时演示](https://demo.thingsboard.io/) 服务器，请使用“demo.thingsboard.io”。
   - thingsboard mqtt 端口 - 1883 是默认值。
   - thingsboard 访问令牌 - DHT11_DEMO_TOKEN 是对应于预置 [演示帐户](/docs/samples/demo-account/#tenant-devices) 的默认值。
   
   如果您使用的是 [实时演示](https://demo.thingsboard.io/) 服务器 - [获取访问令牌](/docs/user-guide/ui/devices/#manage-device-credentials) 以预置“DHT11 演示设备”。
 - dht11.lua - 每 10 秒通过 MQTT 协议将温度和湿度发送到 thingsboard 服务器。
 - init.lua - 包含 config.lua 的初始化文件：

{% capture tabspec %}lua-scripts
Config,config.lua,lua,resources/config.lua,/docs/samples/nodemcu/resources/config.lua
Dht11,dht11.lua,lua,resources/dht11.lua,/docs/samples/nodemcu/resources/dht11.lua
Init,init.lua,lua,resources/init.lua,/docs/samples/nodemcu/resources/init.lua{% endcapture %}
{% include tabs.html %}

### 刷写固件

在刷写固件之前，我们需要弄清楚使用哪个串行接口与 NodeMCU 通信。

```bash
$ dmesg
...
[845270.901509] usb 3-3: ch341-uart converter now attached to ttyUSB0
...
```

在我们的案例中，**/dev/ttyUSB0** 用于通信。

为了给 NodeMCU 刷写固件，请下载并安装以下实用程序
 
 - [Esptool](https://github.com/espressif/esptool)
 - [Luatool](https://github.com/4refr0nt/luatool)

使用以下命令上传 nodemcu 固件：

```bash
$ sudo ./esptool.py -b 115200 write_flash --flash_mode dio --flash_size 32m 0x0 ~~/samples/nodemcu/nodemcu-firmware/bin/nodemcu_integer_master_*.bin --verify
```

使用以下命令上传应用程序文件：

```bash
$ sudo ./luatool.py --port /dev/ttyUSB0 -b 115200 --src config.lua --dest config.lua -v
$ sudo ./luatool.py --port /dev/ttyUSB0 -b 115200 --src dht11.lua --dest dht11.lua -v
$ sudo ./luatool.py --port /dev/ttyUSB0 -b 115200 --src init.lua --dest init.lua -v
```

### 故障排除

有时您可能会在固件上传后观察到蓝色 LED 频繁闪烁。这可能与缺少初始化数据有关。使用以下命令修复此问题：

```bash
$ sudo ./esptool.py -b 115200 write_flash --flash_mode dio --flash_size 32m 0x3fc000 ~/samples/nodemcu/nodemcu-firmware/bin/esp_init_data_default.bin --verify
```

有时您无法上传 lua 文件。尝试重置设备并在重置后的前 10 秒内再次执行命令。如果仍然不成功，请尝试从 NodeMCU 中删除 init.lua 代码：

```bash
$ sudo ./luatool.py --port /dev/ttyUSB0 -b 115200 --delete init.lua
```

## 数据可视化

为了简化本指南，我们已将“温度和湿度演示仪表板”包含在每个 GridLinks 安装中可用的 [演示数据](/docs/samples/demo-account/) 中。
您仍然可以修改此仪表板：调整、添加、删除小部件等。
您可以通过以租户管理员身份登录来访问此仪表板。使用

 - 登录：tenant@gridlinks.com
 - 密码：tenant
 
在本地 GridLinks 安装的情况下。
 
登录后，打开 **仪表板->温度和湿度演示仪表板** 页面。您应该观察到仪表板演示，其中包含来自您的设备的实时数据（类似于介绍中的仪表板图像）。
 
## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 GridLinks 主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}
 
{% include socials.html %}


## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}