#### X.509 证书链：

#### 步骤 1. 准备服务器和证书链

ThingsBoard 团队已经为 [ThingsBoard Cloud](https://thingsboard.cloud/signup) 预置了一个有效的证书。
{% if docsPrefix != 'paas/' %}
如果您托管自己的 GridLinks 实例，请按照 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/) 指南预置服务器证书。
{% endif %}

预置后，您应该准备一个 pem 格式的 CA 根证书。此证书将由 mqtt 客户端用于验证服务器证书。
将 CA 根证书保存到您的工作目录中，文件名“**ca-root.pem**”。
*mqtt.thingsboard.cloud* 的 CA 根证书示例位于
[此处](/docs/paas/user-guide/resources/mqtt-over-ssl/ca-root.pem)。

#### 步骤 2. 生成客户端证书链

我们应该生成具有 **合理** 公共名称 (CN) 的证书链。我们将使用中间证书为我们的设备签署证书。
例如，证书链 CN 可能如下：

* 根证书 CN：company-name.com；
* 中间证书：device-group-name.company-name.com；
* 设备证书：device-name.device-group-name.company-name.com；

使用以下命令为每个链级生成自签名私钥、证书签名请求和 x509 证书。这些命令基于 **OpenSSL** 工具，该工具很可能已经安装在您的工作站上：

**步骤 2.1** 生成根证书

生成根证书和私钥，使用以下命令。提示时不要忘记输入正确的 CN：

```bash
openssl req -x509 -newkey rsa:4096 -keyout rootKey.pem -out rootCert.pem -sha256 -days 365 -nodes
```
{: .copy-code}

<details>
<summary>
示例输出，引用 *company.com* 作为 CN
</summary>
{% highlight text %}
生成 RSA 私钥
将新私钥写入 'rootKey.pem'
-----
您即将被要求输入将包含在证书请求中的信息。
您即将输入的内容称为专有名称或 DN。
有很多字段，但您可以留空
对于某些字段，将有默认值，
如果您输入“.”，该字段将留空。
-----
国家名称（2 个字母代码）[AU]：
州或省名称（全名）[Some-State]：
地区名称（例如，城市）[]：
组织名称（例如，公司）[Internet Widgits Pty Ltd]：
组织单位名称（例如，部门）[]：
公用名称（例如，服务器 FQDN 或您的姓名）[]：company.com
电子邮件地址[]：
{% endhighlight %}
</details>
<br>

**步骤 2.2** 生成中间证书

要生成中间密钥和证书请求，请使用以下命令。提示时不要忘记输入正确的 CN：

```bash
openssl req -new -newkey rsa:4096 -keyout intermediateKey.pem -out intermediate.csr -sha256 -nodes
```
{: .copy-code}

<details>
<summary>
示例输出，引用 *group.company.com* 作为 CN
</summary>
{% highlight text %}
生成 RSA 私钥
将新私钥写入 'intermediateKey.pem'
-----
您即将被要求输入将包含在证书请求中的信息。
您即将输入的内容称为专有名称或 DN。
有很多字段，但您可以留空
对于某些字段，将有默认值，
如果您输入“.”，该字段将留空。
-----
国家名称（2 个字母代码）[AU]：
州或省名称（全名）[Some-State]：
地区名称（例如，城市）[]：
组织名称（例如，公司）[Internet Widgits Pty Ltd]：
组织单位名称（例如，部门）[]：
公用名称（例如，服务器 FQDN 或您的姓名）[]：group.company.com
电子邮件地址[]：

请输入以下“额外”属性
与您的证书请求一起发送
挑战密码[]：
可选公司名称[]：
{% endhighlight %}
</details>
<br>

要生成中间证书，请使用以下命令。提示时不要忘记输入正确的 CN：

```bash
openssl x509 -req -in intermediate.csr -out intermediateCert.pem -CA rootCert.pem -CAkey rootKey.pem -days 365 -sha256 -CAcreateserial
```
{: .copy-code}

<details>
<summary>
示例输出
</summary>
{% highlight text %}
签名正常
subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = group.company.com
获取 CA 私钥
{% endhighlight %}
</details>
<br>


**步骤 2.3** 生成设备证书

要生成设备证书，请使用以下命令。提示时不要忘记输入正确的 CN：

```bash
openssl req -new -newkey rsa:4096 -keyout deviceKey.pem -out device.csr -sha256 -nodes
```
{: .copy-code}

<details>
<summary>
示例输出，引用 *device123.group.company.com* 作为 CN
</summary>
{% highlight text %}
生成 RSA 私钥
将新私钥写入 'deviceKey.pem'
-----
您即将被要求输入将包含在证书请求中的信息。
您即将输入的内容称为专有名称或 DN。
有很多字段，但您可以留空
对于某些字段，将有默认值，
如果您输入“.”，该字段将留空。
-----
国家名称（2 个字母代码）[AU]：
州或省名称（全名）[Some-State]：
地区名称（例如，城市）[]：
组织名称（例如，公司）[Internet Widgits Pty Ltd]：device.group.company.com
组织单位名称（例如，部门）[]：
公用名称（例如，服务器 FQDN 或您的姓名）[]：
电子邮件地址[]：

请输入以下“额外”属性
与您的证书请求一起发送
挑战密码[]：
可选公司名称[]：
{% endhighlight %}
</details>
<br>

要生成中间证书，请使用以下命令。提示时不要忘记输入正确的 CN：

```bash
openssl x509 -req -in device.csr -out deviceCert.pem -CA intermediateCert.pem -CAkey intermediateKey.pem -days 365 -sha256 -CAcreateserial
```
{: .copy-code}

<details>
<summary>
示例输出
</summary>
{% highlight text %}
签名正常
subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = device.group.company.com
获取 CA 私钥
{% endhighlight %}
</details>
<br>


最后，您需要将证书从设备证书连接到根证书，以形成一个链。

```bash
cat deviceCert.pem intermediateCert.pem rootCert.pem > chain.pem
```
{: .copy-code}

这些命令的输出将是每个链级的私钥和证书。在接下来的步骤中，我们将使用设备密钥文件 *deviceKey.pem* 和证书链 *chain.pem*。

#### 步骤 3. 将客户端中间公钥预置为设备配置文件 X509 预置策略

转到 **GridLinks Web UI -> 配置文件 -> 设备配置文件 -> 您的设备配置文件 -> 设备预置**。
选择 **X.509 证书链** 预置策略，插入 *intermediateCert.pem* 文件的内容和从 *deviceCert.pem* 获取公用名称的正则表达式模式，选择是否允许创建新设备，然后单击保存。
或者，也可以通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 完成相同的操作。

#### 步骤 4. 测试连接

执行以下命令，使用安全通道将温度读数上传到 GridLinks Cloud：

{% if docsPrefix == 'paas/' %}
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "mqtt.thingsboard.cloud" -p "8883" \
-t "v1/devices/me/telemetry" --key deviceKey.pem --cert chain.pem -m {"temperature":25}
```
{: .copy-code}
{% else %}
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" --key deviceKey.pem --cert chain.pem -m {"temperature":25}
```
{: .copy-code}

用于 [自签名](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/#self-signed-certificates-generation) 服务器证书的类似命令：

```bash
mosquitto_pub --insecure --cafile server.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" --key deviceKey.pem --cert chain.pem -m {"temperature":25}
```
{: .copy-code}
{% endif %}

 

不要忘记将 **YOUR_TB_HOST** 替换为 GridLinks 实例的主机。