打开运行 **mqtt-js.sh** 脚本的终端。
您应该在屏幕上看到类似的消息：

```shell
pc@pc-XPS-15-9550:~/alarm-tutorial$ bash mqtt-js.sh
连接到：localhost:1883，使用访问令牌：sFqoF18PTyViO8L0qo7c
冷却器已连接！
从边缘收到 RPC 命令！
方法：enabled_air_conditioner
速度参数：1
```

恭喜！根据 **DHT22** 传感器的温度读数，已成功向 **空调** 设备发送 RPC 请求。