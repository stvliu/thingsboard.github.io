---
layout: docwithnav-gw
title: 服务 RPC 方法
description: 服务 RPC 方法

---


* TOC
{:toc}


本指南解释了如何在 GridLinks IoT 网关中使用 RPC API。

为了本教程的目的，您需要：

1. 本地安装的 GridLinks 平台实例（如果您是 GridLinks 新手，[使用此“如何安装”文档](/docs/user-guide/install/installation-options/)）。
2. [已安装](/docs/iot-gateway/installation/) 和 [已配置](/docs/iot-gateway/configuration/) GridLinks IoT 网关。

## 步骤 1. 创建一个仪表板以在 GridLinks IoT 网关中使用 RPC API

要使用调试终端，我们必须从 **控制小部件** 包中添加 **RPC 调试终端** 小部件。<br>
为此，我们执行以下步骤：

  - 打开 **仪表板** 选项卡；
  <br><br>
  ![](/images/gateway/service-rpc-methods-1.png)

  - 添加一个新仪表板；
  <br><br>
  ![](/images/gateway/service-rpc-methods-2.png)

  - 打开创建的仪表板，通过单击右下角的 **铅笔** 按钮进入编辑模式，然后单击“**添加新小部件**”按钮；
  <br><br>
  ![](/images/gateway/service-rpc-methods-3.png)

  - 选择小部件包 - “**控制小部件**”；
  <br><br>
  ![](/images/gateway/service-rpc-methods-4.png)

  - 向下滚动并选择 **RPC 调试终端** 小部件；
  <br><br>
  ![](/images/gateway/service-rpc-methods-5.png)

  - 我们尚未为小部件指定实体类型，因此我们将 **创建一个新实体**；
  <br><br>
  ![](/images/gateway/service-rpc-methods-6.png)

  - 填写必填字段并保存实体。**网关** - 是我们的网关设备；
  <br><br>
  ![](/images/gateway/service-rpc-methods-7.png)

  - 应用所有更改；
  <br><br>
  ![](/images/gateway/service-rpc-methods-8.png)

  - 连接的小部件如下所示（自动进行连接设置）。<br>
  现在，您可以使用调试终端向网关发送 RPC 请求。
  <br><br>
  ![](/images/gateway/service-rpc-methods-9.png)

## 步骤 2. 网关 RPC 方法

要向网关发送 RPC 请求，应该从 **控制小部件** 包中使用 **RPC 调试终端**。

 GridLinks 物联网网关有几种 RPC 方法，默认情况下可从 WEB UI 调用。

OOTB 方法列表将在即将发布的版本中扩展。

### gateway_ping RPC 方法

**gateway_ping RPC 方法** 用于检查与网关的连接和 RPC 处理状态。
以“**gateway_**”为前缀的每个命令都将被解释为对通用网关服务的命令，而不是对连接器或设备的 RPC 请求。
命令：

```bash
gateway_ping
```
{: .copy-code}

响应是：

```json
{
  "code": 200,
  "resp": "pong"
}
```

![网关 RPC ping 方法](/images/gateway/gateway-rpc-ping.png)

### gateway_devices RPC 方法

**gateway_devices RPC 方法** 用于列出通过网关连接的设备，并提供有关所用连接器类型的信息。
此方法在“resp”中返回带有 **键值** 参数的对象，其中：
键 — 是设备名称
值 — 标识连接器

命令：

```bash
gateway_devices
```
{: .copy-code}

返回类似对象：

```json
{
  "code": 200,
  "resp": {
    "Device Number One": "OPC-UA Connector"
  }
}
```

![网关 RPC 设备方法](/images/gateway/gateway-rpc-devices.png)


### gateway_restart RPC 方法

**gateway_restart RPC 方法** 用于安排重新启动操作，例如 ```bash gateway_restart 60``` 在 60 秒内设置网关服务的重新启动。
此方法使用秒作为测量单位。

**注意：**在将任务添加到网关计划程序后，将返回响应。

命令：

```bash
gateway_restart 60
```
{: .copy-code}

响应是：

```json
{"success": true}
```

![网关 RPC 重新启动方法](/images/gateway/gateway-rpc-restart.png)

### gateway_reboot RPC 方法

**gateway_reboot RPC 方法** 用于安排网关设备（硬件？）的重新启动，例如 ```bash gateway_reboot 60``` 在一分钟内设置网关设备的重新启动。
**请注意：如果您将网关服务作为 Python 模块而不是守护程序方法启动，并且运行网关的用户具有重新启动权限，则此方法可用。**
命令：

```bash
gateway_reboot 60
```
{: .copy-code}

响应是：

```json
{"success": true}
```

**注意：**在将任务添加到网关计划程序后，将返回响应。

![网关 RPC 重新启动方法](/images/gateway/gateway-rpc-reboot.png)

## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。