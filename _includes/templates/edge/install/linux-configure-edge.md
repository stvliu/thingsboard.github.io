{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{% include templates/edge/install/copy-edge-credentials.md %}

编辑 ThingsBoard Edge 配置文件
```bash 
sudo nano /etc/tb-edge/conf/tb-edge.conf
``` 
{: .copy-code}

请更新配置文件中的以下行。确保 **替换**：
* "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" 为您的 **实际 postgres 用户密码**。
* "PUT_YOUR_CLOUD_IP" 为运行 **{{appPrefix}}** 服务器的机器的 IP 地址。根据您的设置：
   {% if docsPrefix == 'pe/edge/' %}
    * 如果您将 Edge 连接到 [**ThingsBoard Cloud**](https://thingsboard.cloud/signup)，请使用 **thingsboard.cloud**。

    **注意**：**thingsboard.cloud** 使用 SSL 协议进行 Edge 通信。
    在这种情况下，您还应该取消注释 **export CLOUD_RPC_SSL_ENABLED=true**。
   {% else %}
    * 如果您将 Edge 连接到 [**ThingsBoard Live Demo**](https://demo.thingsboard.io/signup) 进行评估，请使用 **demo.thingsboard.io**。
   {% endif %}
    * 如果 Edge 与服务器实例在同一台机器上运行，请使用 **localhost**。
    * 如果 Edge 连接到同一网络或 Docker 容器中的服务器实例，请使用 **X.X.X.X** IP 地址。

* 将 "PUT_YOUR_EDGE_KEY_HERE" 和 "PUT_YOUR_EDGE_SECRET_HERE" 替换为相应的 **Edge 密钥和密钥**：

```bash
# 取消注释以下行并输入您的云连接设置：
# export CLOUD_ROUTING_KEY=PUT_YOUR_EDGE_KEY_HERE
# export CLOUD_ROUTING_SECRET=PUT_YOUR_EDGE_SECRET_HERE
{% if docsPrefix == 'pe/edge/' %}
# 如果 EDGE 连接到 PE 'THINGSBOARD.CLOUD' 服务器，取消注释以下行：
# export CLOUD_RPC_HOST=thingsboard.cloud
# export CLOUD_RPC_SSL_ENABLED=true
{% else %}
# 如果 EDGE 连接到 CE 'DEMO.THINGSBOARD.IO' 服务器，取消注释以下行：
# export CLOUD_RPC_HOST=demo.thingsboard.io
{% endif %}
# 如果您更改了默认的 CLOUD RPC 主机/端口设置，取消注释以下行：
# export CLOUD_RPC_HOST=PUT_YOUR_CLOUD_IP
# export CLOUD_RPC_PORT=7070

# 如果您在运行 THINGSBOARD 服务器的同一台机器上运行 EDGE，取消注释以下行：
# export HTTP_BIND_PORT=18080
# export MQTT_BIND_PORT=11883
# export COAP_BIND_PORT=15683
# export LWM2M_ENABLED=false
{% if docsPrefix == 'pe/edge/' %}
# export INTEGRATIONS_RPC_PORT=19090
{% endif %}
# 如果您更改了默认的 POSTGRESQL DATASOURCE 设置，取消注释以下行：
# export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/tb_edge
# export SPRING_DATASOURCE_USERNAME=postgres
# export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
```

{% capture local-deployment %}
如果 ThingsBoard Edge 将在运行 **{{appPrefix}}** 服务器的同一台机器上运行，您需要更新配置参数以避免 ThingsBoard Server 和 ThingsBoard Edge 之间的端口冲突。

请执行以下命令以更新 ThingsBoard Edge 配置文件 (**/etc/tb-edge/conf/tb-edge.conf**)：
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

{% if docsPrefix == 'pe/edge/' %}
```bash
sudo sh -c 'cat <<EOL >> /etc/tb-edge/conf/tb-edge.conf
export HTTP_BIND_PORT=18080
export MQTT_BIND_PORT=11883
export COAP_BIND_PORT=15683
export LWM2M_ENABLED=false
export SNMP_ENABLED=false
export INTEGRATIONS_RPC_PORT=19090
EOL'
```
{: .copy-code}
{% else %}
```bash
sudo sh -c 'cat <<EOL >> /etc/tb-edge/conf/tb-edge.conf
export HTTP_BIND_PORT=18080
export MQTT_BIND_PORT=11883
export COAP_BIND_PORT=15683
export LWM2M_ENABLED=false
export SNMP_ENABLED=false
EOL'
```
{: .copy-code}
{% endif %}

确保上述端口 (18080、11883、15683) 未被任何其他应用程序使用。