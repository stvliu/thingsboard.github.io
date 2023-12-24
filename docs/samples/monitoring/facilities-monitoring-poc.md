---
layout: docwithnav
title: 使用 GridLinks 的设施监控系统原型
description: 使用物联网设备和 GridLinks 的设施监控系统原型
---

{% include templates/old-guide-notice.md %}

* TOC
{:toc}

办公室房间的环境控制非常重要，因为 HVAC 故障可能导致服务器、网络设备、员工生产力等方面出现重大损失。

在本教程中，我们将构建设施监控系统原型，该原型能够涵盖以下案例：

- 监控办公楼不同区域的温度和湿度。
- 根据区域类型（工作空间、会议室和服务器室）处理收集的遥测数据，并应用各种警报规则。
- 将收集到的警报分发给指定的设施经理。
- 在可配置的 Web 仪表板上可视化实时值和历史值。

本文介绍了我们为构建 PoC 所做的开发和配置步骤。

该原型是开源的，并且也基于开源技术，因此您可以使用它来构建商业产品。

![image](/images/samples/monitoring/facilities-management.svg)

## 设备和连接

我们决定使用基于 ESP8266 和 DHT22 传感器的相当便宜的硬件。每个设备的总成本（包括传感器和连接模块）约为 5 美元。由于这是一个原型，我们决定使用 WiFi 上的 MQTT，并且没有讨论其他连接选项。

## 服务器端基础设施

解决方案的服务器端部分将基于 ThingsBoard IoT 平台，该平台 100% 开源，可以部署在云端、本地甚至 Raspberry Pi 3 上。收集的数据存储在 Cassandra 数据库中，因为该数据库具有内置的容错性和可扩展性。我们最近启动了实时演示实例，以简化入门流程，因此我们将在本教程中使用此实例。

## 开发和配置步骤

### 步骤 1. 设备预配

PoC 的初始步骤是预配多个设备及其属性。我们决定支持三种区域类型：工作区、会议室和服务器室。我们已经注册了三座建筑，每座建筑有四个房间。在注册期间，我们已经填充了区域 ID、区域类型服务器端属性。请注意，服务器端设备属性可以由处理规则使用，但设备本身不可见。

![image](/images/samples/monitoring/service-side-attributes.png)

### 步骤 2. 刷新设备

在此步骤中，我们已经刷新了固件更新，其中包含内置于固件中的各个设备凭据。固件代码和相应的说明可在下面的链接中找到。我们使用了我们[上一篇文章](/docs/samples/nodemcu/temperature/)中的代码，没有任何修改，因为所有逻辑都在服务器端。

请注意，步骤 1 和 2 可以自动化，我们已经开发了一个简单的基于 Java 的应用程序，该应用程序使用 REST API 预配设备和其他实体，并且还模拟这些设备以进行实时演示。

### 步骤 3. 处理规则

在这些步骤中，我们已经预配了根据区域类型分析温度和湿度与可配置阈值的规则。

例如，服务器机房中可接受的湿度范围在 40% 到 60% 之间，但是工作区的湿度范围为 30% 到 70%。

这些规则基本上是一组使用 JavaScript 语法编写的逻辑表达式。

例如，服务器机房的规则由两部分组成：属性和遥测过滤器。这些过滤器可以组合，但我们决定将它们分开以简化 PoC。

属性过滤器主体示例：

```javascript
typeof ss.ZoneType !== 'undefined' && ss.ZoneType === 'Server Room'
```

遥测过滤器主体示例：

```javascript
(
    typeof temperature !== 'undefined' 
    && (temperature <= 10 || temperature >= 25)
)
|| 
(
    typeof humidity !== 'undefined' 
    && (humidity <= 40 || humidity >= 60)
)
```

您可能会注意到过滤器主体中的“null”检查。这基本上是一个好习惯，因为您可以将同一台服务器用于多个设备应用程序。其中一些报告湿度和温度，另一些上传其他传感器读数，这不会影响规则处理。


