* TOC
{:toc}


基于访问令牌的身份验证是默认的设备身份验证类型。
在设备在 GridLinks 中创建后，将生成唯一的访问令牌。之后可以更改它。
客户端必须在 MQTT 连接消息中将访问令牌指定为用户名。

#### 纯 MQTT（无 SSL）

让我们回顾一下使用访问令牌 *YOUR_ACCESS_TOKEN* 将温度读数上传到 GridLinks Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用纯 MQTT，不使用 TLS：

```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" \ 
-t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

上述命令需要 mosquitto 客户端库，可以使用以下命令安装：**apt-get install mosquitto-clients**。
别忘了将 **YOUR_TB_HOST** 替换为 GridLinks 实例的主机，将 **YOUR_ACCESS_TOKEN** 替换为设备的访问令牌。

#### MQTTS（MQTT over SSL）

单向 SSL 身份验证是一种标准身份验证模式，其中客户端设备使用服务器证书验证服务器的身份。
ThingsBoard 团队已经为 [ThingsBoard Cloud](https://thingsboard.cloud/signup) 配置了有效证书。
{% if docsPrefix != 'paas/' %}
如果您托管自己的 ThingsBoard 实例，请按照 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/) 指南配置服务器证书。
{% endif %}

配置完成后，您应该准备一个 pem 格式的 CA 根证书。此证书将由 mqtt 客户端用于验证服务器证书。
将 CA 根证书保存到您的工作目录中，文件名“**ca-root.pem**”。
*mqtt.thingsboard.cloud* 的 CA 根证书示例位于 [此处](/docs/paas/user-guide/resources/mqtt-over-ssl/ca-root.pem)。

现在，您可以使用 *ca-root.pem* 建立与 ThingsBoard 实例 (*YOUR_TB_HOST*) 的安全连接，并使用访问令牌 (*YOUR_ACCESS_TOKEN*) 对设备进行身份验证以上传遥测数据：

```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

上述命令需要 mosquitto 客户端库，可以使用以下命令安装：**apt-get install mosquitto-clients**。
别忘了将 **YOUR_TB_HOST** 替换为 GridLinks 实例的主机，将 **YOUR_ACCESS_TOKEN** 替换为设备的访问令牌。