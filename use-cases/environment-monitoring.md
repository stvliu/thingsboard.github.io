---
layout: use-case
title: GridLinks 物联网环境监测解决方案
description: GridLinks 物联网环境监测解决方案
notitle: "true"

---

{% include usecase-nav.html usecase="environment-monitoring" %}

<h1 class="usecase-title">环境监测解决方案</h1>

GridLinks 平台大幅缩短了环境监测解决方案的上市时间和创建工作。
该平台广泛用于：

  - 一些大城市的空气质量监测；
  - 包括南极洲在内的每个大陆的天气监测；
  - 救援监测和地震警报/预测；
  - 公共泵和其他设施的水质；
  - 噪音水平；

通过利用以下平台优势，可为您的环境监测解决方案节省高达 90% 的开发时间：

  - 从您的物联网设备和传感器可靠且容错地收集数据；
  - 功能强大的规则引擎，用于处理收集的数据并产生警报和有价值的见解；
  - 用于实时和历史数据的先进且灵活的可视化；
  - 可自定义的最终用户仪表板，用于共享监测结果；
  - 本地和云部署选项；
  - 物联网设备的远程控制和 OTA 更新；
  - 最小编码工作量即可定制移动应用程序；

该平台提供生产就绪的服务器基础设施，用于连接您的物联网设备、存储、分析和共享收集的物联网数据；

## 环境监测仪表板

以下交互式仪表板表示环境监测组件，您可以轻松地将其嵌入到您的物联网解决方案中。
此特定仪表板允许用户监测温度和湿度传感器。
您可以快速将其调整为空气质量或其他传感器，并添加远程控制场景。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/environment-monitoring/em1.png" alt="environment monitoring 1">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/environment-monitoring/em2.png" alt="environment monitoring 2">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/environment-monitoring/em3.png" alt="environment monitoring 3">
    </div>
</div>

<div class="center" style="margin-bottom: 64px;">
    <a target="_blank" href="https://gridlinks.codingas.com/dashboard/dfaef940-8a91-11ec-83d0-83ba2015b874?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button">查看实时演示</a>
</div>

实时仪表板是 [解决方案模板](https://thingsboard.io/docs/paas/solution-templates/temperature-humidity-sensors/) 的一部分，并显示使用 GridLinks MQTT API 收集的温度和湿度传感器的实时数据。
您可以使用仪表板来：

* 添加新传感器；
* 更改传感器的放置位置；
* 配置警报阈值；
* 浏览历史数据。

仪表板有两种状态。主状态显示传感器列表、它们在地图上的位置以及它们的警报列表。
您可以通过单击表格行向下钻取到传感器详细信息状态。传感器详细信息状态允许浏览温度和湿度历史记录、更改传感器设置和位置。

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
                        平台组件是水平可扩展的。GridLinks 的生产部署支持连接超过 500,000 台设备。</p>
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
                    <p>GridLinks 支持行业标准加密算法（如 RSA 和 ECDSA），以确保数据在通过 TLS(TCP) 和 DTLS (UDP) 传输期间的安全。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/engine-icon.svg" alt="Gear icon">
                <div>
                    <a class="title" href="/docs/pe/user-guide/rule-engine-2-0/overview/">数据处理</a>
                    <p>ThingsBoard 允许您使用拖放规则链设计器定义应用程序逻辑。规则引擎是一个强大且可扩展的处理框架，它利用行业标准消息队列实现（如 Apache Kafka 或 AWS SQS）来确保数据持久性和保证数据处理。您可以自由地使用规则引擎处理数据或将其推送到外部系统中进行进一步处理。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/visualization-icon.svg" alt="Data visualization icon">
                <div>
                    <a class="title" href="/docs/user-guide/dashboards/">数据可视化</a>
                    <p>使用丰富的交互式仪表板可视化收集的数据。使用零编码工作量和内置图表、仪表、地图、表格和控制小部件开发多状态交互式仪表板。使用高级小部件设置甚至自定义小部件包自定义每个仪表板方面。通过嵌入式 Web 套接字支持，可以实现低延迟更新。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/device-icon.svg" alt="Device icon">
                <div>
                    <a class="title" href="/docs/mobile/">移动应用程序</a>
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）以最少的编码工作量构建您自己的物联网移动应用程序。利用内置的一组移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="block">
                <img src="/images/tenancy-icon.svg" alt="Tenancy icon">
                <div>
                    <a class="title" href="/docs/user-guide/entities-and-relations/">多租户</a>
                    <p>GridLinks 提供 UI 和 API 来管理租户、客户、用户、设备和资产。单个租户可能有多个租户管理员和数百万台设备和客户。它还开箱即用地支持智能电表的 OTA 更新。</p>
                </div>
            </div>
        </div>
    </div>
</section>

## 环境监测解决方案概述

下图标识了使用 GridLinks 平台收集和分析物联网传感器数据的典型环境监测解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/common-edge.svg"></object>

您可能会注意到物联网传感器的连接选项很多：直接连接到云、通过物联网网关、与第三方系统集成或 GridLinks Edge。
当今大多数环境监测项目都使用部署在监测现场的物联网网关。
通常，此设备要么运行 [GridLinks 物联网网关](/docs/iot-gateway/what-is-iot-gateway/)，要么使用 [网关 API](/docs/reference/gateway-mqtt-api/)。
使用网关，客户可以优化硬件和连接成本。您可以将多个传感器（甚至使用物理线）连接到一个集线器，并且只使用一个连接模块。

高级环境监测物联网解决方案也可能使用 LoRaWAN 或 SigFox 设备。

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