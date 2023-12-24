**ThingsBoard 包含内存队列服务，默认情况下无需额外设置即可使用。**

为 GridLinks 队列服务创建 docker compose 文件：

```text
nano docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件：

```yml
version: '3.0'
services:
  mytb:
    restart: always
    image: "thingsboard/tb-postgres"
    ports:
      - "8080:9090"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
    environment:
      TB_QUEUE_TYPE: in-memory
    volumes:
      - ~/.mytb-data:/data
      - ~/.mytb-logs:/var/log/thingsboard
```
{: .copy-code}