{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client 库](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 简介

![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
Raspberry Pi Zero W 是一款小巧、低成本且功能强大的单板计算机，专为 DIY 爱好者、业余爱好者和创客设计。
它是广受欢迎的 Raspberry Pi Zero 的一个变体，以其小巧的尺寸和经济实惠的价格而闻名。
Raspberry Pi Zero W 中的“W”代表“无线”，因为它配备了 WIFI 和蓝牙连接功能。
这使它能够轻松连接到互联网、其他设备以及各种传感器和外围设备。
尽管体积小巧（仅为 65mm x 30mm x 5mm），但 Raspberry Pi Zero W 却功能强大，包括一个时钟速度为 1GHz 的 Broadcom BCM2835 处理器、512MB RAM、一个 mini-HDMI 端口、一个用于供电和数据传输的 micro-USB 端口、一个 CSI 相机连接器和一个用于与外部组件连接的 40 针 GPIO 接头。
Raspberry Pi Zero W 运行流行的基于 Linux 的操作系统 Raspbian，并且与各种软件、工具和编程语言兼容。
这使其成为学习、原型设计和构建各种项目的理想平台，例如家庭自动化系统、机器人、媒体中心等。

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