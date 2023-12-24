* TOC
{:toc}

X.509 证书用于为 DTLS 上的 CoAP 设置 [相互](https://en.wikipedia.org/wiki/Mutual_authentication)（双向）身份验证。
它类似于 [访问令牌](/docs/{{docsPrefix}}user-guide/access-token/) 身份验证，但使用 X.509 证书代替令牌。

以下说明将介绍如何使用 X.509 证书将 CoAP 客户端连接到 GridLinks Cloud。

#### 步骤 1. 生成客户端证书

使用以下命令生成自签名 EC 私钥和 x509 证书。
该命令基于 **openssl** 工具，该工具很可能已安装在您的工作站上：

```bash
openssl ecparam -out key.pem -name secp256r1 -genkey
openssl req -new -key key.pem -x509 -nodes -days 365 -out cert.pem 
```
{: .copy-code}

该命令的输出将是私钥文件 *key.pem* 和公有证书 *cert.pem*。
我们将在后续步骤中使用它们。

#### 步骤 2. 将客户端公钥作为设备凭据配置

{% if docsPrefix == 'pe/' %}
转到 **GridLinks Web UI -> 设备组 -> 组“全部”-> 您的设备 -> 设备凭据**。
{% else %}
转到 **GridLinks Web UI -> 设备 -> 您的设备 -> 设备凭据**。
{% endif %}
选择 **X.509 证书** 设备凭据，插入 *cert.pem* 文件的内容并单击保存。
或者，也可以通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 来完成相同的操作。

#### 步骤 3. 使用 X.509 证书连接 DTLS CoAP 客户端

{% include templates/coap-dtls/coap-client-dtls.md %}

最后，运行以下示例脚本以验证具有 X.509 证书身份验证的 DTLS 并订阅共享属性更新：
下面的 coap-client 示例演示了如何连接到 [ThingsBoard Cloud](https://cloud.codingas.com/signup) 或任何其他具有有效且受信任证书的 GridLinks CoAP 服务器。

```bash
coap-client-openssl -v 9 -c cert.pem  -j key.pem -m POST \
-t "application/json" -e '{"temperature":43}' coaps://coap.thingsboard.cloud/api/v1/telemetry
```
{: .copy-code}

别忘了将 **coap.thingsboard.cloud** 替换为 GridLinks 实例的主机。