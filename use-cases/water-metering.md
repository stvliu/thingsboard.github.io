---
layout: use-case
title: GridLinks 物联网水表计量解决方案
description: GridLinks 物联网水表计量解决方案
notitle: "true"

---

{% include usecase-nav.html usecase="water-metering" %}

<h1 class="usecase-title">水表计量解决方案</h1>

GridLinks 平台大幅缩短了上市时间，并减少了创建水表计量解决方案的工作量。通过利用以下平台优势，可为您的智能办公解决方案节省多达 90% 的开发时间：

  - 从您的物联网设备和传感器可靠且容错地收集数据；
  - 强大的规则引擎来处理收集的数据并产生警报和有价值的见解；
  - 高级且灵活的可视化，用于实时和历史数据；
  - 可自定义的最终用户仪表板，用于共享监控结果；
  - 本地和云部署选项；
  - 物联网设备的远程控制和 OTA 更新；
  - 最小编码工作量的可自定义移动应用程序；

该平台提供生产就绪的服务器基础设施，以连接您的物联网水表，存储、分析和共享收集的物联网数据；

## 水表计量模板

水表计量 [解决方案模板](https://thingsboard.io/docs/paas/solution-templates/water-metering/) 代表通用水表计量解决方案。
使用此模板，您可以获得交互式仪表板，允许管理员和最终用户浏览水表的状态和汇总水消耗统计信息。
用户能够定义阈值并通过短信或电子邮件启用警报和通知。
您可以轻松地与外部计费系统集成，以根据 GridLinks 的汇总消耗数据生成和分发发票。

<div class="usecase-carousel owl-carousel owl-theme">
    <div>
        <img class="item-image" src="/images/usecases/water-metering/wm1.png" alt="water metering 1">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/water-metering/wm2.png" alt="water metering 2">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/water-metering/wm3.png" alt="water metering 3">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/water-metering/wm4.png" alt="water metering 4">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/water-metering/wm5.png" alt="water metering 5">
    </div>
    <div>
        <img class="item-image" src="/images/usecases/water-metering/wm6.png" alt="water metering 6">
    </div>
</div>

<div class="center" style="margin-bottom: 64px;">
    <a target="_blank" href="https://gridlinks.codingas.com/dashboard/aff5f200-8b48-11ec-a344-c767c1ab1bb8?publicId=4978baf0-8a92-11ec-98f9-ff45c37940c6" class="button">查看实时演示</a>
</div>

实时仪表板是 [解决方案模板](https://thingsboard.io/docs/paas/solution-templates/smart-office/) 的一部分，它允许您：

* 在地图上观察水表的位置和状态。标记被聚类，以便能够同时显示数千个仪表；
* 浏览每天和每周的活动警报和用水量；
* 使用与主仪表板类似的“分析”、“设备”、“警报”视图；
* 使用“设置”视图为特定客户定义警报阈值。默认情况下，生成的警报对租户管理员不可见；

安装解决方案模板后，您还将获得对“水表计量租户仪表板”的访问权限，该仪表板允许您管理水表计量设备、用户和警报：

* 在地图上观察水表的位置和状态。标记被聚类，以便能够同时显示数千个仪表；
* 使用“分析”视图比较当前月和上个月的消耗量；
* 使用“设备”视图获取所有水表设备的列表，并能够
    * 创建新设备并将其分配给客户；
    * 更改设备的位置；
    * 为此设备配置警报阈值；
    * 通过单击设备行导航到“设备”视图；
* 使用“设备”视图：
    * 浏览特定水表设备的用水量历史记录；
    * 浏览特定水表设备的活动警报；
    * 更改水表位置信息
    * 上传水表照片；
    * 更改设备的位置；
* 使用“客户”视图管理您的客户；
* 使用“警报”视图浏览和清除水表的警报；
* 使用“设置”视图：
    * 打开和关闭系统警报；
    * 为系统警报定义阈值；
    * 打开和关闭短信和电子邮件通知；

由于实时演示仪表板是公开可用的，因此某些仪表板功能（例如创建设备的能力）已被禁用。

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
                    <p>ThingsBoard 允许您使用拖放规则链设计器定义应用程序逻辑。规则引擎是一个强大且可扩展的处理框架，它利用行业标准消息队列实现（如 Apache Kafka 或 AWS SQS）来确保数据持久性和保证数据处理。您可以使用规则引擎处理数据或将其推送到外部系统中进行进一步处理。</p>
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
                    <p>使用 GridLinks 移动应用程序（一个基于 Flutter 的开源项目）构建您自己的物联网移动应用程序，并最大限度地减少编码工作量。利用一组内置的移动操作，可以在仪表板中直接拍照、扫描二维码、更新位置等。</p>
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

## 水表计量解决方案概述

下图标识了使用 GridLinks 平台从智能水表收集和分析数据的典型水表计量解决方案的数据流和集成点。

<object width="100%" style="max-width: max-content; margin: 32px 0" data="/images/iot-use-cases/common.svg"></object>

您可能会注意到物联网传感器的连接选项很多：直接连接到云、通过物联网网关、与第三方系统集成或 GridLinks Edge。
如今，大多数水表计量项目使用 LoRaWAN、SigFox 或 NB IoT 来连接水表。

该平台支持行业标准加密算法和设备凭据类型。GridLinks 将数据存储在容错且可靠的 Cassandra 数据库中。规则引擎支持使用 Kafka 或其他消息总线将传入数据转发到各种分析系统，例如 Apache Spark 或 Hadoop。

## 了解更多
<div class="usecases-bottom-nav">
    <a href="/docs/getting-started-guides/helloworld/" class="button">入门</a>
    <a href="/industries/smart-energy/" class="button">客户反馈</a>
    <a href="/docs/#platform-features" class="button">平台功能</a>
    <a href="/docs/reference/" class="button">架构</a>
    <a href="/docs/contact-us/" class="button">联系我们</a>
</div>