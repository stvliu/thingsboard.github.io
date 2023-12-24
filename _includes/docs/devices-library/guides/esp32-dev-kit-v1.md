{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign arduinoBoardPath = "**ESP32** > **ESP32 开发模块**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

ESP32 开发套件 V1 开发套件基于 ESP-WROOM-32 模块构建，ESP-WROOM-32 模块是来自 Espressif 的新型微型高性能 Wi-Fi + BT + BLE 芯片，专为各种应用而设计，从微功率网络传感器到最复杂的应用，如编码、音乐流和 MP3 编码。  
该模块包含所有必要的最小外设，足以快速、舒适地开始使用 ESP-WROOM-32。  
ESP-WROOM-32 基于流行的 ESP32 双核芯片组，可变时钟频率为 80 MHz 至 240 MHz，具有单独控制和电源的可能性。  
该模块专为便携式和自主电子设备以及物联网应用而设计，采用微型 25.5 毫米 x 18 毫米封装。它具有板载闪存、40 MHz 石英和提供良好射频特性的 PCB 天线。  
  
{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/esp32-arduino-library-install-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/general-code-to-program-block.md %}

## 在 GridLinks 上检查数据

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