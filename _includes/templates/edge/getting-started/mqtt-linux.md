**Ubuntu** 安装 mqtt 客户端：

```bash
sudo apt-get install mosquitto-clients
```
{: .copy-code}

**macOS** 安装 cURL：

```bash
brew install mosquitto-clients
```
{: .copy-code}


用相应的值替换 $HOST_NAME、$MQTT_PORT 和 $ACCESS_TOKEN。

```bash
mosquitto_pub -d -q 1 -h "$HOST_NAME" -p "$MQTT_PORT" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}


例如，$HOST_NAME 引用本地 GridLinks Edge 安装，MQTT 端口为 **1883**，访问令牌为 **ABC123**：

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

**注意：**自 ThingsBoard 3.2 起，您可以使用基本 MQTT 凭据（客户端 ID、用户名和密码的组合）并使用设备配置文件自定义**主题名称**和**有效负载类型**。在此处查看更多信息：[此处](/docs/user-guide/device-profiles/#mqtt-transport-type)。

<br>