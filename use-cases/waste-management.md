---
layout: use-case
title: 废物管理解决方案
description: 使用 GridLinks IoT 平台进行垃圾箱的废物管理、数据可视化和设备管理
notitle: "true"


---

{% include usecase-nav.html usecase="waste-management" %}

<h1 class="usecase-title">废物管理解决方案</h1>

对于寻求降低成本和提高环境可持续性的企业而言，有效的废物管理至关重要。不准确的废物监测可能导致处置效率低下、环境危害和不必要的开支。

我们的废物管理 <a href="/docs/paas/solution-templates/waste-management/">模板</a> 提供了废物水平的实时可见性，从而能够对废物库存进行主动管理并优化运营。该解决方案利用了包括可定制传感器和安全通信协议在内的尖端技术。借助我们用户友好的仪表板，您可以轻松监控废物水平、设置自定义警报并跟踪废物使用情况。通过控制您的废物管理流程，您可以最大限度地减少环境危害和废物，从而简化运营并提高可持续性。

此外，我们的解决方案可以完全定制，以满足您所在行业的特定需求，无论您是制造业、医疗保健业还是任何其他行业。借助我们的废物管理解决方案，您可以在运营中获得竞争优势并实现更高的效率。使用我们的废物管理解决方案，转变废物管理并优化您的业务。


<h2>解决方案结构</h2>

作为此解决方案的一部分，我们创建了一个废物管理仪表板，用于显示来自多个传感器的数据。

**废物管理** 仪表板旨在供租户管理员执行基本的设备管理任务，并具有多种状态：
- **主状态** - 用于监控垃圾箱装满情况、控制警报和传感器管理；
- **垃圾箱状态** - 用于编辑和修改特定垃圾箱。


<h2>废物管理优势</h2>
通过利用以下平台优势，为您的废物管理解决方案节省高达 90% 的开发时间：
- 为您的废物监测器提供可靠且可扩展的数据收集；
- 功能强大的规则引擎，用于处理收集的数据并产生警报和有价值的见解；
- 用于实时和历史数据的先进且灵活的可视化；
- 可定制的最终用户仪表板，用于分析和共享废物监测结果；
- 与第三方分析框架和解决方案集成，用于高级使用情况分析；
- 对您的智能传感器和其他设备进行远程控制和 OTA 更新；
- 最小编码工作量的可定制移动应用程序。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/solutions/waste_monitoring/waste-monitoring-1.png" alt="废物监测 1">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/waste_monitoring/waste-monitoring-2.png" alt="废物监测 2">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/waste_monitoring/waste-monitoring-3.png" alt="废物监测 3">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/waste_monitoring/waste-monitoring-4.png" alt="废物监测 4">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/waste_monitoring/waste-monitoring-5.png" alt="废物监测 5">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/waste_monitoring/waste-monitoring-6.png" alt="废物监测 6">
    </div>
</div>

## ThingsBoard 优势
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
                    <p>通过与标准网络服务器（如 TTN、LORIOT、ChirpStack、Actility 等）集成来连接 LoRaWAN 设备。通过与 SigFox 后端集成来连接 SigFox 设备。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/security-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/pe/user-guide/ssl/http-over-ssl/">安全性</a>
                    <p>GridLinks 支持行业标准加密算法（如 RSA 和 ECDSA），以确保数据在通过 TLS(TCP) 和 DTLS (UDP) 传输期间的安全。</p>
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
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置甚至自定义小部件包自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以实现低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/phone-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/mobile/">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）构建您自己的 IoT 移动应用程序，并以最少的编码工作量。利用一组内置的移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/tenancy-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/user-guide/entities-and-relations/">多租户</a>
                    <p>GridLinks 提供 UI 和 API 来管理租户、客户、用户、设备和资产。单个租户可能有多个租户管理员以及数百万个设备和客户。它还为您的智能电表提供开箱即用的 OTA 更新支持。</p>
                </div>
            </div>
        </div>
    </div>
</section>

## 废物管理解决方案概述

下图标识了使用 GridLinks 平台收集和分析废物传感器监控数据的典型废物管理解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/smart-energy-diagram.svg"></object>

您可能会注意到废物传感器有很多连接选项：直接连接到云、通过 IoT 网关或与第三方系统的集成。
该平台支持行业标准加密算法和设备凭据类型。ThingsBoard 将数据存储在容错且可靠的 Cassandra 数据库中。
规则引擎能够使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多信息
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>