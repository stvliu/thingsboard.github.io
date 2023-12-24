{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client 库](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
Orange Pi 4 是一款功能强大的单板计算机 (SBC)，具有六核 Rockchip RK3399 ARM Cortex-A72/A53 CPU、4GB RAM 和千兆以太网。
它还具有 Wi-Fi 和蓝牙连接功能，以及对 4K 超高清视频播放的支持。
该板还包括一个 USB 3.0 端口、两个 USB 2.0 端口和一个 HDMI 2.0a 端口。


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