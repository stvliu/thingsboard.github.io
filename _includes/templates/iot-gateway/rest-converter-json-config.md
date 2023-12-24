Json 转换器是默认转换器，它在来自客户端的传入请求中查找 deviceName、deviceType、attributes 和 telemetry，并遵循本小节中描述的规则：

| **参数** | **默认值** | **说明** |
|:-|:-|-
| type | **json** | 向连接器提供信息，表明默认转换器将用于转换来自传入请求的数据。 |
| deviceNameExpression | **Device ${name}** | 简单 JSON 表达式，用于在传入消息中查找设备名称（请求中参数“name”的值将用作设备名称）。 |
| deviceTypeExpression | **default** | 简单 JSON 表达式，用于在传入消息中查找设备类型（字符串“default”将用作设备类型）。 |
| attributes | | 本小节包含传入请求的参数，这些参数将被解释为设备的属性。 |
| ... type | **string** | 当前属性的传入数据类型。 |
| ... key | **model** | 简单 JSON 表达式，用于在传入数据中查找键，该键将作为属性键发送到 GridLinks 实例。 |
| ... value | **${sensorModel}** | 简单 JSON 表达式，用于在传入数据中查找值，该值将作为键参数的值发送到 GridLinks 实例。 |
| timeseries | | 本小节包含传入消息的参数，这些参数将被解释为设备的遥测数据。 |
| ... type | **double** | 当前遥测数据的传入数据类型。 |
| ... key | **temperature** | 简单 JSON 表达式，用于在传入消息中查找键，该键将作为属性键发送到 GridLinks 实例。 |
| ... value | **${temp}** | 简单 JSON 表达式，用于在传入消息中查找值，该值将作为键参数的值发送到 GridLinks 实例。 |
|---

{% capture difference %}
<br>
**attributes 和 telemetry 部分中的参数可能与上面显示的参数不同，但结构相同。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}


映射小节如下所示：

```json
    {
      "endpoint": "/test_device",
      "HTTPMethod": [
        "POST"
      ],
      "security":
      {
        "type": "basic",
        "username": "user",
        "password": "passwd"
      },
      "converter": {
        "type": "json",
        "deviceNameExpression": "Device ${name}",
        "deviceTypeExpression": "default",
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

此外，您还可以将 MQTT 消息中的值组合在 attributes、telemetry 和 serverSideRpc 部分中，例如：
{% highlight json %}
{
      "endpoint": "/test_device",
      "HTTPMethod": [
        "POST"
      ],
      "security":
      {
        "type": "basic",
        "username": "user",
        "password": "passwd"
      },
      "converter": {
        "type": "json",
        "deviceNameExpression": "Device ${name}",
        "deviceTypeExpression": "default",
        "attributes": [],
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
          },
          {
            "type": "string",
            "key": "combine",
            "value": "${hum}:${temp}"
          }
        ]
      }
    }
{% endhighlight %}