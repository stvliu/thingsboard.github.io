* TOC
{:toc}

模板化是使用预定义模板动态插入或替换文本中值的进程。
这些模板用作变量的占位符，以后可以用实际数据填充这些变量。

在规则引擎的上下文中，模板用于在运行时从传入的消息中提取数据。
这在规则节点配置中特别有用，模板化允许通过用传入消息中的实时值替换配置字段中的静态值来进行动态配置。
这使得数据处理更加灵活和自动化，从而更容易根据不同的输入执行条件操作。

## 语法

模板以美元符号 (`$`) 开头，后跟带有键名的括号。
方括号 (`[]`) 用于消息键，而花括号 (`{}`) 用于消息元数据键。
例如：
- `$[messageKey]` - 将从传入消息中提取 `messageKey` 的值。
- `${metadataKey}` - 将从传入消息元数据中提取 `metadataKey` 的值。

在上面的示例中，`messageKey` 和 `metadataKey` 表示可能存在于消息或其元数据中的任何键名。

## 示例

我们来看一个示例。第一个 JSON 是消息，第二个是消息元数据：

```json
{
  "temperature": 26.5,
  "humidity": 75.2,
  "soilMoisture": 28.9,
  "windSpeed": 26.2,
  "location": "riverside"
}
```
```json
{
  "deviceType": "weather_sensor",
  "deviceName": "weather1",
  "ts": "1685379440000"
}
```

假设我们检测到异常高的风速，并希望将此遥测读数发送到某个外部 REST API。
每次读数都需要与特定设备和位置相关联 - 此信息仅在实时可用。
我们可以使用模板提取必要的数据并构建用于发送数据的 URL：

`example-base-url.com/report-reading?location=$[location]&deviceName=${deviceName}`

此模板将解析为：

`example-base-url.com/report-reading?location=riverside&deviceName=weather1`

模板非常适合在配置时不知道具体值但在运行时会知道具体值的情况下使用。

## 注释

- 模板可以与常规文本组合使用。例如：“油箱已加满至 `$[fuelLevel]`%”。
- 您可以使用点符号访问 JSON 对象中的嵌套键：`$[object.key]`.
- 如果指定的键不存在或与该键关联的值是对象或数组，则模板字符串将保持不变。

为了说明上面写的内容，我们来看一个示例。这是一个消息的内容：
```json
{
    "number": 123.45,
    "string": "text",
    "boolean": true,
    "array": [1, 2, 3],
    "object": {
        "property": "propertyValue"
    },
    "null": null
}
```
这是一个比较模板和提取值的表格：

| **模板**       | **提取值** |
|--------------------|---------------------|
| $[number]          | 123.45              |
| $[string]          | text                |
| $[boolean]         | true                |
| $[array]           | $[array]            |
| $[object]          | $[object]           |
| $[object.property] | propertyValue       |
| $[null]            | null                |
| $[doesNotExist]    | $[doesNotExist]     |