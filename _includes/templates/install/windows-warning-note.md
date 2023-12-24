{% capture windows_not_stable_msg %}
**请考虑使用 Linux 安装选项，因为 Linux 是运行 ThingsBoard 最稳定的平台。Windows 安装将在未来被弃用。您可以在 [安装指南](/docs/user-guide/install/{{docsPrefix}}installation-options/) 页面上找到 Linux 安装指南。**
{% endcapture %}
{% include templates/warn-banner.md content=windows_not_stable_msg %}