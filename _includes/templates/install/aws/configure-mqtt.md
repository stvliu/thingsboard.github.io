如果您计划使用 MQTT 协议连接设备，请配置 MQTT 负载均衡器。

使用以下命令创建 TCP 负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发端口 1883 和 8883 的所有 TCP 流量。

##### 单向 TLS

配置 MQTTS 的最简单方法是让您的 MQTT 负载均衡器 (AWS NLB) 充当 TLS 终止点。
这样，我们就可以设置单向 TLS 连接，其中您的设备和负载均衡器之间的流量是加密的，而您的负载均衡器和 MQTT 传输之间的流量则未加密。
由于 ALB/NLB 在您的 VPC 中运行，因此应该没有安全问题。
此选项的唯一主要缺点是您无法使用“X.509 证书”MQTT 客户端凭据，因为客户端证书的信息不会从负载均衡器传输到 ThingsBoard MQTT 传输服务。

要启用 **单向 TLS**：

使用 [AWS 证书管理器](https://aws.amazon.com/certificate-manager/) 创建或导入 SSL 证书。记下您的证书 ARN。

编辑负载均衡器配置并将 *YOUR_MQTTS_CERTIFICATE_ARN* 替换为您的证书 ARN：

```bash
nano receipts/mqtts-load-balancer.yml
```
{: .copy-code}

执行以下命令以部署纯 https 负载均衡器：

```bash
kubectl apply -f receipts/mqtts-load-balancer.yml
```
{: .copy-code}

##### 双向 TLS

启用 MQTTS 的更复杂方法是获取有效的（已签名的）TLS 证书并在 MQTT 传输中对其进行配置。此选项的主要优点是您可以将其与“X.509 证书”MQTT 客户端凭据结合使用。

要启用 **双向 TLS**：

按照 [本指南](/docs/user-guide/mqtt-over-ssl/) 创建一个包含 SSL 证书的 **.pem** 文件。
将文件存储为工作目录中的 *server.pem*。

您需要使用 PEM 文件创建一个 config-map，您可以通过调用命令来完成：

```
kubectl create configmap tb-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* 其中 **YOUR_PEM_FILENAME** 是您的 **服务器证书文件** 的名称。
* 其中 **YOUR_PEM_KEY_FILENAME** 是您的 **服务器证书私钥文件** 的名称。

然后，取消注释 '{{tbServicesFile}}' 文件中标记为“取消注释以下行以启用双向 MQTTS”的所有部分。

执行命令以应用更改：

```
kubectl apply -f {{tbServicesFile}}
```
{: .copy-code}

最后，部署“透明”负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}