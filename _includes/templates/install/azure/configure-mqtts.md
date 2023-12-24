#### 双向 TLS

启用 MQTTS 的更复杂方法是获取有效的（已签名的）TLS 证书并在 MQTT 传输中配置它。此选项的主要优点是您可以将其与“X.509 证书”MQTT 客户端凭据结合使用。

要启用 **双向 TLS**：

按照 [本指南](/docs/user-guide/mqtt-over-ssl/) 创建一个带有 SSL 证书的 **.jks** 文件。
之后，您需要在 `tb-services.yml` 或 `tb-node.yaml` 文件中将 **MQTT_SSL_KEY_STORE_PASSWORD** 和 **MQTT_SSL_KEY_PASSWORD** 环境变量设置为相应的密钥库和证书密钥密码。

您需要使用 JKS 文件创建一个 config-map，您可以通过调用命令来执行此操作：

```
kubectl create configmap tb-mqtts-config \
             --from-file=server.jks=YOUR_JKS_FILENAME.jks -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

其中 **YOUR_JKS_FILENAME** 是您的 **.jks** 文件的名称。然后，取消注释 '{{eksTbServicesFile}}' 文件中所有标记为“取消注释以下行以启用双向 MQTTS”的部分。
此外，取消注释 'routes.yml' 文件中标记为“取消注释以下行以启用双向 MQTTS”注释的部分。