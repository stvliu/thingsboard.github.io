---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 计算字段
description: Trendz 计算字段
---

* TOC
{:toc}

计算字段是 KPI 监控和预测最强大的功能之一。
基于输入数据，计算字段允许您运行统计函数并通过应用计算创建新的数据项。由于 Trendz Analytics 即时处理计算，因此不会损坏 ThingsBoard 数据库中的任何数据。并且不会施加额外的负载。


## 简单计算

假设传感器以摄氏度提交锅炉温度，我们想将其转换为华氏度：

* 将 **计算** 字段从左侧导航栏拖放到 **Y 轴** 部分
* 打开字段配置并编写转换函数

{% highlight javascript %}
    var celsius = avg(Machine.boilerTemp);
    var fahrenheit = celsius*1.8 + 32;
    return fahrenheit;
{% endhighlight %}   

![image](/images/trendz/calculated-simple.png)

## 用于计算的多个字段

在此示例中，我们有一个安装了 2 个传感器的公寓资产 - 热量表和电能表。两个传感器都会提交消耗了多少能量。
公寓还具有包含公寓面积的面积属性。我们想计算公寓中每平方米的热量表和电能表消耗的总能量。我们将其分解为子任务：

* 获取热量表消耗的能量量 - **heatConsumption** 遥测
* 获取电能表消耗的能量量 - **energyConsumption** 遥测
* 获取公寓面积 - **area** 属性
* 对 **heatConsumption** 和 **energyConsumption** 求和
* 除以 **area**

为此，我们需要：
* 将 **计算** 字段从左侧导航栏拖放到 **Y 轴** 部分
* 打开字段配置并编写转换函数  
  
{% highlight javascript %}
    var energy = sum(energyMeter.energyConsumption);
    var heat = sum(heatMeter.heatConsumption);
    var size = uniq(apartment.area);
    
    return (energy + heat) / size;
{% endhighlight %}   

![image](/images/trendz/calculated-complex-config.png)

![image](/images/trendz/calculated-complex-result.png)

## 获取原始字段值

在应用转换之前，您需要获取对原始字段值的引用。以下是如何执行此操作的示例：

```
var temp = avg(Machine.temperature);
```

* avg() - 聚合函数
* Machine - 实体名称（可以是资产类型或设备类型）
* temperature - 字段名称

**所有 3 个部分都是必需的**，您无法在没有聚合函数的情况下访问原始字段值。

如果原始字段值是属性、实体名称或所有者名称 - 您应该使用 **uniq()** 聚合函数。

## 支持的聚合函数

计算字段的 JSEditor 支持以下聚合函数：

* avg()
* sum()
* min()
* max()
* count()
* latest()
* uniq()

每个函数只允许 1 个参数 - 格式为 EntityName.fieldName 的字段引用。例如：

```
sum(Machine.temperature)
```

聚合函数应用于分组数据集。在 [本文](/docs/trendz/data-grouping-aggregation/) 中找到有关分组和聚合的更多详细信息

## 保存和重用计算字段

创建计算字段后，您可以通过按函数编辑器下的 **保存字段** 按钮将其保存以供将来重用。将使用当前字段标签作为字段名称。如果已经存在具有此名称的字段 - 系统将覆盖它。

保存的计算字段只是一个模板。一旦它从左侧导航树中拖放到某个轴中，就会创建一个新的计算字段，并且该字段不会与原始模板连接。
这意味着如果您将来更新字段配置，它只会更新模板，但添加到视图配置中的真实计算字段不会受到影响。

## 语言和脚本引擎

您可以使用 Javascript 或 Python 编写计算字段。默认情况下，选择 Javascript 引擎。

* **Javascript** - 计算字段使用 Javascript 作为编写转换函数的语言。内部引擎提供对 ECMAScript 5.1 的 100% 支持
* **Python** - Python 脚本引擎支持 python 3.8 并提供对 python 标准库的完全访问。此外，您还可以使用以下库：flask、numpy、statsmodels、pandas、scikit-learn、prophet、seaborn、pmdarima。

## 后续步骤

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}