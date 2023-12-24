{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client 库](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 简介
![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
Orange Pi Zero 适用于想要开始利用技术进行创作，而不仅仅是消费技术的人员。它是一款简单、有趣、实用的工具，可用于开始掌控周围的世界。
Orange Pi Zero 是一款开源单板计算机。它非常紧凑，尺寸为 48X46 毫米。它可以运行 Android 4.4、Ubuntu、Debian。Orange Pi Zero 使用 AllWinner H2 SoC，并具有 256MB/512MB DDR3 SDRAM（256MB 版本为标准版本），它集成了 TF 卡、100 以太网网络、USB 2.0、26 针接头等。它通过 USB OTG 供电。

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