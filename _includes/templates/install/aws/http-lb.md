配置 HTTP(S) 负载均衡器以访问 ThingsBoard 实例的 Web 界面。基本上，您有 2 种可能的配置选项：

* http - 不支持 HTTPS 的负载均衡器。建议**用于开发。**
  唯一的优点是配置简单且成本最低。可能是开发服务器的不错选择，但绝对不适合生产。
* https - 支持 HTTPS 的负载均衡器。建议**用于生产。**充当 SSL 终止点。
  您可以轻松配置它以颁发和维护有效的 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。

请参阅以下链接/说明，了解如何配置每个建议的选项。

#### HTTP 负载均衡器

执行以下命令以部署纯 http 负载均衡器：

```bash
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

负载均衡器配置过程可能需要一些时间。您可以使用以下命令定期检查负载均衡器的状态：

```bash
kubectl get ingress
```
{: .copy-code}

配置完成后，您应该会看到类似的输出：

```text
NAME                   CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-http-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```

现在，您可以使用地址（您在命令输出中看到而不是 34.111.24.134 的地址）来访问 HTTP Web UI（端口 80）并通过 [HTTP API](/docs/{{docsPrefix}}reference/http-api/)连接您的设备
使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin
- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

#### HTTPS 负载均衡器

使用 [AWS 证书管理器](https://aws.amazon.com/certificate-manager/)创建或导入 SSL 证书。记下您的证书 ARN。

编辑负载均衡器配置并将 *YOUR_HTTPS_CERTIFICATE_ARN* 替换为您的证书 ARN：

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

执行以下命令以部署纯 https 负载均衡器：

```bash
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}