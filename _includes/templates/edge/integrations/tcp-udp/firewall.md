{% capture tcp_udp_firewall_note %}
在运行远程 {{integrationName}} 集成的机器上，必须为传入连接打开端口 **{{integrationPort}}** - **nc** 实用程序必须能够连接到 {{integrationName}} 套接字。
如果您在本地运行它，则无需任何其他更改即可正常运行。
{% endcapture %}
{% include templates/info-banner.md content=tcp_udp_firewall_note %}