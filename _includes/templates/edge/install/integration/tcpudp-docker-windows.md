Windows 用户应使用 docker 管理的卷来记录远程集成日志。
在执行 docker run 命令之前创建 docker 卷（例如 `tb-tcp-udp-integration-logs`）：
打开“Docker 快速启动终端”。执行以下命令以创建 docker 卷：

``` 
docker volume create tb-pe-tcp-udp-integration-logs
```
{: .copy-code}

执行以下命令以直接运行此 docker：

```bash
docker run -it -p 10560:10560 -v tb-pe-tcp-udp-integration-logs:/var/log/tb-tcp-udp-integration `
-e "RPC_HOST=EDGE_IP_OR_HOST_ADDRESS" -e "RPC_PORT=9090" `
-e "INTEGRATION_ROUTING_KEY=YOUR_ROUTING_KEY"  -e "INTEGRATION_SECRET=YOUR_SECRET" `
--name my-tb-pe-tcp-udp-integration --restart always thingsboard/tb-pe-tcp-udp-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

其中：

- `EDGE_IP_OR_HOST_ADDRESS` - 是 GridLinks Edge 的主机名或 IP 地址；
- `9090` - 是 GridLinks Edge 的集成端口。它在 tb-edge.yml 中使用 INTEGRATIONS_RPC_PORT 环境变量进行配置；
- `YOUR_ROUTING_KEY` - 在 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials) 中获得的集成路由密钥的占位符；
- `YOUR_SECRET` - 在 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials) 中获得的集成密钥的占位符；
- `docker run` - 运行此容器；
- `-it` - 附加一个终端会话，其中包含当前 ThingsBoard 远程集成进程输出；
- `-p 10560:10560` - 将本地端口 10560 连接到公开的内部 10560 端口以进行集成
- `-v tb-pe-tcp-udp-integration-logs:/var/log/tb-tcp-udp-integration` - 将主机的目录 `~/.tb-pe-tcp-udp-integration-logs` 挂载到 GridLinks 远程集成日志目录；
- `--name tb-pe-tcp-udp-integration` - 此计算机的友好本地名称；
- `--restart always` - 在系统重新启动时自动启动 ThingsBoard 集成，并在发生故障时重新启动；
- `thingsboard/tb-pe-tcp-udp-integration:{{ site.release.pe_full_ver }}` - docker 镜像。

执行此命令后，您可以打开位于此处 `~/.tb-pe-tcp-udp-integration-logs` 的日志。您应该会看到一些 INFO 日志消息，其中包含从服务器收到的最新集成配置。

<br>

您可以使用 **`Ctrl-p`**+**`Ctrl-q`** 从会话终端分离 - 容器将继续在后台运行。

<br>

- **重新连接、停止和启动命令**

要重新连接到终端（以查看 ThingsBoard 远程集成日志），请运行：

```
docker attach tb-pe-tcp-udp-integration
```
{: .copy-code}

要停止容器：

```
docker stop tb-pe-tcp-udp-integration
```
{: .copy-code}

要启动容器：

```
docker start tb-pe-tcp-udp-integration
```
{: .copy-code}