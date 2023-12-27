---
layout: docwithnav
title: 基于传感器读数的警报
description: 根据 IoT 传感器读数和可配置阈值触发电子邮件警报

---

{% include templates/old-guide-notice.md %}

* TOC
{:toc}

本教程将演示如何配置规则，当某些设备报告的温度或湿度超过某些阈值时，该规则将生成警报。

我们假设我们有能够报告湿度和温度值的设备。我们在建筑物或其他设施的每个房间（区域）中有一个设备，并且我们希望根据区域类型指定不同的规则。

## 假设

我们假设您已经配置了将生成的警报分发给收件人的电子邮件插件。您可以按照之前的 [教程](/docs/samples/alarms/mail/) 来执行此操作。

## 工作原理？

我们将提供一个简单的规则，使用以下内容过滤传入的数据：

- “消息类型”过滤器对遥测数据做出反应。
- “设备属性”过滤器处理来自具有某些房间类型作为服务器端属性的设备的数据。
- “设备遥测”过滤器检测超出预配置范围的湿度和温度值。

## 设备配置

让我们创建一个设备并配置某些服务器端属性：ZoneId 和 ZoneType。

#### 步骤 1. 创建设备

导航到 [设备](https://gridlinks.codingas.com/devices) 页面，然后单击红色大“+”按钮。填写设备名称和说明，然后单击“添加”按钮。

![image](/images/samples/alarms/add-device.png)

#### 步骤 2. 配置 ZoneID 和 ZoneType 属性

打开您创建的设备卡。导航到“属性”选项卡，然后选择“服务器”属性范围。

![image](/images/samples/alarms/server-attributes-table.png)

单击突出显示的“+”按钮。如下所示添加两个属性“ZoneId”和“ZoneType”。我们将在规则过滤器中使用它们。

![image](/images/samples/alarms/zone-id.png)
![image](/images/samples/alarms/zone-type.png)

## 规则配置

#### 步骤 3. 创建“服务器机房监控”规则

导航到 [规则](https://gridlinks.codingas.com/rules) 页面，然后单击红色大“+”按钮。首先填写规则名称和说明。

![image](/images/samples/alarms/add-rule.png)

我们的规则将包含三个过滤器，如“[工作原理](#how-it-works)”部分所述。

#### 步骤 4. 消息类型过滤器

根据消息类型添加过滤器（参见下图）。

![image](/images/samples/alarms/msg-filter.png)

#### 步骤 5. 属性过滤器

根据服务器端属性添加过滤器（参见下图）。

```javascript
typeof ss.ZoneType !== 'undefined' && ss.ZoneType === 'Server Room'
```

![image](/images/samples/alarms/attributes-filter.png)

#### 步骤 6. 遥测过滤器

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

根据传感器读数添加过滤器（参见下图）。

![image](/images/samples/alarms/telemetry-filter.png)

#### 步骤 7. 警报处理器

让我们添加一个简单的处理器，它将根据以下模板生成警报并将其保存到数据库。

警报 ID：

```text
[$date.get('yyyy-MM-dd HH:mm')] $ss.get('ZoneId') 检测到 HVAC 故障！
```

警报正文：

```text
[$date.get('yyyy-MM-dd HH:mm:ss')] $ss.get('ZoneId') 检测到 HVAC 故障。
温度 - $temperature.valueAsString (°C)。
湿度 - $humidity.valueAsString (%)！
```

![image](/images/samples/alarms/add-processor.png)

**注意** 警报 ID 是一个唯一标识符。如果有多个事件与过滤器匹配，警报将根据警报 ID 进行去重。

每警报发送一封电子邮件。

在我们的案例中，我们使用截断到分钟的时间戳，以确保每分钟或更少频率发送一封电子邮件。

#### 步骤 8. 规则操作

从之前的 [教程](/docs/samples/alarms/mail/) 中选择“SendGrid 电子邮件插件”，然后单击“创建”按钮。不要忘记将“thingsboard@gmail.com”替换为您的电子邮件地址。

![image](/images/samples/alarms/add-action.png)

#### 步骤 9. 保存并激活规则

成功保存规则后，不要忘记通过单击“激活”按钮激活它（参见下图）。

![image](/images/samples/alarms/activate-rule.png)

## 试运行

让我们通过发布一些遥测数据来检查我们的配置。我们将使用我们在 [第一步](#step1-create-device) 中创建的设备的访问令牌。

```shell
mosquitto_pub -d -h "demo.docs.codingas.com" -t "v1/devices/me/telemetry" -u "$YOUR_ACCESS_TOKEN" -m "{'temperature':42, 'humidity':74}"
```

## 故障排除

如果您配置错误，您应该会看到相应选项卡上记录的错误：

![image](/images/samples/alarms/rule-events.png)

如果规则中没有错误，但您看不到电子邮件 - 请检查目标插件中的错误。