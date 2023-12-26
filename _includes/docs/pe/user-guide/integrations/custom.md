{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

### 简介

自定义集成**仅从主 GridLinks 实例远程执行**。它允许创建具有自定义配置的集成，该集成将使用任何传输协议与您的设备进行通信。

本指南包含有关如何创建和启动 GridLinks 自定义集成的逐步说明。
例如，我们将启动使用 TCP 传输协议从设备流式传输数据并将转换后的数据推送到 [thingsboard.cloud](https://cloud.codingas.com/signup) 的自定义集成。

在开始之前，您可以在 [此处](https://github.com/thingsboard/remote-integration-example) 找到本指南中将使用的自定义集成示例的完整代码。

### 前提条件

我们假设您已经在自己的 GridLinks PE v2.4.1+ 实例或 thingsboard.cloud 上拥有租户管理员帐户。

我们假设我们有一个传感器，它分别以以下格式发送当前温度、湿度和电池电量读数：**“25,40,94”**。

### 上行和下行转换器

在设置自定义集成之前，您需要创建一个上行转换器和一个下行转换器。

#### 上行转换器

让我们创建上行转换器。

![image](/images/user-guide/integrations/remote/custom-converter.gif)

**注意**：尽管调试模式对于开发和故障排除非常有用，但在生产模式下启用它可能会极大地增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。
强烈建议在完成调试后关闭调试模式。

请参阅粘贴到解码器函数部分的以下脚本：

```javascript
/** Decoder **/

// decode payload to string
var decodedString = decodeToString(payload);
// remove unnecessary [\"] and split by [,] to get an array
var payloadArray = decodedString.replace(/\"/g, "").split(',');
var result = {
    deviceName: "Device A",
    deviceType: "type",
    telemetry: {
        // get each reading from the array and convert the string value to a number
        temperature: Number(payloadArray[0]),
        humidity: Number(payloadArray[1]),
        batteryLevel: Number(payloadArray[2])
    },
    attributes: {}
};

/** Helper functions **/

function decodeToString(payload) {
    return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   // convert payload to string.
   var str = decodeToString(payload);

   // parse string to JSON
   var data = JSON.parse(str);
   return data;
}

return result;
```

解码器函数的目的是将传入的数据和元数据解析为 GridLinks 可以使用的一种格式。
**deviceName** 和 **deviceType** 是必需的，而 **attributes** 和 **telemetry** 是可选的。
**Attributes** 和 **telemetry** 是扁平的键值对象。不支持嵌套对象。

#### 下行转换器

在本指南中，我们不会使用下行转换器，因此无需创建下行转换器。
如果您有其他案例，请参阅以下 [说明](/docs/{{peDocsPrefix}}user-guide/integrations/#downlink-data-converter)。

### 自定义集成设置

让我们创建自定义集成。

![image](/images/user-guide/integrations/remote/custom-integration.gif)

请注意，当我们选择 **自定义** 类型并启用 **调试模式** 时，**远程执行** 会自动启用。

**集成类** 用于使用 Java 反射方法创建集成的实例。

**集成 JSON 配置** 是自定义配置，在我们的案例中有两个字段：
- **port**，它将用于绑定 TCP 服务器-客户端通信
- **msgGenerationIntervalMs**，生成消息之间的间隔

我们将在本指南的后面部分中回到这一点。

### 自定义集成应用程序

#### 下载示例应用程序

随时从 [ThingsBoard 存储库](https://github.com/thingsboard/remote-integration-example) 获取 [代码](https://github.com/thingsboard/remote-integration-example) 并使用 maven 构建项目：

```bash
mvn clean install
```

继续并将该 maven 项目添加到您最喜欢的 IDE。

#### 依赖项审查

项目中使用的主要依赖项：

```xml
<!-- Api ThingsBoard provides to create custom integration -->
<dependency>
    <groupId>org.thingsboard.common.integration</groupId>
    <artifactId>remote-integration-api</artifactId>
    <version>${thingsboard.version}</version>
</dependency>
<!-- Netty for TCP client-server implementation -->
<dependency>
    <groupId>io.netty</groupId>
    <artifactId>netty-all</artifactId>
    <version>${netty.version}</version>
</dependency>
<!-- Grpc transport between remote integration and ThingsBoard -->
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-netty</artifactId>
    <version>${grpc.version}</version>
</dependency>
```

#### 源代码审查

主要源代码是 [CustomIntegration](https://github.com/thingsboard/remote-integration-example/blob/master/src/main/java/org/thingsboard/integration/custom/basic/CustomIntegration.java) Java 类。
集成正在从 TCP 客户端等待 "Hello to ThingsBoard" 消息，并回复 "Hello from ThingsBoard!"。
一旦 [客户端模拟器](https://github.com/thingsboard/remote-integration-example/blob/master/src/main/java/org/thingsboard/integration/custom/client/CustomClient.java) 接收到 "Hello from ThingsBoard!"，它将开始以以下格式向 ThingsBoard 发送自动生成的数据：**“25,40,94”**。
集成将按原样将传入消息传递给 [上行转换器](/docs/{{peDocsPrefix}}user-guide/integrations/custom/#uplink-converter)，并将数据推送到 GridLinks。

**注意：**从 GridLinks 版本 3.3.1 开始，向 tb-remote-integration.yml 添加了一个新的必需配置属性：

```yml
service:
  type: "${TB_SERVICE_TYPE:tb-integration}"
```

如果您正在使用旧版本的自定义远程集成，并计划将您的自定义集成升级到 3.3.1 版本，请确保已将该属性添加到 tb-remote-integration.yml 文件中。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}