---
layout: use-case
title: 物联网智能零售解决方案与 ThingsBoard
description: 物联网智能零售解决方案与 ThingsBoard
notitle: "true"

---

{% include usecase-nav.html usecase="smart-retail" %}

<h1 class="usecase-title">智能零售解决方案</h1>

智能零售 [解决方案模板](/docs/paas/solution-templates/smart-retail/) 代表通用智能零售解决方案。
作为解决方案提供商，您可以配置多个客户并为每个客户分配物联网设备池。

每个客户都可以配置其超市资产，包括自定义平面图。
您或您的客户可以物理安装设备并在平面图上逻辑放置它们。

客户用户可以为每个设备配置特定阈值。
所有用于发出警报的逻辑已在相应的设备配置文件中预先配置。

使用此模板，您可以获得交互式仪表板，让您和您的客户可以浏览超市的当前和历史状态。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/smart-retail/sr1.png" alt="smart retail 1">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-retail/sr2.png" alt="smart retail 2">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-retail/sr3.png" alt="smart retail 3">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-retail/sr4.png" alt="smart retail 4">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-retail/sr5.png" alt="smart retail 5">
    </div>
</div>

<div class="center" style="margin-bottom: 64px;">
    <a target="_blank" href="https://thingsboard.cloud/dashboard/551d4ca0-8b54-11ec-98f9-ff45c37940c6?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button">查看实时演示</a>
</div>

实时仪表板是 [解决方案模板](/docs/paas/solution-templates/smart-retail) 的一部分，旨在让超市经理监控超市状态并对警报做出反应。它具有多种状态：

* **主要**状态包含超市地图和警报列表。
警报从设备传播到相应的超市。
平台根据传播警报的最高严重性计算每个超市的状态。
作为用户，您可以根据超市的状态在地图上过滤超市。
* **平面图**状态包含超市平面图和设备标记的室内地图。
除了地图外，状态还包含两个过滤器：基于设备类型和设备状态。
过滤器设置在用户级别上保留。
    * 状态过滤器允许您根据警报的最高严重性过滤设备。
      例如，您可以选择显示至少有一个严重警报的设备。
    * 设备类型过滤器允许您根据设备类型显示或隐藏特定设备。
      例如，您只能显示冰柜和冷藏柜并隐藏所有其他设备。
    * 单击特定设备标记以在仪表板的右侧面板中显示设备详细信息状态。
      设备详细信息的内容特定于设备类型。
      例如，冷冻设备有一个带有温度读数的折线图，而智能垃圾箱有一个带有满载水平的条形图。
      然而，设备详细信息的共同元素是标题和警报列表。
      标题包含有关设备当前状态和电池电量（如果设备由电池供电）的信息。
      标题还允许您导航到特定设备的设置。这些设置允许您配置警报阈值。

实时演示仪表板上的某些仪表板功能（例如，删除设备的能力）已被禁用，因为它是公开可用的。

安装解决方案模板后，您还将获得对“**智能超市管理**”的访问权限，该权限允许您配置客户、其用户、超市和设备。它具有多种状态：

* **主要**状态允许您列出零售公司（客户）。
  我们假设客户是拥有一个或多个超市的零售公司。
  我们已配置了两个“假”零售公司，其中包含许多超市，以进行演示。
 * **设备管理**状态允许您管理零售公司（客户）范围内的设备。
  您可以配置新设备或删除现有设备。该状态显示一个表格，其中包含分配给此零售公司的所有设备。
  这意味着租户或超市管理员将能够使用这些设备将它们定位在超市中。
  您可以将此列表视为可安装在客户超市中的设备池。
* **超市管理**状态允许您管理零售公司（客户）范围内的超市。
    仪表板状态在地图上显示超市并在表格中列出超市。
    超市是可能包含多个设备和几个属性的资产：平面图和地址。
* **超市设备**状态显示超市平面图和设备标记的室内地图。
    您可以拖放设备标记以定义设备在超市中的精确位置。

GridLinks 平台极大地缩短了上市时间并减少了创建智能零售解决方案的精力。
通过利用以下平台优势，为您的智能零售解决方案节省高达 90% 的开发时间：

