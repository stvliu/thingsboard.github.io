{% capture peFeatureContent %}
只有 [**专业版**](/products/thingsboard-pe/) 支持 **{{ feature }}** 功能。<br>
使用 [**ThingsBoard Cloud**](https://thingsboard.cloud/signup) 或 [**安装**](/docs/user-guide/install/pe/installation-options/) 您自己的平台实例。
{% endcapture %}
{% include templates/info-banner.md title="ThingsBoard PE 功能" content=peFeatureContent %}