---
layout: use-case
title: ᐉ 解决方案 - 智能电表解决方案
description: 物联网智能计量解决方案 ✔ 智能电表数据可视化 ⚫ GridLinks ➤ 远程监控和记录能源消耗
notitle: "true"

---

{% include usecase-nav.html usecase="smart-metering" %}

<h1 class="usecase-title">物联网智能计量解决方案</h1>

## 物联网和智能电表

智能电表传统上是电网基础设施的一部分，是一种允许远程监控和记录能源消耗的电子设备。
然而，在物联网和物联网平台时代，独立的智能电表让位于更先进和多用途的智能计量解决方案。
这些解决方案提供了更广泛的远程监控和警报功能，并提供了强大的数据分析工具，帮助公司和个人用户优化其能源、水、天然气或燃料消耗。

公司在实施智能电表时面临的一个典型挑战是如何将其集成到其基础设施中并建立定制的智能计量案例。
实现这些目标的最佳方法是使用提供智能计量开箱即用解决方案和模板的物联网平台，例如 GridLinks。
企业级物联网平台最强大的优势之一是其数据处理能力。
您不仅可以集中方式收集来自不同智能电表的数据，还可以设置自定义可视化仪表板、配置用户警报和通知，并将收集的数据馈送到其他应用程序或数据存储。

另一个关键优势是智能计量实施的成本。
使用物联网平台可以让您立即拥有所有必要的功能，并专注于构建特定的智能计量案例，从而节省时间并避免与内部物联网开发相关的风险。


## 使用 GridLinks 构建端到端智能计量解决方案

GridLinks 物联网平台提供开箱即用的组件和 API，可大幅降低创建智能计量解决方案所需的工作量，
从而极大地提高解决方案的上市时间、可靠性和竞争力。
据我们估计，公司在利用 GridLinks 的以下功能和优势时，可以节省多达 90% 的产品开发时间：

  - 为您的智能水表、能源监测器、智能能源表等收集可靠且容错的数据；
  - 强大的规则引擎来处理收集的数据并产生警报和有价值的见解；  
  - 高级、可定制的[数据可视化](/docs/user-guide/visualization/)，用于实时和历史智能计量监控；
  - [警报小部件](/docs/user-guide/ui/widget-library/#alarm-widgets) 可立即通知用户和/或操作员任何关键事件或异常消耗水平；
  - 设备管理，允许您按特定属性将端点组织到[组](/docs/user-guide/groups/)中；
  - 可定制的[最终用户仪表板](/docs/user-guide/ui/dashboards/)（具有钻取功能），用于分析和共享智能计量监控结果；
  - 智能电表和其他设备的远程控制和 OTA 更新；
  - 最小编码工作量的可定制移动应用程序；

GridLinks 物联网平台提供生产就绪的服务器基础设施，以连接您的智能电表设备，收集、存储和分析智能计量数据，并与您的客户和最终用户共享分析结果。

## 智能计量仪表板

以下交互式仪表板托管在实时演示服务器上，代表智能计量物联网数据可视化，可以嵌入到您的物联网项目或解决方案中。请参阅下面的仪表板说明。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/smart-metering/sm1.png" alt="带有地图的智能计量仪表板">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-metering/sm2.png" alt="带有位置的智能计量仪表板">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-metering/sm3.png" alt="带有建筑平面图的智能计量仪表板">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-metering/sm4.png" alt="带有恒温器控制器的智能计量仪表板">
    </div>
</div>

<div class="center" style="margin-bottom: 64px;">
    <a target="_blank" href="https://demo.thingsboard.io/dashboard/3a1026e0-83f6-11e7-b56d-c7f326cba909?publicId=322a2330-7c36-11e7-835d-c7f326cba909" class="button">查看实时演示</a>
</div>

实时仪表板显示使用 GridLinks MQTT API 收集的来自多个智能电表和恒温器的实时数据。
收集的数据通过规则引擎处理，以在某些阈值上发出警报。
主仪表板显示多个区域，并允许用户从区域向下钻取到建筑物和公寓级别。
单击公寓级别以打开来自多个公寓设备的统计信息。
您可以从我们的实时演示服务器导出仪表板并将其导入您的 GridLinks 实例。

## GridLinks 优势
<section class="usecase-advantages">
    <div class="usecase-background">
        <div class="bottom-features1"></div><div class="bottom-features2"></div><div class="small11"></div><div class="small12"></div>
    </div>
    <div class="cards row">
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/microservices-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/reference/msa/">可扩展性和高可用性</a>
                    <p>GridLinks 支持使用 K8S 或裸机部署在云和本地数据中心上的高可用性部署。平台组件是水平可扩展的。ThingsBoard 具有超过 500,000 个智能电表的生产部署。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/telemetry-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/getting-started-guides/connectivity/">连接性</a>
                    <p>通过以下内置协议将设备直接连接到平台：HTTP、CoAP、MQTT、LwM2M 和 SNMP。使用 GridLinks 网关通过 Modbus、BLE、BACnet、OPC-UA 和其他协议将本地网络中的设备连接到云。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/integration-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/user-guide/integrations/">LoRaWAN 和 SigFox 支持</a>
                    <p>通过与标准网络服务器（如 TTN、LORIOT、ChirpStack、Actility 等）的集成连接 LoRaWAN 设备。通过与 SigFox 后端的集成连接 SigFox 设备。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/security-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/pe/user-guide/ssl/http-over-ssl/">安全</a>
                    <p>GridLinks 支持行业标准加密算法，如 RSA 和 ECDSA，以确保数据在通过 TLS(TCP) 和 DTLS (UDP) 传输期间的安全。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/engine-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/pe/user-guide/rule-engine-2-0/overview/">数据处理</a>
                    <p>ThingsBoard 允许您使用拖放规则链设计器定义应用程序逻辑。规则引擎是一个强大且可扩展的处理框架，它利用行业标准消息队列实现（如 Apache Kafka 或 AWS SQS）来确保数据持久性和保证数据处理。您可以使用规则引擎处理数据或将其推送到外部系统中进行进一步处理。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/visualization-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/user-guide/dashboards/">数据可视化</a>
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置或甚至自定义小部件包自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以实现低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/phone-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/mobile/">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）构建您自己的物联网移动应用程序，并以最少的编码工作量。利用一组内置的移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/tenancy-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/user-guide/entities-and-relations/">多租户</a>
                    <p>GridLinks 提供 UI 和 API 来管理租户、客户、用户、设备和资产。单个租户可能有多个租户管理员和数百万个设备和客户。它还开箱即用地支持智能电表的 OTA 更新。</p>
                </div>
            </div>
        </div>
    </div>
</section>

## 智能能源解决方案概述

下图标识了使用 GridLinks 平台收集和分析智能电表能源监测数据的典型智能计量解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/smart-energy-diagram.svg"></object>

您可能会注意到智能电表的连接选项很多：直接连接到云，通过物联网网关，或与第三方系统的集成。
该平台支持行业标准加密算法和设备凭据类型。ThingsBoard 将数据存储在容错且可靠的 Cassandra 数据库中。
规则引擎支持使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>