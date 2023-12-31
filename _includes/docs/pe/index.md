{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'pe/' %}
{% assign platformName = 'GridLinks专业版 ' %}
{% assign firstRowItemClasses = 'col-12 col-sm-6 col-lg col-xxl-6 col-4xl' %}
{% assign faqItemClasses = 'col-12 col-sm-6 col-lg col-xxl-6 col-4xl' %}
<p>GridLinks专业版(PE)文档可以帮助您设置GridLinks专业版、了解该平台并让您的物联网项目在GridLinks专业版上运行。</p>
{% elsif docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% assign platformName = 'GridLinks 云服务' %}
{% assign firstRowItemClasses = 'col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3' %}
{% assign faqItemClasses = 'col col-lg-6 col-xxl col-4xl-6' %}
<p>GridLinks云服务文档可以帮助您开始使用GridLinks云服务、了解该平台并让您的物联网项目在GridLinks云服务上运行。</p>
{% endif %}

<div class="doc-features row mt-4">
    <div class="{{firstRowItemClasses}} mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}getting-started-guides/what-is-thingsboard/">
            <img class="feature-logo" src="/images/feature-logo/thingsboard-logo.svg" alt="GridLinks logo">
            <div class="feature-title">什么是 GridLinks？</div>
            <div class="feature-text">
                <ul>
                    <li>功能</li>
                    <li>架构</li>
                </ul>
            </div>
        </a>
    </div>
    <div class="{{firstRowItemClasses}} mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}getting-started-guides/helloworld/">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="Getting started icon">
            <div class="feature-title">入门</div>
            <div class="feature-text">
                了解如何使用 {{platformName}} 平台。
            </div>
        </a>
    </div>
{% if docsPrefix == 'pe/' %}
    <div class="{{firstRowItemClasses}} mb-4">
        <a class="feature-card" href="/docs/user-guide/install/pe/installation-options/">
            <img class="feature-logo" src="/images/feature-logo/install.svg" alt="Install icon">
            <div class="feature-title">安装</div>
            <div class="feature-text">
                了解如何安装和升级平台。
            </div>
        </a>
    </div>
{% endif %}
    <div class="{{faqItemClasses}} mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}faq/">
            <img class="feature-logo" src="/images/feature-logo/faq.svg" alt="Question icon">
            <div class="feature-title">常见问题</div>
            <div class="feature-text">
                获取最常见问题的答案。
            </div>
        </a>
    </div>
    <!-- <div class="w-100"></div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="https://www.youtube.com/channel/UCDb9fsV-YR4JmnipAMGsVAQ/videos">
            <img class="feature-logo" src="/images/feature-logo/tutorials.svg" alt="Tutorials icon">
            <div class="feature-title">视频教程</div>
            <div class="feature-text">
                在 YouTube 上观看有关平台功能的教程。
            </div>
        </a>
    </div> -->
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}devices-library/">
            <img class="feature-logo" src="/images/feature-logo/guides.svg" alt="Guides icon">
            <div class="feature-title">设备库</div>
            <div class="feature-text">
                了解如何将不同设备连接到 {{platformName}}。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}guides/">
            <img class="feature-logo" src="/images/feature-logo/guides.svg" alt="Guides icon">
            <div class="feature-title">指南</div>
            <div class="feature-text">
               了解主要的 {{platformName}} 功能。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-3 col-xxl-6 col-4xl-3 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}api/">
            <img class="feature-logo" src="/images/feature-logo/api.svg" alt="Api documentation icon">
            <div class="feature-title">API</div>
            <div class="feature-text">
                了解设备连接和服务器端平台特定的 API。
            </div>
        </a>
    </div>
</div>

<h2 id="features">功能</h2>

