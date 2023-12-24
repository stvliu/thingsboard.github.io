* TOC
{:toc}

ThingsBoard 规则引擎支持对传入遥测数据的基本分析，例如阈值越界。
规则引擎背后的理念是提供功能，根据设备属性或数据本身，将数据从物联网设备路由到不同的插件。
但是，大多数实际用例还需要高级分析的支持：机器学习、预测分析等。

本教程将演示如何：

- 使用内置规则引擎功能将遥测设备数据从 ThingsBoard 路由到 Kafka 主题（适用于 ThingsBoard CE 和 PE）。
- 使用简单的 Kafka Streams 应用程序聚合来自多个设备的数据。
- 使用 ThingsBoard PE Kafka 集成将分析结果推回 ThingsBoard 以进行持久化和可视化。

当然，本教程中的分析非常简单，但我们的目标是突出集成步骤。

![image](/images/samples/analytics/kafka-streams/kafka-streams-example.svg)

假设我们有大量太阳能电池板，其中包括许多太阳能模块。
ThingsBoard 用于收集、存储和可视化来自每个电池板中这些太阳能模块的异常遥测数据。

我们通过将太阳能模块产生的值与同一电池板的所有模块产生的平均值以及相同值的标准**偏差**进行比较来计算异常。

![image](/images/user-guide/integrations/kafka/deviation.png)

