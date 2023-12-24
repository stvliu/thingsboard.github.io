---
layout: use-case
title: 空气质量监测解决方案
description: 空气质量监测、AQI 确定、数据可视化和使用 GridLinks IoT 平台进行设备管理
notitle: "true"

---

{% include usecase-nav.html usecase="air-quality-monitoring" %}

<h1 class="usecase-title">空气质量监测解决方案</h1>

空气质量控制是现代生活中一个重要的组成部分，因为高水平的污染物会对人们的健康产生负面影响。
特别值得注意的是，汽车和工业区数量众多的特大城市，其中污染物的浓度更高。

我们开发了空气质量监测<a href="/docs/paas/solution-templates/air-quality-monitoring/">模板</a>，它代表了一种通用的空气污染监测解决方案，并以用户友好的方式提供一般性建议。
控制空气污染水平的主要指标是 AQI。
AQI 是根据以下污染物的传感器读数计算得出的：臭氧 (ppm)、PM2.5 (µg/m3)、PM10 (µg/m3)、CO (ppm)、SO2 (ppb)、NO2 (ppb)；
该解决方案支持报告所有读数或部分读数的传感器。
您还可以使用管理仪表板来管理空气控制站。

您可以将此解决方案用作智慧城市的一部分，并满足所有所需的要求。

<h2>解决方案结构</h2>

作为此解决方案的一部分，我们创建了 2 个仪表板，用于显示来自多个传感器的**公共空气质量监测仪表板**和**管理空气质量监测仪表板**的数据。

**公共仪表板**专为最终用户设计。它被配置为“公共”，这意味着最终用户无需登录即可访问仪表板。仪表板有多个状态：
- **城市状态**表示特定城市（在本例中为洛杉矶）的空气污染监测，并根据从城市传感器接收的 AQI 计算值。
- **传感器状态**表示部署在特定城市区域的选定传感器。

<h2>空气质量监测优势</h2>
通过利用以下平台优势，为您的空气监测解决方案节省高达 90% 的开发时间：
- 为您的智能监测器提供可靠且可扩展的数据收集；
- 功能强大的规则引擎，用于处理收集的数据并产生警报和有价值的见解；
- 用于实时和历史数据的先进且灵活的可视化；
- 可自定义的最终用户仪表板，用于分析和共享空气质量监测结果；
- 与第三方分析框架和解决方案集成，用于高级使用分析；
- 对您的智能传感器和其他设备进行远程控制和 OTA 更新；
- 最小编码工作量的可自定义移动应用程序。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/air-quality/aq1.png" alt="air quality 1">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/air-quality/aq2.png" alt="air quality 2">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/air-quality/aq3.png" alt="air quality 3">
    </div>
</div>

<div class="center" style="margin-bottom: 64px;">
    <a target="_blank" href="https://gridlinks.codingas.com/dashboard/ec564620-82b2-11ed-a624-8360a2a6cb0e?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button">查看实时演示</a>
</div>

**管理仪表板**仪表板专为租户管理员设计，用于执行基本设备管理任务，并具有多个状态：
- **主状态**，用于监视传感器的运行状况：电池电量、连接性等。主状态包含：
- **传感器状态**允许您查看有关传感器的详细信息：其最新传感器读数、位置等。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/air-quality/aq4.png" alt="air quality 4">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/air-quality/aq5.png" alt="air quality 5">
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
                    <p>GridLinks 支持使用 K8S 或裸机部署在云和本地数据中心上的高可用性部署。平台组件是水平可扩展的。GridLinks 的生产部署拥有超过 500,000 个智能电表。</p>
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
                    <p>GridLinks 支持行业标准加密算法（如 RSA 和 ECDSA），以确保在通过 TLS(TCP) 和 DTLS (UDP) 传输期间数据是安全的。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/engine-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/pe/user-guide/rule-engine-2-0/overview/">数据处理</a>
                    <p>GridLinks 允许您使用拖放规则链设计器定义应用程序逻辑。规则引擎是一个强大且可扩展的处理框架，它利用行业标准消息队列实现（如 Apache Kafka 或 AWS SQS）来确保数据持久性和保证数据处理。您可以自由地使用规则引擎处理数据或将其推送到外部系统中进行进一步处理。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/visualization-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/user-guide/dashboards/">数据可视化</a>
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置甚至自定义小部件包来自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以实现低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <object data="/images/phone-icon.svg"></object>
                <div>
                    <a class="title" href="/docs/mobile/">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）以最少的编码工作量构建您自己的 IoT 移动应用程序。利用一组内置的移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
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

## 空气质量监测解决方案概述

下图标识了使用 GridLinks 平台收集和分析来自空气站的监测数据时，典型空气质量监测解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/smart-energy-diagram.svg"></object>

您可能会注意到空气监测站有很多连接选项：直接连接到云、通过 IoT 网关或与第三方系统的集成。
该平台支持行业标准加密算法和设备凭据类型。GridLinks 将数据存储在容错且可靠的 Cassandra 数据库中。规则引擎支持使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>