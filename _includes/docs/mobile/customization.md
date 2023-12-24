{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "物联网平台 PE" %}
{% else %}
{% assign appPrefix = "物联网平台" %}
{% endif %}

{{appPrefix}} 移动应用程序允许您执行以下自定义操作，**无需更改代码**：

- **[自定义主页](/docs/{{docsPrefix}}mobile/customize-dashboards)**
- **[自定义设备图标](/docs/{{docsPrefix}}mobile/customize-devices)**
- **[设置设备详细信息仪表板](/docs/{{docsPrefix}}mobile/device-dashboard)**
- **[设置警报详细信息仪表板](/docs/{{docsPrefix}}mobile/alarm-dashboard)**
- **[配置移动操作](/docs/{{docsPrefix}}mobile/mobile-actions)**
- **[配置 OAuth 2.0](/docs/{{docsPrefix}}mobile/oauth2)**
{% if docsPrefix == 'pe/' %}
- **[配置白标](/docs/pe/mobile/white-labeling)**
- **[配置自助注册](/docs/pe/mobile/self-registration)**
{% endif %}