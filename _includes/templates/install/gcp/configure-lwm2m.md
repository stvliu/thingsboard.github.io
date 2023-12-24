如果您计划使用 LwM2M 协议连接设备，请配置 LwM2M 负载均衡器。

使用以下命令创建 LwM2M UDP 负载均衡器：

```bash
kubectl apply -f receipts/lwm2m-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发以下端口的所有 UDP 流量：

* 5685 - LwM2M 服务器非安全端口。
* 5686 - LwM2M 服务器安全 DTLS 端口。
* 5687 - LwM2M 引导服务器 DTLS 端口。
* 5688 - LwM2M 引导服务器安全 DTLS 端口。

#### LwM2M over DTLS

此类型的负载均衡器要求您自行配置和维护有效的 SSL 证书。
按照通用 [LwM2M over DTLS](/docs/{{docsPrefix}}user-guide/ssl/lwm2m-over-dtls/) 指南在 *{{tbServicesFile}}* 文件中配置所需的变量。