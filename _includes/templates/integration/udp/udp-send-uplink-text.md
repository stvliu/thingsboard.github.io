向运行在本地主机 (127.0.0.1) 上的 UDP 服务器发送消息的命令如下所示：

```shell
echo -e 'SN-001,default,temperature,25.7,humidity,69' | nc -q1 -w1 -u 127.0.0.1 11560
```
{: .copy-code}

![image](/images/user-guide/integrations/udp/terminal-text.png)