执行以下命令为服务创建日志文件夹，并将这些文件夹的 chown 授予 docker 容器用户。

要能够更改用户，请使用 **chown** 命令，该命令需要 sudo 权限（脚本将请求 sudo 访问的密码）：

```bash
./docker-create-log-folders.sh
```
{: .copy-code}

执行以下命令运行安装：

```bash
./docker-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载其他演示数据。

执行以下命令启动服务：

```bash
./docker-start-services.sh
```
{: .copy-code}

一段时间后，当所有服务都成功启动后，你可以在浏览器中打开 `http://{your-host-ip}`（例如 `http://localhost`）。

你应该会看到 ThingsBoard 登录页面。

使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin

如果你使用 `--loadDemo` 标志安装了包含演示数据的数据库，你还可以使用以下凭据：

- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

如果出现任何问题，你可以检查服务日志以查找错误。

例如，要查看 ThingsBoard 节点日志，请执行以下命令：

```bash
docker compose {{dockerComposeFileLocation}}logs -f tb-core1 tb-rule-engine1
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果你仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：

**docker-compose {{dockerComposeFileLocation}}logs -f tb-core1 tb-rule-engine1**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

或者使用以下命令查看所有容器的状态：

```bash
docker compose {{dockerComposeFileLocation}}ps
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果你仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：

**docker-compose {{dockerComposeFileLocation}}ps**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

使用以下命令检查所有正在运行的服务的日志：

```bash
docker compose {{dockerComposeFileLocation}}logs -f
```
{: .copy-code}

{% capture dockerComposeStandalone %}
如果你仍然依赖 Docker Compose 作为 docker-compose（带连字符），请执行以下命令：

**docker-compose {{dockerComposeFileLocation}}logs -f**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

有关详细信息，请参阅 [docker-compose logs](https://docs.docker.com/compose/reference/logs/) 命令参考。

执行以下命令停止服务：

```bash
./docker-stop-services.sh
```
{: .copy-code}

执行以下命令停止并完全删除已部署的 docker 容器：

```bash
./docker-remove-services.sh
```
{: .copy-code}

执行以下命令更新特定服务或所有服务（拉取较新的 docker 镜像并重建容器）：

```bash
./docker-update-service.sh [SERVICE...]
```
{: .copy-code}

其中：

- `[SERVICE...]` - 要更新的服务列表（在 docker-compose 配置中定义）。如果未指定，则将更新所有服务。

{% include templates/install/upgrade-docker-compose.md %}

{% include templates/install/generate_certificate_docker-compose.md %}