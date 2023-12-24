{% assign boardLedCount = 1 %}
{% assign hasCamera = "true" %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign arduinoBoardPath = "**M5Stack** > **M5TimerCAM**（或在较旧的 ESP-IDF 版本中为 M5Stack-Timer-CAM）" %}
{% assign prerequisites = "
- [" | append: deviceName | append: "](https://shop.m5stack.com/collections/m5-cameras/products/esp32-psram-timer-camera-fisheye-ov3660)
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[M5Stack Timer Camera F](https://shop.m5stack.com/collections/m5-cameras/products/esp32-psram-timer-camera-fisheye-ov3660) 是一款基于 ESP32-D0WDQ6-V3 的鱼眼摄像头模块，板上带有 8M PSRAM 和 4M Flash。  
可以拍摄 300 万像素摄像头（OV3660），DFOV 120°，最大分辨率为 2048x1536 的照片。  
该摄像头采用超低功耗设计，内部集成的 RTC（BM8563）发出 IRQ 信号，可用于睡眠和定时唤醒（睡眠电流低至 2μA）。  
内置 270mAh 电池，启用定时拍照（每小时一张）后，电池续航时间超过一个月。  
该模块支持 Wi-Fi 图像传输和 USB 端口调试，底部的 HY2.0-4P 输出可用于扩展其他外围设备。  
板载 LED 状态指示灯和复位按钮便于程序开发和调试。  

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/m5stack-arduino-library-install-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/microcontrollers/camera-code-to-program-block.md %}

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