我们将使用具有 30 秒窗口（可配置）的 [Kafka Streams](https://kafka.apache.org/documentation/streams/) 作业分析来自多个设备的实时数据。

为了存储和可视化分析结果，我们将为每个太阳能电池板创建三个虚拟太阳能模块设备。

### 先决条件

以下服务必须启动并运行：

* ThingsBoard PE v2.4.2+ [实例](/docs/user-guide/install/pe/installation-options/)
* Kafka [服务器](https://kafka.apache.org/23/documentation/streams/quickstart#quickstart_streams_download)

### 步骤 1. 规则链配置

在此步骤中，我们将配置三个生成器节点，这些节点将在开发期间生成模拟数据以进行测试。
通常，您在生产中不需要它们，但它们对于调试非常有用。我们将为 3 个模块和 1 个电池板生成数据。
其中两个模块将产生相同的值，一个模块将产生低得多的值。
当然，您应该用真实设备产生的真实数据替换此数据。这只是一个示例。

让我们创建三个类型为“solar-module”的设备。如果您使用的是 ThingsBoard PE，您可以将它们放入新的“Solar Modules”组中。

![image](/images/samples/analytics/kafka-streams/solar-module-devices.png)

现在，让我们创建三个设备模拟器，以便将数据直接推送到我们的本地 Kafka 代理。
模拟数据将被推送到 Kafka 规则节点，该节点负责将数据推送到 Kafka 主题。
让我们首先配置 Kafka 规则节点。我们将使用本地 Kafka 服务器 (localhost:9092) 和主题“solar-module-raw”。

![image](/images/samples/analytics/kafka-streams/add-kafka-rule-node.png)

现在，让我们为第一个模块添加“generator”节点。我们将配置生成器以持续“产生”5 瓦。

![image](/images/samples/analytics/kafka-streams/add-module1-simulator-rule-node.png)

为第二个模块添加“generator”节点。我们将配置生成器以持续“产生”5 瓦。

现在，让我们为第三个模块添加“generator”节点。我们将配置生成器以持续“产生”3.5 瓦，模拟模块退化。

![image](/images/samples/analytics/kafka-streams/add-module3-simulator-rule-node.png)

结果规则链应类似于以下内容：

![image](/images/samples/analytics/kafka-streams/simulator-rule-chain.png)

您还可以下载规则链 [JSON 文件](/docs/samples/analytics/resources/solar_module_simulator.json) 并将其 [导入](/docs/{{docsPrefix}}user-guide/ui/rule-chains/#rule-import) 到您的项目中。

导入规则链后，您应该检查 Kafka 节点的调试输出。如果您的 Kafka 在 localhost 上启动并运行，您应该会看到类似的调试消息。
注意调试日志中没有错误：

![image](/images/samples/analytics/kafka-streams/check-no-errors.png)

### 步骤 2. 启动 Kafka Streams 应用程序。

在此步骤中，我们将下载并启动示例应用程序，该应用程序分析来自“solar-module-raw”的原始数据，并生成有关模块退化的有价值的见解。
示例应用程序计算电池板中每个模块在时间窗口（可配置）内产生的总能量。
然后，应用程序计算每个电池板的模块产生的平均功率及其在相同时间窗口内的偏差。
完成后，应用程序将每个模块值与平均值进行比较，如果差异大于偏差，我们将此视为异常。

异常计算的结果被推送到“anomalies-topic”。
ThingsBoard 使用 Kafka 集成订阅此主题，生成警报并将异常存储到数据库。


#### 下载示例应用程序

随时从 [ThingsBoard 存储库](https://github.com/thingsboard/kafka-streams-example) 获取 [代码](https://github.com/thingsboard/kafka-streams-example) 并使用 maven 构建项目：

```bash
mvn clean install
```

继续并将该 maven 项目添加到您喜欢的 IDE。

#### 依赖项审查

项目中使用的主要依赖项：

```xml
<dependencies>
...
    <dependency>
        <groupId>org.apache.kafka</groupId>
        <artifactId>kafka-streams</artifactId>
        <version>${kafka.version}</version>
    </dependency>
...
</dependencies>
```

#### 源代码审查

Kafka Streams 应用程序逻辑主要集中在 [SolarConsumer](https://github.com/thingsboard/kafka-streams-example/blob/master/src/main/java/org/thingsboard/kafka/SolarConsumer.java) 类中。

```java
private static Properties getProperties() {
    final Properties props = new Properties();
    props.put(StreamsConfig.APPLICATION_ID_CONFIG, "streams");
    props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
    props.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, 0);
    props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
    props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
    props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest");
    return props;
}
```

```java
private static final String IN_TOPIC = "solar-module-raw";

private static final TopicNameExtractor<String, SolarModuleAggregatorJoiner> OUT_TOPIC =
        new StaticTopicNameExtractor<>("solar-module-anomalies");

// Time for windowing
private static final Duration DURATION = Duration.ofSeconds(30);

private static final TimeWindows TIME_WINDOWS = TimeWindows.of(DURATION);

private static final JoinWindows JOIN_WINDOWS = JoinWindows.of(DURATION);

private static final StreamsBuilder builder = new StreamsBuilder();


// serde - Serializer/Deserializer
// for custom classes should be custom Serializer/Deserializer
private static final Serde<SolarModuleData> SOLAR_MODULE_DATA_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleData.class));

private static final Serde<SolarModuleAggregator> SOLAR_MODULE_AGGREGATOR_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleAggregator.class));

private static final Serde<SolarPanelAggregator> SOLAR_PANEL_AGGREGATOR_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarPanelAggregator.class));

private static final Serde<SolarModuleKey> SOLAR_MODULE_KEY_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleKey.class));

private static final Serde<SolarPanelAggregatorJoiner> SOLAR_PANEL_AGGREGATOR_JOINER_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarPanelAggregatorJoiner.class));

private static final Serde<SolarModuleAggregatorJoiner> SOLAR_MODULE_AGGREGATOR_JOINER_SERDE =
    Serdes.serdeFrom(new JsonPojoSerializer<>(), new JsonPojoDeserializer<>(SolarModuleAggregatorJoiner.class));

private static final Serde<String> STRING_SERDE = Serdes.String();

private static final Serde<Windowed<String>> WINDOWED_STRING_SERDE = Serdes.serdeFrom(
    new TimeWindowedSerializer<>(STRING_SERDE.serializer()),
    new TimeWindowedDeserializer<>(STRING_SERDE.deserializer(), TIME_WINDOWS.size()));

// 1 - sigma
private static final double Z = 1;
```

```java
// source stream from kafka
final KStream<SolarModuleKey, SolarModuleData> source =
    builder
        .stream(IN_TOPIC, Consumed.with(STRING_SERDE, SOLAR_MODULE_DATA_SERDE))
        .map((k, v) -> KeyValue.pair(new SolarModuleKey(v.getPanel(), v.getName()), v));


// calculating sum power and average power for modules
final KStream<Windowed<SolarModuleKey>, SolarModuleAggregator> aggPowerPerSolarModuleStream =
     source
        .groupByKey(Grouped.with(SOLAR_MODULE_KEY_SERDE, SOLAR_MODULE_DATA_SERDE))
        .windowedBy(TIME_WINDOWS)
        .aggregate(SolarModuleAggregator::new,
            (modelKey, value, aggregation) -> aggregation.updateFrom(value),
            Materialized.with(SOLAR_MODULE_KEY_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE))
        .suppress(Suppressed.untilTimeLimit(DURATION, Suppressed.BufferConfig.unbounded()))
        .toStream();


// calculating sum power and average power for panels
final KStream<Windowed<String>, SolarPanelAggregator> aggPowerPerSolarPanelStream =
    aggPowerPerSolarModuleStream
        .map((k, v) -> KeyValue.pair(new Windowed<>(k.key().getPanelName(), k.window()), v))
        .groupByKey(Grouped.with(WINDOWED_STRING_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE))
        .aggregate(SolarPanelAggregator::new,
            (panelKey, value, aggregation) -> aggregation.updateFrom(value),
            Materialized.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE))
        .suppress(Suppressed.untilTimeLimit(DURATION, Suppressed.BufferConfig.unbounded()))
        .toStream();


 // if used for join more than once, the exception "TopologyException: Invalid topology:" will be thrown
final KStream<Windowed<String>, SolarModuleAggregator> aggPowerPerSolarModuleForJoinStream =
    aggPowerPerSolarModuleStream
        .map((k, v) -> KeyValue.pair(new Windowed<>(k.key().getPanelName(), k.window()), v));


// joining aggregated panels with aggregated modules
// need for calculating sumSquare and deviance
final KStream<Windowed<String>, SolarPanelAggregatorJoiner> joinedAggPanelWithAggModule =
    aggPowerPerSolarPanelStream
        .join(
            aggPowerPerSolarModuleForJoinStream,
            SolarPanelAggregatorJoiner::new, JOIN_WINDOWS,
            Joined.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE));


//calculating sumSquare and deviance
final KStream<Windowed<String>, SolarPanelAggregator> aggPowerPerSolarPanelFinalStream =
    joinedAggPanelWithAggModule
        .groupByKey(Grouped.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_JOINER_SERDE))
        .aggregate(SolarPanelAggregator::new,
            (key, value, aggregation) -> aggregation.updateFrom(value),
            Materialized.with(WINDOWED_STRING_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE))
        .suppress(Suppressed.untilTimeLimit(DURATION, Suppressed.BufferConfig.unbounded()))
        .toStream();


// joining aggregated modules with aggregated panels in which calculated sumSquare and deviance
// need for check modules with anomaly power value
final KStream<Windowed<String>, SolarModuleAggregatorJoiner> joinedAggModuleWithAggPanel =
    aggPowerPerSolarModuleStream
        .map((k, v) -> KeyValue.pair(new Windowed<>(k.key().getPanelName(), k.window()), v))
        .join(
            aggPowerPerSolarPanelFinalStream,
            SolarModuleAggregatorJoiner::new, JOIN_WINDOWS,
            Joined.with(WINDOWED_STRING_SERDE, SOLAR_MODULE_AGGREGATOR_SERDE, SOLAR_PANEL_AGGREGATOR_SERDE));


// streaming result data (modules with anomaly power value)
joinedAggModuleWithAggPanel
    .filter((k, v) -> isAnomalyModule(v))
    .map((k, v) -> KeyValue.pair(k.key(), v))
    .to(OUT_TOPIC, Produced.valueSerde(SOLAR_MODULE_AGGREGATOR_JOINER_SERDE));


// starting streams
final KafkaStreams streams = new KafkaStreams(builder.build(), getProperties());
streams.cleanUp();
streams.start();
Runtime.getRuntime().addShutdownHook(new Thread(streams::close));
```


**Calculating anomaly data**

![image](/images/user-guide/integrations/kafka/latex.png)
 
```java
private static boolean isAnomalyModule(SolarModuleAggregatorJoiner module) {
    double currentZ = Math.abs(module.getSumPower() - module.getSolarPanelAggregator().getAvgPower()) / module.getSolarPanelAggregator().getDeviance();
    return currentZ > Z;
}
```

**Sample application output**

```text
...SolarConsumer - PerSolarModule: [1572447720|Panel 1|Module 1]: 30.0:6
...SolarConsumer - PerSolarModule: [1572447720|Panel 1|Module 2]: 30.0:6
...SolarConsumer - PerSolarModule: [1572447720|Panel 1|Module 3]: 21.0:6
...SolarConsumer - PerSolarPanel: [1572447690|Panel 1]: 81.0:3
...SolarConsumer - PerSolarPanelFinal: [1572447660|Panel 1]: power:81.0 count:3 squareSum:54.0 variance:18.0 deviance:4.2
...SolarConsumer - ANOMALY module: [1572447660|Panel 1|Module 3]: sumPower:21.0 panelAvg:27.0 deviance:4.2
```

### Step 3. Configure the Kafka Integration.

Let's configure ThingsBoard to subscribe to the “solar-module-anomalies” topic and create alarms. We will use Kafka Integration that is available since ThingsBoard v2.4.2.

#### Configure Uplink Converter

Before setting up a Kafka integration, you need to create the Uplink data converter. The uplink data converter is responsible for parsing the incoming anomalies data. 

Example of the incoming message that is produced by our Kafka Streams application:
```json
{
    "moduleName": "Module 3",
    "panelName": "Panel 1",
    "count": 6,
    "sumPower": 21.0,
    "avgPower": 3.5,
    "solarPanelAggregator": {
        "panelName": "Panel 1",
        "count": 3,
        "sumPower": 81.0,
        "avgPower": 27.0,
        "squaresSum": 54.0,
        "variance": 18.0,
        "deviance": 4.2
    }
}
``` 

See the following script that is pasted to the Decoder function section:

```javascript
// Decode an uplink message from a buffer
// payload - array of bytes
// metadata - key/value object

/** Decoder **/

// decode payload to string
var msg = decodeToJson(payload);

// decode payload to JSON
// var data = decodeToJson(payload);

var deviceName = msg.moduleName;
var deviceType = 'module';

// Result object with device attributes/telemetry data
var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   attributes: {
       panel: msg.panelName
   },
   telemetry: {
       avgPower: msg.avgPower,
       sumPower: msg.sumPower,
       avgPowerFromPanel: msg.solarPanelAggregator.avgPower,
       deviance: msg.solarPanelAggregator.deviance
   }
};

/** Helper functions **/

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   // covert payload to string.
   var str = decodeToString(payload);

   // parse string to JSON
   var data = JSON.parse(str);
   return data;
}

return result;
```
{: .copy-code}

The purpose of the decoder function is to parse the incoming data and metadata to a format that ThingsBoard can consume. 
**deviceName** and **deviceType** are required, while **attributes** and **telemetry** are optional.
**Attributes** and **telemetry** are flat key-value objects. Nested objects are not supported.

![image](/images/samples/analytics/kafka-streams/add-converter.png)

#### Configure Kafka Integration

Let's create kafka integration that will subscribe to “solar-module-anomalies” topic.

![image](/images/samples/analytics/kafka-streams/add-integration.png)

### Step 4. Configure Rule Engine to raise Alarms.

Follow existing "[Create and Clear Alarms](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/)" guide to raise the alarm 
based on the "anomaly" boolean flag in the incoming telemetry and use 
"[Send email on alarm](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)" guide to send email notifications.
Explore other [guides](/docs/{{docsPrefix}}guides/) to learn mode. 

### Step 5. Remove debug messages logging

Although the Debug mode is very useful for development and troubleshooting, leaving it enabled in production mode may tremendously increase the disk space, used by the database, because all the debugging data is stored there. 
It is highly recommended to turn the Debug mode off when done debugging. 


## Next steps

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}