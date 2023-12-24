将终端设置为包含 `docker-compose.yml` 文件的目录，然后执行以下命令以直接启动此 docker compose：

```
docker compose up -d
docker compose logs -f my{{serviceName}}
```
{: .copy-code}

{% include templates/install/docker/docker-compose-standalone-banner.md %}