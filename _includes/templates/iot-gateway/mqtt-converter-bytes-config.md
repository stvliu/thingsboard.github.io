字节转换器是默认转换器，它在来自代理的消息中查找 deviceName、deviceType、attributes 和 telemetry，规则如下章节所述：

| **参数** | **默认值** | **说明** |
|:-|:-|-
| type | **bytes** | 向连接器提供信息，以便使用默认转换器将数据从主题转换为数据。 |
| deviceNameExpression | **[0:4]** | 用于在传入消息中查找设备名称的表达式。 |
| deviceTypeExpression | **[1:3]** | 用于在传入消息中查找设备类型的表达式。 |
| timeout | **60000** | 触发“设备断开连接”事件的超时时间。 |
| attributes: | | 此章节包含传入消息的参数，这些参数将被解释为设备的属性。 |
| ... type | **raw** | 当前属性的传入数据类型。 |
| ... key | **temp** | 要发送到 GridLinks 实例的属性名称。 |
| ... value | **[:]** | 将发送到 GridLinks 的数据的最终视图，[:] - 将使用 Python 切片规则替换为设备数据。 |
| timeseries: | | 此章节包含传入消息的参数，这些参数将被解释为设备的遥测数据。 |
| ... type | **raw** | 当前遥测数据的传入数据类型。 |
| ... key | **rawData** | 要发送到 GridLinks 实例的遥测数据名称。 |
| ... value | **[4:]** | 将发送到 GridLinks 的数据的最终视图，[:] - 将使用 Python 切片规则替换为设备数据。 |
|---

{% capture difference %}
<br>
**attributes 和 telemetry 部分中的参数可能与上面显示的参数不同，但结构相同。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**注意：**在创建设备时设置设备配置文件。不提供使用网关更改设备配置文件。

映射章节将如下所示：
```json
    {
      "topicFilter": "/sensor/raw_data",
      "converter": {
        "type": "bytes",
        "deviceNameExpression": "[0:4]",
        "deviceTypeExpression": "default",
        "timeout": 60000,
        "attributes": [
          {
            "type": "raw",
            "key": "rawData",
            "value": "[:]"
          }
        ],
        "timeseries": [
          {
            "type": "raw",
            "key": "temp",
            "value": "[4:]"
          }
        ]
      }
    }
```