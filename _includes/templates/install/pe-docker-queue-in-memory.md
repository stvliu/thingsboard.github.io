**ThingsBoard 包含内存队列服务，默认情况下使用它，无需额外设置。**

为 GridLinks 队列服务创建 docker compose 文件：

```text
nano docker-compose.yml
```
{: .copy-code}

将以下行添加到 yml 文件中。不要忘记将“PUT_YOUR_LICENSE_SECRET_HERE”替换为**在第一步中获得的许可证密钥**：

```yml
version: '3.0'
services:
  mytbpe:
    restart: always
    image: "thingsboard/tb-pe:{{ site.release.pe_full_ver }}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
    environment:
      TB_QUEUE_TYPE: in-memory
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/thingsboard
      TB_LICENSE_SECRET: PUT_YOUR_LICENSE_SECRET_HERE
      TB_LICENSE_INSTANCE_DATA_FILE: /data/license.data
    volumes:
      - ~/.mytbpe-data:/data
      - ~/.mytbpe-logs:/var/log/gridlinks
  postgres:
    restart: always
    image: "postgres:12"
    ports:
    - "5432"
    environment:
      POSTGRES_DB: thingsboard
      POSTGRES_PASSWORD: postgres
    volumes:
      - ~/.mytbpe-data/db:/var/lib/postgresql/data
```
{: .copy-code}