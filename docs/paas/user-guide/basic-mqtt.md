---
layout: docwithnav-paas
assignees:
- ashvayka
title: MQTT 基本认证
description: ThingsBoard 基于 MQTT 的认证。
options:
    0:
        image: /images/user-guide/basic-mqtt/client-id.png  
        title: '如果指定正确的客户端 ID，MQTT 客户端将能够使用任何用户名或密码进行连接。'    
    1:
        image: /images/user-guide/basic-mqtt/username-password.png  
        title: '如果指定正确的用户名和密码，MQTT 客户端将能够使用任何客户端 ID 进行连接。'
    2:
        image: /images/user-guide/basic-mqtt/no-password-check.png  
        title: '密码是可选的'
    3:
        image: /images/user-guide/basic-mqtt/client-id-username-password.png  
        title: '如果指定正确的客户端 ID、用户名和密码组合，MQTT 客户端将能够连接'    
---

{% assign docsPrefix = "paas/" %}

* TOC
{:toc}

基于 MQTT 的认证可用于使用 MQTT 连接的设备。
您可以将设备凭证类型从“访问令牌”更改为“MQTT 基本”。
MQTT 基本凭证由可选的客户端 ID、用户名和密码组成。有三个选项可用：

#### 仅基于客户端 ID 的认证。

为此，您应该仅在下面的凭证表单中填充客户端 ID。
如果指定正确的客户端 ID，MQTT 客户端将能够使用任何用户名或密码进行连接；

让我们回顾一下使用 MQTT 客户端 ID 将温度读数上传到 ThingsBoard Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用不带 TLS 的纯 MQTT：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **mqtt.thingsboard.cloud** 主机和 **1883** 端口，并且需要您可以使用以下命令安装的 mosquitto 客户端库：**apt-get install mosquitto-clients**

#### 基于用户名和密码的认证。

为此，您应该仅在下面的凭证表单中填充用户名和密码。
如果指定正确的用户名和密码，MQTT 客户端将能够使用任何客户端 ID 进行连接。密码是可选的；

让我们回顾一下使用 MQTT 客户端用户名和密码将温度读数上传到 ThingsBoard Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用不带 TLS 的纯 MQTT：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" \
-t "v1/devices/me/telemetry" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **mqtt.thingsboard.cloud** 主机和 **1883** 端口，并且需要您可以使用以下命令安装的 mosquitto 客户端库：**apt-get install mosquitto-clients**

#### 基于客户端 ID、用户名和密码的认证。

对于此选项，您应该填写客户端 ID、用户名和密码。
如果指定正确的客户端 ID、用户名和密码组合，MQTT 客户端将能够连接；

让我们回顾一下使用 MQTT 客户端 ID、用户名和密码将温度读数上传到 ThingsBoard Cloud 的简单命令。
有关更多详细信息，请参阅 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用不带 TLS 的纯 MQTT：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" \
-t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **mqtt.thingsboard.cloud** 主机和 **1883** 端口，并且需要您可以使用以下命令安装的 mosquitto 客户端库：**apt-get install mosquitto-clients**

{% include images-gallery.html imageCollection="options" %}

#### MQTTS（MQTT over TLS）

单向 SSL 认证是一种标准认证模式，您的客户端设备使用服务器证书验证服务器的身份。
ThingsBoard Cloud 使用有效的证书。
请使用此 [**链接**](/docs/{{docsPrefix}}user-guide/resources/mqtt-over-ssl/ca-root.pem) 下载 CA 根证书，并将其保存到您的工作目录中，文件名“**ca-root.pem**”。

```bash
wget https://thingsboard.io/docs/{{docsPrefix}}user-guide/resources/mqtt-over-ssl/ca-root.pem
```
{: .copy-code}

现在，您可以使用 *ca-root.pem* 建立与 ThingsBoard Cloud 的安全连接，并使用访问令牌 *YOUR_ACCESS_TOKEN* 对设备进行认证以上传遥测数据：

```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "mqtt.thingsboard.cloud" -p "8883" \
-t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **mqtt.thingsboard.cloud** 主机和 **8883** 端口，并且需要您可以使用以下命令安装的 mosquitto 客户端库：**apt-get install mosquitto-clients**