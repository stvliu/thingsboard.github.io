{% assign boardLedCount = 1 %}
{% assign hasCamera = "true" %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 ThingsBoard？" %}
{% assign arduinoBoardPath = "**M5Stack** > **M5Stack-Timer-CAM**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![ESP-EYE](/images/devices-library/esp-eye.png){: style="float: left; max-width: 150px; max-height: 150px; margin: 0px 10px 0px 10px"}
[ESP-EYE](https://www.espressif.com/en/products/devkits/esp-eye/overview) 是一款用于图像识别和音频处理的开发板，可用于各种 AIoT 应用。
它具有 ESP32 芯片、200 万像素摄像头和麦克风。ESP-EYE 提供充足的存储空间，具有 8 MB PSRAM 和 4 MB 闪存。
它还支持通过 Wi-Fi 传输图像，并通过 Micro-USB 端口进行调试。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/esp32-arduino-library-install-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 将设备连接到 ThingsBoard

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/camera-code-to-program-block.md %}

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