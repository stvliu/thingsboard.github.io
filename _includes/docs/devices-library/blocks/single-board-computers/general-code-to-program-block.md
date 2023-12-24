现在，您可以代表您的设备发布遥测数据。我们将使用前面提到的“thingsboard-python-client-sdk”库。
让我们设置我们的项目：

1. 创建项目文件夹：

    ```bash
   mkdir thingsboard_example && cd thingsboard_example
   ```
   {:.copy-code}

2. 安装软件包：

   ```bash
   pip3 install tb-mqtt-client
   ```
   {:.copy-code}

3. 创建主脚本：

   ```bash
   nano main.py
   ```
   {:.copy-code}

4. 复制并粘贴以下代码：

   ```python
   import logging.handlers
   import time
   import os
   
   from tb_gateway_mqtt import TBDeviceMqttClient
   
   ACCESS_TOKEN = "TEST_TOKEN"
   THINGSBOARD_SERVER = '{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}thingsboard.cloud{% else %}demo.thingsboard.io{% endif %}'
   THINGSBOARD_PORT = 1883

   logging.basicConfig(level=logging.DEBUG)
   
   client = None
   
   # 默认闪烁周期
   period = 1.0
   
   
   # 当我们更改共享属性的值时将调用的回调函数
   def attribute_callback(result, _):
        print(result)
        # 确保粘贴您的共享属性名称
        period = result.get('blinkingPeriod', 1.0)

   # 当我们发送 RPC 时将调用的回调函数
   def rpc_callback(id, request_body):
       # 请求正文包含方法和其他参数
       print(request_body)
       method = request_body.get('method')
       if method == 'getTelemetry':
           attributes, telemetry = get_data()
           client.send_attributes(attributes)
           client.send_telemetry(telemetry)
       else:
           print('Unknown method: ' + method)
   
   
   def get_data():
       cpu_usage = round(float(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage }' ''').readline().replace('\n', '').replace(',', '.')), 2)
       ip_address = os.popen('''hostname -I''').readline().replace('\n', '').replace(',', '.')[:-1]
       mac_address = os.popen('''cat /sys/class/net/*/address''').readline().replace('\n', '').replace(',', '.')
       processes_count = os.popen('''ps -Al | grep -c bash''').readline().replace('\n', '').replace(',', '.')[:-1]
       swap_memory_usage = os.popen("free -m | grep Swap | awk '{print ($3/$2)*100}'").readline().replace('\n', '').replace(',', '.')[:-1]
       ram_usage = float(os.popen("free -m | grep Mem | awk '{print ($3/$2) * 100}'").readline().replace('\n', '').replace(',', '.')[:-1])
       st = os.statvfs('/')
       used = (st.f_blocks - st.f_bfree) * st.f_frsize
       boot_time = os.popen('uptime -p').read()[:-1]
       avg_load = (cpu_usage + ram_usage) / 2
   
       attributes = {
           'ip_address': ip_address,
           'macaddress': mac_address
       }
       telemetry = {
           'cpu_usage': cpu_usage,
           'processes_count': processes_count,
           'disk_usage': used,
           'RAM_usage': ram_usage,
           'swap_memory_usage': swap_memory_usage,
           'boot_time': boot_time,
           'avg_load': avg_load
       }
       print(attributes, telemetry)
       return attributes, telemetry
   
   # 请求属性回调
   def sync_state(result, exception=None):
        global period
        if exception is not None:
            print("Exception: " + str(exception))
        else:
            period = result.get('shared', {'blinkingPeriod': 1.0})['blinkingPeriod']

   def main():
        global client
        client = TBDeviceMqttClient(THINGSBOARD_SERVER, THINGSBOARD_PORT, ACCESS_TOKEN)
        client.connect()
        client.request_attributes(shared_keys=['blinkingPeriod'], callback=sync_state)
        
        # 现在 attribute_callback 将处理来自服务器的共享属性请求
        sub_id_1 = client.subscribe_to_attribute("blinkingPeriod", attribute_callback)
        sub_id_2 = client.subscribe_to_all_attributes(attribute_callback)

        # 现在 rpc_callback 将处理来自服务器的 rpc 请求
        client.set_server_side_rpc_request_handler(rpc_callback)

        while not client.stopped:
            attributes, telemetry = get_data()
            client.send_attributes(attributes)
            client.send_telemetry(telemetry)
            time.sleep(60)
   
   if __name__=='__main__':
       if ACCESS_TOKEN != "TEST_TOKEN":
           main()
       else:
           print("Please change the ACCESS_TOKEN variable to match your device access token and run script again.")
   ```
   {:.copy-code.expandable-15}

   在上面的代码中，将以下变量的值更改为您的凭据 - THINGSBOARD_SERVER、ACCESS_TOKEN。
   
   连接所需的变量：  
   
   | 变量名 | 默认值 | 说明 | 
   |-|-|
   | ACCESS_TOKEN | **TEST_TOKEN** | 您的设备访问令牌 |
   | THINGSBOARD_SERVER | **{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}thingsboard.cloud{% else %}demo.thingsboard.io{% endif %}** | 您的 GridLinks 主机或 IP 地址。 |
   | THINGSBOARD_PORT | **1883** | GridLinks 服务器 MQTT 端口。对于本指南，可以是默认值。 |

