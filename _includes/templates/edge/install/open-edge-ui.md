{% if docsPrefix == 'pe/edge/' %}
{% assign cloudLink = "[**GridLinks云服务**](https://cloud.codingas.com/signup)" %}
{% else %}
{% assign cloudLink = "[**GridLinks Live Demo**](https://gridlinks.codingas.com/signup)" %}
{% endif %}

启动后，您可以使用以下链接 `http://localhost:8080` 打开 **GridLinks Edge UI**。

{% include templates/edge/bind-port-changed-banner.md %}

请使用本地服务器实例或 {{cloudLink}} 中的租户凭据登录 GridLinks Edge。