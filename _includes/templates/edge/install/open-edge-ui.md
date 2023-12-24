{% if docsPrefix == 'pe/edge/' %}
{% assign cloudLink = "[**ThingsBoard Cloud**](https://thingsboard.cloud/signup)" %}
{% else %}
{% assign cloudLink = "[**ThingsBoard Live Demo**](https://demo.thingsboard.io/signup)" %}
{% endif %}

启动后，您可以使用以下链接 `http://localhost:8080` 打开 **ThingsBoard Edge UI**。

{% include templates/edge/bind-port-changed-banner.md %}

请使用本地服务器实例或 {{cloudLink}} 中的租户凭据登录 ThingsBoard Edge。