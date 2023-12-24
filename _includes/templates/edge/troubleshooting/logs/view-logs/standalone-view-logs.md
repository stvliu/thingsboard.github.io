查看运行时的最新日志：

```bash
tail -f /var/log/tb-edge/tb-edge.log
```

您可以使用 **grep** 命令仅显示其中包含所需字符串的输出。
例如，您可以使用以下命令检查服务端是否存在任何错误：

```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```