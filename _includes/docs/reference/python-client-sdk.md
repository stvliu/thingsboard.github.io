* TOC
{:toc}

SDK 支持：
- 未加密和加密（TLS v1.2）连接；
- QoS 0 和 1；
- 自动重新连接；
- 所有 [**设备 MQTT API**](/docs/{{docsPrefix}}reference/mqtt-api/)
- 所有 [**网关 MQTT API**](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)

SDK 基于 Paho MQTT 库。

## 安装

要使用 pip 安装：

```bash
pip3 install tb-mqtt-client
```

## 入门

客户端初始化和遥测发布。

```python
from tb_device_mqtt import TBDeviceMqttClient, TBPublishInfo


telemetry = {"temperature": 41.9, "enabled": False, "currentFirmwareVersion": "v1.2.2"}
client = TBDeviceMqttClient("127.0.0.1", "A1_TEST_TOKEN")
# 连接到 ThingsBoard
client.connect()
# 发送遥测而不检查传递状态
client.send_telemetry(telemetry) 
# 发送遥测并检查传递状态（默认情况下 QoS = 1）
result = client.send_telemetry(telemetry)
# get 是一个阻塞调用，等待传递状态  
success = result.get() == TBPublishInfo.TB_ERR_SUCCESS
# 断开与 ThingsBoard 的连接
client.disconnect()

```

### 使用 TLS 的连接

到本地的 TLS 连接。{% if docsPrefix != 'paas/' %}有关客户端和 ThingsBoard 配置的更多信息，请参阅 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/)。{% endif %}
要通过 MQTT over SSL 连接到 ThingsBoard，首先，您应该生成一个证书，并具有如下所示的代码：

```python
from socket import gethostname
from tb_device_mqtt import TBDeviceMqttClient


client = TBDeviceMqttClient(gethostname())
client.connect(tls=True,
               ca_certs="mqttserver.pub.pem",
               cert_file="mqttclient.nopass.pem")
client.disconnect()

```

## 使用设备 API

**TBDeviceMqttClient** 提供对 ThingsBoard 平台的设备 MQTT API 的访问。  
它允许发布遥测和属性更新、订阅属性更改、发送和接收 RPC 命令等。    

#### 订阅属性

如果您需要接收共享属性更新，可以使用如下代码：  

```python
from time import sleep
from tb_device_mqtt import TBDeviceMqttClient


def callback(result):
    print(result)

client = TBDeviceMqttClient("127.0.0.1", "A1_TEST_TOKEN")
client.connect()
client.subscribe_to_attribute("uploadFrequency", callback)
client.subscribe_to_all_attributes(callback)
while True:
    sleep(1)

```

#### 发送遥测包

为了将数据发送到 ThingsBoard，可以使用如下代码：

```python
from time import time
from tb_device_mqtt import TBDeviceMqttClient, TBPublishInfo


telemetry_with_ts = {"ts": int(round(time() * 1000)), "values": {"temperature": 42.1, "humidity": 70}}
client = TBDeviceMqttClient("127.0.0.1", "A1_TEST_TOKEN")
# 我们设置发送的最大消息数，以便同时发送它们。它可能会占用内存，但会提高性能
client.max_inflight_messages_set(100)
client.connect()
results = []
result = True
for i in range(0, 100):
    results.append(client.send_telemetry(telemetry_with_ts))
for tmp_result in results:
    result &= tmp_result.get() == TBPublishInfo.TB_ERR_SUCCESS
print("Result", str(result))
client.disconnect()

```

#### 从服务器请求属性

为了从 ThingsBoard 请求共享属性值，可以使用以下示例：

```python
from time import sleep
from tb_device_mqtt import TBDeviceMqttClient


def on_attributes_change(result, exception):
    if exception is not None:
        print("Exception:", str(exception))
    else:
        print(result)

client = TBDeviceMqttClient("127.0.0.1", "A1_TEST_TOKEN")
client.connect()
client.request_attributes(["configuration","targetFirmwareVersion"], callback=on_attributes_change)


while True:
    sleep(1)

```
#### 响应服务器 RPC 调用

如果您想为某些 RPC 请求发送响应，可以使用如下代码中的逻辑。  
以下示例连接到 ThingsBoard 本地实例并等待 RPC 请求。  
收到 RPC 请求后，客户端将向 ThingsBoard 发送带有来自具有客户端的设备的机器数据的响应，该设备的名称为 **Test Device A1**。  

