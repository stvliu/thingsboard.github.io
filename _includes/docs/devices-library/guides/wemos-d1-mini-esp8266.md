{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign arduinoBoardPath="**ESP8266** > **LOLIN(WEMOS) D1 R2 & mini**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

WEMOS D1 mini 基于 32 位 ESP8266 微控制器，并具有 WiFi 模块。
该设备的闪存容量达到 4 MB。
改进后的 WEMOS D1 mini 型号具有 16 MB 内存、SMD 天线和用于连接外部天线的输出。
两种类型的电路板的尺寸和触点位置相同。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/microcontrollers/esp8266-arduino-library-install-block.md %}

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