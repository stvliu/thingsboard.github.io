{% assign boardLedCount = 1 %}
{% assign hasCamera = "true" %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 ThingsBoard？" %}
{% assign arduinoBoardPath = "**M5Stack** > **M5TimerCAM**（或在较旧的 ESP-IDF 版本中为 M5Stack-Timer-CAM）" %}
{% assign prerequisites = "
- [" | append: deviceName | append: "](https://shop.m5stack.com/collections/m5-cameras/products/esp32-psram-timer-camera-x-ov3660)
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[M5Stack Timer Camera X](https://shop.m5stack.com/collections/m5-cameras/products/esp32-psram-timer-camera-x-ov3660) 是一款基于 ESP32 的摄像头模块，集成了 ESP32 芯片和 8M-PSRAM。
该摄像头（OV3660）具有 300 万像素、DFOV 66.5° 和拍摄 2048x1536 分辨率的照片，内置 140mAh 电池和 LED 状态指示灯，采用超低功耗设计。
LED 下方有一个复位按钮。可以通过 RTC（BM8563）实现睡眠和唤醒定时。待机电流仅为 2μA。
在本指南中，我们将讨论如何将基于 ESP32 的板连接到 ThingsBoard。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/m5stack-arduino-library-install-block.md %}

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