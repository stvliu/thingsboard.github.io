{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client 库](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
Rock64 是一款单板计算机，旨在以小巧的外形提供强大而高效的计算解决方案。
它围绕 Rockchip RK3328 四核 ARM Cortex-A53 处理器构建，该处理器提供可靠的性能和能源效率。
该板具有 1GB、2GB 或 4GB LPDDR3 RAM，以及一个用于可扩展存储的 microSD 卡插槽。
该板还具有一个 USB 3.0 端口、一个 USB 2.0 端口和一个 40 针 GPIO 接头，使其能够与各种外围设备和传感器连接。
Rock64 运行各种操作系统，包括 Debian、Ubuntu 和 Android，这使其成为希望构建从媒体中心到家庭自动化系统等任何内容的开发人员、业余爱好者和 DIY 爱好者的绝佳选择。
其紧凑的外形、强大的性能和多功能的连接性使其成为任何需要可靠且高效的计算解决方案的项目的宝贵补充。

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