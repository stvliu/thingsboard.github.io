Json 转换器是默认转换器，它在来自代理的传入消息中查找 deviceName、deviceType、attributes 和 telemetry，并遵循本章节中描述的规则：

|**参数**|**默认值**|**说明**|
|:-|:-|-
| type                        | **json**                  | 向连接器提供信息，表明要使用默认转换器将数据从主题转换为数据。                                       |
| deviceNameJsonExpression    | **${serialNumber}**       | 简单 JSON 表达式，用于在传入消息中查找设备名称（参数“serialNumber”将用作设备名称）。      |
| deviceTypeJsonExpression    | **${sensorType}**         | 简单 JSON 表达式，用于在传入消息中查找设备类型（参数“sensorType”将用作设备类型）。        |
| timeout                     | **60000**                 | 触发“设备断开连接”事件的超时                                                                                        |
| attributes:                 |                           | 本章节包含传入消息的参数，这些参数将被解释为设备的属性。                              |
| ... type                    | **string**                | 当前属性的传入数据类型。                                                                                            |
| ... key                     | **model**                 | 要发送到 GridLinks 实例的属性名称。                                                                                       |
| ... value                   | **${sensorModel}**        | 简单 JSON 表达式，用于在传入消息中查找值，该值将作为 key 参数的值发送到 GridLinks 实例。     |
|                             |                           |                                                                                                                                           |
| ... type                    | **string**                | 当前属性的传入数据类型。                                                                                            |
| ... key                     | **${sensorModel}**        | 简单 JSON 表达式，用于在传入消息中查找值，该值用作属性名称。                                     |
| ... value                   | **on**                    | 要发送到 GridLinks 实例的属性值。                                                                                      |
| timeseries:                 |                           | 本章节包含传入消息的参数，这些参数将被解释为设备的遥测。                               |
| ... type                    | **double**                | 当前遥测的传入数据类型。                                                                                            |
| ... key                     | **temperature**           | 要发送到 GridLinks 实例的遥测名称。                                                                                       |
| ... value                   | **${temp}**               | 简单 JSON 表达式，用于在传入消息中查找值，该值将作为 key 参数的值发送到 GridLinks 实例。     |
|                             |                           |                                                                                                                                           |
| ... type                    | **double**                | 当前遥测的传入数据类型。                                                                                            |
| ... key                     | **humidity**              | 要发送到 GridLinks 实例的遥测名称。                                                                                       |
| ... value                   | **${hum}**                | 简单 JSON 表达式，用于在传入消息中查找值，该值将作为 key 参数的值发送到 GridLinks 实例。     |
|--- 

{% capture difference %}
<br>
**attributes 和 telemetry 部分中的参数可能与上面显示的参数不同，但结构相同。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**注意**：设备配置文件在创建设备时设置。不提供使用网关更改设备配置文件。


示例 1 的映射章节如下所示：

```json
    {
      "topicFilter": "/sensor/data",
      "converter": {
        "type": "json",
        "deviceNameJsonExpression": "${serialNumber}",
        "deviceTypeJsonExpression": "${sensorType}",
        "timeout": 60000,
        "attributes": [
          {
            "type": "string",
            "key": "model",
            "value": "${sensorModel}"
          },
          {
            "type": "string",
            "key": "${sensorModel}",
            "value": "on"
          }
        ],
        "timeseries": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          }
        ]
      }
    }
```

示例 2 的映射如下所示：

```json
    {
      "topicFilter": "/sensor/+/data",
      "converter": {
        "type": "json",
        "deviceNameTopicExpression": "(?<=sensor\/)(.*?)(?=\/data)",
        "deviceTypeTopicExpression": "Thermometer",
        "timeout": 60000,
        "attributes": [
          {
            "type": "string",
            "key": "model",
            "value": "${sensorModel}"
          }
        ],
        "timeseries": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          }
        ]
      }
    }
```