#### X.509 证书：

#### 步骤 1. 准备服务器和证书链

ThingsBoard 团队已经为 [ThingsBoard Cloud](https://thingsboard.cloud/signup) 配置了有效证书。
{% if docsPrefix != 'paas/' %}
如果您托管自己的 ThingsBoard 实例，请按照 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/) 指南配置服务器证书。
{% endif %}

配置后，您应该准备一个 pem 格式的 CA 根证书。此证书将由 mqtt 客户端用于验证服务器证书。
将 CA 根证书保存到您的工作目录中，文件名“**ca-root.pem**”。
*mqtt.thingsboard.cloud* 的 CA 根证书示例位于
[此处](/docs/paas/user-guide/resources/mqtt-over-ssl/ca-root.pem)。

#### 步骤 2. 生成客户端证书

使用以下命令生成自签名私钥和 x509 证书。
该命令基于 **openssl** 工具，该工具很可能已经安装在您的工作站上：

要生成基于 RSA 的密钥和证书，请使用：

```bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365 -nodes
```
{: .copy-code}

要生成基于 EC 的密钥和证书，请使用：

```bash
openssl ecparam -out key.pem -name secp256r1 -genkey
openssl req -new -key key.pem -x509 -nodes -days 365 -out cert.pem 
```
{: .copy-code}

该命令的输出将是私钥文件 *key.pem* 和公有证书 *cert.pem*。
我们将在后续步骤中使用它们。

#### 步骤 3. 将客户端公钥配置为设备凭证

转到 **GridLinks Web UI -> 实体 -> 设备 -> 您的设备 -> 管理凭证**。
选择 **X.509 证书** 设备凭证，插入 *cert.pem* 文件的内容，然后单击保存。
或者，也可以通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 完成相同的操作。

#### 步骤 4. 测试连接

执行以下命令，使用安全通道将温度读数上传到 GridLinks Cloud：

{% if docsPrefix == 'paas/' %}
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "mqtt.thingsboard.cloud" -p "8883" \
-t "v1/devices/me/telemetry" --key key.pem --cert cert.pem -m {"temperature":25}
```
{: .copy-code}
{% else %}
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" --key key.pem --cert cert.pem -m {"temperature":25}
```
{: .copy-code}
{% endif %}

别忘了将 **YOUR_TB_HOST** 替换为 GridLinks 实例的主机。