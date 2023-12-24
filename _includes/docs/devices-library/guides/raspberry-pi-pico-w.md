{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 ThingsBoard？" %}
{% assign arduinoBoardPath="**Raspberry Pi Pico/RP2040** > **Raspberry Pi Pico W**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

继广受欢迎的 Raspberry Pi Pico 之后，新的 Raspberry Pi Pico W 是基于 RP2040 的电路板的无线版本，增加了 2.4GHz 802.11n WiFi 连接。
无线连接的加入为 Pico W 开辟了大量新项目，例如远程传感器读数、远程控制、家庭自动化、小型网络服务器、无线 GPIO 引脚控制等等。
Pico W 的核心是 RP2040——与原始 Raspberry Pi Pico 中使用的芯片相同，具有两个 ARM Cortex-M0+ 内核，时钟频率为 133MHz；256KB RAM；30 个 GPIO 引脚；以及广泛的接口选项。这与 2MB 板载 QSPI 闪存配对，用于代码和数据存储。
WiFi 通过使用 Infineon CYW43439 无线芯片启用。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/raspberry-pi-pico-arduino-library-install-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 将设备连接到 ThingsBoard

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/rp2040-general-code-to-program-block.md %}

## 在 ThingsBoard 上检查数据

{% include /docs/devices-library/blocks/basic/thingsboard-upload-example-dashboard.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-check-example-data-block.md %}

## 使用客户端和共享属性请求同步设备状态

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-synchronize-device-state-using-attribute-requests-block.md %}

## 使用共享属性控制设备

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-update-shared-attributes-device-block.md %}

## 使用 RPC 控制设备

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-send-rpc-to-device-block.md %}

## 结论
{% include /docs/devices-library/blocks/basic/conclusion-block.md %}