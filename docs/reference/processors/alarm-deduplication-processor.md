---
layout: docwithnav
assignees:
- ashvayka
title: 报警去重处理器

---

## 概述

此组件允许生成唯一报警。您可以指定*报警 ID* 和*报警正文*模板。
模板评估基于[velocity 引擎](http://velocity.apache.org/)。
当组件处理传入的设备消息时，它会将消息值和设备属性替换到模板中。
报警唯一性由*报警 ID*的结果值控制。
如果处理器检测到唯一报警，它将添加以下元数据：

- *isNewAlarm* 布尔标志为*true*。
- *alarmId* 字符串。
- *alarmBody* 字符串。

## 配置

模板评估使用特定上下文完成。此上下文会根据设备消息和属性填充值。
可以使用以下名称的地图获取属性值：

- **cs** - 客户端属性映射。
- **ss** - 服务器端属性映射。
- **shared** - 共享属性映射。

遥测值使用其键直接推送到上下文。
您还可以使用*date*、*deviceId*、*deviceName* 和*deviceType*。

例如，以下模板：

``` javascript
[$date.get('yyyy-MM-dd HH:mm:ss')] Device $deviceType+$cs.get('serialNumber')($cs.get('model')) temperature is $temperature.valueAsString!
```

将评估为

``` 
[2016-01-02 03:04:05] Device Killbot4000+SN-001(A) temperature is 100!
```

对于具有以下内容的设备

- 客户端属性*序列号* = SN-001
- 客户端属性*型号* = A

以及遥测消息

```json
{"temperature":100}
``` 

我们建议将截断日期和一些唯一的设备属性包含到报警 ID 模板中。
这将确保您不会为同一设备问题生成报警的频率过高。

## 示例

作为租户管理员，您可以在**规则->演示报警规则->处理器->报警去重处理器**中查看处理器示例。