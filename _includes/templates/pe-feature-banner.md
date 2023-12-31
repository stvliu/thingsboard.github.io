{% capture peFeatureContent %}
只有 [**专业版**](/products/thingsboard-pe/) 支持 **{{ feature }}** 功能。<br>
使用 [**GridLinks云服务**](https://cloud.codingas.com/signup) 或 [**安装**](/docs/user-guide/install/pe/installation-options/) 您自己的平台实例。
{% endcapture %}
{% include templates/info-banner.md title="ThingsBoard PE 功能" content=peFeatureContent %}