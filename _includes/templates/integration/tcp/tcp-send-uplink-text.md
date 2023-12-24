向运行在本地主机 (127.0.0.1) 上的 TCP 服务器发送消息的命令如下所示：

```shell
echo -e 'SN-002,default,temperature,25.7' | nc -q0 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-add-attribute-1.png)

我们还可以在一个字符串中发送多条消息，用 **消息分隔符**（**系统行分隔符**）分隔。
换行符分隔符（**\n**）将用于将有效负载拆分为多条消息。

在这种情况下，命令如下所示：

```shell
echo -e 'SN-002,default,temperature,25.7\nSN-002,default,humidity,69' | nc -q1 -w1 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-add-attribute-2.png)

如果您想使用 **下行链路** 向设备发送回消息，则命令如下所示：

```shell
echo -e 'SN-002,default,temperature,25.7' | nc 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-downlink-message-1.png)

对于一个字符串中的多条消息：

```shell
echo -e 'SN-002,default,temperature,25.7\nSN-002,default,humidity,69' | nc -w60 127.0.0.1 10560
```
{: .copy-code}

![image](/images/user-guide/integrations/tcp/tcp-terminal-text-downlink-message-2.png)