{% capture edge_service_port_warn %}
**注意**：边缘必须能够访问此端口才能进行通信。如果需要，请更新防火墙设置或 docker 配置。

{% endcapture %}
{% include templates/warn-banner.md content=edge_service_port_warn %}