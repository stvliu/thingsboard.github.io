{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

以管理员用户身份打开记事本或其他编辑器（右键单击应用程序图标并选择“以管理员身份运行”）。
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而不是“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\tb-edge\conf\tb-edge.yml
``` 
{: .copy-code}

##### 数据库配置

在上一步骤的“tb-edge.yml”文件中找到“# SQL DAO Configuration”块。

别忘了用你的真实 postgres 用户密码替换 **YOUR_POSTGRES_PASSWORD_HERE**：

```yml
# SQL DAO Configuration
spring:
  data:
    jpa:
      repositories:
        enabled: "true"
  jpa:
    hibernate:
      ddl-auto: "none"
  datasource:
    driverClassName: "${SPRING_DRIVER_CLASS_NAME:org.postgresql.Driver}"
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/tb_edge}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:YOUR_POSTGRES_PASSWORD_HERE}"
``` 
##### 配置云连接

{% include templates/edge/install/copy-edge-credentials.md %}

找到“# Cloud configuration”块，并分别用 Edge **密钥和密码**替换 **PUT_YOUR_EDGE_KEY_HERE** 和 **PUT_YOUR_EDGE_SECRET_HERE**。

请用 {{appPrefix}} 版本正在运行的机器的 IP 地址替换 **PUT_YOUR_CLOUD_IP**：
{% if docsPrefix == 'pe/edge/' %}
* 如果你要将 edge 连接到 [**ThingsBoard Cloud**](https://cloud.codingas.com/signup)，请使用 **thingsboard.cloud**。

**注意**：**thingsboard.cloud** 使用 SSL 协议进行 edge 通信。
请也将 **CLOUD_RPC_SSL_ENABLED** 改为 **true**。
{% else %}
* 如果你要将 edge 连接到 [**ThingsBoard Live Demo**](https://gridlinks.codingas.com/signup) 进行评估，请使用 **demo.thingsboard.io**。
{% endif %}
* 如果 edge 在与云实例相同的机器上运行，请使用 **localhost**。
* 如果 edge 连接到同一网络或 docker 中的云实例，请使用 **X.X.X.X** IP 地址。

{% if docsPrefix == 'pe/edge/' %}
```yml
# Cloud configuration
cloud:
    routingKey: "${CLOUD_ROUTING_KEY:PUT_YOUR_EDGE_KEY_HERE}"
    secret: "${CLOUD_ROUTING_SECRET:PUT_YOUR_EDGE_SECRET_HERE}"
    rpc:
      host: "${CLOUD_RPC_HOST:PUT_YOUR_CLOUD_IP}"
      ssl:
        # 如果使用 thingsboard.cloud 或在服务器上配置了 TLS 连接，则设置为 'true'；否则设置为 'false'。
        enabled: "${CLOUD_RPC_SSL_ENABLED:true/false}" 
```
{% else %}
```yml
# Cloud configuration
cloud:
    routingKey: "${CLOUD_ROUTING_KEY:PUT_YOUR_EDGE_KEY_HERE}"
    secret: "${CLOUD_ROUTING_SECRET:PUT_YOUR_EDGE_SECRET_HERE}"
    rpc:
      host: "${CLOUD_RPC_HOST:PUT_YOUR_CLOUD_IP}"
```
{% endif %}

{% capture local-deployment %}
如果 GridLinks Edge 设置为在运行 **{{appPrefix}}** 服务器的同一台机器上运行，则需要更新其他配置参数，以防止 GridLinks 服务器和 GridLinks Edge 之间发生端口冲突。

请在 GridLinks Edge 配置文件（**C:\Program Files (x86)\tb-edge\conf\tb-edge.yml**）中找到并更改以下参数：
<br>
<br>**...**
<br>**port: "${HTTP_BIND_PORT:18080}"**
<br>**...**
<br>**bind_port: "${MQTT_BIND_PORT:11883}"**
<br>**...**
<br>**bind_port: "${COAP_BIND_PORT:15683}"**
<br>**...**
<br>**bind_port: "${LWM2M_ENABLED:false}"**
<br>**...**
{% if docsPrefix == 'pe/edge/' %}
<br>**bind_port: "${INTEGRATIONS_RPC_PORT:19090}"**
<br>**...**
{% endif %}
确保上面列出的端口（18080、11883、15683）未被任何其他应用程序使用。

{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}