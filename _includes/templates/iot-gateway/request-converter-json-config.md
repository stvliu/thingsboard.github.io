Json 转换器是默认转换器，它在来自代理的传入消息中查找 deviceName、deviceType、attributes 和 telemetry，并遵循本章节中描述的规则：

| **参数** | **默认值** | **说明** |
|:-|:-|-
| type | **json** | 向连接器提供信息，表明默认转换器将用于转换响应中的数据。 |
| deviceNameJsonExpression | **SD8500** | 简单 JSON 表达式，用于在传入消息中查找设备名称（字符串“SD8500”将用作设备名称）。 |
| deviceTypeJsonExpression | **SD** | 简单 JSON 表达式，用于在传入消息中查找设备类型（字符串“SD”将用作设备类型）。 |
| timeout | **60000** | 触发“设备断开连接”事件的超时时间 |
| attributes | | 本章节包含传入消息的参数，这些参数将被解释为设备的属性。 |
| ... type | **string** | 当前属性的传入数据类型。 |
| ... key | **serialNumber** | 将发送到 GridLinks 实例的属性名称。 |
| ... value | **${serial}** | 简单 JSON 表达式，用于在传入消息中查找值，该值将作为 key 参数的值发送到 GridLinks 实例。 |
| timeseries | | 本章节包含传入消息的参数，这些参数将被解释为设备的遥测数据。 |
| ... type | **string** | 当前遥测数据的传入数据类型。 |
| ... key | **Maintainer** | 将发送到 GridLinks 实例的遥测数据名称。 |
| ... value | **${Developer}** | 简单 JSON 表达式，用于在传入消息中查找值，该值将作为 key 参数的值发送到 GridLinks 实例。 |
|--- 

{% capture difference %}
<br>
**attributes 和 telemetry 部分中的参数可能与上面显示的参数不同，但结构相同。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}


映射章节将如下所示：

```json
    {
      "url": "getdata",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 5,
      "converter": {
        "type": "json",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "attributes": [
          {
            "key": "serialNumber",
            "type": "string",
            "value": "${serial}"
          }
        ],
        "telemetry": [
          {
            "key": "Maintainer",
            "type": "string",
            "value": "${Developer}"
          }
        ]
      }
    }
```

此外，您还可以将 MQTT 消息中的值组合在 attributes、telemetry 和 serverSideRpc 部分中，例如：
```json
{
      "url": "getdata",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 5,
      "converter": {
        "type": "json",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "attributes": [],
        "telemetry": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          },
          {
            "type": "string",
            "key": "combine",
            "value": "${hum}:${temp}"
          }
        ]
      }
    }
```