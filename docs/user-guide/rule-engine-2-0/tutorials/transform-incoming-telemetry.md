---
layout: docwithnav
title: 转换传入遥测数据
description: 转换传入遥测数据
---

* TOC
{:toc}

## 使用案例

假设你的设备使用自定义传感器来收集并将温度读数推送到 GridLinks。
此传感器以 °F 为单位收集温度读数，你想在将温度读数存储到数据库和可视化之前将其转换为 °C。

在本教程中，我们将配置 GridLinks 规则引擎以根据以下公式修改温度读数：

```code
[°C] = ([°F] - 32) × 5/9.
```

## 先决条件

我们假设你已完成以下指南并阅读了以下文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 步骤 1：添加温度转换节点

我们将修改默认规则链，并将添加带有温度转换脚本的 [**转换**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node) 规则节点。
我们将此规则节点放在默认“消息类型开关”和“保存时序”规则节点之间。
请注意，我们还从根规则链中删除了不相关的规则节点。

![image](/images/user-guide/rule-engine-2-0/tutorials/transformation/rule-chain.png)

假设到达系统的的数据可能具有或不具有“温度”字段。
我们将所有不具有“温度”字段的数据视为有效数据。为了做到这一点，我们将使用以下函数

```javascript
function precisionRound(number, precision) {
  var factor = Math.pow(10, precision);
  return Math.round(number * factor) / factor;
}

if (typeof msg.temperature !== 'undefined'){
    msg.temperature = precisionRound((msg.temperature -32) * 5 / 9, 2);
}

return {msg: msg, metadata: metadata, msgType: msgType};
```

## 步骤 2：验证脚本调试

让我们使用内置的“测试转换器函数”按钮来检查我们的脚本是否正确

![image](/images/user-guide/rule-engine-2-0/tutorials/transformation/node-config.png)

![image](/images/user-guide/rule-engine-2-0/tutorials/transformation/test-function.png)

你可以检查更多情况，例如当温度未设置时。

## 摘要

下载并导入附加的 json [**文件**](/docs/user-guide/resources/transformation-rule-chain.json) 和本教程中的规则链。不要忘记将新规则链标记为“根”。

![image](/images/user-guide/rule-engine-2-0/tutorials/make-root.png)

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}