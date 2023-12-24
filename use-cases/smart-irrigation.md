---
layout: use-case
title: 智能灌溉解决方案
description: GridLinks IoT 平台的灌溉管理、田地配置和数据可视化
notitle: "true"

---

{% include usecase-nav.html usecase="smart-irrigation" %}

<h1 class="usecase-title">智能灌溉解决方案</h1>

众所周知，在农业领域，成功的关键指标是产量和产品的高质量。然而，实现这些指标需要农民付出大量努力和资源。农产品稳定生产的主要条件之一是作物生长所需的土壤水分。然而，并非所有地区都能拥有理想的气候条件。有时，土壤水分不足以及在生长过程中对作物进行不当的监测和护理会导致负面后果：收成损失，进而导致利润损失。

灌溉系统通常用于解决农业和灌溉土地的问题，这有助于农民在种植和收获产品方面取得良好的成果。

我们开发了智能灌溉 <a href="/docs/paas/solution-templates/smart-irrigation/">模板</a> 来表示通用的田地灌溉解决方案。

<h2>解决方案结构</h2>

智能灌溉仪表板允许您监控灌溉系统并及时响应田地条件的变化，并且具有您可以轻松嵌入到您的物联网解决方案中的组件。

此外，此仪表板有几个状态：**主状态**和**田地状态**：
- **主状态** 用于用户列出田地并监控其土壤水分、位置、统计信息等；
- **田地状态** 显示有关田地的详细信息。它允许您管理水分监测传感器，观察土壤水分水平，安排灌溉，查看统计信息等。

<h2>智能灌溉优势</h2>
通过利用以下平台优势，为您的智能灌溉解决方案节省高达 90% 的开发时间：
- 为您的智能传感器和土壤水分监测器提供可靠且可扩展的数据收集；
- 功能强大的规则引擎来处理收集的数据并产生警报和有价值的见解；
- 先进且灵活的可视化，用于实时和历史数据；
- 可自定义的最终用户仪表板，用于分析和共享土壤水分监测结果；
- 与第三方分析框架和解决方案集成，用于高级使用分析；
- 远程控制和 OTA 更新，适用于您的智能传感器和其他设备；
- 最小编码工作量的可自定义移动应用程序。


<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/solutions/smart_irrigation/smart-irrigation-1.png" alt="smart irrigation 1">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/smart_irrigation/smart-irrigation-2.png" alt="smart irrigation 2">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/smart_irrigation/smart-irrigation-3.png" alt="smart irrigation 3">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/smart_irrigation/smart-irrigation-4.png" alt="smart irrigation 4">
    </div>
    <div>
        <img class="item-image" src="/images/solutions/smart_irrigation/smart-irrigation-5.png" alt="smart irrigation 5">
    </div>
</div>


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
                    <p>GridLinks 支持使用 K8S 或裸机部署在云和本地数据中心上的高可用性部署。平台组件是水平可扩展的。GridLinks 具有超过 500,000 个智能电表的生产部署。</p>
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
                    <p>通过与标准网络服务器（如 TTN、LORIOT、ChirpStack、Actility 等）集成来连接 LoRaWAN 设备。通过与 SigFox 后端的集成来连接 SigFox 设备。</p>
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
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置甚至自定义小部件包自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以进行低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/phone-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/mobile">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）构建您自己的物联网移动应用程序，并以最少的编码工作量。利用内置的一组移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/tenancy-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/user-guide/entities-and-relations/">多租户</a>
                    <p>GridLinks 提供 UI 和 API 来管理租户、客户、用户、设备和资产。单个租户可能有多个租户管理员以及数百万个设备和客户。它还开箱即用地支持智能电表的 OTA 更新。</p>
                </div>
            </div>
        </div>
    </div>
</section>

## 智能灌溉解决方案概述

下图标识了使用 GridLinks 平台收集和分析来自传感器的监测数据，用于典型的智能灌溉监测解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/smart-energy-diagram.svg"></object>

您可能会注意到土壤水分传感器有很多连接选项：直接连接到云、通过物联网网关或与第三方系统的集成。
该平台支持行业标准加密算法和设备凭据类型。GridLinks 将数据存储在容错且可靠的 Cassandra 数据库中。
规则引擎能够使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>