* TOC
{:toc}

基于 MQTT 的身份验证适用于使用 MQTT 连接的设备。
您可以将设备凭证类型从“访问令牌”更改为“MQTT 基本”。
基本 MQTT 凭证由可选的客户端 ID、用户名和密码组成。有三个选项可用：

#### 仅基于客户端 ID 的身份验证。

为此，您应该仅在下面的凭证表单中填充客户端 ID。
如果 MQTT 客户端指定正确的客户端 ID，则可以使用任何用户名或密码进行连接；

让我们回顾一下使用 MQTT 客户端 ID 将温度读数上传到 GridLinks Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用没有 TLS 的纯 MQTT：

```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" -t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -m {"temperature":25}
```
{: .copy-code}

上述命令需要 mosquitto 客户端库，您可以使用以下命令安装：**apt-get install mosquitto-clients**。
别忘了替换：

* **YOUR_TB_HOST** 为您的 GridLinks 实例的主机；
* **YOUR_CLIENT_ID** 为您的客户端 ID；

#### 基于用户名和密码的身份验证。

为此，您应该仅在下面的凭证表单中填充用户名和密码。
如果 MQTT 客户端指定正确的用户名和密码，则可以使用任何客户端 ID 进行连接。密码是可选的；

让我们回顾一下使用 MQTT 客户端用户名和密码将温度读数上传到 GridLinks Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用没有 TLS 的纯 MQTT：

```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" \
-t "v1/devices/me/telemetry" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

上述命令需要 mosquitto 客户端库，您可以使用以下命令安装：**apt-get install mosquitto-clients**。
别忘了替换：

* **YOUR_TB_HOST** 为您的 GridLinks 实例的主机；
* **YOUR_CLIENT_USERNAME/YOUR_CLIENT_PASSWORD** 为您的客户端用户名和密码；

#### 基于客户端 ID、用户名和密码的身份验证。

对于此选项，您应该填写客户端 ID、用户名和密码。
如果 MQTT 客户端指定正确的客户端 ID、用户名和密码组合，则可以连接；

让我们回顾一下使用 MQTT 客户端 ID、用户名和密码将温度读数上传到 GridLinks Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用没有 TLS 的纯 MQTT：

```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" \
-t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

上述命令需要 mosquitto 客户端库，您可以使用以下命令安装：**apt-get install mosquitto-clients**。
别忘了替换：

* **YOUR_TB_HOST** 为您的 GridLinks 实例的主机；
* **YOUR_CLIENT_ID** 为您的客户端 ID；
* **YOUR_CLIENT_USERNAME/YOUR_CLIENT_PASSWORD** 为您的客户端用户名和密码；

{% include images-gallery.html imageCollection="options" %}

#### MQTTS（MQTT over TLS）

单向 SSL 身份验证是一种标准身份验证模式，其中您的客户端设备使用服务器证书验证服务器的身份。
GridLinks 团队已经为 [GridLinks Cloud](https://cloud.codingas.com/signup) 配置了有效证书。
{% if docsPrefix != 'paas/' %}
如果您托管自己的 GridLinks 实例，请按照 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/) 指南配置服务器证书。
{% endif %}

配置完成后，您应该准备一个 pem 格式的 CA 根证书。此证书将由 mqtt 客户端用于验证服务器证书。
将 CA 根证书保存到您的工作目录中，文件名“**ca-root.pem**”。
*mqtt.thingsboard.cloud* 的 CA 根证书示例位于 [此处](/docs/paas/user-guide/resources/mqtt-over-ssl/ca-root.pem)。

现在，您可以使用 *ca-root.pem* 建立与您的 GridLinks 实例 (*YOUR_TB_HOST*) 的安全连接以上传遥测数据：
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

上述命令需要 mosquitto 客户端库，您可以使用以下命令安装：**apt-get install mosquitto-clients**。
别忘了替换：

* **YOUR_TB_HOST** 为您的 GridLinks 实例的主机；
* **YOUR_CLIENT_ID** 为您的客户端 ID；
* **YOUR_CLIENT_USERNAME/YOUR_CLIENT_PASSWORD** 为您的客户端用户名和密码；