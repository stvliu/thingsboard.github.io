{% assign hasDisplay = "true" %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign arduinoBoardPath = "**ESP32** > **WEMOS LOLIN32**" %}
{% assign OLEDInstallationRequired = "true" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

{{deviceName}} 是一个 ESP32 开发板，内置 128×64 像素 SSD1306 OLED 显示屏。  
该显示屏通过 I2C 通信协议与 ESP32 通信。  
ESP32 集成了天线和功率放大器、低噪声放大器、滤波器和电源管理模块。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/esp32-arduino-library-install-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/oled-example-code-to-program-block.md %}

## 在 GridLinks 上查看数据

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