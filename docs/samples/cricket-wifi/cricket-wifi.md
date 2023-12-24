---
layout: docwithnav
assignees:
- ddiachenko
title: 用 Cricket 和 ThingsBoard 制作电池供电的 Wi-Fi 传感器
description: 一个使用 Cricket 制作的超低功耗 Wi-Fi 温度传感器的示例，该传感器集成到 ThingsBoard 中，无需编写任何代码
hidetoc: "true"

---

* TOC
{:toc}

## 简介
在本指南中，我们将逐步演示 Things On Edge - Cricket Wi-Fi 模块与 ThingsBoard 的集成。只需几个步骤，我们就可以制作一个 Wi-Fi 电池供电传感器，并在 ThingsBoard 中对其数据进行可视化，而无需编码和编程。它可以是任何类型的传感器，但在本示例中，我们制作了一个温度传感器。

我们将完成以下步骤：
<br>
1) 制作电池供电的 Wi-Fi 传感器
<br>
2) 将传感器连接到 WiFi 网络
<br>
3) 配置传感器以将数据发送到 ThingsBoard
<br>

### Things On Edge
Things On Edge 设计了一种易于使用、超低功耗的 Cricket Wi-Fi 模块。它们旨在快速轻松地制作物联网终端节点，例如传感器、按钮、开关等；使用电池为它们供电很长时间；并集成到庞大的软件和互联网服务生态系统中。所有这一切都无需编写一行代码。
<br>
<img src="/images/samples/cricket-wifi/cricket.png" width="50%" alt="Cricket plate">
<br>
![image](/images/samples/cricket-wifi/TB-graph.png)

## 先决条件

### 硬件
* Things On Edge - Cricket Wi-Fi 模块
* 2xAAA 电池座
* 2xAAA 电池

### 制作电池供电的 Wi-Fi 传感器
Cricket WiFi 模块内置温度传感器。在此示例中，我们不需要任何其他硬件外围设备。但是，为了获得更准确的温度读数，强烈建议使用外部传感器，例如 DS18B20/+

在此示例中，我们只需将电池连接到 Cricket Wi-Fi 模块，设备即可使用。注意：请使用新鲜且质量良好的电池，例如 Duracel、Energizer

<img src="/images/samples/cricket-wifi/asm.png" width="50%" alt="Asm plate connection">


### 将 Cricket 连接到 Wi-Fi 网络

<img src="/images/samples/cricket-wifi/TOE-01.png" width="50%" alt="步骤 1 - 按 TOE 上的按钮">

<img src="/images/samples/cricket-wifi/TOE-02.png" width="50%" alt="步骤 2 - 将设备连接到 TOE">

<img src="/images/samples/cricket-wifi/TOE-03.png" width="50%" alt="步骤 3 - 将设备连接到 WiFi">

<img src="/images/samples/cricket-wifi/TOE-04.png" width="50%" alt="步骤 4 - 通过设备将 TOE 连接到 WiFi">



### 配置 Cricket 以将数据发送到 ThingsBoard
现在我们可以配置 Cricket 将温度读数传输到 ThingsBoard。
<br>

Cricket 同时支持 MQTT 和 HTTP 协议，我们将使用 HTTP 协议进行集成。我们必须确保我们拥有 ThingsBoard 的访问令牌，如下所示：
![image](/images/samples/cricket-wifi/TB-01.png)
<br>

现在我们可以再次返回到 Cricket 的配置面板并完成配置。
<br>
我们将用于将数据发送到 ThingsBoard 的完整 URL 应如下所示：
<br>
**https://thingsboard.cloud/api/v1/**在此处添加您的令牌**/telemetry**
<br>
<br>
我们还定义了以下有效负载格式：
<br>
{"temperature":#temp}
<br>
其中 #temp 标记在发送到 ThingsBoard 之前会自动替换为温度值。

完整的 Cricket 配置可能如下所示：
![image](/images/samples/cricket-wifi/TB-02.png)
<br>


配置 Cricket 后，我们必须通过按下右上角的重置按钮退出配置面板，如下面的图片所示。
<br>
<img src="/images/samples/cricket-wifi/TOE-last.png" width="50%" alt="从 TOE 断开连接">
<br>


如果我们按照上面所示配置设备，设备将每 10 分钟向 ThingsBoard 发送数据。数据以图形方式显示，如下所示：
![image](/images/samples/cricket-wifi/TB-03.png)

<br>
<br>


### 其他信息

[Cricket Wi-Fi 模块 - 文档](https://thingsonedge.com/documentation)


{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}