5. 单击 **Ctrl+O** 和 **Ctrl+X** 键保存文件。
6. 最后，让我们启动我们的脚本：

   ```bash
   python3 main.py
   ```
   {:.copy-code}

如果您做对了所有事情，您应该会看到以下控制台输出：
```
> INFO:tb_device_mqtt:connection SUCCESS
> 
> 
> {'ip_address': '192.168.1.198', 'macaddress': '3c:06:30:44:e0:24'} {'cpu_usage': 6.6, 'processes_count': 8, 'disk_usage': 70.0, 'RAM_usage': 73.9, 'swap_memory_usage': 69.4, 'battery': 29, 'boot_time': 1675154176.0}
> 
```

让我们回顾一下并对我们的代码进行解释。在此步骤中，我们对 `get_data` 函数感兴趣。
在 `get_data` 函数中打包和返回数据，因此如果您想监视更多值，可以轻松地将新的遥测或属性添加到字典中：
```python
...
def get_data():
       cpu_usage = round(float(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage }' ''').readline().replace('\n', '').replace(',', '.')), 2)
       ip_address = os.popen('''hostname -I''').readline().replace('\n', '').replace(',', '.')[:-1]
       mac_address = os.popen('''cat /sys/class/net/*/address''').readline().replace('\n', '').replace(',', '.')
       processes_count = os.popen('''ps -Al | grep -c bash''').readline().replace('\n', '').replace(',', '.')[:-1]
       swap_memory_usage = os.popen("free -m | grep Swap | awk '{print ($3/$2)*100}'").readline().replace('\n', '').replace(',', '.')[:-1]
       ram_usage = float(os.popen("free -m | grep Mem | awk '{print ($3/$2) * 100}'").readline().replace('\n', '').replace(',', '.')[:-1])
       st = os.statvfs('/')
       used = (st.f_blocks - st.f_bfree) * st.f_frsize
       boot_time = os.popen('uptime -p').read()[:-1]
       avg_load = (cpu_usage + ram_usage) / 2
   
       attributes = {
           'ip_address': ip_address,
           'macaddress': mac_address
       }
       telemetry = {
           'cpu_usage': cpu_usage,
           'processes_count': processes_count,
           'disk_usage': used,
           'RAM_usage': ram_usage,
           'swap_memory_usage': swap_memory_usage,
           'boot_time': boot_time,
           'avg_load': avg_load
       }
       print(attributes, telemetry)
       return attributes, telemetry
...
```

发送数据部分，如下所示，我们每 60 秒发送一次属性和遥测数据（如果您希望更频繁地更新数据，可以随时更改）：
```python
...		
    while not client.stopped:
        attributes, telemetry = get_data()
        client.send_attributes(attributes)
        client.send_telemetry(telemetry)
        time.sleep(60)
...
```