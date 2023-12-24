为了启动集群监控——Grafana 和 Prometheus 服务，请编辑配置文件：

```bash
nano .env
```
{: .copy-code}

您需要确保 `MONITORING_ENABLED` 变量设置为 `true`：

```bash
MONITORING_ENABLED=true
```

部署后，您将能够在 `http://localhost:9090` 访问 Prometheus，在 `http://localhost:3000` 访问 Grafana（默认登录名为 `admin`，密码为 `foobar`）。