---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 测试计算字段
description: 测试计算字段
---

* TOC
{:toc}

计算测试器是一个工具，允许您调试计算字段的代码。要打开计算测试器窗口，您需要单击计算字段设置中的 **测试** 按钮。

![image](/images/trendz/test-calculated-open.png)

布局分为四个部分：

* **预览**：此部分显示可视化，就像在非测试器模式中一样。
* **函数**：此字段用作计算字段代码的输入区域，就像在非测试器模式中一样。
* **输入**：您可以在此处查看和修改输入数据值。
* **输出**：计算后的结果输出数据将显示在此处，以及任何日志（如果“函数”字段包含任何 console.log() 语句）。

![image](/images/trendz/test-calculated-details.png)

#### 预览
此部分只是主可视化的较小副本。它不依赖于测试数据；它仅基于真实数据。
这意味着输入字段中遥测值的变化不会影响它。只有在您更改公式本身时才能看到更改。
如果您单击“构建”或“获取真实数据”按钮，将更新预览。但是，在第二种情况下，如果您更改了输入数据，它也将被覆盖。

#### 输入
输入数据可帮助您了解计算中涉及哪些数据，并让您有机会更改它以进行测试。
可以通过单击“测试”或“获取真实数据”按钮来获取或更新初始输入数据。
但我们建议您先请求真实数据，然后再进行测试。因此，输入数据列表将更加完整。此外，“获取真实数据”在某些情况下可以提供更完整的日志，当涉及到“行”对象时。

主要字段

* startTs - 时间段的开始
  * 类型 - 数字/unix 格式
  * 示例 - 1677621600000
* endTs - 时间段的结束
    * 类型 - 数字/unix 格式
    * 示例 - 1685566799999
* groupBy - 按时间分组。当可视化不包含原始日期字段或计算字段为批处理类型时，该值为“null”。
    * 类型 - `"week" | "day", "hour" | "minute" | "null"`
    * 示例 - “周”
* row - 一个对象，其中键表示单个迭代的可视化字段的名称。这可以可视化为表中的一行，但此对象也可用于其他图表类型。但是，它不适用于批处理计算字段。要引用特定行，请使用带有键名的方括号（row['key name']）。
  * 类型 - `{[key]: string | number}`
  * 示例 - `{"CalculatedSUM": 100,    "GR greenhouseUNIQ": "London",    "consumptionWaterSUM": 2684}`
* telemetry - 这些是公式中使用的聚合值或原始值（取决于计算字段的类型）。
  * 对于简单字段
    * 类型  - `string | number`
    * 示例 - `"sum(GR water meter.consumptionWater)": 100`
  * 对于批处理字段
    * 类型  - `Array<{ts: number, value: number | string}>`
    * 示例 - `"none(GR water meter.consumptionWater)": [{"ts": 1677621600000, "value": 100 }, … ]`

在输入中，您可以更改测试的值，但不能更改键。

再次按 **获取真实数据** 将覆盖当前更改。


#### 简单计算字段的示例

![image](/images/trendz/test-calculated-simple-field.png)

#### 批处理计算字段的示例

![image](/images/trendz/test-calculated-batch-field.png)

#### 函数
有关如何为计算字段编写函数的更多详细信息，请参阅文档的相应部分。
此字段是相同的。值得注意的是，您可以使用聚合数据或原始数据。在第二个选项中，您需要通过激活相应的复选框来启用 **批处理** 模式。

#### 输出
这是一个不可编辑的字段，有两种模式：

* **输出数据**：您可以看到计算结果。这是函数最后返回的值。对于非批处理计算字段，这将是一个简单值（数字或字符串），对于批处理字段，它将是一个类似于输入数据的对象数组。

![image](/images/trendz/test-calculated-output.png)

* **日志**：显示日志，类似于浏览器控制台中显示的日志（如果“公式”字段中存在任何 console.log()）。

![image](/images/trendz/test-calculated-logs.png)


单击 **测试** 按钮后，输出数据和日志会更新。当您单击 **获取真实数据** 时，日志也会更新，这有时可以使它们比 **测试** 按钮更完整。

当您对计算结果满意时，不要忘记单击 **保存** 按钮。之后，新函数将在计算字段中可用。

## 后续步骤

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}