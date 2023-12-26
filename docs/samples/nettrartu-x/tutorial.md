---
layout: docwithnav
title: 使用 Nettra RTU 通过 MQTT 上传温度
description: 使用 Nettra RTU 通过 MQTT 上传温度的 GridLinks IoT 平台示例
hidetoc: "true"
---

## 目录
1. [简介](#introduction)
3. [前提条件](#prerequisites)
4. [连接图](#connection_diagram)
5. [GridLinks 配置](#tb_configuration)
6. [将 RTU-X 连接到 PC](#connection_pc)
7. [RTU-X 配置](#rtu_configuration)
8. [数据可视化](#data_visualization)

## 简介

本指南包含有关如何通过 TCP/IP 通过 wifi 将 Nettra RTU 设备连接到 GridLinks Community Edition 的分步说明，使用 Nettra RTU 的众多应用程序之一作为示例。在本指南的最后，您将能够使用 Thingsboard Web UI 监视数据以显示数据。

### Nettra RTU
[Nettra RTU](https://nettra.tech)称为 **“RTU-X”**，是一款功能强大的 IoT 电子设备，具有数字和模拟输入和输出，以及多种集成通信接口，如调制解调器、以太网、蓝牙、802.15.4、RS485、RS232 和 GPS。它是通过分布式数据网络实现监控、数据采集和控制应用程序的理想产品。

RTU-X 可以通过 [RTU-X 配置界面](http://wiki.nettra.tech/en/downloads)轻松配置。为了使 RTU-X 适应每个应用程序，它运行一个完全可自定义的脚本，可从配置界面访问和编辑。在本指南中，我们将提供一个示例，非常简单易懂。

完成此示例/教程后，您将在右侧的仪表板上看到传感器数据，如下所示。
<br><br>

![rtu_x](https://user-images.githubusercontent.com/61634031/133831823-b6e2420e-5669-433a-a3fa-54b506ab24b9.png) ![dash2](https://user-images.githubusercontent.com/61634031/134074200-5063cd05-6091-4f36-90a3-91771373bd65.png)


## 前提条件


### 硬件

 - 1x [RTU-X](https://nettra.tech)
 - 1x 12VDC 电源电压

### 软件
 - [RTU-X 配置界面](http://wiki.nettra.tech/en/downloads)。
 - 您需要启动并运行 GridLinks 服务器。使用 [实时演示](https://thingsboard.io/docs/user-guide/install/installation-options/?ceInstallType=liveDemo)或 [安装指南](https://thingsboard.io/docs/user-guide/install/ubuntu/)安装 GridLinks。

## 连接图

下图总结了此简单项目的连接：
<br><br>
![copy_941957077](https://user-images.githubusercontent.com/61634031/133837072-8340491f-ea35-4204-91e1-7d513641d7bb.png)

## GridLinks 配置

此步骤包含将设备连接到 GridLinks 所需的说明。

以 [实时演示](https://gridlinks.codingas.com/signup)的形式注册 GridLinks Web UI。有关如何获取帐户的更多详细信息，请参阅 [实时演示](https://thingsboard.io/docs/user-guide/install/installation-options/?ceInstallType=liveDemo)页面。

### 设备

1. 转到 *“设备”* 部分。
2. 单击 *“+”* 按钮并创建一个名为 **“RTU-X”** 的设备。将 *“设备类型”* 设置为 **“默认”**。
<br><br>
![add_opt (1)](https://user-images.githubusercontent.com/61634031/133840783-8b605dfd-3a50-430b-bb63-a8244a53cad9.png)
<br><br>
3. 创建设备后，打开其详细信息并单击 *“复制访问令牌”*。请保存此设备令牌。它将在以后称为 **$RTU_DEMO_TOKEN**。
<br><br>
![access_opt (3)](https://user-images.githubusercontent.com/61634031/133840798-1ea7dc07-c157-4fda-ab1c-9ecb0bba1bb8.png)

### 仪表板

使用此 [链接](/docs/samples/nettrartu-x/resources/rtu_x_dashboard.json)下载仪表板文件 (.json)。
使用导入/导出 [说明](https://thingsboard.io/docs/user-guide/dashboards/#import-dashboard)将仪表板导入到您的 GridLinks 实例。

## 将 RTU-X 连接到 PC

 - 下载并安装最新版本的 [RTU-X 配置界面](http://wiki.nettra.tech/en/downloads)。

 - 打开 RTU-X。

 - 检查您的 wifi 网络并连接到“RTU-X-******”。

 - 打开 RTU-X 配置界面。

   1. 转到 *“主页”*。
   2. 单击 *“TCP/IP”*。
   4. 指定 *“IP”* 地址 **“192.168.4.1”**，*“端口”* **“502”**（默认）。
   5. 单击 *“连接”*。

   ![rtu1_step1](https://user-images.githubusercontent.com/61634031/134022796-78e22a93-5f03-4c9f-80bb-c129814b349a.png)

 - 连接后，您应该会看到以下内容：

   ![rtu2_step](https://user-images.githubusercontent.com/61634031/133849616-2b64bd94-8b5e-49d8-b9fc-a909b8d0cf3e.png)
  
 - 那么：
   1. 转到 *“通信”*。
   2. 转到 *“Wifi、串行、Modbus”*。
   3. 单击 *“站点”* 并注册 WiFi 网络的数据。
   4. *“应用更改”*
   
   ![rtu3_step3](https://user-images.githubusercontent.com/61634031/134022912-8dcbe19c-986f-4fa7-8231-823564262343.png)
   
 - 最后：
   1. 返回 *“主页”*。
   2. 复制 *“WiFi STA 信息”* 上的 *“IP”* 地址。
   3. 断开与 RTU-X 的连接。
   4. 更改 *“IP”* 地址并重新连接。

   ![rtu4_step4](https://user-images.githubusercontent.com/61634031/134022869-f1ec2a5b-dfee-4571-96a4-7fd1fcd81778.png)

## RTU-X 配置

将 RTU-X 连接到 PC 后，我们可以继续进行配置。

### MQTT

1. 转到 *“通信”*。
2. 单击 *“MQTT”*。
3. 在 *“接口”* 上选择 *“调制解调器”*。在 *“格式”* 上选择 *“Thingsboard”*。在 *“URI”* 上粘贴 *“mqtt://demo.thingsboard.io:1883”*。在 *“密码”* 上粘贴 *“设备”* 步骤中的设备访问令牌。
4. 单击 *“应用更改”*。

![rtu5_step5](https://user-images.githubusercontent.com/61634031/134028854-17b5d9c8-c807-4b3b-a557-00ea5b25d7ac.png)

### 脚本

 - 下载此 [***脚本***](/docs/samples/nettrartu-x/resources/rtu_x_script.json)。

```c
/*
 * DESCRIPTION :
 *	- Sending a variable to a Thingsboard Dashboard
*/
// VARIABLES DEFINITION ------------------------------------------
// Attributes
shared uint tLog = 10;

// Loggable
telemetry float variable;

// SCRIPT -----------------------------------------------------------
while (1)
{
    variable = 15;
	
    delay_loop(tLog*1000); // 10 seconds
    log(variable);
}
```

1. 转到 *“用户界面”*
2. 单击 *“加载”* 导入脚本。如果您想制作自己的脚本，可以参阅 [Nettra 脚本用户手册](http://wiki.nettra.tech/en/script)。
3. 单击 *“编译并应用”*，在 RTU-X 中编译并保存脚本。

![rtu6_step6](https://user-images.githubusercontent.com/61634031/134028433-e7412285-9f4e-4d67-9f3c-80879f99191f.png)

## 数据可视化

最后，使用与 *GridLinks 配置* 部分相同的用户名和密码在实时演示服务器中打开 GridLinks Web UI。

转到 *“设备”* 部分并找到 *“RTU-X 设备”*，打开设备详细信息并切换到 *“最新遥测”* 选项卡。
如果所有配置正确，您应该能够在表中看到 *“variable”* 的最新值。<br><br>

![dev](https://user-images.githubusercontent.com/61634031/134029353-d4d80304-0396-4a10-b313-02a249300280.png)

之后，打开 *“仪表板”* 部分，然后找到并打开 *“RTU-X”* 仪表板。
结果，您将看到一个模拟仪表（类似于简介中的仪表板图像）。<br><br>

![dash](https://user-images.githubusercontent.com/61634031/134030076-19fd80de-38fd-4114-b1f1-221f61756782.png)

## 另请参阅

浏览其他 [示例](https://thingsboard.io/docs/samples/)或探索与 GridLinks 主要功能相关的指南：

 - [设备属性](https://thingsboard.io/docs/user-guide/attributes/) - 如何使用设备属性。
 - [数据可视化](https://thingsboard.io/docs/guides/#AnchorIDDataVisualization) - 如何可视化收集的数据。
 - [数据分析](https://thingsboard.io/docs/guides/#AnchorIDDataAnalytics) - 如何收集遥测数据。
 - [规则引擎](https://thingsboard.io/docs/user-guide/rule-engine-2-0/re-getting-started/) - 如何使用规则引擎分析来自设备的数据。
 - [使用 RPC 功能](https://thingsboard.io/docs/user-guide/rule-engine-2-0/tutorials/rpc-request-tutorial/) - 如何向设备发送/从设备接收命令。