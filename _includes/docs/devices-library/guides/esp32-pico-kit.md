{% assign boardLedCount = 0 %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign arduinoBoardPath = "**ESP32** > **ESP32 Pico-D4** (旧名称为 ESP32 Pico 套件)" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

ESP32 PICO 套件是由 Espressif 生产的基于 ESP32 的开发板。
该开发板具有 USB 转 UART 桥电路，允许开发人员将该板连接到计算机的 USB 端口以进行刷新和调试。
官方文档可在此处获得 [此处](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/hw-reference/esp32/get-started-pico-kit-1.html)。

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