- 从您的物联网设备和传感器可靠且容错地收集数据；
- 强大的规则引擎来处理收集的数据并产生警报和有价值的见解；
- 用于实时和历史数据的先进且灵活的可视化；
- 可自定义的最终用户仪表板以共享监控结果；
- 本地和云部署选项；
- 物联网设备的远程控制和 OTA 更新；
- 最小编码工作量的可自定义移动应用程序。

该平台提供生产就绪的服务器基础设施来连接您的物联网设备、存储、分析和共享收集的物联网数据。


## GridLinks 优势
<section class="usecase-advantages">
    <div class="usecase-background">
        <div class="bottom-features1"></div><div class="bottom-features2"></div><div class="small11"></div><div class="small12"></div>
    </div>
    <div class="cards row">
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/microservices-icon.svg" alt="Microservice icon">
                <div>
                    <a class="title" href="/docs/reference/msa/">可扩展性和高可用性</a>
                    <p>GridLinks 支持使用 K8S 或裸机部署在云和本地数据中心上的高可用性部署。
                        平台组件是水平可扩展的。ThingsBoard 具有支持连接超过 500,000 台设备的生产部署。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/telemetry-icon.svg" alt="Telemetry icon">
                <div>
                    <a class="title" href="/docs/getting-started-guides/connectivity/">连接性</a>
                    <p>通过以下内置协议将设备直接连接到平台：HTTP、CoAP、MQTT、LwM2M 和 SNMP。
                        使用 GridLinks 网关通过 Modbus、BLE、BACnet、OPC-UA 和其他协议将本地网络中的设备连接到云。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/integration-icon.svg" alt="Integration icon">
                <div>
                    <a class="title" href="/docs/user-guide/integrations/">LoRaWAN 和 SigFox 支持</a>
                    <p>通过与标准网络服务器（如 TTN、LORIOT、ChirpStack、Actility 等）集成来连接 LoRaWAN 设备。通过与 SigFox 后端集成来连接 SigFox 设备。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/security-icon.svg" alt="Security icon">
                <div>
                    <a class="title" href="/docs/pe/user-guide/ssl/http-over-ssl/">安全性</a>
                    <p>GridLinks 支持行业标准加密算法（如 RSA 和 ECDSA），以确保数据在通过 TLS(TCP) 和 DTLS (UDP) 传输期间是安全的。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/engine-icon.svg" alt="Gear icon">
                <div>
                    <a class="title" href="/docs/pe/user-guide/rule-engine-2-0/overview/">数据处理</a>
                    <p>ThingsBoard 允许您使用拖放规则链设计器定义应用程序逻辑。规则引擎是一个强大且可扩展的处理框架，它利用行业标准消息队列实现（如 Apache Kafka 或 AWS SQS）来确保数据持久性和保证数据处理。您可以使用规则引擎处理数据或将其推送到外部系统中进行进一步处理。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/visualization-icon.svg" alt="Data visualization icon">
                <div>
                    <a class="title" href="/docs/user-guide/dashboards/">数据可视化</a>
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置甚至自定义小部件包来自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以实现低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/device-icon.svg" alt="Device icon">
                <div>
                    <a class="title" href="/docs/mobile/">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）构建您自己的物联网移动应用程序，该应用程序具有最少的编码工作量。利用一组内置的移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/tenancy-icon.svg" alt="Tenancy icon">
                <div>
                    <a class="title" href="/docs/user-guide/entities-and-relations/">多租户</a>
                    <p>GridLinks 提供 UI 和 API 来管理租户、客户、用户、设备和资产。单个租户可能有多个租户管理员以及数百万台设备和客户。它还开箱即用地支持智能电表的 OTA 更新。</p>
                </div>
            </div>
        </div>
    </div>
</section>

## 智能零售解决方案概述

下图标识了使用 GridLinks 平台从多个来源收集和分析数据来监控超市的典型解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/common-edge.svg"></object>

您可能会注意到物联网传感器的许多连接选项：直接连接到云、通过物联网网关、与第三方系统集成或 GridLinks Edge。

该平台支持行业标准加密算法和设备凭据类型。ThingsBoard 将数据存储在容错且可靠的 Cassandra 数据库中。
规则引擎支持使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多信息
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>