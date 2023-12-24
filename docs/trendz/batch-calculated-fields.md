---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 批量计算字段
description: 批量计算字段
---

* TOC
{:toc}


当禁用批量计算选项时 - 你编写一个一次处理 1 个值的功能。但当启用批量计算时，你处理整个原始遥测数组。启用“批量计算”复选框后，你可以更好地控制如何将原始遥测转换为所需的指标。例如，你可以编写一个可以访问先前遥测值的功能，如果需要，你可以从计算中过滤或排除遥测值，你可以按时间戳对遥测进行分组并在组上应用转换。

一旦原始遥测数组从计算函数转换并返回，系统将对该数组应用所需的聚合。

## 基本语法

假设你为遥测数据创建了以下变量：

```javascript
var temperatureReadings = none(thermostat.temperature);
```

在这种情况下，`temperatureReadings` 变量将是一个遥测对象数组：

```json
[
	{
		"ts": 1622505600000,
		"value": 17
	},
	{
		"ts": 1622592000000,
		"value": 21
	},
	{
		"ts": 1622678400000,
		"value": 35
	}
]
```

对于属性，你还有一个包含表示属性的 1 个对象的数组。以下是如何在脚本中使用属性的示例：

```javascript
var unit = uniq(thermostat.measureUnit);
if(unit.length) {
    unit = unit[0].value;
}
```

## 示例

#### 过滤原始遥测

你可以从指标计算中排除一些遥测值。在此示例中，我们将排除所有大于 40 的温度值：

```javascript
var temperatureReadings = none(thermostat.temperature);

var filteredReadings = [];

for (var i = 0; i < temperatureReadings.length; i++) {
    var tsValue = temperatureReadings[i];
    if(tsValue.value <= 40) {
        filteredReadings.push(tsValue);
    }
}

return filteredReadings;
```

#### 修改原始遥测

以下是如何根据属性值转换原始遥测数组的示例：

```javascript
var temperatureReadings = none(thermostat.temperature);

var unit = uniq(thermostat.measureUnit);
if(unit.length) {
    unit = unit[0].value;
}

for (var i = 0; i < temperatureReadings.length; i++) {
    var tsValue = temperatureReadings[i];
    if(unit === 'Fahrenheit') {
        tsValue.value = 5 / 9 * (tsValue.value - 32);
    }
}

return temperatureReadings;
```

#### 按时间戳对多个遥测进行分组

```javascript
var voltageTelemetry = none(energyMeter.voltage);
var temperatureTelemetry = none(energyMeter.temperature);
var pressureTelemetry = none(energyMeter.pressure);

var groupedTelemetry = {};

groupTelemetryByTime(voltageTelemetry, groupedTelemetry, 'voltage');
groupTelemetryByTime(temperatureTelemetry, groupedTelemetry, 'temperature');
groupTelemetryByTime(pressureTelemetry, groupedTelemetry, 'pressure');

// ... 执行转换

groupTelemetryByTime = function (telemetry, groupedTelemetry, keyName) {
    for (var i = 0; i < telemetry.length; i++) {
        var ts = telemetry[i].ts;
        if(!groupedTelemetry[ts]) {
            groupedTelemetry[ts] = {ts: ts};
        }
        groupedTelemetry[ts][keyName] = telemetry[i].value;
    }
};

```


#### 填充遥测流中的空白

在此示例中，我们将演示如何检测时序流中的空白并用 `0` 值填充它：

```javascript
var temperatureReadings = none(thermostat.temperature);

var timeGap = 30 * 60 * 1000; // 30 minutes
for (var i = 1; i < temperatureReadings.length; i++) {
    var tsDelta = temperatureReadings[i].ts - temperatureReadings[i - 1].ts;
    if (tsDelta > timeGap) {
        var newTs = (temperatureReadings[i].ts + temperatureReadings[i - 1].ts) / 2;
        temperatureReadings.splice(i, 0, {ts: newTs, value: 0})
    }
}

return temperatureReadings;
``` 

## 后续步骤

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}