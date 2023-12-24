{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 简介

可以从主 GridLinks 实例远程执行任何 ThingsBoard 集成。
本指南包含有关如何远程启动 ThingsBoard 集成的分步说明。
例如，我们将启动 MQTT 集成，该集成连接到本地 MQTT 代理并将数据推送到
[thingsboard.cloud](https://thingsboard.cloud/signup)。

有关更多一般信息，请参阅 [部署选项](/docs/{{peDocsPrefix}}user-guide/integrations/#deployment-options)。

## 先决条件

我们假设您已经在自己的 GridLinks PE v3.3.1+ 实例或
[thingsboard.cloud](https://thingsboard.cloud/signup) 上拥有租户管理员帐户。

## GridLinks 配置步骤

### 步骤 1. 创建默认上行和下行转换器

让我们创建虚拟上行和下行转换器，并将它们设置为在调试模式下工作。
在调试模式下运行时，这些转换器将记录所有传入事件。
这将帮助我们在开始接收数据后调整转换器。

![image](/images/user-guide/integrations/remote/default-converters.gif)

### 步骤 2. 创建远程集成

让我们创建远程集成，该集成将使用端口 1883 连接到本地代理并订阅所有主题。
请注意，我们启用了“调试”和“远程执行”。

![image](/images/user-guide/integrations/remote/mqtt-integration.gif)

### 步骤 3. 保存远程集成凭据。

让我们从集成详细信息中复制粘贴集成密钥和密码。

![image](/images/user-guide/integrations/remote/copy-integration-credentials.gif)

## 远程集成安装步骤

### 选择您的平台并安装

可以通过 Docker、Debian 或 RPM 软件包安装 GridLinks 集成。
请使用以下步骤之一。

* [Linux 或 Mac OS 上的 Docker](#docker-on-linuxmac)
* [Windows 上的 Docker](#docker-on-windows)
* [Ubuntu](#ubuntu-server)
* [CentOS/RHEL 服务器](#centosrhel-server)

### Linux/Mac 上的 Docker

- **[安装 Docker CE](https://docs.docker.com/engine/installation/)**

- **选择要安装的集成**


{% capture contenttogglespec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-docker.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-docker.md%br%
AWS SQS<br> 集成<br>%,%aws%,%templates/install/integration/aws-docker.md%br%
Azure 事件中心<br>集成<br>%,%azure%,%templates/install/integration/azure-docker.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/install/integration/opcua-docker.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/install/integration/tcpudp-docker.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/install/integration/coap-docker.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationdockerinstall" toggle-spec=contenttogglespec %}


{% include templates/install/integration/advanced-config-docker.md %} 


- **故障排除**

{% include templates/troubleshooting/dns-issues.md %}

### Windows 上的 Docker

- **[为 Windows 安装 Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)**

- **选择要安装的集成**


{% capture contenttogglespecwin %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-docker-windows.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-docker-windows.md%br%
AWS SQS<br> 集成<br>%,%aws%,%templates/install/integration/aws-docker-windows.md%br%
Azure 事件中心<br>集成<br>%,%azure%,%templates/install/integration/azure-docker-windows.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/install/integration/opcua-docker-windows.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/install/integration/tcpudp-docker-windows.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/install/integration/coap-docker-windows.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationdockerinstallwin" toggle-spec=contenttogglespecwin %}


{% include templates/install/integration/advanced-config-docker.md %} 


- **故障排除**

{% include templates/troubleshooting/dns-issues-windows.md %}

### Ubuntu 服务器

- 安装 Java 11 (OpenJDK)

{% include templates/install/ubuntu-java-install.md %}

- **选择要安装的集成包**

{% capture ubuntuinstallspec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-ubuntu.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-ubuntu.md%br%
AWS SQS<br> 集成<br>%,%aws%,%templates/install/integration/aws-ubuntu.md%br%
Azure 事件中心<br>集成<br>%,%azure%,%templates/install/integration/azure-ubuntu.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/install/integration/opcua-ubuntu.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/install/integration/tcpudp-ubuntu.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/install/integration/coap-ubuntu.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationinstallubuntu" toggle-spec=ubuntuinstallspec %} 

### CentOS/RHEL 服务器

- 安装 Java 11 (OpenJDK)

{% include templates/install/rhel-java-install.md %}

- **选择要安装的集成包**

{% capture rhelinstallspec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/install/integration/http-rhel.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/install/integration/mqtt-rhel.md%br%
AWS SQS<br> 集成<br>%,%aws%,%templates/install/integration/aws-rhel.md%br%
Azure 事件中心<br>集成<br>%,%azure%,%templates/install/integration/azure-rhel.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/install/integration/opcua-rhel.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/install/integration/tcpudp-rhel.md{% endcapture %}

{% include content-toggle.html content-toggle-id="remoteintegrationinstallrhel" toggle-spec=rhelinstallspec %} 

## 远程集成配置

远程集成配置通过 GridLinks UI 完成，没有具体步骤。
探索与特定集成相关的指南和视频教程：

- [HTTP](/docs/{{peDocsPrefix}}user-guide/integrations/http/)
- [MQTT](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/)
- [AWS IoT](/docs/{{peDocsPrefix}}user-guide/integrations/aws-iot/)
- [IBM Watson IoT](/docs/{{peDocsPrefix}}user-guide/integrations/ibm-watson-iot/)
- [Azure 事件中心](/docs/{{peDocsPrefix}}user-guide/integrations/azure-event-hub/)
- [Actility ThingPark](/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/)
- [SigFox](/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/)
- [OceanConnect](/docs/{{peDocsPrefix}}user-guide/integrations/ocean-connect/)
- [TheThingsStack](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/)
- [OPC-UA](/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/)
- [TCP](/docs/{{peDocsPrefix}}user-guide/integrations/tcp/)
- [UDP](/docs/{{peDocsPrefix}}user-guide/integrations/udp/)
- [CoAP](/docs/{{peDocsPrefix}}user-guide/integrations/coap/)
- [自定义](/docs/{{peDocsPrefix}}user-guide/integrations/custom/)


## 远程集成故障排除

请查看日志文件。它们的位置取决于您使用的平台和安装包，并在安装步骤中提及。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}