安装 **Ubuntu** 的 mqtt 客户端：

```bash
sudo apt-get install mosquitto-clients
```
{: .copy-code}

安装 **macOS** 的 cURL：

```bash
brew install mosquitto-clients
```
{: .copy-code}

{% if docsPrefix == 'paas/' %}

将 $ACCESS_TOKEN 替换为相应的值。

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

例如，$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

{% else %}

将 $THINGSBOARD_HOST_NAME 和 $ACCESS_TOKEN 替换为相应的值。

```bash
mosquitto_pub -d -q 1 -h "$THINGSBOARD_HOST_NAME" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 引用本地安装，$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "localhost" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

{% endif %}

成功的输出应类似于以下内容：

```text
Client mosqpub|xxx sending CONNECT
Client mosqpub|xxx received CONNACK
Client mosqpub|xxx sending PUBLISH (d0, q1, r0, m1, 'v1/devices/me/telemetry', ... (16 bytes))
Client mosqpub|xxx received PUBACK (Mid: 1)
Client mosqpub|xxx sending DISCONNECT
```

{% capture difference %}
**注意：**自 ThingsBoard 3.2 起，您可以使用基本 MQTT 凭据（客户端 ID、用户名和密码的组合）并使用设备配置文件自定义**主题名称**和**有效负载类型**。有关更多信息，请参阅[此处](/docs/user-guide/device-profiles/#mqtt-transport-type)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}