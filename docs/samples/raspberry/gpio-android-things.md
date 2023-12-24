---
layout: docwithnav
title: 使用 Android Things 和 ThingsBoard 控制 Raspberry Pi GPIO
description: GridLinks IoT 平台示例，用于通过运行 Android Things 的 MQTT 控制 Raspberry Pi GPIO

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序允许您使用 GridLinks RPC 小部件控制 Raspberry Pi 设备的 GPIO。我们将观察连接到引脚的 LED 来控制 GPIO。此应用程序的目的是演示 GridLinks [RPC 功能](/docs/user-guide/rpc/)。

Raspberry Pi 将使用简单的 [Android Things](https://developer.android.com/things/index.html) 应用程序，该应用程序将通过 [MQTT](https://en.wikipedia.org/wiki/MQTT) 连接到 GridLinks 服务器并侦听 RPC 命令。当前 GPIO 状态和 GPIO 控制小部件使用内置的可自定义仪表板进行可视化。

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

- 11 个带有相应电阻的 LED

- 13 根母对公跳线

## 接线图

由于我们的应用程序允许我们控制所有可用 GPIO 引脚的状态，因此我们建议将一些 LED 连接到这些引脚以提高可见性。
您可以使用此 [基本说明](https://www.raspberrypi.org/documentation/usage/gpio/) 或 [另一个说明](https://projects.drogon.net/raspberry-pi/gpio-examples/tux-crossing/gpio-examples-1-a-single-led/) 来连接一些 LED。
以下是本教程中使用的示例接线图。

![image](/images/samples/raspberry/gpio-android-things/raspberry-gpio-leds.png)

## 编程 Raspberry Pi

### 烧录 Android Things 映像

首先，您需要使用此 [**指南**](https://developer.android.com/things/hardware/raspberrypi.html#flashing_the_image) 将 Android Things 映像烧录到您的 Raspberry Pi 板。
完成此指南后，确保您的电路板可以访问 Internet 并可以通过 adb 工具访问。

### Android Things 开发环境

在开始本教程中介绍的应用程序之前，您需要准备开发环境以使用 Android Things 应用程序。
按照官方 [**指南**](https://developer.android.com/things/training/first-device/index.html) 中的说明构建并部署您的第一个 Android Things 应用程序。

### 应用程序源代码

现在，您应该从 ThingsBoard 示例 GitHub 存储库获取 GpioControlSample 应用程序的源代码。
您可以通过发出以下 git clone 命令来执行此操作：

```bash
git clone https://github.com/thingsboard/samples
```

打开克隆的示例文件夹并导航到 **android-things/GpioControlSample**。

您需要修改 **THINGSBOARD_HOST** 常量以匹配您的 GridLinks 服务器安装 IP 地址或主机名。
如果您使用的是 [实时演示](https://demo.thingsboard.io/) 服务器，请使用“demo.thingsboard.io”。

**ACCESS_TOKEN** 常量的值对应于预置 [演示数据](/docs/samples/demo-account/#tenant-devices) 中的示例 Raspberry Pi 设备。
如果您使用的是 [实时演示](https://demo.thingsboard.io/) 服务器 - [获取访问令牌](/docs/user-guide/ui/devices/#manage-device-credentials) 以获取预置的“Raspberry Pi 演示设备”。

### 运行应用程序

确保可以通过 adb 工具访问您的 Raspberry 设备：

```bash
adb devices
```

导航到 **GpioControlSample** 应用程序文件夹并将应用程序部署到设备：

```bash
./gradlew assembleDebug
adb push ./app/build/outputs/apk/app-debug.apk /data/local/tmp/org.thingsboard.sample.gpiocontrol
adb shell pm install -r "/data/local/tmp/org.thingsboard.sample.gpiocontrol"
```

或者，您可以使用其他选项来部署 Android 应用程序：

- [使用 Android Studio](https://developer.android.com/studio/run/index.html)
- [使用命令行](https://developer.android.com/studio/build/building-cmdline.html)

最后，您可以通过发出以下 adb 命令来启动应用程序：

```bash
adb shell am start -n "org.thingsboard.sample.gpiocontrol/org.thingsboard.sample.gpiocontrol.GpioControlActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
```

## 数据可视化

为了简化本指南，我们已将“Raspberry PI GPIO 演示仪表板”包含在每个 GridLinks 安装中可用的 [演示数据](/docs/samples/demo-account/#dashboards) 中。
当然，您可以修改此仪表板：调整、添加、删除小部件等。
您可以通过以租户管理员身份登录来访问此仪表板。

在本地安装的情况下：

- 登录名：tenant@gridlinks.com
- 密码：tenant

在实时演示服务器的情况下：

- 登录名：您的实时演示用户名（电子邮件）
- 密码：您的实时演示密码

请参阅 **[实时演示](/docs/user-guide/live-demo/)** 页面，了解如何获取您的帐户的更多详细信息。

登录后，打开 **仪表板->Raspberry PI GPIO 演示仪表板** 页面。您应该观察到设备的 GPIO 控制和状态面板的演示仪表板。
现在，您可以使用控制面板切换 GPIO 的状态。结果，您将看到设备和状态面板上的 LED 状态发生变化。

以下是“Raspberry PI GPIO 演示仪表板”的屏幕截图。

![image](/images/samples/raspberry/gpio/dashboard.png)

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 ThingsBoard 主要功能相关的指南：

- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}