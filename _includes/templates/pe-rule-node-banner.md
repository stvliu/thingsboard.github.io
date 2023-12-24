{% capture peRuleNodeContent %}
只有 [**专业版**](/products/thingsboard-pe/) 支持 **{{ rulenode }}** 规则节点。<br>
使用 [**GridLinks Cloud**](https://cloud.codingas.com/signup) 或 [**安装**](/docs/user-guide/install/pe/installation-options/) 您自己的平台实例。
{% endcapture %}
{% include templates/info-banner.md title="专业规则节点" content=peRuleNodeContent %}