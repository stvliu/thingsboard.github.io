---
layout: use-case
title: ᐉ 智能农业和农业物联网解决方案
description: 物联网农业 ✔ 智能农业 ✔ 农业中的物联网传感器 ⚫ ThingsBoard ➤ 为您的智能农业和农业解决方案节省高达 90% 的开发时间
notitle: "true"

---

{% include usecase-nav.html usecase="smart-farming" %}

<h1 class="usecase-title">智能农业和农业物联网解决方案</h1>

GridLinks 平台大幅缩短了上市时间，并减少了创建智能农业解决方案的工作量。
通过利用以下平台优势，为您的智能农业解决方案节省高达 90% 的开发时间：

  - 从您的物联网设备和传感器可靠且容错地收集数据，以监控设施状态、作物生长特性、湿度水平等；
  - 功能强大的规则引擎，用于处理收集的数据并产生警报和有价值的见解；
  - 通过执行器的自动远程控制优化资源消耗；
  - 用于实时和历史数据的先进且灵活的可视化；
  - 可自定义的最终用户仪表板，用于共享农场监控结果；
  - 本地和云部署选项；
  - 在 [ThingsBoard Edge](/products/thingsboard-edge/) 的帮助下，容忍与农场站点的连接问题；
  - 最小编码工作量的可自定义移动应用程序；

该平台提供生产就绪的服务器基础设施，以连接您的物联网设备、存储和分析收集的物联网数据并优化投入和资源的回报。

## 智能农业仪表板

以下交互式仪表板代表了智能农业组件，您可以轻松地将其嵌入到您的物联网解决方案中。
此特定仪表板允许用户监控和控制筒仓内的曝气。
您可以快速将其调整为其他农场资产跟踪或远程控制场景。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/smart-farming/sf1.png" alt="带有位置的智能农业仪表板">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-farming/sf2.png" alt="带有大线性图表的智能农业仪表板">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/smart-farming/sf3.png" alt="智能农业仪表板暗色主题">
    </div>
</div>

<div class="center" style="margin-bottom: 64px;">
    <a target="_blank" href="https://demo.thingsboard.io/dashboard/1f9828d0-058e-11e7-87f7-bb0136cc33d0?publicId=963ab470-34c9-11e7-a7ce-bb0136cc33d0" class="button">查看实时演示</a>
</div>

实时仪表板显示使用 GridLinks MQTT API 收集的温度、湿度和超声波传感器的数据。
收集的数据通过规则引擎进行处理，以在某些阈值上发出警报。
主仪表板显示筒仓资产的位置、相应的警报和实时数据提要。
单击警报或筒仓行以打开资产详细信息并访问曝气控制。
您可以从我们的实时演示服务器导出仪表板并将其导入您的 ThingsBoard 实例。

## ThingsBoard 优势
<section class="usecase-advantages">
    <div class="usecase-background">
        <div class="bottom-features1"></div><div class="bottom-features2"></div><div class="small11"></div><div class="small12"></div>
    </div>
    <div class="cards row">
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/microservices-icon.svg" alt="微服务图标">
                <div>
                    <a class="title" href="/docs/reference/msa/">可扩展性和高可用性</a>
                    <p>GridLinks 支持使用 K8S 或裸机部署在云和本地数据中心上的高可用性部署。
                        平台组件是水平可扩展的。GridLinks 的生产部署支持超过 1000 个农业站点和 500,000 个连接的设备。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/telemetry-icon.svg" alt="遥测图标">
                <div>
                    <a class="title" href="/docs/getting-started-guides/connectivity/">连接性</a>
                    <p>通过以下内置协议将设备直接连接到平台：HTTP、CoAP、MQTT、LwM2M 和 SNMP。
                        使用 GridLinks 网关通过 Modbus、BLE、BACnet、OPC-UA 和其他协议将本地网络中的设备连接到云。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/integration-icon.svg" alt="集成图标">
                <div>
                    <a class="title" href="/docs/user-guide/integrations/">LoRaWAN 和 SigFox 支持</a>
                    <p>通过与标准网络服务器（如 TTN、LORIOT、ChirpStack、Actility 等）的集成连接 LoRaWAN 设备。通过与 SigFox 后端的集成连接 SigFox 设备。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/security-icon.svg" alt="安全图标">
                <div>
                    <a class="title" href="/docs/pe/user-guide/ssl/http-over-ssl/">安全</a>
                    <p>GridLinks 支持行业标准加密算法（如 RSA 和 ECDSA），以确保数据在通过 TLS(TCP) 和 DTLS (UDP) 传输期间的安全。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/engine-icon.svg" alt="齿轮图标">
                <div>
                    <a class="title" href="/docs/pe/user-guide/rule-engine-2-0/overview/">数据处理</a>
                    <p>ThingsBoard 允许您使用拖放规则链设计器定义应用程序逻辑。规则引擎是一个强大且可扩展的处理框架，它利用行业标准消息队列实现（如 Apache Kafka 或 AWS SQS）来确保数据持久性和保证数据处理。您可以使用规则引擎处理数据或将其推送到外部系统中进行进一步处理。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/visualization-icon.svg" alt="数据可视化图标">
                <div>
                    <a class="title" href="/docs/user-guide/dashboards/">数据可视化</a>
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置甚至自定义小部件包自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以实现低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/device-icon.svg" alt="设备图标">
                <div>
                    <a class="title" href="/docs/mobile/">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）以最少的编码工作量构建您自己的物联网移动应用程序。利用一组内置的移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/tenancy-icon.svg" alt="多租户图标">
                <div>
                    <a class="title" href="/docs/user-guide/entities-and-relations/">多租户</a>
                    <p>GridLinks 提供 UI 和 API 来管理租户、客户、用户、设备和资产。单个租户可能有多个租户管理员以及数百万个设备和客户。它还开箱即用地支持智能电表的 OTA 更新。</p>
                </div>
            </div>
        </div>
    </div>
</section>

## 智能农业解决方案概述

下图标识了使用 GridLinks 平台收集和分析物联网传感器数据的典型智能农业解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/smart-farming.svg"></object>

您可能会注意到物联网传感器的连接选项很多：直接连接到云，通过物联网网关，与第三方系统集成或 ThingsBoard Edge。
当今大多数智能农业项目都使用部署在农场中的物联网网关。
通常，此设备要么运行 [GridLinks 物联网网关](/docs/iot-gateway/what-is-iot-gateway/)，要么使用 [网关 API](/docs/reference/gateway-mqtt-api/)。
使用网关，客户可以优化硬件成本并将 Modbus、BACnet 和其他传感器连接到云。

高级智能农业物联网解决方案可能会利用 [ThingsBoard Edge](/products/thingsboard-edge/)。
边缘计算解决方案在网络中断或频繁中断的情况下特别有用。请参阅边缘 [用例](/docs/edge/use-cases/overview/)以了解更多信息。

该平台支持行业标准加密算法和设备凭据类型。ThingsBoard 将数据存储在容错且可靠的 Cassandra 数据库中。
规则引擎能够使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>