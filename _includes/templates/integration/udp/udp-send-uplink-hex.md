向运行在本地主机 (127.0.0.1) 上的 UDP 服务器发送消息的命令如下所示：

```shell
echo -e -n '534e2d30303164656661756c7432352e373639' | xxd -r -p | nc -q1 -w1 -u 127.0.0.1 11560
```
{: .copy-code}

![image](/images/user-guide/integrations/udp/terminal-hex.png)