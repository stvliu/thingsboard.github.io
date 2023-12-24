{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

涂鸦是一个云平台，通过物联网连接一系列设备。将涂鸦与 GridLinks 集成后，您可以在 GridLinks IoT 平台中连接、管理、通信、处理和可视化设备数据。

## 涂鸦集成教程

在本教程中，我们将使用一个真实设备 - 智能插头。

此外，您还可以使用 [**虚拟设备**](https://developer.tuya.com/en/docs/iot/manage-virtual-devices?id=Ka4725tiyfhg0)。虚拟设备可帮助您在没有实际 IoT 设备的情况下执行云开发。

### 先决条件

第一步是在您的移动设备上安装智能设备控制应用程序（Smart Life、涂鸦智能或其他）并在应用程序中注册您的智能插头设备。

{% include images-gallery.html imageCollection="tuya-application-add-device" %}

### 涂鸦设置

#### 创建云项目

下一步是在 [涂鸦](https://www.tuya.com/) 上注册一个帐户并创建云项目。

{% include images-gallery.html imageCollection="tuya-create-cloud-project" showListImageTitles="true" %}

#### 启用涂鸦消息服务

启用消息服务以及时接收有关设备注册、数据报告和状态更改的消息。

{% include images-gallery.html imageCollection="tuya-message-service-enable" showListImageTitles="true" %}

#### 链接涂鸦应用帐户

您需要使用 Smart Life 应用帐户将您的设备链接到此项目。

{% include images-gallery.html imageCollection="tuya-add-smart-life-app" showListImageTitles="true" %}

<br>
**注意：**
<br>
确保您启用了消息传递规则（过滤器）以接收上行链路。最基本过滤器（statusReport）应足以用于测试目的

{% include images-gallery.html imageCollection="tuya-enable-rules-environment" showListImageTitles="true" %}

## 涂鸦集成配置

### 上行链路转换器

在设置 **涂鸦集成** 之前，您需要创建一个 **上行链路转换器**，这是一个用于解析和转换涂鸦集成接收的数据的脚本，使其成为 GridLinks 可以使用的一种格式。

要创建 **上行链路转换器**，请转到 **数据转换器** 部分，然后单击 **添加新的数据转换器 —> 创建新的转换器**，将其命名为 **“涂鸦上行链路转换器”** 并选择类型 **上行链路**。现在使用调试模式。

{% capture difference %}
**注意**
<br>
尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在完成调试后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**选择设备有效负载类型以进行解码器配置：**

{% include templates/tbel-vs-js.md %}

{% capture tuyauplink %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/tuya/tuya-uplink-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/tuya/tuya-uplink-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tuyauplink" toggle-spec=tuyauplink %}

### 下行链路转换器

下行链路转换器转换传出的 RPC 消息，然后集成将其发送到您的设备。

使用名称 **“涂鸦下行链路转换器”** 和类型 **下行链路** 创建另一个转换器。要查看事件 - 启用调试。

{% capture tuyadownlink %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/tuya/tuya-downlink-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/tuya/tuya-downlink-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="tuyadownlink" toggle-spec=tuyadownlink %}

### 涂鸦集成设置

转到 **集成** 部分，然后单击添加新集成按钮。将其命名为 **涂鸦集成**，选择类型 **涂鸦**；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-1-pe.png)
{% endif %}

在此步骤中，您可以选择最近创建的 **涂鸦上行链路转换器** 或创建一个新的上行链路数据转换器；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-2-pe.png)
{% endif %}

将 **涂鸦下行链路转换器** 添加到集成或创建一个新的下行链路数据转换器；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-3-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-3-pe.png)
{% endif %}

在最后一步，填写以下字段：

- **区域** - 指定您的区域；

- **环境：** 选择 **PROD** 或 **TEST**。对于真实设备，选择 **PROD**。如果您想将 [**虚拟设备**](https://developer.tuya.com/en/docs/iot/manage-virtual-devices?id=Ka4725tiyfhg0) 连接到 Thingsboard 并在其购买之前测试其操作，请选择 **TEST**。

- **访问 ID** 和 **访问密钥** 是涂鸦分发的授权证书。将先前复制的 **访问 ID** 和 **访问密钥** 粘贴到集成中。

单击“添加”以创建集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-4-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-create-integration-4-pe.png)
{% endif %}

### 规则链配置

当集成配置好并准备就绪时，我们需要转到 **规则链**，选择 **“根规则链”**，然后在此处创建规则节点 **集成下行链路**。在此处输入一些名称，选择较早创建的涂鸦集成，然后点击 **添加**。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-rule-chain-downlink-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-rule-chain-downlink-1-pe.png)
{% endif %}

完成这些步骤后，我们需要点击规则节点 **消息类型开关** 的右侧灰色圆圈，并将此圆圈拖动到 **集成下行链路** 的左侧。在弹出窗口中添加 **“RPC 请求到设备”** linl，然后点击“添加”。保存根规则链。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-rule-chain-downlink-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-rule-chain-downlink-2-pe.png)
{% endif %}

### 上行链路消息

创建 ThingsBoard **涂鸦集成** 后，您必须断开智能插头与电源的连接，然后重新连接。设备将向集成发送带有遥测和属性的上行链路消息

转到 **设备组** -> **全部**，您应该找到由集成配置的设备。在我的案例中，它是 - **SmartPlug268970**。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-integration-create-device-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-integration-create-device-pe.png)
{% endif %}

### 涂鸦智能插头仪表板

为了可视化智能插头数据并测试 RPC 命令，我们将创建 **涂鸦智能插头** 仪表板。

- 下载 [**tuya_smart_plug_dashboard.json**](/docs/user-guide/resources/tuya_smart_plug_dashboard.json) 文件
- 转到 **仪表板组** 选项卡。创建仪表板组 - **智能插头** 并转到该组。
- 要导入此 JSON 文件，请单击仪表板组页面右上角的 `import` 按钮，并将先前下载的文件拖动到窗口中。点击 **导入**。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-1-pe.png)
{% endif %}

- 打开 **涂鸦智能插头** 仪表板
- **进入编辑模式**，单击 **实体别名** 按钮，并将您的设备添加到 **smartPlug** 别名

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-alias-1-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-alias-1-pe.png)
{% endif %}

{% capture difference %}
**注意：**
<br>
您设备的时序数据键可能与显示的键不同。如有必要，您需要根据设备的文档（对于每个小部件）替换它们。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-edit-timeseries-data-keys-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-edit-timeseries-data-keys-pe.png)
{% endif %}

<br>
如果您已正确配置所有内容，您将看到智能插头状态指示灯（开/关）和过去一小时的遥测：电压、功率和电流。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-2-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-2-pe.png)
{% endif %}

智能插头状态指示灯为绿色。尝试通过单击 **开/关圆形开关** 关闭智能插头

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-3-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-3-pe.png)
{% endif %}

智能插头状态指示灯变为灰色。功耗停止。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-4-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/tuya/tuya-dashboard-4-pe.png)
{% endif %}

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}