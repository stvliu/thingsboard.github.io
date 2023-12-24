{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client 库](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 简介
![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
Raspberry Pi 3 Model B+ 目前是您可以购买的最好的 Raspberry Pi 计算机。虽然价格保持在 35 美元，但新电路板在多个方面都优于其前身，最显着的是处理器和 Wi-Fi 更快。该电路板的联合创始人 Eben Upton 将其描述为在功率和功能方面介于 2016 年的 Raspberry Pi 3 和未来的 Raspberry Pi 4 之间。硬件改进以及对 Pi 3 B+ 官方 Raspbian 操作系统的改进，使该电路板提升到完全可以接受的日常 PC 的地位——对于一台价格与一顿饭相当的计算机来说，这是令人印象深刻的。

{% include /docs/devices-library/blocks/basic/introduction-block.md %}

## 在 GridLinks 上创建设备

{% include /docs/devices-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需的库和工具

{% include /docs/devices-library/blocks/single-board-computers/install-required-libraries-and-tools-block.md %}

## 将设备连接到 GridLinks

{% include /docs/devices-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/devices-library/blocks/single-board-computers/general-code-to-program-block.md %}

## 使用客户端和共享属性请求同步设备状态

{% include /docs/devices-library/blocks/single-board-computers/thingsboard-synchronize-device-state-using-attribute-requests-block.md %}

## 在 GridLinks 上检查数据

{% include /docs/devices-library/blocks/single-board-computers/check-data-on-thingsboard-block.md %}

## 使用共享属性控制设备

{% include /docs/devices-library/blocks/single-board-computers/update-shared-attributes-block.md %}

## 使用 RPC 控制设备

{% include /docs/devices-library/blocks/single-board-computers/using-rpc-block.md %}

## 结论

{% include /docs/devices-library/blocks/basic/conclusion-block.md %}