---
layout: docwithnav
title: 性能测试工具
description: ThingsBoard IoT 平台数据收集性能测试工具

---

* TOC
{:toc}

物联网市场的快速增长极大地提高了 MQTT 协议的普及率。MQTT 受最流行的物联网平台支持，用于数据收集、推送通知、实时消息传递等。

我们想在本文中分享我们在针对 MQTT 服务器运行性能测试方面的经验。我们将重点介绍用于在服务器上生成负载的工具。我们平台的性能测试结果将作为单独的帖子发布。

## Gatling

我们选择 **Gatling** 作为运行测试的框架，原因如下：

* 开箱即用，生成漂亮的报告。
* 高性能和低开销。
* 轻松设置负载场景。
* 模拟的 **可扩展性**。

遗憾的是，Gatling.io 框架开箱即用不支持 MQTT 协议。同时，Gatling 是一个开源框架，我们找到了一个非官方的 MQTT 插件。

#### Gatling MQTT 插件

**Gatling-MQTT** 插件由 **Muneyuki Noguchi** 开发，目前在 GitHub 上托管，采用 Apache 2.0 许可证。我们已经开始使用 Gatling 和 Gatling-MQTT 插件实施 ThingsBoard 性能测试项目。一段时间后，我们意识到该插件不支持我们想要验证的场景，并且默认场景的行为不是我们所期望的。

非官方 Gatling-MQTT 插件的默认场景的问题在于，每次发布某些数据时，客户端都会等待服务器的回复并发送 MQTT 断开连接。因此，消息序列如下所示：

![image](/images/reference/performance-tools/connect-publish-disconnect.png)

这种方法非常耗费资源，与 HTTP 或其他协议相比，好处最少。这种行为对于 HTTP 请求-响应模型来说是正常的，但对于 MQTT 来说却不是。典型的 MQTT 会话会保持一段时间，并且客户端和 MQTT 代理之间会发送和接收多个 MQTT 发布消息。当然，还有其他类型的 MQTT 消息，但它们超出了我们测试的范围。在我们的场景中，物联网平台的负载测试必须按以下方式进行：

![image](/images/reference/performance-tools/connect-publish-publish-publish-disconnect.png)

因此，一旦我们将设备连接到充当 MQTT 代理的物联网平台，我们将重用会话并使用相同的会话发布 MQTT 消息。当然，会话可能会在某个时刻重新创建，但不是每次我们想向服务器发布消息时都会重新创建。

为了支持此场景，我们决定不从头开始实施新内容，而是将 Gatling-MQTT 插件用作基础，并考虑到这是一个开源项目，我们可以自由地修改软件以满足我们的需求。

#### Gatling MQTT 插件分支

我们已经完成了 **Gatling-MQTT** 插件的分支，花了一些时间调查插件的构建方式，对其进行了修改，并将 **Connect**、**Publish** 和 **Disconnect** 操作添加为单独的步骤。

