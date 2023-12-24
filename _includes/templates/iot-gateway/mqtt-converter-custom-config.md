自定义转换器是为某些设备编写的转换器：



|**参数**|**默认值**|**说明**|
|:-|:-|-
| type                        | **custom**                      | 向连接器提供信息，即自定义转换器将用于转换来自主题的数据。                                                                      |
| extension                   | **CustomMqttUplinkConverter**   | 自定义转换器类的名称。                                                                                                                                           |
| extension-config            |                                 | 此子部分是自定义转换器的配置。在默认示例中，它包含遥测的字节数和键。                                                                      |
| temperatureBytes            | **2**                           | 在默认示例中，从接收到的消息中提取的前 2 个字节将被解释为遥测的 **temperature** 键（如果存在，将删除子字符串“Bytes”）。                 |
| humidityBytes               | **2**                           | 在默认示例中，从接收到的消息中提取的第二个和第三个字节将被解释为遥测的 **humidity** 键（如果存在，将删除子字符串“Bytes”）。        |
| batteryLevelBytes           | **1**                           | 在默认示例中，从接收到的消息中提取的第五个字节将被解释为遥测的 **batteryLevel** 键（如果存在，将删除子字符串“Bytes”）。              |
---

{% capture difference %}
<br>
**此子部分和主题中的所有参数将在初始化期间作为字典传输到转换器对象。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}


配置中的转换器子部分将如下所示：
```json
      "converter": {
        "type": "custom",
        "extension": "CustomMqttUplinkConverter",
        "extension-config": {
            "temperatureBytes" : 2,
            "humidityBytes" :  2,
            "batteryLevelBytes" : 1
        }
      }
```