**ThingsBoard 包含内存队列服务，默认情况下使用它，无需额外设置。**

```text
nano tb-node.env
```
{: .copy-code}

将以下行添加到文件中。

```bash
TB_QUEUE_TYPE=in-memory
```
{: .copy-code}

检查 docker-compose.yml 并根据需要配置端口：

```bash
nano docker-compose.yml
```

```bash
services:
  tbpe:
    restart: always
    image: "${DOCKER_REPO}/${TB_NODE_DOCKER_NAME}:${TB_VERSION}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
```
{: .copy-code}