<div class="doc-features row mt-4">
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}guides/#AnchorIDDataVisualization">
            <div class="feature-title">数据可视化</div>
            <div class="feature-text">
                涵盖数据可视化功能：小部件、仪表板、仪表板状态。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/telemetry/">
            <div class="feature-title">遥测</div>
            <div class="feature-text">
                用于收集时间序列数据和相关用例的 API。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/reporting/">
            <div class="feature-title">报告</div>
            <div class="feature-text">
                使用现有仪表板生成报告并通过电子邮件将其分发给最终用户。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/attributes/">
            <div class="feature-title">属性</div>
            <div class="feature-text">
                平台能够将自定义键值属性分配给您的实体（例如配置、数据处理、可视化参数）。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/">
            <div class="feature-title">规则引擎</div>
            <div class="feature-text">
                涵盖传入遥测和事件的数据处理和操作。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/entities-and-relations/">
            <div class="feature-title">实体和关系</div>
            <div class="feature-text">
                平台能够对物理世界对象（例如设备和资产）及其之间的关系进行建模。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/audit-log/">
            <div class="feature-title">审计日志</div>
            <div class="feature-text">
                跟踪用户活动和 API 调用使用情况。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/api-limits/">
            <div class="feature-title">API限流</div>
            <div class="feature-text">
                通过限制单个时间单位内来自单个主机的请求数量来控制 API 使用。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/rpc/">
            <div class="feature-title">远程调用</div>
            <div class="feature-text">
                API 和小部件可将命令从应用程序和仪表板推送到设备，反之亦然。
            </div>
        </a>
    </div>
    <!-- <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/white-labeling/">
            <div class="feature-title">品牌定制</div>
            <div class="feature-text">
                在 2 分钟内配置您的公司或产品徽标、配色方案和邮件模板。
            </div>
        </a>
    </div> -->
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/scheduler/">
            <div class="feature-title">调度器</div>
            <div class="feature-text">
                使用灵活的配置选项安排各种类型的事件（即配置更新、报告生成、rpc 命令）。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}user-guide/advanced-filters/">
            <div class="feature-title">高级过滤器</div>
            <div class="feature-text">
                过滤实体字段、属性和最新遥测数据。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/groups/">
            <div class="feature-title">设备和资产组</div>
            <div class="feature-text">
                配置多个自定义设备和资产组。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg-4 col-xxl-6 col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/csv-xls-data-export/">
            <div class="feature-title">CSV/XLS数据导出</div>
            <div class="feature-text">
               将数据从小部件导出到 CSV 或 XLS。
            </div>
        </a>
    </div>
    <div class="col col-lg-4 col-xxl col-4xl-4 mb-4">
        <a class="feature-card" href="/docs/{{peDocsPrefix}}user-guide/file-storage/">
            <div class="feature-title">文件存储</div>
            <div class="feature-text">
                能够在数据库中存储二进制内容（文件）。
            </div>
        </a>
    </div>
    <div class="w-100"></div>
    <div class="col col-lg-8 col-xxl col-4xl-8 mb-4">
        <div class="feature-card">
            <div class="feature-title"><a href="/docs/{{peDocsPrefix}}user-guide/integrations/">平台集成</a></div>
            <div class="feature-text">
                使用 NB IoT、LoRaWAN 和 SigFox、特定有效负载格式或各种物联网平台等连接解决方案连接设备。
            </div>
            <div class="row mt-4">
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/http/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/http.svg" alt="HTTP logo icon"><span>HTTP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/opc-ua.svg" alt="OPC-UA logo icon"><span>OPC-UA</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/mqtt.svg" alt="MQTT logo icon"><span>MQTT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/sigfox.svg" alt="SigFox logo icon"><span>SigFox</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/tcp/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/tcp.svg" alt="TCP logo icon"><span>TCP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/azure-event-hub/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/azure-event-hub.svg" alt="Azure Event Hub logo icon"><span>Azure Event Hub</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/azure-iot-hub/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/azure-iot-hub.svg" alt="Azure IoT Hub logo icon"><span>Azure IoT Hub</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/coap/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/coap.svg" alt="CoAP logo icon"><span>CoAP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/thingpark.svg" alt="Thing Park logo icon"><span>ThingPark</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/ttn/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/ttn.svg" alt="The Things Stack Community logo icon"><span>TheThingsStackCommunity</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/tti/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/things-stack-industries.svg" alt="The Things Stack Industries logo icon"><span>TheThingsStackIndustries</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/chirpstack.svg" alt="Chirp Stack logo icon"><span>ChirpStack</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/apache-pulsar.svg" alt="Apache Pulsar logo icon"><span>Apache Pulsar</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/aws-iot/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/aws-iot.svg" alt="AWS IoT logo icon"><span>AWS IoT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/aws-kinesis/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/aws-kinesis.svg" alt="AWS Kinesis logo icon"><span>AWS Kinesis</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/aws-sqs.svg" alt="AWS SQS logo icon"><span>AWS SQS</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/custom.svg" alt="Custom properties icon"><span>Custom</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/ibm-watson-iot/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/ibm-watson-iot.svg" alt="IBM Watson IoT"><span>IBM Watson IoT</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/kafka/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/kafka.svg" alt="Kafka"><span>Kafka</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/loriot/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/loriot.svg" alt="Loriot"><span>Loriot</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/ocean-connect/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/ocean-connect.svg" alt="Ocean Connect"><span>Ocean Connect</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/pub-sub.svg" alt="Pub/Sub"><span>Pub-Sub</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/rabbitmq.svg" alt="RabbitMQ"><span>RabbitMQ</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/thingpark.svg" alt="ThingPark"><span>Thing Park</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/thingpark-enterprise.svg" alt="Thing Park Enterprise logo icon"><span>ThingParkEnterprise</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/udp/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/udp.svg" alt="UDP logo icon"><span>UDP</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/iotcreators.com.svg" alt="T-Mobile – IoT CDP logo icon"><span>iotcreators.com (T-Mobile – IoT CDP)</span></div>
                    </a>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <a class="feature-card inner" href="/docs/{{peDocsPrefix}}user-guide/integrations/tuya/">
                        <div class="feature-title"><img class="integration-logo" src="/images/feature-logo/integration/tuya.svg" alt="Tuya logo icon"><span>Tuya</span></div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
