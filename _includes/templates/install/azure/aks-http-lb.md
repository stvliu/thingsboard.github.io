配置 HTTP(S) 负载均衡器以访问 GridLinks 实例的 Web 界面。基本上，您有 3 种可能的配置选项：

- http - 不支持 HTTPS 的负载均衡器。建议用于开发。唯一的优点是配置简单且成本最低。可能是开发服务器的不错选择，但绝对不适合生产。
- https - 支持 HTTPS 的负载均衡器。建议用于生产。充当 SSL 终止点。您可以轻松配置它以颁发和维护有效的 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。

请参阅以下链接/说明，了解如何配置每个建议的选项。

#### HTTP 负载均衡器

执行以下命令以部署纯 http 负载均衡器：

```
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

负载均衡器配置过程可能需要一些时间。您可以使用以下命令定期检查负载均衡器的状态：

```
kubectl get ingress
```
{: .copy-code}

配置完成后，您应该会看到类似的输出：

```text
NAME                   CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-http-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```
现在，您可以使用地址（您在命令输出中看到 34.111.24.134 代替的地址）访问 HTTP Web UI（端口 80）并通过 HTTP API 连接您的设备。使用以下默认凭据：

- **系统管理员**：sysadmin@gridlinks.com / sysadmin
- **租户管理员**：tenant@gridlinks.com / tenant
- **客户用户**：customer@gridlinks.com / customer

#### HTTPS 负载均衡器

对于使用 ssl 证书，我们可以使用以下命令直接在 Azure ApplicationGateWay 中添加我们的证书：
```
az network application-gateway ssl-cert create \
   --resource-group $(az aks show --name $TB_CLUSTER_NAME --resource-group $AKS_RESOURCE_GROUP --query nodeResourceGroup | tr -d '"') \
   --gateway-name $AKS_GATEWAY\
   --name ThingsBoardHTTPCert \
   --cert-file YOUR_CERT \
   --cert-password YOUR_CERT_PASS
```
{: .copy-code}

将证书添加到应用程序负载均衡器后，我们可以执行：
```
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

负载均衡器配置过程可能需要一些时间。您可以使用以下命令定期检查负载均衡器的状态：

```
kubectl get ingress
```
{: .copy-code}

配置完成后，您应该会看到类似的输出：
```text
NAME                   CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-https-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```


{% capture https_lb_device_api_warn %}
**注意**：负载均衡器会将所有 HTTP 流量重定向到 HTTPS。不支持 HTTPS 的设备将无法连接到 GridLinks。
如果您想支持此类设备，您可以为 HTTP 传输部署单独的负载均衡器（推荐）或通过更改 *https-load-balancer.yml* 文件中的 *appgw.ingress.kubernetes.io/ssl-redirect* 设置来禁用重定向行为。

{% endcapture %}
{% include templates/warn-banner.md content=https_lb_device_api_warn %}