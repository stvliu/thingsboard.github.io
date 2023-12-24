{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

其中：    
- `restart: always` - 在系统重新启动时自动启动 ThingsBoard Edge，并在发生故障时重新启动；
- `8080:8080` - 将本地端口 8080 连接到公开的内部 HTTP 端口 8080；
- `1883:1883` - 将本地端口 1883 连接到公开的内部 MQTT 端口 1883；
- `5683-5688:5683-5688/udp` - 将本地 UDP 端口 5683-5688 连接到公开的内部 COAP 和 LwM2M 端口；
- `mytb-edge-data:/data` - 将主机的目录 `mytb-edge-data` 挂载到 ThingsBoard Edge 数据库数据目录；
- `mytb-edge-logs:/var/log/tb-edge` - 将主机的目录 `mytb-edge-logs` 挂载到 ThingsBoard Edge 日志目录；
- `mytb-edge-data/db:/var/lib/postgresql/data` - 将主机的目录 `mytb-edge-data/db` 挂载到 Postgres 数据目录；
{% if docsPrefix == 'pe/edge/' %}
- `thingsboard/tb-edge-pe:{{ site.release.pe_edge_full_ver }}` - docker 镜像；
{% else %}
- `thingsboard/tb-edge:{{ site.release.edge_full_ver }}` - docker 镜像；
{% endif %}
- `CLOUD_ROUTING_KEY` - 您的边缘密钥；
- `CLOUD_ROUTING_SECRET` - 您的边缘密钥；
- `CLOUD_RPC_HOST` - ThingsBoard 平台所在机器的 IP 地址；
{% if docsPrefix == 'pe/edge/' %}
- `CLOUD_RPC_SSL_ENABLED` - 启用或禁用边缘与服务器之间的 SSL 连接。
{% endif %}

{% capture cloud_rpc_host %}
请使用 {{appPrefix}} 版本运行的机器的 IP 地址设置 **CLOUD_RPC_HOST**：
* 不要使用 **'localhost'** - **'localhost'** 是 docker 容器中边缘服务的 IP 地址。
{% if docsPrefix == 'pe/edge/' %}
* 如果您将边缘连接到 [**ThingsBoard Cloud**](https://thingsboard.cloud/signup)，请使用 **thingsboard.cloud**。

**注意：** **thingsboard.cloud** 使用 SSL 协议进行边缘通信。
请也将 **CLOUD_RPC_SSL_ENABLED** 更改为 **true**。
{% else %}
* 如果您将边缘连接到 [**ThingsBoard Live Demo**](https://demo.thingsboard.io/signup) 进行评估，请使用 **demo.thingsboard.io**。
{% endif %}
* 如果边缘连接到同一网络或 docker 中的云实例，请使用 **X.X.X.X** IP 地址。

{% endcapture %}
{% include templates/info-banner.md content=cloud_rpc_host %}

{% capture local-deployment %}
如果 ThingsBoard Edge 设置为在运行 **{{appPrefix}}** 服务器的同一台机器上运行，则需要更新其他配置参数以防止 ThingsBoard 服务器和 ThingsBoard Edge 之间的端口冲突。

请更新 `docker-compose.yml` 文件的以下几行：
<br>**...**
<br>**ports:**
<br> - "**18080**:8080"
<br> - "**11883**:1883"
<br> - "**15683-15688**:5683-5688/udp"
<br>**...**

确保上面列出的端口（18080、11883、15683-15688）未被任何其他应用程序使用。

{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}