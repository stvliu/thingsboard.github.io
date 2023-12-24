### 监控 Thingsboard Java 应用程序

为了监控 Thingsboard 应用程序，我们将使用 [Visual VM](https://visualvm.github.io/)
JMX 已在 `docker-compose.yml` 中启用，使用此行

```bash
JAVA_OPTS: " -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.rmi.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1"
```

让我们将 Thingsboard 实例的 **JMX 端口转发** 到本地计算机

```bash
ssh -L 9999:127.0.0.1:9999 thingsboard 
```

现在我们可以使用 VisualVM 连接到 Thingsboard 应用程序并发现内部情况

![VisualVM 中的 Thingsboard JMX 概述](/images/reference/performance-aws-instances/method/chart-examples/performance_test_thingsboard_jmx_visual_vm_overview.png "VisualVM 中的 Thingsboard JMX 概述")