---
layout: docwithnav
title: 使用 LinkIt ONE 和 ThingsBoard 上传和可视化 GPS 数据
description: GridLinks IoT 平台示例，用于使用 LinkIt ONE 上传和可视化 GPS 数据

---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}

此示例应用程序展示了跟踪 LinkIt ONE 设备的 GPS 位置并在地图上执行进一步可视化的功能。
它执行 GPS 模块产生的纬度和经度值的收集。
收集的数据被推送到 GridLinks 以进行存储和可视化。
此应用程序的目的是演示 GridLinks 数据收集 API 和可视化功能。

GPS 模块是 [LinkIt ONE](https://wiki.seeedstudio.com/LinkIt_ONE/) 的内置模块。
LinkIt ONE 通过使用 Arduino 的 [PubSubClient](https://github.com/knolleary/pubsubclient) 库通过 MQTT 协议将数据推送到 GridLinks 服务器。
数据使用地图小部件进行可视化，该小部件是可自定义仪表板的一部分。
在 LinkIt ONE 上运行的应用程序使用 Arduino SDK 编写，非常简单易懂。

完成此示例/教程后，您将在以下仪表板上看到您的设备 GPS 和电池数据。

![image](/images/samples/linkit-one/gps/dashboard.png)

{% include templates/prerequisites.md %}

本教程专为 Windows 操作系统用户编写。
但是，可以在其他操作系统（Linux 或 MacOS）上运行它。

## 硬件清单

- [LinkIt One](https://www.seeedstudio.com/LinkIt-ONE-p-2017.html)

   GPS 和 WIFI 天线与电路板一起发货。

{% include templates/thingsboard-configuration.md %}

### 配置您的设备

此步骤包含将您的设备连接到 GridLinks 所需的说明。

在浏览器中打开 GridLinks Web UI (http://localhost:8080) 并以租户管理员身份登录

- 登录名：tenant@gridlinks.com
- 密码：tenant

转到“设备”部分。
单击“+”按钮并创建一个名为“LinkIt One Demo Device”的设备。

![image](/images/samples/linkit-one/gps/device.png)

创建设备后，打开其详细信息并单击“管理凭据”。

从“访问令牌”字段复制自动生成的访问令牌。
请保存此设备令牌。
它将在后面称为 **$ACCESS_TOKEN**。

![image](/images/samples/linkit-one/gps/credentials.png)


在设备详细信息中单击“复制设备 ID”以将您的设备 ID 复制到剪贴板。
将您的设备 ID 粘贴到某个地方，此值将在后续步骤中使用。

### 配置您的仪表板

使用此 [**链接**](/docs/samples/linkit-one/resources/linkit_one_gps_dashboard_v2.json) 下载仪表板文件。
使用导入/导出 [**说明**](/docs/user-guide/ui/dashboards/#dashboard-importexport) 将仪表板导入您的 GridLinks 实例。

## 编程 LinkIt One 设备

如果您已经熟悉使用 Arduino IDE 编程 LinkIt One 的基础知识，则可以跳过以下步骤并继续执行步骤 2。

### 步骤 1. LinkIt ONE 和 Arduino IDE 设置。

为了开始编程 LinkIt One 设备，您需要安装 Arduino IDE 和所有相关库。
请按照此 [指南](https://github.com/MediaTek-Labs) 安装 Arduino IDE 和 LinkIt One SDK：

### 步骤 2. PubSubClient 库安装。

打开 Arduino IDE 并转到 **草图 -> 包含库 -> 管理库**。
找到 Nick O'Leary 的 PubSubClient 并安装它。

**注意**本教程使用 PubSubClient 2.6 进行了测试。

下载并打开 **gps_tracker.ino** 草图。

**注意**您需要在草图中编辑以下常量和变量：

- WIFI_AP - 您的接入点的名称
- WIFI_PASSWORD - 接入点密码
- WIFI_AUTH - 选择 LWIFI_OPEN、LWIFI_WPA 或 LWIFI_WEP 之一。
- TOKEN - ThingsBoard 配置步骤中的 **$ACCESS_TOKEN**。
- thingsboardServer - 可在您的 wifi 网络中访问的 GridLinks HOST/IP 地址。
如果您使用 [实时演示](https://demo.thingsboard.io/) 服务器，请指定“demo.thingsboard.io”。

{% capture tabspec %}gps-arduino
gps,gps_tracker.ino,c,resources/gps_tracker.ino,/docs/samples/linkit-one/resources/gps_tracker.ino{% endcapture %}
{% include tabs.html %}

通过 USB 电缆连接您的 LinkIt One 设备并在 Arduino IDE 中选择串行调试 COM 端口。
使用“上传”按钮编译并上传草图到设备。

应用程序上传并启动后，它将尝试使用 mqtt 客户端连接到 GridLinks 节点，并每秒上传一次“纬度”和“经度”属性。

## 故障排除

应用程序运行时，您可以将您的设备连接到 Arduino IDE 中的串行调试 COM 端口并打开“串行监视器”以查看串行输出产生的调试信息。

## 数据可视化

最后，打开 GridLinks Web UI。
您可以通过以租户管理员身份登录来访问此仪表板。
使用

- 登录名：tenant@gridlinks.com
- 密码：tenant

在本地 GridLinks 安装的情况下。

转到 **“设备”** 部分并找到 **“LinkIt One Demo Device”**，打开设备详细信息并切换到 **“属性”** 选项卡。
如果所有配置正确，您应该能够在表中看到 *“纬度”*、*“经度”* 和电池状态属性及其最新值。

![image](/images/samples/linkit-one/gps/attributes.png)

之后，打开 **“仪表板”** 部分，然后找到并打开 **“LinkIt One GPS 跟踪演示仪表板”**。
因此，您将看到一个地图小部件，其中包含一个指示您设备位置的指针和一个电池电量小部件（类似于简介中的仪表板图像）。

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