配置 HTTP(S) 负载均衡器以访问 ThingsBoard 实例的 Web 界面。基本上，您有 3 种可能的配置选项：

* http - 不支持 HTTPS 的负载均衡器。建议**用于开发。**
  唯一的优点是配置简单且成本最低。可能是开发服务器的不错选择，但绝对不适合生产环境。
* https - 支持 HTTPS 的负载均衡器。建议**用于生产。**充当 SSL 终止点。
  您可以轻松配置它以颁发和维护有效的 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。
* transparent - 负载均衡器，只需将流量转发到 ThingsBoard 的 http 和 https 端口。要求您配置和维护有效的 SSL 证书。
  适用于无法容忍 LB 作为 SSL 终止点的生产环境。

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

现在，您可以使用地址（您在命令输出中看到而不是 34.111.24.134 的地址）来访问 HTTP Web UI（端口 80）并通过 [HTTP API](/docs/{{docsPrefix}}reference/http-api/)连接您的设备。

使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin
- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

#### HTTPS 负载均衡器

使用 Google 管理的 SSL 证书配置负载均衡器的过程在官方 [文档页面](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs) 中进行了描述。
以下说明摘自官方文档。在继续之前，请仔细阅读 [先决条件](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#prerequisites)。

```bash
gcloud compute addresses create thingsboard-http-lb-address --global
```
{: .copy-code}

在 *https-load-balancer.yml* 文件中将 *PUT_YOUR_DOMAIN_HERE* 替换为有效的域名：

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

执行以下命令以部署安全的 http 负载均衡器：

```bash
 kubectl apply -f receipts/https-load-balancer.yml
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
tb-https-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```

现在，**将您使用的域名**分配给负载均衡器 IP 地址（您在命令输出中看到而不是 34.111.24.134 的地址）。

使用 dig 检查域名是否配置正确：

```bash
dig YOUR_DOMAIN_NAME
```
{: .copy-code}

示例输出：

```text

; <<>> DiG 9.11.3-1ubuntu1.16-Ubuntu <<>> YOUR_DOMAIN_NAME
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12513
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;YOUR_DOMAIN_NAME.	IN	A

;; ANSWER SECTION:
YOUR_DOMAIN_NAME. 36 IN	A	34.111.24.134

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Fri Nov 19 13:00:00 EET 2021
;; MSG SIZE  rcvd: 74

```

分配后，等待 Google 管理的证书完成配置。这可能需要长达 60 分钟。您可以使用以下命令检查证书的状态：

```bash
kubectl describe managedcertificate managed-cert
```
{: .copy-code}

如果您正确配置了域记录，最终将配置证书。配置完成后，您可以使用您的域名访问 Web UI（通过 https）并通过 [HTTP API](/docs/{{docsPrefix}}reference/http-api/)连接您的设备。

{% capture https_lb_device_api_warn %}
**注意**：负载均衡器会将所有 HTTP 流量重定向到 HTTPS。不支持 HTTPS 的设备将无法连接到 ThingsBoard。
如果您想支持此类设备，您可以为 HTTP 传输部署单独的负载均衡器（推荐）或通过更改 *https-load-balancer.yml* 文件中的 *redirectToHttps* 设置来禁用重定向行为。

{% endcapture %}
{% include templates/warn-banner.md content=https_lb_device_api_warn %}