```python
from psutil import cpu_percent, virtual_memory
from time import sleep
from tb_device_mqtt import TBDeviceMqttClient


# 根据请求方法，我们发送不同的数据
def on_server_side_rpc_request(client, request_id, request_body):
    print(request_id, request_body)
    if request_body["method"] == "getCPULoad":
        client.send_rpc_reply(request_id, {"CPU percent": cpu_percent()})
    elif request_body["method"] == "getMemoryUsage":
        client.send_rpc_reply(request_id, {"Memory": virtual_memory().percent})

client = TBDeviceMqttClient("127.0.0.1", "A1_TEST_TOKEN")
client.set_server_side_rpc_request_handler(on_server_side_rpc_request)
client.connect()


while True:
    sleep(1)

```
## 使用网关 API

**TBGatewayMqttClient** 扩展了 **TBDeviceMqttClient**，因此可以像普通设备一样访问其所有 API。   
此外，网关能够表示连接到它的多个设备。例如，代表其他受限设备发送遥测或属性。有关网关的更多信息，请参阅 [**此处**](/docs/iot-gateway/)。  

#### 发送遥测和属性

为了将数据发送到 ThingsBoard，设备名称为 **Test Device A1**，可以使用如下代码：

```python
from time import time
from tb_gateway_mqtt import TBGatewayMqttClient


gateway = TBGatewayMqttClient("127.0.0.1", "GATEWAY_TEST_TOKEN")
gateway.connect()
gateway.gw_connect_device("Test Device A1")

gateway.gw_send_telemetry("Test Device A1", {"ts": int(round(time() * 1000)), "values": {"temperature": 42.2}})
gateway.gw_send_attributes("Test Device A1", {"firmwareVersion": "2.3.1"})

gateway.gw_disconnect_device("Test Device A1")
gateway.disconnect()

```


#### 从服务器请求属性

为了从 ThingsBoard 请求设备名称为 **Test Device A1** 的共享属性值，可以使用以下示例：

```python
from time import sleep
from tb_gateway_mqtt import TBGatewayMqttClient


def callback(result, exception):
    if exception is not None:
        print("Exception: " + str(exception))
    else:
        print(result)

gateway = TBGatewayMqttClient("127.0.0.1", "TEST_GATEWAY_TOKEN")
gateway.connect()
gateway.gw_request_shared_attributes("Test Device A1", ["temperature"], callback)

while True:
    sleep(1)

```

#### 响应服务器 RPC 调用

如果您想为某些 RPC 请求发送响应，可以使用如下代码中的逻辑。  
以下示例将连接到 ThingsBoard 本地实例并等待 RPC 请求。  
收到 RPC 请求后，客户端将向 ThingsBoard 发送带有设备名称为 **Test Device A1** 的数据的响应。  

```python

from time import sleep
from psutil import cpu_percent, virtual_memory
from tb_gateway_mqtt import TBGatewayMqttClient


def rpc_request_response(client, request_id, request_body):
    # 请求正文包含 id、方法和其他参数
    print(request_body)
    method = request_body["data"]["method"]
    device = request_body["device"]
    req_id = request_body["data"]["id"]
    # 根据请求方法，我们发送不同的数据
    if method == 'getCPULoad':
        gateway.gw_send_rpc_reply(device, req_id, {"CPU load": cpu_percent()})
    elif method == 'getMemoryLoad':
        gateway.gw_send_rpc_reply(device, req_id, {"Memory": virtual_memory().percent})
    else:
        print('Unknown method: ' + method)

gateway = TBGatewayMqttClient("127.0.0.1", "TEST_GATEWAY_TOKEN")
gateway.connect()
# 现在 rpc_request_response 将处理来自服务器的 rpc 请求
gateway.gw_set_server_side_rpc_request_handler(rpc_request_response)
# 如果没有设备连接，则无法接收任何消息
gateway.gw_connect_device("Test Device A1")

while True:
    sleep(1)

```


## 其他示例

在相应的 [文件夹](https://github.com/thingsboard/thingsboard-python-client-sdk/tree/master/examples) 中，还有更多有关 [设备](https://github.com/thingsboard/thingsboard-python-client-sdk/tree/master/examples/device) 和 [网关](https://github.com/thingsboard/thingsboard-python-client-sdk/tree/master/examples/gateway) 的示例。