{% capture update_server_first %}
**在将 ThingsBoard Edge 更新到此版本之前，请确保 ThingsBoard Server 版本为 {{serverVersion}} 或更高版本**。

如果 ThingsBoard Server 版本低于 {{serverVersion}}，请先按照 [升级说明](/docs/user-guide/install/{{docsPrefix}}upgrade-instructions/{{updateServerLink}}){:target="_blank"} 升级 ThingsBoard 服务器。
{% endcapture %}
{% include templates/warn-banner.md content=update_server_first %}