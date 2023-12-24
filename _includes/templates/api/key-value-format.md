## 键值格式

默认情况下，ThingsBoard 支持 JSON 中的键值内容。键始终为字符串，而值可以是字符串、布尔值、双精度、长整数或 JSON。
例如：

```json
{
 "stringKey":"value1", 
 "booleanKey":true, 
 "doubleKey":42.0, 
 "longKey":73, 
 "jsonKey": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
 }
}
```