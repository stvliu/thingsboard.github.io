---
layout: docwithnav
assignees:
- ashvayka
title: 设备属性过滤器

---

## 概述

此组件允许按设备属性过滤传入消息。
如果您只想将规则应用于设备的特定子集，此过滤器非常有用。
过滤器表达式是一个 javascript 表达式，基本上定义了此子集。您可以使用任何 [属性类型](/docs/user-guide/attributes#attribute-types)。

## 配置

您可以使用以下绑定编写布尔型 javascript 表达式：

- **cs** - 客户端属性映射。
- **ss** - 服务器端属性映射。
- **shared** - 共享属性映射。

如果您不确定是否存在某个属性，可以添加检查其类型是否未定义。
例如，如果客户端属性“firmware_version”已设置且等于“1.0.0”，则下面的过滤器将匹配

```javascript
typeof cs.firmware_version !== 'undefined' && cs.firmware_version === '1.0.0' 
```

## 示例

假设以下设备属性及其类型
- firmware_version - 客户端
- country - 客户端
- subscription_plan - 共享
- balance - 服务器端

以下过滤器将匹配所有位于美国且固件版本等于 1.1.0 的高级订阅设备，这些设备的余额为正数

```javascript
cs.firmware_version=='1.1.0' && cs.country=='USA' && shared.subscription_plan=='premium' && ss.balance > 0
```

如果您不确定设备的所有属性都存在，则应使用以下语法添加所有必要的“null”检查

```javascript
typeof cs.firmware_version !== 'undefined' && 
typeof cs.country !== 'undefined' && 
typeof shared.subscription_plan !== 'undefined' && 
typeof ss.balance !== 'undefined' && 
cs.firmware_version=='1.1.0' && cs.country=='USA' && shared.subscription_plan=='premium' && ss.balance > 0
```