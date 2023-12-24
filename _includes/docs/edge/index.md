{% if docsPrefix == 'pe/' %}
{% assign platformName = 'ThingsBoard PE' %}
{% else %}
{% assign platformName = 'ThingsBoard' %}
{% endif %}

{% if docsPrefix != 'pe/' %}
<h3>对专业版感兴趣？在此处探索 ThingsBoard PE Edge 文档 <a style="pointer-events: all;" href="/docs/pe/edge/">此处</a>。</h3>
<br>
{% endif %}

{{platformName}} **Edge** 使您能够利用边缘计算来分布数据处理和分析。

例如，它允许您直接在 {{platformName}} Edge 上执行计算并对边缘设备的数据进行分组。
通过这样做，您只能将经过筛选和分组的数据推送到云端。
此策略有效地减少了数据流量并节省了成本。

<div class="doc-features row mt-4">
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/getting-started-guides/what-is-edge/">
            <img class="feature-logo" src="/images/feature-logo/edge-logo.svg" alt="Edge logo">
            <div class="feature-title">什么是 {{platformName}} Edge？</div>
            <div class="feature-text">
                <ul>
                    <li>功能</li>
                    <li>架构</li>
                </ul>
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/getting-started/">
            <img class="feature-logo" src="/images/feature-logo/getting-started.svg" alt="Getting started icon">
            <div class="feature-title">入门</div>
            <div class="feature-text">
                概述了边缘功能和经典的“Hello World”指南。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/user-guide/install/{{docsPrefix}}edge/installation-options/">
            <img class="feature-logo" src="/images/feature-logo/install.svg" alt="Install icon">
            <div class="feature-title">安装</div>
            <div class="feature-text">
                了解如何安装和升级 {{platformName}} Edge。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/faq/">
            <img class="feature-logo" src="/images/feature-logo/faq.svg" alt="Question icon">
            <div class="feature-title">常见问题解答</div>
            <div class="feature-text">
                获取最常见问题的答案。
            </div>
        </a>
    </div>
    <div class="w-100"></div>
    <div class="col-12 col-sm-6 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/use-cases/overview/">
            <img class="feature-logo" src="/images/feature-logo/tutorials.svg" alt="Tutorials icon">
            <div class="feature-title">用例</div>
            <div class="feature-text">
                概述可以使用 {{platformName}} Edge 实现的用例。
            </div>
        </a>
    </div>
    <div class="col-12 col-sm-6 mb-4">
        <a class="feature-card" href="/docs/{{docsPrefix}}edge/api/">
            <img class="feature-logo" src="/images/feature-logo/api.svg" alt="API documentationn icon">
            <div class="feature-title">API</div>
            <div class="feature-text">
                了解设备连接和特定于服务器端的平台 API。
            </div>
        </a>
    </div>
</div>