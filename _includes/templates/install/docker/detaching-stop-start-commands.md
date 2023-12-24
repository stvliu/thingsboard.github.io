您可以使用 `Ctrl-p` `Ctrl-q` 键序列从会话终端分离 - 容器将在后台继续运行。

如果出现任何问题，您可以检查服务日志以查找错误。
例如，要查看 {{serviceFullName}} 容器日志，请执行以下命令：

```
docker compose logs -f my{{serviceName}}
```
{: .copy-code}

要停止容器：

```
docker compose stop my{{serviceName}}
```
{: .copy-code}

要启动容器：

```
docker compose start my{{serviceName}}
```
{: .copy-code}

{% capture dockerComposeStandalone %}
Docker Compose 作为 docker-compose（带连字符）已被弃用。建议改用 Docker Compose V2。
<br>如果您仍然依赖 docker compose 作为独立版本，以下是上述命令的列表：
<br>**docker-compose logs -f my{{serviceName}}**
<br>**docker-compose stop my{{serviceName}}**
<br>**docker-compose start my{{serviceName}}**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}