### 步骤 4. 警报分发

在此步骤中，我们已经配置了电子邮件插件以使用 SendGrid 邮件服务分发数据，并预配了规则操作以将数据发送到配置的电子邮件地址。

规则操作由多个模板组成，这些模板允许根据设备属性和遥测值的替换灵活配置电子邮件主题、正文和地址列表。

例如，以下电子邮件正文模板：

```velocity
[$date.get('yyyy-MM-dd HH:mm:ss')] $ss.get('ZoneId') HVAC malfunction detected. 
Temperature - $temperature.valueAsString (°C). 
Humidity - $humidity.valueAsString (%)!
```

将评估为以下电子邮件正文

```text
[2016-12-22 15:06:09] Server Room C HVAC malfunction detected. 
Temperature – 45.0 (°C).
Humidity – 70.0 (%)!
```

评估和模板语法基于[Velocity](http://velocity.apache.org/)引擎。

### 步骤 5. 数据可视化
在此步骤中，我们预配了几个仪表板来可视化数据。我们将在下面描述它们。

### 地图仪表板

此仪表板在地图上显示多座建筑，其简短状态可在工具提示中获得。您可以使用工具提示中的链接导航到平面图和历史数据仪表板。

![image](/images/samples/monitoring/map.png)

### 平面图仪表板

此仪表板使用带有平面图的静态背景图像。我们已经放置了小部件，以显示正在监控的每个房间的温度和湿度。

![image](/images/samples/monitoring/plan.png)

### 历史仪表板

此仪表板显示每秒报告的传感器读数的最后时刻。

![image](/images/samples/monitoring/history-all.png)

## 实时演示

为了演示此 PoC 的实际操作，您需要执行两个简单的步骤：

- [注册](https://demo.thingsboard.io/signup)或[登录](https://demo.thingsboard.io)实时演示实例，并保存您的登录名和密码。
- 使用此[链接](https://github.com/thingsboard/samples/releases/download/v1.0-tfm/facilities-monitoring.jar)下载并启动设备模拟器。

```shell
java -jar facilities-monitoring.jar demo.thingsboard.io
```

启动后，模拟器会要求您提供实时演示登录名和密码。此信息将用于获取 JWT 令牌并执行 REST API 调用，以便：

- 预配演示设备。
- 创建规则和仪表板。
- 使用 MQTT 开始模拟预配设备的温度和湿度传感器数据。

## 结论

这个原型是由两位工程师在一天之内编写的。大部分时间都花在了客户端代码上（真实设备和模拟器的 Lua 脚本）。原型的服务器端部分没有编码，完全是关于规则、插件和仪表板的配置。

这说明了使用[ThingsBoard](http://thingsboard.io)构建物联网解决方案是多么容易。当然，您需要通过一定的学习曲线，但我们希望本文和其他[文档](http://thingsboard.io/docs/)将帮助您做到这一点。

如果您发现本文有趣，请在评论部分留下您的反馈、问题或功能请求，并在[github](https://github.com/thingsboard/thingsboard)上“点赞”我们的项目，以便随时了解新版本和教程。


## 链接

- 适用于不同硬件平台的兼容示例应用程序：

    - [使用 ESP8266 和 DHT22 传感器通过 MQTT 上传温度](/docs/samples/esp8266/temperature/)
    - [使用 Arduino UNO、ESP8266 和 DHT22 传感器通过 MQTT 上传温度](/docs/samples/arduino/temperature/)
    - [使用 NodeMCU 和 DHT11 传感器通过 MQTT 上传温度](/docs/samples/nodemcu/temperature/)

- [ThingsBoard github 页面](https://github.com/thingsboard/thingsboard)
- [模拟器源代码](https://github.com/thingsboard/samples)
- [模拟器二进制文件](https://github.com/thingsboard/samples/releases/download/v1.0-tfm/facilities-monitoring.jar)