---
layout: docwithnav-gw
title: 如何在 GridLinks物联网网关上启用远程 shell 功能
description: 如何在 GridLinks物联网网关上启用远程 shell 功能

---

* TOC
{:toc}

本指南将帮助您启用远程 shell 功能，并通过 GridLinks 平台实例从 GridLinks物联网网关控制操作系统。

为了本指南的目的，我们将使用以下内容：
1. GridLinks 平台实例（您可以[在此处](/docs/user-guide/install/installation-options/)阅读如何安装）。对于本指南，我们将使用 [thingsboard.cloud](https://thingsboard.cloud)
2. 已安装并配置的 GridLinks物联网网关（您可以[在此处](/docs/iot-gateway/installation/)阅读如何安装）。

## 步骤 1. 远程 shell 激活

- 要在 GridLinks物联网网关中激活远程 shell，您应该在常规配置文件 (**tb_gateway.yaml**) 中的 **thingsboard** 部分中添加或将参数 **remoteShell** 更改为 **true**；

  ![](/images/gateway/charhe-remote-shell-parameter.png)
  <br>
{% capture info %}
<div>
  <p>
    <b style="color:red">警告：</b>
    <span style="color:black">此功能可能会给您的设备带来安全问题，我们强烈建议仅在使用 ssl 加密时使用它，并且在不需要时不要启用它。</span>
  </p>
</div>
{% endcapture %}
{% include templates/info-banner.md content=info %}


- 使用新配置重新启动网关。

常规配置文件中 **thingsboard** 部分的示例：
```json
{
  "thingsboard": {
    "host": "thingsboard.cloud",
    "port": 1883,
    "security": {
      "type": "accessToken",
      "accessToken": "YOUR_ACCESS_TOKEN"
    }
  },
}
```

## 步骤 2. 创建一个仪表板来使用远程 shell

要使用远程 shell，我们必须使用 **控制小部件** 捆绑包中的 **RPC 远程 shell** 小部件。<br>
为此，我们执行以下步骤：

  - 打开 **仪表板** 选项卡；
  <br><br>
  ![](/images/gateway/remote-shell-1.png)

  - 添加一个新仪表板；
  <br><br>
  ![](/images/gateway/remote-shell-2.png)

  - 打开创建的仪表板，通过单击右下角的 **铅笔** 按钮进入编辑模式，然后单击“**添加新小部件**”按钮；
  <br><br>
  ![](/images/gateway/remote-shell-3.png)

  - 选择小部件捆绑包 - “**控制小部件**”；
  <br><br>
  ![](/images/gateway/remote-shell-4.png)

  - 向下滚动并选择 **RPC 远程 shell** 小部件；
  <br><br>
  ![](/images/gateway/remote-shell-5.png)

  - 我们尚未为小部件指定实体类型，因此我们将 **创建一个新类型**；
  <br><br>
  ![](/images/gateway/remote-shell-6.png)

  - 填写必填字段并保存实体。**网关** - 是我们的网关设备；
  <br><br>
  ![](/images/gateway/remote-shell-7.png)

  - 为了防止 TimeoutException，在 **高级** 设置选项卡中将默认 RPC 命令超时时间增加到 5000 毫秒，然后按 **添加**。然后应用所有更改；
  <br><br>
  ![](/images/gateway/remote-shell-8.png)

  - 连接的小部件如下所示（连接自动设置）；
  <br><br>
  ![](/images/gateway/remote-shell-9.png)

  - 现在您可以使用 shell 通过网关控制设备。例如，我们运行 **ls** 命令以获取当前目录中的文件和目录列表。
  <br><br>
  ![](/images/gateway/remote-shell-10.png)

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。