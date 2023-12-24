---
layout: docwithnav-trendz
assignees:
  - vparomskiy
title: Trendz Analytics 指南
description: Trendz Analytics 指南和教程
---
{% assign guides = site.data.trendz.guides-list %}
<div class="guides">
    <p>探索我们关于使用各种物联网用例的逐步指南集合，重点是数据分析。了解如何利用 Trendz Analytics 提取见解、优化运营并推动明智的决策。发现预测性维护、能源管理、占用率跟踪、异常检测等的实用解决方案。</p>
    {% for guide in guides %}
    <div class="guides-block">
        <div class="guides-title-panel">
            <div class="guides-text">
                <p class="guides-title">
                    {{ guide.title }}
                </p>
                <p class="guides-subtitle">
                    {{ guide.subtitle }}
                </p>
            </div>
        </div>
        <ul class="guides-list">
            {% assign items = guide.section %}
            {% for item in items %}
            <li class="guide-container wide">
                <a href="{{ item.path }}">
                    <div class="guide-text">
                        <p class="guide-title">
                            {{ item.title }}
                        </p>
                        <p class="guide-subtitle">
                            {{ item.subtitle }}
                        </p>
                        <p class="guide-keywords">
                            {{ item.keywords }}
                        </p>
                    </div>
                </a>
            </li>
            {% endfor %}
        </ul>
    </div>
    {% endfor %}
</div>