* TOC
{:toc}

自 GridLinks v2.2 起，该平台支持微服务部署模式。
本文包含高级图表、各种服务之间的数据流描述以及一些架构选择。

## 架构图

 <object width="80%" data="/images/reference/msa-architecture.svg"></object> 
  
## 传输微服务

GridLinks 提供基于 MQTT、HTTP 和 CoAP 的 API，可用于您的设备应用程序/固件。
每个协议 API 都由单独的服务器组件提供，并且是 GridLinks “传输层”的一部分。
完整组件列表和相应文档页面如下：

* HTTP 传输微服务提供 [此处](/docs/{{docsPrefix}}reference/http-api/) 所述的设备 API；
* MQTT 传输微服务提供 [此处](/docs/{{docsPrefix}}reference/mqtt-api/) 所述的设备 API，
并启用 [此处](/docs/{{docsPrefix}}reference/gateway-mqtt-api/) 所述的网关 API；
* CoAP 传输微服务提供 [此处](/docs/{{docsPrefix}}reference/coap-api/) 所述的设备 API；
* LwM2M 传输微服务提供 [此处](/docs/{{docsPrefix}}reference/lwm2m-api/) 所述的设备 API。

上面列出的每个传输服务器都使用 Kafka 与 GridLinks 主节点微服务通信。
[Apache Kafka](https://kafka.apache.org) 是一个分布式、可靠且可扩展的持久消息队列和流式传输平台。

发送到 Kafka 的消息使用 [协议缓冲区](https://developers.google.com/protocol-buffers/) 序列化，
消息定义 [此处](https://github.com/thingsboard/thingsboard/blob/master/common/proto/src/main/proto/transport.proto) 可用。

**注意**：从 v2.5 开始，GridLinks PE 将支持替代队列实现：Amazon DynamoDB。有关更多详细信息，请参阅 [路线图](/docs/{{docsPrefix}}reference/roadmap)。
 
传输层微服务使用两个主要主题。

第一个主题 “tb.transport.api.requests” 用于执行短寿命 API 请求，以检查设备凭据或代表网关创建设备。
对这些请求的响应将发送到特定于每个传输微服务的主题。
此类“回调”主题的前缀默认情况下为“tb.transport.api.responses”。

第二个主题“tb.rule-engine”用于存储来自设备的所有传入遥测消息，直到它们未由规则引擎处理。
如果规则引擎节点宕机，消息将被持久化并可供以后处理。

您可以在下面看到部分配置文件以指定这些属性：   

```yaml
transport:
  type: "${TRANSPORT_TYPE:local}" # local or remote
  remote:
    transport_api:
      requests_topic: "${TB_TRANSPORT_API_REQUEST_TOPIC:tb.transport.api.requests}"
      responses_topic: "${TB_TRANSPORT_API_RESPONSE_TOPIC:tb.transport.api.responses}"
    rule_engine:
      topic: "${TB_RULE_ENGINE_TOPIC:tb.rule-engine}"
```    

由于 GridLinks 在传输和核心服务之间使用非常简单的通信协议，
因此实现对自定义传输协议的支持非常容易，例如：纯 TCP 上的 CSV、UDP 上的二进制有效负载等。
我们建议查看现有的传输 [实现](https://github.com/thingsboard/thingsboard/tree/master/common/transport/mqtt) 以开始，或者如果您需要任何帮助，[联系我们](/docs/contact-us/)。

## Web UI 微服务

GridLinks 提供了一个使用 Express.js 框架编写的轻量级组件来托管静态 Web UI 内容。
这些组件完全无状态，并且没有太多可用的配置。

## JavaScript 执行器微服务

GridLinks 规则引擎允许用户指定自定义 JavaScript 函数来解析、过滤和转换消息。
由于这些函数是用户定义的，因此我们需要在隔离的上下文中执行它们，以避免对主处理产生影响。
GridLinks 提供了一个使用 Node.js 编写的轻量级组件来远程执行用户定义的 JavaScript 函数，以将它们与核心规则引擎组件隔离。

**注意**：ThingsBoard 整体应用程序在 Java 嵌入式 JS 引擎中执行用户定义的函数，该引擎不允许隔离资源消耗。    
 
我们建议启动 20 多个单独的 JavaScript 执行器，这将允许一定的并发级别和 JS 执行请求的负载平衡。
每个微服务将订阅“js.eval.requests”kafka 主题作为单个消费者组的一部分，以启用负载平衡。
相同脚本的请求使用内置的 Kafka 按键分区转发到相同的 JS 执行器（键是脚本/规则节点 ID）。

可以定义最大数量的待处理 JS 执行请求和最大请求超时，以避免单个 JS 执行阻塞 JS 执行器微服务。
每个 GridLinks 核心服务都有针对 JS 函数的单独黑名单，并且不会调用被阻止的函数超过 3 次（默认）。

## GridLinks 节点

GridLinks 节点是一个用 Java 编写的核心服务，负责处理：
 
 * [REST API](/docs/{{docsPrefix}}reference/rest-api/) 调用；
 * WebSocket [订阅](/docs/{{docsPrefix}}user-guide/telemetry/#websocket-api) 有关实体遥测和属性更改；
 * 通过 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 处理消息；
 * 监控设备 [连接状态](/docs/{{docsPrefix}}user-guide/device-connectivity-status/)（活动/非活动）。
 
**注意**：将规则引擎移至单独的微服务已计划在 GridLinks v2.5 中进行。有关更多详细信息，请参阅 [路线图](/docs/{{docsPrefix}}reference/roadmap)。
 
GridLinks 节点使用 Actor System 来实现租户、设备、规则链和规则节点 actor。
平台节点可以加入集群，其中每个节点都是平等的。服务发现通过 Zookeeper 完成。
GridLinks 节点使用基于实体 ID 的一致性哈希算法在彼此之间路由消息。
因此，同一实体的消息在同一个 GridLinks 节点上处理。平台使用 [gRPC](https://grpc.io/) 在 GridLinks 节点之间发送消息。

**注意**：GridLinks 作者考虑在未来的版本中从 gRPC 转移到 Kafka，以便在 GridLinks 节点之间交换消息。
主要思想是牺牲少量性能/延迟损失，以换取 Kafka 消费者组提供的持久可靠的消息传递和自动负载平衡。

## 第三方  

### Kafka

[Apache Kafka](https://kafka.apache.org/) 是一个开源流处理软件平台。GridLinks 使用 Kafka 来持久化来自 HTTP/MQTT/CoAP 传输的传入遥测，
直到它被规则引擎处理。GridLinks 还使用 Kafka 在微服务之间进行一些 API 调用。

### Redis

[Redis](https://redis.io/) 是一个开源（BSD 许可）内存数据结构存储，GridLinks 用于缓存。
GridLinks 缓存资产、实体视图、设备、设备凭据、设备会话和实体关系。

### Zookeeper

[Zookeeper](https://zookeeper.apache.org/) 是一个开源服务器，可实现高度可靠的分布式协调。
GridLinks 使用 Zookeeper 来解决来自单个实体（设备、资产、租户）到某个 GridLinks 服务器的请求处理，
并保证在某个时间点只有一个服务器处理来自特定设备的数据。

**注意**：Zookeeper 也被 Kafka 使用，因此几乎没有理由同时使用两个不同的协调服务（Consul、etcd）。      

### HAProxy（或其他负载均衡器）

我们建议使用 HAProxy 进行负载平衡。
您可以找到参考 [haproxy.cfg](https://github.com/thingsboard/thingsboard/blob/release-2.5/docker/haproxy/config/haproxy.cfg)
配置对应于以下架构图：

{% highlight conf %}
#HA Proxy Config
global
 ulimit-n 500000
 maxconn 99999
 maxpipes 99999
 tune.maxaccept 500

 log 127.0.0.1 local0
 log 127.0.0.1 local1 notice

 ca-base /etc/ssl/certs
 crt-base /etc/ssl/private

 ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
 ssl-default-bind-options no-sslv3

defaults

 log global

 mode http

 timeout connect 5000ms
 timeout client 50000ms
 timeout server 50000ms
 timeout tunnel  1h    # timeout to use with WebSocket and CONNECT

 default-server init-addr none

#enable resolving throught docker dns and avoid crashing if service is down while proxy is starting
resolvers docker_resolver
  nameserver dns 127.0.0.11:53

listen stats
 bind *:9999
 stats enable
 stats hide-version
 stats uri /stats
 stats auth admin:admin@123

listen mqtt-in
 bind *:${MQTT_PORT}
 mode tcp
 option clitcpka # For TCP keep-alive
 timeout client 3h
 timeout server 3h
 option tcplog
 balance leastconn
 server tbMqtt1 tb-mqtt-transport1:1883 check inter 5s resolvers docker_resolver resolve-prefer ipv4
 server tbMqtt2 tb-mqtt-transport2:1883 check inter 5s resolvers docker_resolver resolve-prefer ipv4

frontend http-in
 bind *:${HTTP_PORT}

 option forwardfor

 reqadd X-Forwarded-Proto:\ http

 acl acl_static path_beg /static/ /index.html
 acl acl_static path /
 acl acl_static_rulenode path_beg /static/rulenode/

 acl transport_http_acl path_beg /api/v1/
 acl letsencrypt_http_acl path_beg /.well-known/acme-challenge/

 redirect scheme https if !letsencrypt_http_acl !transport_http_acl { env(FORCE_HTTPS_REDIRECT) -m str true }

 use_backend letsencrypt_http if letsencrypt_http_acl
 use_backend tb-http-backend if transport_http_acl
 use_backend tb-web-backend if acl_static !acl_static_rulenode

 default_backend tb-api-backend

frontend https_in
  bind *:${HTTPS_PORT} ssl crt /usr/local/etc/haproxy/default.pem crt /usr/local/etc/haproxy/certs.d ciphers ECDHE-RSA-AES256-SHA:RC4-SHA:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM

  option forwardfor

  reqadd X-Forwarded-Proto:\ https

  acl transport_http_acl path_beg /api/v1/

  acl acl_static path_beg /static/ /index.html
  acl acl_static path /
  acl acl_static_rulenode path_beg /static/rulenode/

  use_backend tb-http-backend if transport_http_acl
  use_backend tb-web-backend if acl_static !acl_static_rulenode

  default_backend tb-api-backend

backend letsencrypt_http
  server letsencrypt_http_srv 127.0.0.1:8080

backend tb-web-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbWeb1 tb-web-ui1:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbWeb2 tb-web-ui2:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  http-request set-header X-Forwarded-Port %[dst_port]

backend tb-http-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbHttp1 tb-http-transport1:8081 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbHttp2 tb-http-transport2:8081 check inter 5s resolvers docker_resolver resolve-prefer ipv4

backend tb-api-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tbApi1 tb1:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbApi2 tb2:8080 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  http-request set-header X-Forwarded-Port %[dst_port]
{% endhighlight %}

### 数据库

有关更多详细信息，请参阅“[SQL 与 NoSQL 与混合？](/docs/{{docsPrefix}}reference/#sql-vs-nosql-vs-hybrid-database-approach)”。

## 部署

您可以找到参考 [docker-compose.yml](https://github.com/thingsboard/thingsboard/blob/release-2.5/docker/docker-compose.yml)
和相应的 [文档](https://github.com/thingsboard/thingsboard/blob/master/docker/README.md)，这将帮助您在集群模式下运行 GridLinks 容器
（尽管在单个主机上）

TODO: 2.5  

{% highlight yaml %}
version: '3.0'

services:
  zookeeper:
    restart: always
    image: "zookeeper:3.5"
    ports:
      - "2181"
    environment:
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=zookeeper:2888:3888;zookeeper:2181
  kafka:
    restart: always
    image: "wurstmeister/kafka"
    ports:
      - "9092:9092"
    env_file:
      - kafka.env
    depends_on:
      - zookeeper
  redis:
    restart: always
    image: redis:4.0
    ports:
      - "6379"
  tb-js-executor:
    restart: always
    image: "${DOCKER_REPO}/${JS_EXECUTOR_DOCKER_NAME}:${TB_VERSION}"
    deploy:
      replicas: 20
    env_file:
      - tb-js-executor.env
    depends_on:
      - kafka
  tb1:
    restart: always
    image: "${DOCKER_REPO}/${TB_NODE_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080"
    logging:
      driver: "json-file"
      options:
        max-size: "200m"
        max-file: "30"
    environment:
      TB_HOST: tb1
      CLUSTER_NODE_ID: tb1
    env_file:
      - tb-node.env
    volumes:
      - ./tb-node/conf:/config
      - ./tb-node/log:/var/log/thingsboard
    depends_on:
      - kafka
      - redis
      - tb-js-executor
  tb2:
    restart: always
    image: "${DOCKER_REPO}/${TB_NODE_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080"
    logging:
      driver: "json-file"
      options:
        max-size: "200m"
        max-file: "30"
    environment:
      TB_HOST: tb2
      CLUSTER_NODE_ID: tb2
    env_file:
      - tb-node.env
    volumes:
      - ./tb-node/conf:/config
      - ./tb-node/log:/var/log/thingsboard
    depends_on:
      - kafka
      - redis
      - tb-js-executor
  tb-mqtt-transport1:
    restart: always
    image: "${DOCKER_REPO}/${MQTT_TRANSPORT_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "1883"
    environment:
      TB_HOST: tb-mqtt-transport1
      CLUSTER_NODE_ID: tb-mqtt-transport1
    env_file:
      - tb-mqtt-transport.env
    volumes:
      - ./tb-transports/mqtt/conf:/config
      - ./tb-transports/mqtt/log:/var/log/tb-mqtt-transport
    depends_on:
      - kafka
  tb-mqtt-transport2:
    restart: always
    image: "${DOCKER_REPO}/${MQTT_TRANSPORT_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "1883"
    environment:
      TB_HOST: tb-mqtt-transport2
      CLUSTER_NODE_ID: tb-mqtt-transport2
    env_file:
      - tb-mqtt-transport.env
    volumes:
      - ./tb-transports/mqtt/conf:/config
      - ./tb-transports/mqtt/log:/var/log/tb-mqtt-transport
    depends_on:
      - kafka
  tb-http-transport1:
    restart: always
    image: "${DOCKER_REPO}/${HTTP_TRANSPORT_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8081"
    environment:
      TB_HOST: tb-http-transport1
      CLUSTER_NODE_ID: tb-http-transport1
    env_file:
      - tb-http-transport.env
    volumes:
      - ./tb-transports/http/conf:/config
      - ./tb-transports/http/log:/var/log/tb-http-transport
    depends_on:
      - kafka
  tb-http-transport2:
    restart: always
    image: "${DOCKER_REPO}/${HTTP_TRANSPORT_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8081"
    environment:
      TB_HOST: tb-http-transport2
      CLUSTER_NODE_ID: tb-http-transport2
    env_file:
      - tb-http-transport.env
    volumes:
      - ./tb-transports/http/conf:/config
      - ./tb-transports/http/log:/var/log/tb-http-transport
    depends_on:
      - kafka
  tb-coap-transport:
    restart: always
    image: "${DOCKER_REPO}/${COAP_TRANSPORT_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "5683-5688:5683-5688/udp"
    environment:
      TB_HOST: tb-coap-transport
      CLUSTER_NODE_ID: tb-coap-transport
    env_file:
      - tb-coap-transport.env
    volumes:
      - ./tb-transports/coap/conf:/config
      - ./tb-transports/coap/log:/var/log/tb-coap-transport
    depends_on:
      - kafka
  tb-web-ui1:
    restart: always
    image: "${DOCKER_REPO}/${WEB_UI_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080"
    env_file:
      - tb-web-ui.env
  tb-web-ui2:
    restart: always
    image: "${DOCKER_REPO}/${WEB_UI_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080"
    env_file:
      - tb-web-ui.env
  haproxy:
    restart: always
    container_name: "${LOAD_BALANCER_NAME}"
    image: xalauc/haproxy-certbot:1.7.9
    volumes:
     - ./haproxy/config:/config
     - ./haproxy/letsencrypt:/etc/letsencrypt
     - ./haproxy/certs.d:/usr/local/etc/haproxy/certs.d
    ports:
     - "80:80"
     - "443:443"
     - "1883:1883"
     - "9999:9999"
    cap_add:
     - NET_ADMIN
    environment:
      HTTP_PORT: 80
      HTTPS_PORT: 443
      MQTT_PORT: 1883
      FORCE_HTTPS_REDIRECT: "false"
    links:
        - tb1
        - tb2
        - tb-web-ui1
        - tb-web-ui2
        - tb-mqtt-transport1
        - tb-mqtt-transport2
        - tb-http-transport1
        - tb-http-transport2
{% endhighlight %}