---
layout: docwithnav
title: 使用 GridLinks 通过 MQTT 控制 Raspberry Pi GPIO
description: GridLinks IoT 平台示例，用于通过 MQTT 控制 Raspberry Pi GPIO

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序允许您使用 GridLinks Web UI 控制 Raspberry Pi 设备的 GPIO。我们将观察连接到其中一个引脚的 LED 来控制 GPIO。此应用程序的目的是演示 GridLinks [RPC 功能](/docs/user-guide/rpc/)。

Raspberry Pi 将使用用 Python 编写的简单应用程序，该应用程序将通过 [MQTT](https://en.wikipedia.org/wiki/MQTT)连接到 GridLinks 服务器并侦听 RPC 命令。当前 GPIO 状态和 GPIO 控制小部件使用内置的可自定义仪表板进行可视化。

下面的视频演示了本教程的最终结果。

<br>
<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/SRnYjoS3M0Y" frameborder="0" allowfullscreen></iframe>
    </div>
</div>
<br>
<br>

{% include templates/prerequisites.md %}

## 硬件和引脚列表

- [Raspberry Pi](https://en.wikipedia.org/wiki/Raspberry_Pi) - 我们将使用 Raspberry Pi 3 Model B，但您可以使用任何其他型号。

- LED 和相应的电阻

- 2 根母对公跳线

## 接线图

由于我们的应用程序允许控制所有可用 GPIO 引脚的状态，因此我们建议将一些 LED 连接到这些引脚以提高可见性。
您可以使用此 [基本说明](https://www.raspberrypi.org/documentation/usage/gpio/)或 [另一个说明](https://projects.drogon.net/raspberry-pi/gpio-examples/tux-crossing/gpio-examples-1-a-single-led/)来连接一些 LED。

## 编程 Raspberry Pi

### 安装 MQTT 库

以下命令将安装 MQTT Python 库：

```bash
sudo pip install paho-mqtt
```

### 应用程序源代码

我们的应用程序由一个记录良好的 Python 脚本组成。

您需要修改 **THINGSBOARD_HOST** 常量以匹配您的 GridLinks 服务器安装 IP 地址或主机名。
如果您使用的是 [实时演示](https://demo.thingsboard.io/)服务器，请使用“demo.thingsboard.io”。

**ACCESS_TOKEN** 常量值对应于预置 [演示数据](/docs/samples/demo-account/#tenant-devices)中的示例 Raspberry Pi 设备。
如果您使用的是 [实时演示](https://demo.thingsboard.io/)服务器 - [获取访问令牌](/docs/user-guide/ui/devices/#manage-device-credentials)以预置“Raspberry Pi 演示设备”。

{% capture tabspec %}python-script
gpio,gpio.py,python,resources/gpio.py,/docs/samples/raspberry/resources/gpio.py{% endcapture %}
{% include tabs.html %}

### 运行应用程序

此简单命令将启动应用程序：

```bash
python gpio.py
```

## 数据可视化

为了简化本指南，我们已将“Raspberry PI GPIO 演示仪表板”包含在每个 GridLinks 安装中可用的 [演示数据](/docs/samples/demo-account/#dashboards)中。
您仍然可以修改此仪表板：调整、添加、删除小部件等。
您可以通过以租户管理员身份登录来访问此仪表板。使用

- 登录名：tenant@gridlinks.com
- 密码：tenant

在本地 GridLinks 安装的情况下。

登录后，打开 **仪表板->Raspberry PI GPIO 演示仪表板** 页面。您应该观察到设备的 GPIO 控制和状态面板的演示仪表板。
现在，您可以使用控制面板切换 GPIO 的状态。结果，您将看到设备和状态面板上的 LED 状态发生变化。

以下是“Raspberry PI GPIO 演示仪表板”的屏幕截图。

![image](/images/samples/raspberry/gpio/dashboard.png)

## 另请参阅

浏览其他 [示例](/docs/samples)或探索与 ThingsBoard 主要功能相关的指南：

- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}