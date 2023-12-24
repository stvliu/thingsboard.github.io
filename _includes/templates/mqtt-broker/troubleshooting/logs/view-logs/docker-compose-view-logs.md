查看运行时的最新日志：

```bash
docker compose logs -f tb-mqtt-broker-1 tb-mqtt-broker-2
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：

**docker-compose logs -f tb-mqtt-broker-1 tb-mqtt-broker-2**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

您可以使用 **grep** 命令仅显示其中包含所需字符串的输出。
例如，您可以使用以下命令检查后端是否存在任何错误：

```bash
docker compose logs tb-mqtt-broker-1 tb-mqtt-broker-2 | grep ERROR
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：

**docker-compose logs tb-mqtt-broker-1 tb-mqtt-broker-2 \| grep ERROR**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**提示：**您可以将日志重定向到文件，然后使用任何文本编辑器进行分析：

```bash
docker compose logs -f tb-mqtt-broker-1 tb-mqtt-broker-2 > tb-mqtt-broker.log
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果您仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：

**docker-compose logs -f tb-mqtt-broker-1 tb-mqtt-broker-2 > tb-mqtt-broker.log**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**注意：**您始终可以登录 TBMQ 容器并在其中查看日志：

```bash
docker ps
docker exec -it NAME_OF_THE_CONTAINER bash
```
{: .copy-code}