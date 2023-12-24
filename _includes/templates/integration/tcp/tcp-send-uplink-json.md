向运行在本地主机 (127.0.0.1) 上的 TCP 服务器发送消息的命令如下所示：

```shell
echo -e -n '{"deviceName": "SN-002", "deviceType": "default", "temperature": 25.7, "humidity": 69}' | nc -q1 -w1 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-json-uplink-message-1.png)

如果要使用 **下行链路** 向设备发送消息，则命令如下所示：

```shell
echo -e -n '{"deviceName": "SN-002", "deviceType": "default", "temperature": 25.7, "humidity": 69}' | nc -w60 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-json-downlink-message-1.png)