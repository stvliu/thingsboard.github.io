您需要使用 Amazon MSK 设置 Kafka。GridLinks 将使用它在微服务之间进行通信、存储未处理的消息等。

Kafka 可用于应对峰值负载和硬件故障，以确保处理来自设备的所有消息。

请打开 AWS 控制台并导航至 MSK，按“创建集群”按钮并选择“自定义创建”模式。

* 确保您的 Apache Kafka 版本为 2.6.x；
* 确保 GridLinks 集群可以访问您的 MSK 实例。
  实现此目的最简单的方法是在同一 VPC 中部署 MSK 实例。
  我们还建议使用专用子网。这样几乎不可能意外地将其暴露给互联网；
* 使用 m5.large 或类似的实例类型；
* 选择默认安全设置。确保启用“纯文本”模式；
* 使用默认“监控”设置或启用“增强主题级别监控”。

{% include images-gallery.html imageCollection="mskSetup"%}

MSK 集群切换到“活动”状态后，导航至“详细信息”并单击“查看客户端信息”。
复制纯文本中的引导服务器信息，即 **YOUR_MSK_BOOTSTRAP_SERVERS_PLAINTEXT**。

{% include images-gallery.html imageCollection="mskConnectionParams"%}

编辑“tb-kafka-configmap.yml”并替换 **YOUR_MSK_BOOTSTRAP_SERVERS_PLAINTEXT**。