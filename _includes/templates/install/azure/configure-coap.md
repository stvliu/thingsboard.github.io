如果您计划使用 CoAP 协议连接设备，请配置 CoAP 负载均衡器。

使用以下命令创建 CoAP 负载均衡器：

```bash
kubectl apply -f receipts/coap-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发以下端口的所有 UDP 流量：

* 5683 - CoAP 服务器非安全端口
* 5684 - CoAP 服务器安全 DTLS 端口。

#### CoAP over DTLS

此类型的负载均衡器要求您自行配置和维护有效的 SSL 证书。
按照通用 [CoAP over DTLS](/docs/{{docsPrefix}}user-guide/coap-over-dtls) 指南在 *{{tbServicesFile}}* 文件中配置所需的变量。