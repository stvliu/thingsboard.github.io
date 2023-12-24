集群准备就绪后，您必须创建 AWS 负载均衡器控制器。
您可以按照[此](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)指南进行操作。
集群配置脚本将创建多个负载均衡器：

* “tb-http-loadbalancer” - 负责 Web UI、REST API 和 HTTP 传输的 AWS ALB；
* “tb-mqtt-loadbalancer” - 负责 MQTT 传输的 AWS NLB；
* “tb-coap-loadbalancer” - 负责 CoAP 传输的 AWS NLB；
* “tb-edge-loadbalancer” - 负责 Edge 实例连接的 AWS NLB；

配置 AWS 负载均衡器[控制器](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)是**非常重要的一步**，这是使这些负载均衡器正常工作所必需的。