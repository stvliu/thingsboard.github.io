{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 ThingsBoard？" %}
{% assign arduinoBoardPath="**ESP8266** > **NodeMCU 1.0 (ESP-12E 模块)**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

NodeMCU 是一个非常流行的开发板，在互联网世界中广泛使用。
它基于 ESP-12E Wi-Fi 模块，该模块与 Arduino IDE 的简单编程元素以及 Wi-Fi 功能完美结合。
内置的编程器和 CP2102 USB 转串口芯片可以顺利处理原型设计和开发项目，这些芯片可以在 PC 集成上刷新 ESP8266 和串行输出。
NodeMCU 开发板集成了 ESP8266。它是一款集成度很高的芯片，专门设计用于满足新连接世界的需求。
该单元允许托管应用程序或卸载源自另一个应用程序处理单元的所有 Wi-Fi 网络功能。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/esp8266-arduino-library-install-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 将设备连接到 ThingsBoard

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/general-code-to-program-block.md %}

## 在 ThingsBoard 上查看数据

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