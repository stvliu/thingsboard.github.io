{% assign deviceName = page.title | remove: "如何连接 " | remove: "到 GridLinks？" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client 库](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 简介
![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
BeagleBone Black 是一个低成本、社区支持的开发平台，适合专业人士和业余爱好者。
在不到 10 秒的时间内启动 Linux，只需一根 USB 电缆即可开始开发项目。
BeagleBone Black 是 BeagleBoard.org 系列的最新产品，与它的前辈一样，面向开源开发社区、早期采用者以及任何对低成本 ARM Cortex-A8 处理器感兴趣的人。
它配备了一组最少的功能，使用户能够体验处理器的强大功能，并不打算成为一个成熟的开发平台，因为处理器提供的许多功能和接口都无法通过嵌入式系统在 BeagleBone Black 上使用。它不是旨在执行任何特定功能的完整产品。这是进行实验和学习如何对处理器进行编程以及通过创建自己的软件和硬件来访问外围设备的基础。它还提供了对许多接口的访问，并允许使用其他扩展板来添加许多不同的功能组合。用户还可以设计自己的电路板或添加自己的电路。

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