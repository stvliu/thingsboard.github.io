---
layout: docwithnav-gw
title: GridLinks IoT 网关入门
description: 配置 MQTT、OPC-UA 和 Modbus 连接器，以便在 Docker 容器中与各自的演示服务器建立连接并检索数据。

---

* TOC
{:toc}

 GridLinks 物联网网关是一个创新解决方案，旨在作为连接到 GridLinks 的传统和第三方系统中 IoT 设备的桥梁。

本指南涵盖了初始 IoT 网关的安装和配置，我们将执行以下操作：
- 使用 [ GridLinks 物联网网关仪表板](#prerequisites) 创建新的网关设备；
- 使用 Docker 命令启动网关；
- 配置不同类型的连接器（[MQTT](/docs/iot-gateway/config/mqtt/)、[OPC-UA](/docs/iot-gateway/config/opc-ua/)、[Modbus](/docs/iot-gateway/config/modbus/))，以便连接到本地演示服务器并从中读取数据；
- 在 GridLinks 上检查接收到的设备数据。

## 先决条件

- 在启动网关设置之前，请确保 GridLinks 服务器已启动并正在运行。最简单的方法是利用 [实时演示](https://gridlinks.codingas.com) 或 [GridLinks 云](https://gridlinks.codingas.com)。或者，您可以按照 [安装指南](/docs/user-guide/install/installation-options/) 中概述的步骤手动安装 GridLinks。
- 在继续之前，请确保在您的机器上安装并正确配置了 Docker。如果您尚未安装 Docker，可以从 [Docker 官方网站](https://docs.docker.com/engine/install/) 下载并按照针对您特定操作系统的安装指南进行操作。
- 如果您没有安装仪表板，可以下载网关小部件包 [此处](/docs/iot-gateway/resources/thingsboard-gateway-widget-bundle.json){:target="_blank" download="thingsboard-gateway-widget-bundle.json"} 的 JSON 文件和 GridLinks IoT 网关仪表板 [此处](/docs/iot-gateway/resources/thingsboard-gateways-dashboard.json){:target="_blank" download="thingsboard-gateways-dashboard.json"} 的 JSON 文件。您可以使用以下部分执行此操作：

### （可选）导入网关小部件包和仪表板

首先，我们必须导入网关小部件包，为此，请执行以下步骤：

{% assign importWidgetsBundle = '
    ===
        image: /images/gateway/dashboard/wl-import-bundle-gateway-1-ce.png,
        title: 转到“**小部件库**”页面，然后单击“**小部件包**”页面右上角的“**+**”按钮。从下拉菜单中选择“**导入小部件包**”。
    ===
        image: /images/gateway/dashboard/wl-import-bundle-gateway-2-ce.png,
        title: 在弹出窗口中，系统会提示您上传下载的网关小部件包 JSON 文件。从您的计算机中拖放一个文件，然后单击“**导入**”将小部件包添加到库中。
    ===
        image: /images/gateway/dashboard/wl-import-bundle-gateway-3-ce.png,
        title: 小部件包已导入。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=importWidgetsBundle %} 

要导入 GridLinks IoT 网关仪表板，请按照以下步骤操作：

{% assign importGatewayDashboard = '
    ===
        image: /images/gateway/dashboard/import-dashboard-gateway-1-ce.png,
        title: 转到“**仪表板**”页面，然后单击页面右上角的“**+**”按钮，并从下拉菜单中选择“**导入仪表板**”；
    ===
        image: /images/gateway/dashboard/import-dashboard-gateway-2-ce.png,
        title: 在导入仪表板窗口中，上传下载的网关仪表板 JSON 文件，然后单击“**导入**”。
    ===
        image: /images/gateway/dashboard/import-dashboard-gateway-3-ce.png,
        title: 仪表板已导入。单击包含仪表板名称的行以将其打开。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=importGatewayDashboard %} 

## 步骤 1. 在 GridLinks 上创建新的网关设备

首先，我们必须将网关设备添加到您的 GridLinks 实例。您可以使用以下步骤执行此操作：

{% assign createNewGatewayDevice = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-1-ce.png,
        title: 转到“**仪表板**”选项卡并打开“** GridLinks 物联网网关**”仪表板。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-2-ce.png,
        title: 单击“**+**”按钮，输入网关设备名称（例如，“我的新网关”），然后选择设备配置文件。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createNewGatewayDevice %} 

{% capture info %}
<div>
  <p>
    <span style="color:black">如果您之前配置过网关，请创建备份，因为新的远程配置会覆盖现有设置文件。  
    <br>对于那些使用早于 3.4 版本的网关的人，网关将自动生成 JSON 格式的新配置文件。</span>
  </p>
</div>
{% endcapture %}
{% include templates/info-banner.md content=info %}

要启动网关，请使用以下步骤：

{% assign remoteCreateGatewayDocker = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-3-ce.png,
        title: 在网关仪表板上，单击右上角的 **“启动命令”** 按钮。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-4-ce.png,
        title: 复制自动生成的命令并在您的终端中执行它。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=remoteCreateGatewayDocker %}

在运行网关 docker 镜像后，您可以在终端中看到以下日志：

![](/images/gateway/dashboard/launch-gateway-docker.png)

## 步骤 2. 启用远程日志记录

要在仪表板上查看网关和连接器日志，您需要启用远程日志记录。为此，请使用以下步骤：

{% assign enableRemoteLogging = '
    ===
        image: /images/gateway/dashboard/general-configuration-1-ce.png,
        title: 在网关仪表板上，单击右侧面板上的 **“常规配置”** 按钮。
    ===
        image: /images/gateway/dashboard/general-configuration-2-ce.png,
        title: 导航到“**日志**”选项卡。启用“**远程日志**”开关。在“**日志级别**”行中选择“**DEBUG**”。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=enableRemoteLogging %}

## 步骤 3. 添加新的连接器

通过选择连接器类型，您可以确定将用于确保网关与其他系统或设备交互的特定连接方法。

要了解连接器的工作原理，您可以选择以下连接器之一：

{% capture connectorscreationspec %}
MQTT<small></small>%,%mqtt%,%templates/iot-gateway/remote-creating-connector-mqtt.md%br%
Modbus<small></small>%,%modbus%,%templates/iot-gateway/remote-creating-connector-modbus.md%br%
OPC-UA<small></small>%,%opcua%,%templates/iot-gateway/remote-creating-connector-opcua.md{% endcapture %}

{% include content-toggle.html content-toggle-id="connectorsCreation" toggle-spec=connectorscreationspec %}

## 步骤 4. 检查设备数据

要查看从网关上传的数据，请使用以下步骤：

{% assign checkDeviceData = '
    ===
        image: /images/gateway/dashboard/review-gateway-statistics-1-ce.png,
        title: 导航到 **设备** 页面并单击创建的设备。这将打开设备详细信息页面。从那里，切换到 **“属性”** 选项卡以查看在连接器中配置的属性。
    ===
        image: /images/gateway/dashboard/review-gateway-statistics-2-ce.png,
        title: 要查看来自设备的实时遥测数据，请导航到“**最新遥测**”选项卡。在这里，您将找到设备发送的遥测数据，包括“**湿度**”和“**温度**”等指标。此选项卡提供实时设备遥测更新。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkDeviceData %}

## 配置其他连接器

在成功安装和配置第一个连接器后，您可以配置其他连接器以连接到不同的设备。您可以在以下文章中找到有关连接器的更多信息：  
 - [**MQTT** 连接器](/docs/iot-gateway/config/mqtt/)
 - [**OPC-UA** 连接器](/docs/iot-gateway/config/opc-ua/)
 - [**Modbus** 连接器](/docs/iot-gateway/config/modbus/)
 - [**BLE** 连接器](/docs/iot-gateway/config/ble/)
 - [**请求** 连接器](/docs/iot-gateway/config/request/)
 - [**REST** 连接器](/docs/iot-gateway/config/rest/)
 - [**CAN** 连接器](/docs/iot-gateway/config/can/)
 - [**FTP** 连接器](/docs/iot-gateway/config/ftp/)
 - [**套接字** 连接器](/docs/iot-gateway/config/socket/)
 - [**XMPP** 连接器](/docs/iot-gateway/config/xmpp/)
 - [**BACnet** 连接器](/docs/iot-gateway/config/bacnet/)
 - [**OCPP** 连接器](/docs/iot-gateway/config/ocpp/)
 - [**ODBC** 连接器](/docs/iot-gateway/config/odbc/)
 - [**SNMP** 连接器](/docs/iot-gateway/config/snmp/)
 - [**自定义** 连接器](/docs/iot-gateway/custom/)

有关 * GridLinks 物联网网关* 仪表板的更多信息，您可以在 [此处](/docs/iot-gateway/guides/how-to-enable-remote-configuration/) 阅读。

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。