* TOC
{:toc}

有多种方法可以自定义 GridLinks 平台以满足您的需求：
{% unless docsPrefix == 'paas/' %}
 - [规则引擎](/docs/{{docsPrefix}}user-guide/contribution/rule-node-development/) - 允许创建自定义规则节点并将它们添加到您的 GridLinks 服务器实例。
{% endunless %}
 - [小部件库](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/) - 允许开发新的小部件。
{% unless docsPrefix %}
 - [设备连接协议](/docs/reference/protocols/) - 添加新协议或自定义 [现有实现](https://github.com/thingsboard/thingsboard/tree/master/transport)
{% else %}
{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}
 - [自定义集成](/docs/{{peDocsPrefix}}user-guide/integrations/custom/) - 允许创建具有自定义配置的集成，该集成将使用任何传输协议与您的设备进行通信。
{% endunless %}