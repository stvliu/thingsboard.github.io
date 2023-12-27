---
layout: docwithnav-paas
assignees:
- ashvayka
title: MQTT 的访问令牌身份验证
description: 基于 GridLinks 访问令牌的身份验证。

---

{% assign docsPrefix = "paas/" %}
* TOC
{:toc}

基于访问令牌的身份验证是默认的设备身份验证类型。
在 GridLinks 中创建设备后，将生成唯一的访问令牌。之后可以更改它。
客户端必须在 MQTT 连接消息中将访问令牌指定为用户名。

#### 纯 MQTT（无 SSL）

让我们回顾一下使用访问令牌 *YOUR_ACCESS_TOKEN* 将温度读数上传到 GridLinks Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用纯 MQTT，不使用 TLS：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **mqtt.thingsboard.cloud** 主机和 **1883** 端口，并且需要 mosquitto 客户端库，可以使用以下命令安装：**apt-get install mosquitto-clients**

#### MQTTS（MQTT over SSL）

单向 SSL 身份验证是一种标准身份验证模式，其中客户端设备使用服务器证书验证服务器的身份。
GridLinks Cloud 使用有效的证书。
请使用此 [**链接**](/docs/{{docsPrefix}}user-guide/resources/mqtt-over-ssl/ca-root.pem) 下载 CA 根证书，并将其保存到您的工作目录中，文件名是“**ca-root.pem**”。

```bash
wget https://docs.codingas.com/docs/{{docsPrefix}}user-guide/resources/mqtt-over-ssl/ca-root.pem
```
{: .copy-code}

现在，您可以使用 *ca-root.pem* 建立与 GridLinks云服务 的安全连接，并使用访问令牌 *YOUR_ACCESS_TOKEN* 对设备进行身份验证以上传遥测数据：

```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "mqtt.thingsboard.cloud" -p "8883" -t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **mqtt.thingsboard.cloud** 主机和 **8883** 端口，并且需要 mosquitto 客户端库，可以使用以下命令安装：**apt-get install mosquitto-clients**