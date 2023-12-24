{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign arduinoBoardPath = "**ESP32** > **uPesy ESP32 WROOM DevKit**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
  %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}

[uPesy ESP32 低功耗 DevKit](https://www.upesy.com/products/upesy-esp32-wroom-low-power-devkit) 基于 ESP-WROOM-32D 模块构建，该模块是来自 Espressif 的微型高性能 Wi-Fi + BT + BLE 芯片，专为各种应用而设计，从微功率网络传感器到最复杂的应用，如编码、音乐流和 MP3 编码。  
该模块包含所有必要的最小外设，足以快速舒适地开始使用 ESP-WROOM-32 系列。  
ESP-WROOM-32D 基于流行的 ESP32 双核芯片组，可变时钟频率为 80 MHz 至 240 MHz，具有单独控制和电源的可能性。  
它具有板载闪存、40 MHz 石英和提供良好射频特性的 PCB 天线。

- **优化功耗**：这是 uPesy Wroom DevKit 板的优化版本，当 ESP32 处于深度睡眠模式时，功耗非常低。在深度睡眠模式下，功耗低于 15µA。  
- **方便**：与 uPesy Wroom Devkit 板兼容：相同尺寸，相同引脚（只有 GPIO35 引脚不可用，因为它允许估计电池电量）。  
它受益于其所有实用优势：面包板兼容、自动上传、USB C 连接器 ...  
- **内置电池充电器**：uPesy ESP32 Wroom 低功耗 DevKit 具有内置充电器，可通过 USB 连接器为锂离子/锂聚合物电池充电。  
- **可靠**：法国设计的高品质电路板。每个 uPesy ESP32 Wroom 低功耗 DevKit 板都经过单独测试，以确保其正常工作！它附带已安装的 MicroPython。  

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