现在我们能够支持预期的场景。扩展版本的 Gatling-MQTT 插件位于此处 [**扩展的 Gatling-MQTT**](https://github.com/thingsboard/gatling-mqtt)。

最后，我们能够实施满足我们需求的场景。下面的 Gatling 模拟将为 10 个模拟设备创建单独的 MQTT 会话，并将为每个会话发送 100 条发布消息。

**MqttSimulation.scala**

```scala
class MqttSimulation extends Simulation {
    val mqttConfiguration = mqtt
        // MQTT 代理
        .host("tcp://localhost:1883")
    
    val connect = exec(mqtt("connect")
        .connect())
    
    // 发送 100 条发布 MQTT 消息
    val publish = repeat(100) {
        exec(mqtt("publish")
            // 主题：“foo”
            // 有效负载：“Hello”
            // 服务质量：AT_LEAST_ONCE (1)
            // 保留：false
            .publish("foo", "Hello", QoS.AT_LEAST_ONCE, retain = false))
            // 发送消息之间暂停 1 秒
            .pause(1000 milliseconds)
        }
    
    val disconnect = exec(mqtt("disconnect")
      .disconnect())
    
    val scn = scenario("MQTT 测试")
      .exec(connect, publish, disconnect)
    
    setUp(scn
        // 在 1 秒内线性连接 10 个设备
        // 并发送 100 条发布消息
        .inject(rampUsers(10) over (1 seconds))
    ).protocols(mqttConfiguration)
}
```

## 性能测试项目

我们的性能测试项目 **托管在 GitHub 上**。它主要用 Java 编写，并使用 Maven 作为构建工具。Gatling 和 Gatling-MQTT 插件是用 Scala 编写的，并使用 SBT 工具构建源代码和运行测试。但是，在 GridLinks，我们更多的是 Java 人员，而不是 Scala 人员，这就是为什么我们已经实施了连接到平台、创建设备、对其进行预热并提供 **凭据 ID** 字符串的自定义 Java 代码：

**MqttSimulation.scala**

```scala
// 获取已创建设备的设备凭据 ID
val deviceCredentialsIds: Array[String] = MqttStressTestTool.createDevices(testParams).asScala.toArray
```

**MqttStressTestTool.java**

```java
RestClient restClient = new RestClient(params.getRestApiUrl());
// 登录到 GridLinks 服务器
restClient.login(params.getUsername(), params.getPassword());
for (int i = 0; i < params.getDeviceCount(); i++) {
    // 使用 REST API 创建设备
    Device device = restClient.createDevice("Device " + UUID.randomUUID());
    // 从已创建的设备获取凭据
    DeviceCredentials credentials = restClient.getCredentials(device.getId());
    // 存储在最终将由 Simulation 类使用的数组中    
    deviceCredentialsIds.add(credentials.getCredentialsId());
    String[] mqttUrls = params.getMqttUrls();
    String mqttURL = mqttUrls[i % mqttUrls.length];
    MqttStressTestClient client = new MqttStressTestClient(results, mqttURL, credentials.getCredentialsId());
    // 连接到服务器并进行预热
    client.connect().waitForCompletion();
    client.warmUp(data);
    client.disconnect();
}
Thread.sleep(1000);
```

凭据 ID 列表用于 **MqttSimulation.scala** 文件以执行压力测试本身：

```scala
// 获取已创建设备的设备凭据 ID
val deviceCredentialsIds: Array[String] = MqttStressTestTool.createDevices(testParams).asScala.toArray

// 在连接到 GridLinks 服务器的阶段提供设备凭据 ID 作为用户名
val mqttConf = mqtt
    .host(testParams.getMqttUrls.head)
    .userName("${deviceCredentialsId}")

val connect = exec(mqtt("connect").connect())

val publish = repeat(testParams.getPublishTelemetryCount.toInt) {
    exec(mqtt("publish") 
        // 发布单条消息并验证是否至少已发送一次
        .publish("v1/devices/me/telemetry", "{\"temp\":73.2}", QoS.AT_LEAST_ONCE, retain = false))
        .pause(testParams.getPublishTelemetryPause milliseconds)
}

val disconnect = exec(mqtt("disconnect").disconnect())
// 创建已连接设备的设备凭据 ID 映射
// 并将其用作场景中的馈送器
val deviceCredentialsIdsFeeder = deviceCredentialsIds.map( x => {Map("deviceCredentialsId" -> x)})

val scn = scenario("场景名称")
    // 遍历映射并获取列 deviceCredentialsId 作为用户名
    .feed(deviceCredentialsIdsFeeder)
    .exec(connect, publish, disconnect)

setUp(scn
    .inject(rampUsers(deviceCredentialsIds.length) over (1 seconds))
).protocols(mqttConf)
```

对于喜欢 Java 和 Maven 的人，有一个 maven 插件 - **gatling-maven-plugin**：

```xml
<plugin>
    <groupId>io.gatling</groupId>
    <artifactId>gatling-maven-plugin</artifactId>
</plugin>
```

此插件会在您的项目中找到 *Simulation* 文件，编译并运行它们。结果将以漂亮的格式存储在目标文件夹中，您可以在运行后检查这些结果：

![image](/images/reference/performance-tools/gatling-indicators.png)

![image](/images/reference/performance-tools/gatling-statistics.png)

![image](/images/reference/performance-tools/gatling-number-of-requests-per-second.png)

![image](/images/reference/performance-tools/gatling-number-of-responses-per-second.png)

要运行测试，您只需键入：

```bash
mvn clean install gatling:execute
```

## 摘要

总的来说，我们已经描述了我们如何为我们的物联网平台生成高负载并验证它提供了良好的结果。

我们将在下一篇文章中分享 GridLinks 物联网平台性能测试的结果。

此外，我们将描述我们为实现每分钟处理超过 100 万条 MQTT 消息所做的代码更改、改进和实例调整。这些基本上是我们朝着平台性能测试方向迈出的第一步，我们非常欢迎有关此方法的任何反馈。

我们希望提供的经验将帮助您根据您期望在生产中看到的负载规范来验证您的解决方案。通过订阅我们的 Twitter、博客或在 Github 上关注我们的项目，随时了解最新动态。