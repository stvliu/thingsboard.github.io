---
layout: docwithnav
assignees:
- ashvayka
title: 设备遥测过滤器

---

## 概述

此组件允许按其值过滤传入的 [遥测](/docs/user-guide/telemetry/) 消息。
如果您想根据遥测的某些值应用规则，此过滤器非常有用。
例如，发动机控制器可能会定期报告其温度。
当发动机温度高于 100 度时，您可能会发出警报。
过滤器表达式以 javascript 编写。

## 配置

您可以使用与遥测消息的键匹配的绑定编写布尔型 javascript 表达式。
如果您不确定消息中是否存在某个键，您可以添加检查其类型是否为 *undefined*。
例如，如果 *temperature* 高于 *100* 度，则下面的过滤器将匹配。

```javascript
typeof temperature !== 'undefined' && temperature > 100
```

假设从发动机控制器设备上传了以下遥测消息：

```json
{"temperature":1100, "enabled":true, "mode":"A"}
```

如果设备已启用、在模式“A”中运行且温度高于 1000 度，则以下过滤器将匹配

```javascript
temperature > 1000 && enabled == true && mode == 'A'
```

如果您不确定消息中是否存在所有遥测数据点，则应使用以下语法添加所有必要的“null”检查

```javascript
typeof temperature!== 'undefined' && typeof enabled !== 'undefined' && typeof mode !== 'undefined' && 
temperature > 1000 && enabled == true && mode == 'A'
```

## 示例

作为租户管理员，您可以在 **规则->演示警报规则->过滤器->设备遥测过滤器** 中查看过滤器示例。