---
layout: docwithnav
title: 使用 Nettra RTU 通过 MQTT 上传温度
description: 使用 Nettra RTU 通过 MQTT 上传温度的 ThingsBoard IoT 平台示例
hidetoc: "true"
---

* TOC
{:toc}

## 简介

本指南包含有关如何通过以太网将 Nettra RTU 设备连接到 GridLinks Community Edition 的分步说明，其中使用 Nettra RTU 的众多应用程序之一作为示例。特别是，此示例应用程序允许您使用 GridLinks Web UI 监视温度，以显示来自传感器的温度数据。

### Nettra RTU
[Nettra RTU](https://nettra.tech)（称为 **“RTU+”**）是一款功能强大的 IoT 电子设备，具有数字和模拟输入和输出，以及多种集成通信接口，如调制解调器、以太网、802.15.4、RS485、RS232 和 GPS。它是通过分布式数据网络实现监视、采集和控制应用程序的理想产品。

RTU+ 可以通过 [RTU+ 配置界面](https://nettra.tech) 轻松配置。为了使 RTU+ 适应每个应用程序，它运行一个完全可自定义的脚本，可从配置界面访问和编辑。在本指南中，我们将提供一个示例，非常简单且易于理解。

完成此示例/教程后，您将在右侧的仪表板上看到传感器数据，如下所示。
<br><br>
![image](/images/samples/nettrartu+/nettrartu+.png)   ![image](/images/samples/nettrartu+/rtu_temp_sensor/dashboard.png)

## 先决条件

### 硬件

 - 1x [RTU+](https://nettra.tech)
 - 1x 温度传感器（工作范围：4-20mA 或 0-20V）
 - 1x 12VDC 电源电压
 - 1x USB 转串口电缆
 - 1x 以太网电缆

### 软件
 - [RTU+ 配置界面](https://nettra.tech)。
 - 您需要启动并运行 GridLinks 服务器。使用 [实时演示](/docs/user-guide/live-demo/) 或 [安装指南](/docs/user-guide/install/installation-options/) 来安装 GridLinks。

## 连接图

下图总结了此简单项目的连接：
<br><br>

![image](/images/samples/nettrartu+/rtu_temp_sensor/connection_diagram.png)

## ThingsBoard 配置

此步骤包含将设备连接到 GridLinks 所需的说明。

以 [实时演示](https://demo.thingsboard.io/signup) 的身份注册 GridLinks Web UI。有关如何获取帐户的更多详细信息，请参阅 [实时演示](/docs/user-guide/live-demo/) 页面。

### 设备

1. 转到 *“设备”* 部分。
2. 单击 *“+”* 按钮，并创建一个名为 **“RTU+”** 的设备。将 *“设备类型”* 设置为 **“default”**。
<br><br>
![image](/images/samples/nettrartu+/device.png)
<br><br>
3. 创建设备后，打开其详细信息并单击 *“管理凭据”*。
4. 从 *“访问令牌”* 字段复制自动生成的访问令牌。请保存此设备令牌。它将在后面称为 **$RTU_DEMO_TOKEN**。
<br><br>
 ![image](/images/samples/nettrartu+/credentials.png)

### 仪表板

使用此 [链接](/docs/samples/nettrartu+/resources/rtu_.json) 下载仪表板文件 (.json)。
使用导入/导出 [说明](/docs/user-guide/ui/dashboards/#iot-dashboard-importexport) 将仪表板导入到您的 ThingsBoard 实例。

## 将 RTU+ 连接到 PC

 - 下载并安装最新版本的 [RTU+ 配置界面](https://nettra.tech)。

 - 将 RTU+ 连接到温度传感器和 12VDC 电源（如 *连接图* 部分所示）后，使用 USB-串口电缆将 RTU+ 连接到 PC（确保已安装所有必要的驱动程序）。

 - 打开 RTU+ 配置界面。

   1. 转到 *“Inicio”*。
   2. 单击 *“Serial”*。
   3. 选择您已连接 RTU+ 的 USB 端口 *“Puerto”*、*“Baud rate”*：**“9600”**（默认）和 *“Paridad”*：**“Sin paridad”**。
   4. 单击 *“Connect”*。

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/serial_connection.png)

   连接后，您应该看到此图标：

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/connected.png)

## RTU+ 配置

将 RTU+ 连接到 PC 后，我们可以继续进行配置。

### 以太网

1. 转到 *“Comunicaciones”*。
2. 单击 *“Serial y Ethernet”*。
3. 勾选 **“DHCP”** 框，如下一个图像所示。
4. 单击 *“Aplicar cambios”* 保存。

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/ethernet_conf.png)

### MQTT

1. 转到 *“Comunicaciones”*。
2. 单击 *“MQTT y Hora”*。
3. 填入 ***MQTT*** 框，如下所示：
   <br><br>
   **Interfaz**：以太网 &nbsp;&nbsp; **Puerto**：1883<br>
   **Servidor**：ThingsBoard HOST/IP 地址，可在您的本地网络中访问。如果您使用 [实时演示](https://demo.thingsboard.io/) 服务器，请指定 `demo.thingsboard.io`。<br>
   **Usuario**：$RTU_DEMO_TOKEN（在 *设备* 小节中提供）<br>
   **Contraseña**：留空<br>
   **Client ID**：RTU+<br>
   **Telemetry Topic**：v1/devices/me/telemetry<br>
   **Attributes Topic**：v1/devices/me/attributes<br>
   **Formato**：Telemetry+<br>
4. 填入 ***时间同步*** 框，如下所示：
   <br><br>
   **Interfaz**：NTP 以太网<br>
   **Servidor**：ThingsBoard HOST/IP 地址，可在您的本地网络中访问。如果您使用 [实时演示](https://demo.thingsboard.io/) 服务器，请指定 `demo.thingsboard.io`。<br>
   **Frecuencia**：10<br>
   **Huso**：写下您的时区<br>

5. 单击 *“Aplicar cambios”* 保存。

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/mqtt_conf.png)

   您应该在 *“Estado”* 中看到：*“Conectado”*（MQTT 状态：已连接）
   （第一次可能需要几分钟）

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/status.png)

### 时间

1. 转到 *“Inicio”*

2. 单击 *“Configurar Hora”*。

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/configure_time.png)

### 模拟输入

1. 转到 *“Escalado de Entradas Analógicas”*。

2. 在这里，我们有两种可能的配置，具体取决于您的温度传感器。

   如果您的温度传感器输出范围在 **4-20mA** 之间：<br>
   在 *“Entrada Analógica 0: ”* 中选择 *“Corriente”*。将 *“X0”* 填为 **“819”**，将 *“X1”* 填为 **“4096”**。将 *“Y0”* 填为最低传感器温度，将 *“Y1”* 填为最高传感器温度。<br>
   示例：传感器范围：-10°C 至 100°C。*“X0” = 819*，*“Y0” = -10*，*“X1” = 4096* 和 *“Y1” = 100*

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/current_input.png)

   如果您的温度传感器输出范围在 **0-20V** 之间：<br>
   在 *“Entrada Analógica 0: ”* 中选择 *“Tensión”*。将 *“X0”* 填为 **“0”**，将 *“X1”* 填为 **“4096”**。将 *“Y0”* 填为最低传感器温度，将 *“Y1”* 填为最高传感器温度。<br>
   示例：传感器范围：-10°C 至 100°C。*“X0” = 0*，*“Y0” = -10*，*“X1” = 4096* 和 *“Y1” = 100*

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/voltage_input.png)

3. 单击 *“Aplicar cambios”* 保存。

### 脚本

 - 下载此 [***脚本***](/docs/samples/nettrartu+/resources/rtu_temp_script.nbs)。

```c
/*
 * DESCRIPTION :
 * - Monitor temperature each 20 seconds.
 * 
 * INPUTS:
 * - Temperature sensor : Analog Input 0 
 */

// Constants
const TLOG = 20000;  // [Miliseconds]
 
// Variables definition
loggable float temperature;   // [ºC]
ulong logTimer;
<span style="color: green"> Some green text </span>
// Alias
alias sensorTemperature as AInEscalado[0];

// Variables initialization
logTimer = ConfigurarTimeout(0); 

// Code
while(1)
{
   if (Timeout(logTimer))
   {
      logTimer = ConfigurarTimeout(TLOG);
      temperature = sensorTemperature;
      Log(temperature);
   }
}
```

1. 转到 *“Nettra-C”*
2. 单击 *“Cargar”* 导入脚本。如果您想制作自己的脚本，可以参阅 [Nettra C](https://nettra.tech) 用户手册。

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/import_script.png)

3. 单击 *“Compilar y Aplicar”* 编译并保存 RTU+ 中的脚本。

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/script_running.png)

## 数据可视化

最后，使用与 *ThingsBoard 配置* 部分相同的用户名和密码，在实时演示服务器中打开 GridLinks Web UI。

转到 *“设备”* 部分并找到 *“RTU+ 设备”*，打开设备详细信息并切换到 *“最新遥测”* 选项卡。
如果所有配置正确，您应该能够在表中看到 *“temperature”* 的最新值。<br><br>

![image](/images/samples/nettrartu+/rtu_temp_sensor/telemetry_table.png)

之后，打开 *“仪表板”* 部分，然后找到并打开 *“RTU+”* 仪表板。
结果，您将看到一个时序图表，显示温度水平（类似于介绍中的仪表板图像）。<br><br>

![image](/images/samples/nettrartu+/rtu_temp_sensor/dashboard.png)

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 ThingsBoard 主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}