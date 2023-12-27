使用以下列出的说明在 Windows 中下载、安装、设置和运行 mosquitto_pub：

1. 下载并安装 Eclipse Mosquitto。访问 [Mosquitto 的官方下载页面](https://mosquitto.org/download/) 并选择合适的 Windows 安装程序（32 位或 64 位，具体取决于您的系统）。
2. 下载后，运行安装程序并按照说明进行操作。这将在您的 Windows 机器上安装 Mosquitto。默认情况下，Mosquitto 安装在“C:\Program Files\mosquitto”中；
3. 更新系统的“路径”变量。可执行文件“mosquitto_pub.exe”和“mosquitto_sub.exe”位于您安装 Mosquitto 的目录中。您需要将此目录添加到系统的“路径”环境变量中，以便 Windows 可以找到这些可执行文件，而不管当前目录是什么。

要将 Mosquitto 目录添加到“路径”变量，请按照以下步骤操作：

{% include images-gallery.html imageCollection="mosquitto-windows" showListImageTitles="true" %}

打开终端，并将 $THINGSBOARD_HOST_NAME 和 $ACCESS_TOKEN 替换为相应的值。

```bash
mosquitto_pub -d -q 1 -h "$THINGSBOARD_HOST_NAME" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 引用实时演示服务器，$ACCESS_TOKEN 是 ABC123：

```bash
mosquitto_pub -d -q 1 -h "demo.docs.codingas.com" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 引用您的本地安装，$ACCESS_TOKEN 是 ABC123：

```bash
mosquitto_pub -d -q 1 -h "localhost" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

成功的输出应类似于以下内容：

```text
Client mosqpub|xxx sending CONNECT
Client mosqpub|xxx received CONNACK
Client mosqpub|xxx sending PUBLISH (d0, q1, r0, m1, 'v1/devices/me/telemetry', ... (16 bytes))
Client mosqpub|xxx received PUBACK (Mid: 1)
Client mosqpub|xxx sending DISCONNECT
```

{% capture difference %}
**注意：**自 ThingsBoard 3.2 起，您可以使用基本 MQTT 凭据（客户端 ID、用户名和密码的组合）并使用设备配置文件自定义 **主题名称** 和 **有效负载类型**。在此处查看更多信息 [此处](/docs/user-guide/device-profiles/#mqtt-transport-type)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}